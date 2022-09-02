Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2655AB9A7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiIBUxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIBUxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 16:53:48 -0400
Received: from mailout3.rbg.tum.de (mailout3.rbg.tum.de [131.159.0.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A9106DB4;
        Fri,  2 Sep 2022 13:53:32 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout3.rbg.tum.de (Postfix) with ESMTPS id 4E909100D1E;
        Fri,  2 Sep 2022 22:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1662152008;
        bh=U3TuavEmYauNSL5ReGEu5jSL5mPW0h3kY7JePUHK7IU=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=albk5apkHN/ADjaqURn83Kmx0Tp8rRhRiYbPfFMxDWOdwNGy98bjA4FEyUCNRxJ8b
         z802YlzGUDlEEOgX5JJ91qpi+TLYD2mZSDbRBj7hD7UU+nCm4+seoIUgfIytXvwHM7
         gpn64G9gUpmSbECzCvdXFoVimABekQINC3Ftq5YcyVqOs779eAbK1QfsgMzV8wM8hE
         rLJQNIFK14oQV1CEjttQNXBNmb3bb5Q45ahwyRxMCahkzJBakHX31MqIiWGwXwDECf
         68J8jSCq+e0H1ZXaib/YcL0FU0VaH/LGM4kCJj8UOArfe/N23MIY14RVDCT6oI/Cq1
         QZV0lx2cxQBew==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 4ABF81ABC; Fri,  2 Sep 2022 22:53:28 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 1CF701ABB;
        Fri,  2 Sep 2022 22:53:28 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 18F1A1ABA;
        Fri,  2 Sep 2022 22:53:28 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 154884A0440; Fri,  2 Sep 2022 22:53:28 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 51DDC4A007E;
        Fri,  2 Sep 2022 22:53:27 +0200 (CEST)
        (Extended-Queue-bit xtech_vk@fff.in.tum.de)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_DBB9647F-E8B8-49DF-9CDA-D6283A477504";
        protocol="application/pkcs7-signature";
        micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] tools/memory-model: Weaken ctrl dependency definition in
 explanation.txt
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <YxIQrT+jFteFd8+e@rowland.harvard.edu>
Date:   Fri, 2 Sep 2022 22:53:26 +0200
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FD673C3-F8FA-428C-B8B1-4DBC71AFDF0C@in.tum.de>
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
 <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
 <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
 <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
 <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
 <EE1FA3DC-5A38-45EC-97AB-44B19C1C7707@in.tum.de>
 <YxIQrT+jFteFd8+e@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Apple-Mail=_DBB9647F-E8B8-49DF-9CDA-D6283A477504
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On 2. Sep 2022, at 16:18, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, Sep 02, 2022 at 10:40:34AM +0200, Paul Heidekr=C3=BCger wrote:
>> On 31. Aug 2022, at 19:38, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>>>>> Finally, a read event X and another memory access event Y are =
linked by a
>>>>> control dependency if Y syntactically lies within an arm of an if
>>>>> statement and X affects the evaluation of the if condition via a =
data or
>>>>> address dependency.  Similarly for switch statements.
>>>>=20
>>>> What do you think?
>>>=20
>>> I like the second one.  How about combining the last two sentences? =20=

>>>=20
>>> 	... via a data or address dependency (or similarly for a switch=20=

>>> 	statement).
>>=20
>> Yes, sounds good!
>>=20
>>> Now I suppose someone will pipe up and ask about the conditional=20
>>> expressions in "for", "while" and "do" statements...  :-)
>>=20
>> Happy to have obliged :-)
>> =
https://lore.kernel.org/all/20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de=
/
>>=20
>> Do you think the text should explicitly address control dependencies =
in the
>> context of loops as well? If yes, would it be a separate patch, or =
would it
>> make sense to combine it with this one?
>=20
> Anything else should be a separate patch.
>=20
> For the time being, I'm happy not to worry about loops.  In the end
> we'll probably have to describe them as though they were unrolled,
> with all the complications that entails.

OK, sounds good!

Since there aren't any other immediate objections, I'll go ahead an =
resubmit
a v3 version of the patch with all the changes we discussed then.

Many thanks,
Paul=

