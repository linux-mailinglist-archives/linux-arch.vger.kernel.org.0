Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135015A8365
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiHaQmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiHaQmL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 12:42:11 -0400
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [131.159.0.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A201C4820;
        Wed, 31 Aug 2022 09:42:08 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id 76B484C01F4;
        Wed, 31 Aug 2022 18:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1661964126;
        bh=VeT0XnfShADwTWKFyDNDAQjDzdWyJobQfscRy7CwuE8=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=DXrK3jb7AKCc1y7tQ+64qIn0iD9CE40IAFWLmy60PMuR0ADPWij/iowiceuohEJdT
         ARjPG1dz6efT6buiDLKf7iOa3M1EDKvN+xRiI8NIzLDbv8XJpYTyPl9U0W5zrdbLYH
         XIiTAbPweGPW0hD8CGtCoCU22l4YvJHBTK0H2lhFH3G+pFM+/FBNOnTyq5EYQW0DJd
         EgcHcStJLB1Fs//iUZLOmOyzEBrxR5kLKrKiVZhOGqKIr1SXYOmolzGySuOb76pexH
         xR7XkhO95Rpv3bGYTjagkmx/xjE1QnhCZZXgnj35vNKPjyP8YL/8Vqs0iM1IZcm7Ce
         G+KxE+5pqtjag==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 70E2E549; Wed, 31 Aug 2022 18:42:06 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 42A77548;
        Wed, 31 Aug 2022 18:42:06 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 3E8C7546;
        Wed, 31 Aug 2022 18:42:06 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 3B1444A02E6; Wed, 31 Aug 2022 18:42:06 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id C50824A00F8;
        Wed, 31 Aug 2022 18:42:05 +0200 (CEST)
        (Extended-Queue-bit xtech_xi@fff.in.tum.de)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CE12793D-99B8-4DC2-ABFC-5EC269C2E4F1";
        protocol="application/pkcs7-signature";
        micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] tools/memory-model: Weaken ctrl dependency definition in
 explanation.txt
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
Date:   Wed, 31 Aug 2022 18:42:05 +0200
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
Message-Id: <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
 <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
 <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Apple-Mail=_CE12793D-99B8-4DC2-ABFC-5EC269C2E4F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On 31. Aug 2022, at 03:57, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Tue, Aug 30, 2022 at 05:12:33PM -0400, Joel Fernandes wrote:
>> On 8/30/2022 5:08 PM, Joel Fernandes wrote:
>>> On 8/30/2022 4:44 PM, Paul Heidekr=C3=BCger wrote:
>>>> The current informal control dependency definition in =
explanation.txt is
>>>> too broad and, as dicsussed, needs to be updated.
>>>>=20
>>>> Consider the following example:
>>>>=20
>>>>> if(READ_ONCE(x))
>>>>> 	return 42;
>>>>>=20
>>>>> 	WRITE_ONCE(y, 42);
>>>>>=20
>>>>> 	return 21;
>>>>=20
>>>> The read event determines whether the write event will be executed =
"at
>>>> all" - as per the current definition - but the formal LKMM does not
>>>> recognize this as a control dependency.
>>>>=20
>>>> Introduce a new defintion which includes the requirement for the =
second
>>>> memory access event to syntactically lie within the arm of a =
non-loop
>>>> conditional.
>>>>=20
>>>> Link: =
https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.=
tum.de/
>>>> Cc: Marco Elver <elver@google.com>
>>>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
>>>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
>>>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
>>>> Cc: Martin Fink <martin.fink@in.tum.de>
>>>> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
>>>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
>>>> ---
>>>>=20
>>>> @Alan:
>>>>=20
>>>> Since I got it wrong the last time, I'm adding you as a =
co-developer after my
>>>> SOB. I'm sorry if this creates extra work on your side due to you =
having to
>>>> resubmit the patch now with your SOB if I understand correctly, but =
since it's
>>>> based on your wording from the other thread, I definitely wanted to =
give you
>>>> credit.
>>>>=20
>>>> tools/memory-model/Documentation/explanation.txt | 7 ++++---
>>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/tools/memory-model/Documentation/explanation.txt =
b/tools/memory-model/Documentation/explanation.txt
>>>> index ee819a402b69..0bca50cac5f4 100644
>>>> --- a/tools/memory-model/Documentation/explanation.txt
>>>> +++ b/tools/memory-model/Documentation/explanation.txt
>>>> @@ -464,9 +464,10 @@ to address dependencies, since the address of =
a location accessed
>>>> through a pointer will depend on the value read earlier from that
>>>> pointer.
>>>>=20
>>>> -Finally, a read event and another memory access event are linked =
by a
>>>> -control dependency if the value obtained by the read affects =
whether
>>>> -the second event is executed at all.  Simple example:
>>>> +Finally, a read event X and another memory access event Y are =
linked by
>>>> +a control dependency if Y syntactically lies within an arm of an =
if,
>>>> +else or switch statement and the condition guarding Y is either =
data or
>>>> +address-dependent on X.  Simple example:

