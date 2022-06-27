Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013955E1DD
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiF0Jrz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiF0Jrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 05:47:55 -0400
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [IPv6:2a09:80c0::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F363E5;
        Mon, 27 Jun 2022 02:47:52 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id E30454C0264;
        Mon, 27 Jun 2022 11:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1656323269;
        bh=L7qEC585hEwBxV8TKjave0aeMkYAgmHI5p0Vbtge8QA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=sRtvA5EtU1Ty8eIw7cJ9R4f3SBWwGup6tHqeVh8hyDnP2EsE0TBu3Vx5lAdZwTR7m
         8+vlI3ypNmw4K8qQnRW0zMKdRYd6sc3CD2b333U8WRbhLqQ/WDTQ08QD9gFlpFqUPu
         pRH0Qg0dT1HevStbFhCwj6/lm69r4bp5UFKV2D43sEB08u3WYBnnglXcinUew9l5lY
         0uxL6oZJBtlqIx/7CFdLWo0ZkyxaXAG47DyObnuqKKeTQL5fDp+P27Y3N7f8TPLZtY
         iFUc49TWZn8Ge9rw8knPZfVsKM1OkqMisH2qpYfK72ZGgBwYiSDvalaOLD17cBY4PU
         jBG/7ELBotZgA==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 67D853F8; Mon, 27 Jun 2022 11:47:44 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 3A2493F7;
        Mon, 27 Jun 2022 11:47:44 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 34C693F5;
        Mon, 27 Jun 2022 11:47:44 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 3079D4A03A9; Mon, 27 Jun 2022 11:47:44 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 98ED34A0067;
        Mon, 27 Jun 2022 11:47:43 +0200 (CEST)
        (Extended-Queue-bit xtech_jh@fff.in.tum.de)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D532E39D-CD94-4301-B85C-8B71FDAE15EB";
        protocol="application/pkcs7-signature";
        micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <YrHUkfDWsexHRUKj@rowland.harvard.edu>
Date:   Mon, 27 Jun 2022 11:47:43 +0200
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains@vger.kernel.org,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
 <YrHUkfDWsexHRUKj@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Apple-Mail=_D532E39D-CD94-4301-B85C-8B71FDAE15EB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 21. Jun 2022, at 16:24, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>=20
> On Tue, Jun 21, 2022 at 01:59:27PM +0200, Paul Heidekr=C3=BCger wrote:
>> OK. So, LKMM limits the scope of control dependencies to its arm(s), =
hence
>> there is a control dependency from the last READ_ONCE() before the =
loop
>> exists to the WRITE_ONCE().
>>=20
>> But then what about the following:
>>=20
>>> int *x, *y;
>>>=20
>>> int foo()
>>> {
>>> 	/* More code */
>>>=20
>>> 	if(READ_ONCE(x))
>>> 		return 42;
>>>=20
>>> 	/* More code */
>>>=20
>>> 	WRITE_ONCE(y, 42);
>>>=20
>>> 	/* More code */
>>>=20
>>> 	return 0;
>>> }
>>=20
>> The READ_ONCE() determines whether the WRITE_ONCE() will be executed =
at all,
>> but the WRITE_ONCE() doesn't lie in the if condition's arm.
>=20
> So in this case the LKMM would not recognize that there's a control=20
> dependency, even though it clearly exists.

Oh, that's unfortunate.

Then I would still argue that the "at all" definition is misleading. =
This
time in the other direction as I had initially proposed though, as the =
above
example is a case where "at all" holds true, but LKMM doesn't cover it. =
Or
do you think that caveating this in litmus-tests.txt, e.g. via the patch =
we
had recently worked out [1], is enough?

>>  However, by
>> "inverting" the if, we get the following equivalent code:
>>=20
>>> if(!READ_ONCE(x)) {
>>> 	/* More code */
>>>=20
>>> 	WRITE_ONCE(y, 42);
>>>=20
>>> 	/* More code */
>>>=20
>>> 	return 0;
>>> }
>>>=20
>>> return 42;
>>=20
>> Now, the WRITE_ONCE() is in the if's arm, and there is clearly a =
control
>> dependency.
>=20
> Correct.
>=20
>> Similar cases:
>>=20
>>> if(READ_ONCE())
>>> 	foo(); /* WRITE_ONCE() in foo() */
>>> return 42;
>>=20
>> or
>>=20
>>> if(READ_ONCE())
>>>    goto foo; /* WRITE_ONCE() after foo */
>>> return 42;
>>=20
>> In both cases, the WRITE_ONCE() again isn't in the if's arm =
syntactically
>> speaking, but again, with rewriting, you can end up with a control
>> dependency; in the first case via inlining, in the second case by =
simply
>> copying the code after the "foo" marker.
>=20
> Again, correct.  The LKMM isn't always consistent, and it behaves this=20=

> way to try to avoid presuming too much about the optimizations that=20
> compilers may apply.

Many thanks,
Paul

--
[1]: =
https://lore.kernel.org/all/20220614154812.1870099-1-paul.heidekrueger@in.=
tum.de/=

--Apple-Mail=_D532E39D-CD94-4301-B85C-8B71FDAE15EB
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
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjcwOTQ3NDNaMC8GCSqGSIb3DQEJBDEiBCBTUeuk+CSZ8e9C
wRWp0FlP/jWsxidAxLqKNyIOTbNAhzCBrwYJKwYBBAGCNxAEMYGhMIGeMIGNMQswCQYDVQQGEwJE
RTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1
bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEds
b2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswgbEGCyqGSIb3DQEJEAILMYGhoIGeMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4t
VmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswDQYJKoZIhvcNAQELBQAEggEA
MEWwTlY8/brO2xHmirwxs3D8rVq4Rgzdmcfq+bHGakc5cVBZe3Zt4LUTZkEDqZeXNNLL7/lNPbxE
hCQQs2+2CgzTSC/NUIov7RQugFqVyueWBMX4sscKiM4lJjATdfEbdBQYSb1sesZlB2Dz1qRJbvV2
hcvh5Q6o6hlzCOehpt/ZVRDc357sSkbca0MWxo3Jp7gwSUeRSmG8FIYMjswrWjzxVnIL20wWJN5W
3M8AyXYdqy67fV4kTc12iy0ll1QG0X04/pKzsPYiiksRvYGd4/E7sf6xr0wIOuuhIJ0qW/EXLLE+
Oic04pT/hNtcxoORg4ZZt2lzB3w96ac+0Tt3RgAAAAAAAA==
--Apple-Mail=_D532E39D-CD94-4301-B85C-8B71FDAE15EB--
