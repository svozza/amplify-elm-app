import Amplify, { Auth } from 'aws-amplify';
import awsmobile from './aws-exports';
Amplify.configure(awsmobile);

const app = Elm.Main.init({
    node: document.getElementById('elm')
});

// what happens on sign up
app.ports.signup.subscribe(data => {

    Auth.signUp({
        username: data.username,
        password: data.password,
        attributes: {
            email: data.emailAddress
        },
        validationData: []
    })
        .then(data => {
            console.log(data);
            app.ports.signupSuccess.send({username: data.user})
        })
        .catch(err => {
            console.log(err);
            app.ports.errors.send(err)
        });

// After retrieving the confirmation code from the user
//     Auth.confirmSignUp(username, code, {
//         // Optional. Force user confirmation irrespective of existing alias. By default set to True.
//         forceAliasCreation: true
//     }).then(data => console.log(data))
//         .catch(err => console.log(err));
//
//     Auth.resendSignUp(username).then(() => {
//         console.log('code resent successfully');
//     }).catch(e => {
//         console.log(e);
//     });


});