Thank you both for commenting!

> "if, else or switch" should be just "if or switch".  In C there is no=20=

> such thing as an "else" statement; an "else" clause is merely part of=20=

> an "if" statement.  In fact, maybe "body" would be more appropriate =
than=20
> "arm", because "switch" statements don't have arms -- they have cases.

Right. What do you think of "branch"? "Body" to me suggests that there's
only one and therefore that the else clause isn't included.

Would it be fair to say that switch statements have branches? I guess
because switch statements are a convenient way of writing goto's, i.e.
jumps, it's a stretch and basically the same as saying "arm"?

Maybe we can avoid the arm / case clash by just having a definition for =
if
statements and appending something like "similarly for switch =
statements"?

>>> 'conditioning guarding Y' sounds confusing to me as it implies to me =
that the
>>> condition's evaluation depends on Y. I much prefer Alan's wording =
from the
>>> linked post saying something like 'the branch condition is data or =
address
>>> dependent on X, and Y lies in one of the arms'.
>>>=20
>>> I have to ask though, why doesn't this imply that the second =
instruction never
>>> executes at all? I believe that would break the MP-pattern if it =
were not true.
>>=20
>> About my last statement, I believe your patch does not disagree with =
the
>> correctness of the earlier text but just wants to improve it. If =
that's case
>> then that's fine.
>=20
> The biggest difference between the original text and Paul's suggested=20=

> update is that the new text makes clear that Y has to lie within the=20=

> body of the "if" or "switch" statement.  If Y follows the end of the=20=

> if/else, as in the example at the top of this email, then it does have=20=

> not a control dependency on X (at least, not via that if/else), even=20=

> though the value read by X does determine whether or not Y will =
execute.
>=20
> [It has to be said that this illustrates a big weakness of the LKMM: =
It=20
> isn't cognizant of "goto"s or "return"s.  This naturally derives from=20=

> limitations of the herd tool, but the situation could be improved.  So=20=

> for instance, I don't think it would cause trouble to say that in:
>=20
> 	if (READ_ONCE(x) =3D=3D 0)
> 		return;
> 	WRITE_ONCE(y, 5);
>=20
> there really is a control dependence from x to y, even though the=20
> WRITE_ONCE is outside the body of the "if" statement.  Certainly the=20=

> compiler can't reorder the write before the read.  But AFAIK there's =
no=20
> way to include a "return" statement in a litmus test for herd.  Or a=20=

> subroutine definition, for that matter.]
>=20
> I agree that "condition guarding Y" is somewhat awkward.  "the=20
> condition of the if (or the expression of the switch)" might be =
better,=20
> even though it is somewhat awkward as well.  At least it's more=20
> explicit.

Maybe we can reuse the wording from the data and address dependency
definition here and say "affects"?

Putting it all together:

> Finally, a read event X and another memory access event Y are linked =
by a
> control dependency if Y syntactically lies within a branch of an if or
> switch statement and X affects the evaluation of that statement's
> condition via a data or address dependency.

Alternatively without the arm / case clash:

> Finally, a read event X and another memory access event Y are linked =
by a
> control dependency if Y syntactically lies within an arm of an if
> statement and X affects the evaluation of the if condition via a data =
or
> address dependency.  Similarly for switch statements.

What do you think?

Paul



--Apple-Mail=_CE12793D-99B8-4DC2-ABFC-5EC269C2E4F1
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
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MzExNjQyMDVaMC8GCSqGSIb3DQEJBDEiBCCvQZZYb6o43au8
oNzgNCPLy9ravmewAN7h+8tMibr9IjCBrwYJKwYBBAGCNxAEMYGhMIGeMIGNMQswCQYDVQQGEwJE
RTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1
bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEds
b2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswgbEGCyqGSIb3DQEJEAILMYGhoIGeMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4t
VmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwmy+tK+VY08qnS8mswDQYJKoZIhvcNAQELBQAEggEA
lDyFFWmiWelpGbsRo6yprkWTCd94Ll1C6cGDZU6Rg20KhMBIo3BcCOCSN+hCLlgPNp7bcIRhuJ4p
SbLsYRQcRM5olPSHLGGRV0eh4kZvYoql0zL+rBckYsBsyWy50wKpR/NurEKy+9OGpXr+3+b/dxYP
0uEILx1j6ctnWWXMOZpHcf0/l67dTPaSEro52T6it7BaA/AYAKv6gNRxqXL3eyrDw8UYcdLDztAC
diphgA1EdHVyp4pTMZnULlwktE8vBpvtbX95COWAy5/HHgYmC3OZNMCC/8E28CYFGv6wFXGMWLrf
Pb4v+SHg5W9kI1r0NHVueTjEFQ7u4EGy0hMGSwAAAAAAAA==
--Apple-Mail=_CE12793D-99B8-4DC2-ABFC-5EC269C2E4F1--
