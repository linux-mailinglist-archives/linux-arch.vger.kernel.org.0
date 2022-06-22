Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BE35548A4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiFVJFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 05:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiFVJFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 05:05:24 -0400
X-Greylist: delayed 75945 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 02:05:19 PDT
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [IPv6:2a09:80c0::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E29CE;
        Wed, 22 Jun 2022 02:05:19 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id 949814C0236;
        Wed, 22 Jun 2022 11:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1655888716;
        bh=Yr78Voy6/ZWAI8Ex/Aure+xnmqoVC4pzJJ8L88wVTWw=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=foT1bnOBe3f+w23asVxwVtrsg/xXUnglKYhpV/et7W3LMwgtIBkuBCOYWq7Ly5hCF
         5piqdFf+MdrGVM+5S8xjHK/I/x888WBgwp+3PiTgfyAooXOaPKYmY+gL1654gQXeKA
         UmsDvOEIwcCHvc5oqBRTtOW0EpNn6hsE4TlT9J/5kwuwZ0GQRn879OcQMB8cnhc1qn
         xgBT7HFcmxP81pm7ELlkj0O9lGrT4lvhlfCKo4vvW3Rk2Uw2Yvx34niU0I4TThlWp4
         N9QO26urbRLHzVWsW0FdYzY61pphN2wJ3YKwmgJvDIOr62/KjXI/0tEBR/udn+TGER
         YyBfrzd1hqgLg==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 83AC3DD; Wed, 22 Jun 2022 11:05:16 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 6159FD6;
        Wed, 22 Jun 2022 11:05:16 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 5C7ADCE;
        Wed, 22 Jun 2022 11:05:16 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 572E54A02E7; Wed, 22 Jun 2022 11:05:16 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 489D14A013B;
        Wed, 22 Jun 2022 11:05:15 +0200 (CEST)
        (Extended-Queue-bit xtech_yi@fff.in.tum.de)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_60399BCD-725C-4105-B4F1-1543619E21D4";
        protocol="application/pkcs7-signature";
        micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: Dangerous addr to ctrl dependency transformation in
 fs/nfs/delegation.c::nfs_server_return_marked_delegations()?
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <CAKwvOdkrZbRTfrK_cFRseoONGi7qQ-_4vB=Zm9KH3Bb2KZ5tww@mail.gmail.com>
Date:   Wed, 22 Jun 2022 11:05:15 +0200
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C90EF3D6-CB26-48D3-A600-A4237C4BE4EC@in.tum.de>
References: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local>
 <CAKwvOdkEULT_OOeaaCneJjbrE=O3kC8SMDs2thFa9gBfpuo2Jg@mail.gmail.com>
 <YmKF5tiH4W8AVdXe@Pauls-MacBook-Pro.local>
 <CAKwvOd=yLgY_0SwfBuOAzo=+zeWNMu4FMp65y0bi_RM+1G3NWQ@mail.gmail.com>
 <CAKwvOdkrZbRTfrK_cFRseoONGi7qQ-_4vB=Zm9KH3Bb2KZ5tww@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Apple-Mail=_60399BCD-725C-4105-B4F1-1543619E21D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 22. Jun 2022, at 00:05, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
>=20
> On Tue, May 17, 2022 at 3:29 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> On Fri, Apr 22, 2022 at 3:39 AM Paul Heidekr=C3=BCger
>> <paul.heidekrueger@in.tum.de> wrote:
>>> On Thu, Apr 14, 2022 at 02:21:25PM -0700, Nick Desaulniers wrote:
>>>> On Thu, Apr 7, 2022 at 8:22 AM Paul Heidekr=C3=BCger
>>>> <paul.heidekrueger@in.tum.de> wrote:
>>>>> Hi all,
>>>>>=20
>>>>> work on my dependency checker tool is progressing nicely, and it =
is
>>>>> flagging, what I believe is, a harmful addr to ctrl dependency
>>>>> transformation. For context, see [1] and [2]. I'm using the Clang
>>>>> compiler.
>>>>> [1]: =
https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/10=
75/LPC_2020_--_Dependency_ordering.pdf
>>>>> [2]: =
https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-Pro/T/#u
>>>>=20
>>>> Hi Paul,
>>>> Thanks for the report and your (and your team's) work on this tool.
>>>> Orthogonal to your report, Jose (cc'ed) and I are currently in the
>>>> planning process to put together a Kernel+Toolchain microconference
>>>> track at Linux Plumbers Conference [0] this year (Sept 12-14) in
>>>> Dublin, Ireland. Would you or someone from your group be able and
>>>> interested in presenting more information about your work to an
>>>> audience of kernel and toolchain developers at such an event?
>>>>=20
>>>> Would others be interested in such a topic? (What do they say in
>>>> Starship Troopers...?...Would you like to know more?)
>>>>=20
>>>> [0] https://lpc.events/event/16/
>>>> --
>>>> Thanks,
>>>> ~Nick Desaulniers
>>>=20
>>> Hi Nick and Jose,
>>>=20
>>> Many thanks for inviting us! I would love to do a talk at LPC! =
Hopefully
>>> in person too.
>>>=20
>>> Given that there have been several talks around this topic at LPC
>>> already, it seems very fitting, and we'll hopefully have more to =
share
>>> by then. Actually we have more to share already :-)
>>>=20
>>> =
https://lore.kernel.org/all/YmKE%2FXgmRnGKrBbB@Pauls-MacBook-Pro.local/T/#=
u
>>>=20
>>> I assume we will have to submit an abstract soon?
>>=20
>> Yes, if you go to: https://lpc.events/event/16/abstracts/
>>=20
>> click "Submit new abstract" in the bottom right.
>>=20
>> Under the "Track" dropdown, please select "Toolchains Track."
>=20
> Hi Paul, we'll need all proposals soon.
> If you're still considering attending Linux Plumbers conf, please
> submit a proposal:
> https://lpc.events/event/16/abstracts/
> Please make sure to select "Toolchains Track" as the "Track" after
> clicking on "Submit new abstract."

Hi Nick,

Of course! :-)

Sorry for taking so long, and thanks for reminding! I was under the
impression the deadline was sometime mid-August and therefore hadn't
prioritised it high enough - sorry!

You'll have the proposal ASAP.

Many thanks,
Paul

>> --
>> Thanks,
>> ~Nick Desaulniers
>=20
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

--Apple-Mail=_60399BCD-725C-4105-B4F1-1543619E21D4
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
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjIwOTA1MTVaMC8GCSqGSIb3DQEJBDEiBCDcHusrtXVVwMq+
e5SqAtQZNVAKO+X9++3/KFlY9JkVjDCBrwYJKwYBBAGCNxAEMYGhMIGeMIGNMQswCQYDVQQGEwJE
RTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1
bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEds
b2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswgbEGCyqGSIb3DQEJEAILMYGhoIGeMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4t
VmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswDQYJKoZIhvcNAQELBQAEggEA
F51R73UXQemY4Wkdf9CLIEBDtrx/WicfN7zj4wfIe7HPzdyDK7U4E3r+Kx4zIzYmOYNwaSC36aKH
KvhADMP6hGBQZWW05JexiDyHcZcIRqWrZ9A0YMoPCKvBkThaGPxO2zczJ378FsKBFnKSi/hNUJdd
/6Wu2abrHmAQcmrxdJI6l9gFENeWCZDo/KIjVoMpY7NHV82q9qnjyMth5GLWnZe+xEPp1GajEUht
GGAtnAHbkFUVSxwb9JzS/ZM6K1wi5L5xT6+8+HwM5XFfQrEubX04voYKoEwQZkZRL7RmjutLGqOB
jlOIxWi7DOS7E1lbsuigl+NsR8BdImSJhyDdRAAAAAAAAA==
--Apple-Mail=_60399BCD-725C-4105-B4F1-1543619E21D4--