--Apple-Mail=_DBB9647F-E8B8-49DF-9CDA-D6283A477504
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEWow
ggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYTAkRFMSsw
KQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYDVQQLDBZULVN5
c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFsUm9vdCBDbGFzcyAy
MB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNVBAYTAkRFMUUwQwYDVQQK
EzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMg
ZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlv
biBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMtg1/9moUHN0vqH
l4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZsFVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8F
XRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0peQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+Ba
L2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qL
NupOkSk9s1FcragMvp0049ENF4N1xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz
9AkH4wKGMUZrAcUQDBHHWekCAwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU
k+PYMiba1fFKpZFK4OpL4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYD
VR0TAQH/BAgwBgEB/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGC
LB4wCAYGZ4EMAQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUv
cmwvVGVsZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYB
BQUHMAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5jZXIw
DQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4eTizDnS6
dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/MOaZ/SLick0+
hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3SPXez7vTXTf/D6OWS
T1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc22CzeIs2LgtjZeOJVEqM7
h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bPZYoaorVyGTkwggWsMIIElKAD
AgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYDVQQGEwJERTFFMEMGA1UEChM8VmVy
ZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYu
MRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRERk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcNMzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUx
RTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5n
c25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9i
YWwgSXNzdWluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp
1xCeOdfZojDbchwFfylfS2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6W
LkDh0YNMZj0cZGnlm6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mI
TQ5HjUhfZZkQ0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUk
P7agCwf9TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22M
ZD08WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAdBgNV
HQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK4OpL4qIM
z+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9v
dC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYBBQUHAQEEgdAwgc0wMwYI
KwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBKBggrBgEF
BQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/
DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCN
T1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7Ln8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+
lgQCXISoKTlslPwQkgZ7nu7YRrQbtQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v
9NsH1VuEGMGpuEvObJAaguS5Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7
EUkp2KgtdRXYShjqFu9VNCIaE40GMIIGoDCCBYigAwIBAgIMJsvrSvlWNPKp0vJrMA0GCSqGSIb3
DQEBCwUAMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIyMDYxNzEyMDQxM1oXDTIz
MDgxMTE0MDM0OVowge4xCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11
ZW5jaGVuMSkwJwYDVQQKDCBUZWNobmlzY2hlIFVuaXZlcnNpdGFldCBNdWVuY2hlbjEiMCAGA1UE
CwwZRmFrdWx0YWV0IGZ1ZXIgSW5mb3JtYXRpazEVMBMGA1UEBAwMSGVpZGVrcnVlZ2VyMQ0wCwYD
VQQqDARQYXVsMRowGAYDVQQDDBFQYXVsIEhlaWRla3J1ZWdlcjEqMCgGCSqGSIb3DQEJARYbUGF1
bC5IZWlkZWtydWVnZXJAaW4udHVtLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
s8gdDu7n1qQK6/QRJemihL7fh5yVIaGugo3Hn8qvlKzDwHfM9fHhXzrjBp8VHYSFRi6fPoHjV3OL
UM7ZLqFEmNEcaoioH5prXfx+N686Vu4w3FsZyQd5/lQO5qD7AJ1zu0N78uJyBLMfnlv7mmMKupkz
FmnLbKzurYdbpdiYxBHF0ej/h2oMJeOKI26sZ0ItW11cFxqBe4gD+DYQ4PIXzMXkqNbK4n7tIu5s
uzZt3B3dW/52kNi1vjI+Fi373AhIseAE3mZ/zixFyI9Ib/tqtA2iXLZaINhPEm05+H/IdKYqdwAW
NO/SiL6nXxnoHmOJzToqfiN9ERDaN7K3lzb3ewIDAQABo4ICmzCCApcwPgYDVR0gBDcwNTAPBg0r
BgEEAYGtIYIsAQEEMBAGDisGAQQBga0hgiwBAQQKMBAGDisGAQQBga0hgiwCAQQKMAkGA1UdEwQC
MAAwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4E
FgQUA2y9lnfs17UBHlCWzGGaJ5gDAhMwHwYDVR0jBBgwFoAUazqYi/nyU4na4K2yMh4JH+iqO3Qw
bQYDVR0RBGYwZIESaGVpZGVrcnBAaW4udHVtLmRlgRtQYXVsLkhlaWRla3J1ZWdlckBpbi50dW0u
ZGWBE2hlaWRla3JwQGNzLnR1bS5lZHWBHFBhdWwuSGVpZGVrcnVlZ2VyQGNzLnR1bS5lZHUwgY0G
A1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcy
L3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1n
bG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzAB
hidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5j
cnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAC1bKIVMA6w7eSFfxv+1vQXR
YQ6WQujz3MVSfYeplJXWKgKkUzpSzI7juw5sT3OkqStl+CGjIKaJiyYhZ/uP6/YMEpifBncsygjw
+K+2K+L8lov4wokWMVaLSoaaPeGrP20rzkumyUSvsI1ILZzplggsDmdS8D4H/Vc66cMWkrUkeurt
Diorn6fG0gfy18YCq9XGQV+NxozwRkAfxkmvF0fzviQnSJ/lkzs4AadJ8sH5AzZXHPzydIK/Lcle
dc6wi287tsRDpDMh+UOR4xe73+72oZabULSwhuM3iD50vr8o+Tm8Sg+mWIPNFivjY/FkNKPleiTW
y3z7OxbaF19HnEgxggOdMIIDmQIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVp
biB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQ
MA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIM
JsvrSvlWNPKp0vJrMA0GCWCGSAFlAwQCAQUAoIIBzzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA5MDIyMDUzMjZaMC8GCSqGSIb3DQEJBDEiBCAvRFs7CNQL1eej
FSSeSPp1ZK/h4Qu6jCDChKkBZZF1NjCBrwYJKwYBBAGCNxAEMYGhMIGeMIGNMQswCQYDVQQGEwJE
RTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1
bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEds
b2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswgbEGCyqGSIb3DQEJEAILMYGhoIGeMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4t
VmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswDQYJKoZIhvcNAQELBQAEggEA
m3Cns7ejXdPEX2bDRNOSv+dnldQm3iZihi7Dsgve2nKZU0JkErJTJ2rsUvxoE8GiKXgJEh6kbtOH
RvKWdeP5lKgGrgMzaz1vkd+YT8LAAjs29DRIcyIn5MA959V9G4YJItzzhxCm6vR4RB77hHIoNgsc
s2m1nDFWzzzNSnwnbea3FW0qu2oftHHK8tifFz4M2MPRrI/P4HTnLiNTGGxd7pozYttuF2hPLCFR
jTW/CnEIcIJmiFnnPnQWRfpk9JtTcf9TfmcHPdl2hf5szFv5UBfEbVH5Z4A4qkgx1mTueX6TcI00
069YFypOXhX4RxgfO7uDeiTdC/WE6TMoYRXAKQAAAAAAAA==
--Apple-Mail=_DBB9647F-E8B8-49DF-9CDA-D6283A477504--
