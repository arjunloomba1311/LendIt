from flask import Flask

app = Flask(__name__)


@app.route('/createEscrow')
def createEscrow():

    from xrpl.wallet import Wallet, generate_faucet_wallet
    from xrpl.clients import JsonRpcClient
    from datetime import datetime, timedelta
    from xrpl.utils import xrp_to_drops
    from xrpl.transaction import (safe_sign_and_autofill_transaction,
                                send_reliable_submission)
    from xrpl.utils import datetime_to_ripple_time
    from xrpl.models import EscrowCreate                             


    client = JsonRpcClient("https://s.altnet.rippletest.net:51234") 

    amount = 10.000 

    receiver = "rPT1Sjq2YGrBMTttX4GZHjKu9dyfzbpAYe" 

  
    claim_date = datetime_to_ripple_time(datetime.now() + timedelta(days=30))



    #
    sender = generate_faucet_wallet(client=client)

    create_txn = EscrowCreate(
        account=sender.classic_address,
        amount=xrp_to_drops(amount), 
        destination=receiver,
        finish_after=claim_date)

 
    stxn = safe_sign_and_autofill_transaction(create_txn, sender, client)
    stxn_response = send_reliable_submission(stxn, client)

  
    stxn_result = stxn_response.result

    return (stxn_result["meta"]["TransactionResult"])

    

@app.route('/finishEscrow')
def finishEscrow():


    from xrpl.clients import JsonRpcClient
    from xrpl.models import EscrowFinish
    from xrpl.transaction import (safe_sign_and_autofill_transaction,
                                send_reliable_submission)
    from xrpl.wallet import Wallet, generate_faucet_wallet

    client = JsonRpcClient("https://s.altnet.rippletest.net:51234")

  


    escrow_creator = generate_faucet_wallet(client=client).classic_address

    escrow_sequence = 27641268


    condition = "A02580203882E2EB9B44130530541C4CC360D079F265792C4A7ED3840968897CB7DF2DA1810120"

    fulfillment = "A0228020AED2C5FE4D147D310D3CFEBD9BFA81AD0F63CE1ADD92E00379DDDAF8E090E24C"

    sender = generate_faucet_wallet(client=client)


    finish_txn = EscrowFinish(account=sender.classic_address, owner=escrow_creator, offer_sequence=escrow_sequence, condition=condition, fulfillment=fulfillment)

    stxn = safe_sign_and_autofill_transaction(finish_txn, sender, client)

    stxn_response = send_reliable_submission(stxn, client)

    stxn_result = stxn_response.result

    return (stxn_result["meta"]["TransactionResult"]) 




if __name__ == '__main__':
    app.run()