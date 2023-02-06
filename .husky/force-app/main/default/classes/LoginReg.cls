public with sharing class LoginReg {
    public String password{get;set;}
    public String username{get;set;}
    public String UserRegistration__c reg {get;set;}
    public transient String errorMessage { get; set; }
    public List<UserRegistration__c> UserRegList;


    public LoginReg(ApexPages.StandardController controller ) 
    {
        reg=(UserRegistration__c)controller.getrecord();
    }

    public PageReference Verifyuser()
    {
        try {
            List<UserRegistration__c> yp = new List<UserRegistration__c>();
            System.debug('username='+username);
            if(!String.isBlank(username))
            {
                yp= [SELECT Email__c,Password__c from UserRegistration__c where Email__c=:username LIMIT 1 ];
                if(yp.size()>0)
                {
                    system.debug('yp[0].Email__c value'+yp[0].Email__c);
                    if(username == yp[0].Email__c && password == yp[0].password__c)
                    {
                        PageReference newPage = new PageReference('/apex/welcome');
                        newPage.setRedirect(true);
                        return newpage;
                    }

                }
                else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Invalid  username and password please check'));
                }

            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter username and password'));
            }
        } 
        catch (Exception e) 
        {
            
        }
        return null;
    } 
}