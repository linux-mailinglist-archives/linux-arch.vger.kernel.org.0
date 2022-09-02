Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2F5AAA43
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiIBIkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiIBIkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 04:40:43 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9C7DF63;
        Fri,  2 Sep 2022 01:40:40 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 59BF94D;
        Fri,  2 Sep 2022 10:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1662108035;
        bh=lVQfbswmYqI5C4vhW2BWNdNZzmgVe3OvE0e0UJV9l+4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=k68D/ZUge+BObfQr5wLNhD/sYvpy4yYPqSf1sACQNTXcjpoEqfiuLGxwYAljrGZyT
         5kB469jiQGAUJK9oerqmsc4H4y60HzgL0WQqigV1xsEzyHA06eIHgkscQRkXs52v98
         rJ0lLpeAcXa5edi7IdMaJwfDMv6apJNZi/XV7an/mcSGqsnDULNw4Ie9tbmzuwmLPw
         6YNJIrAmVmnrhYXOGL9ijmTRT5E9GnFqvG/eXGEQmhiULsBmDlJ5WSW9IKKjJmz3as
         cigZ9TNqGtXPmQPF3Pbu1JOZUf3o1XrnYpV47wQ1pwS+V06eT4VBoveDe/iayBH3pB
         tKCPoGyNT03HQ==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 543211A9A; Fri,  2 Sep 2022 10:40:35 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 250FC1A99;
        Fri,  2 Sep 2022 10:40:35 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 2074A1A98;
        Fri,  2 Sep 2022 10:40:35 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 1BE934A041F; Fri,  2 Sep 2022 10:40:35 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 973774A02B0;
        Fri,  2 Sep 2022 10:40:34 +0200 (CEST)
        (Extended-Queue-bit xtech_aa@fff.in.tum.de)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] tools/memory-model: Weaken ctrl dependency definition in
 explanation.txt
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
Date:   Fri, 2 Sep 2022 10:40:34 +0200
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
Message-Id: <EE1FA3DC-5A38-45EC-97AB-44B19C1C7707@in.tum.de>
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
 <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
 <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
 <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
 <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
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

On 31. Aug 2022, at 19:38, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, Aug 31, 2022 at 06:42:05PM +0200, Paul Heidekr=C3=BCger wrote:
>> On 31. Aug 2022, at 03:57, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>>=20
>>> On Tue, Aug 30, 2022 at 05:12:33PM -0400, Joel Fernandes wrote:
>>>> On 8/30/2022 5:08 PM, Joel Fernandes wrote:
>>>>> On 8/30/2022 4:44 PM, Paul Heidekr=C3=BCger wrote:
>>>>>> The current informal control dependency definition in =
explanation.txt is
>>>>>> too broad and, as dicsussed, needs to be updated.
>>>>>>=20
>>>>>> Consider the following example:
>>>>>>=20
>>>>>>> if(READ_ONCE(x))
>>>>>>> 	return 42;
>>>>>>>=20
>>>>>>> 	WRITE_ONCE(y, 42);
>>>>>>>=20
>>>>>>> 	return 21;
>>>>>>=20
>>>>>> The read event determines whether the write event will be =
executed "at
>>>>>> all" - as per the current definition - but the formal LKMM does =
not
>>>>>> recognize this as a control dependency.
>>>>>>=20
>>>>>> Introduce a new defintion which includes the requirement for the =
second
>>>>>> memory access event to syntactically lie within the arm of a =
non-loop
>>>>>> conditional.
>>>>>>=20
>>>>>> Link: =
https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.=
tum.de/
>>>>>> Cc: Marco Elver <elver@google.com>
>>>>>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
>>>>>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
>>>>>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
>>>>>> Cc: Martin Fink <martin.fink@in.tum.de>
>>>>>> Signed-off-by: Paul Heidekr=C3=BCger =
<paul.heidekrueger@in.tum.de>
>>>>>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
>>>>>> ---
>>>>>>=20
>>>>>> @Alan:
>>>>>>=20
>>>>>> Since I got it wrong the last time, I'm adding you as a =
co-developer after my
>>>>>> SOB. I'm sorry if this creates extra work on your side due to you =
having to
>>>>>> resubmit the patch now with your SOB if I understand correctly, =
but since it's
>>>>>> based on your wording from the other thread, I definitely wanted =
to give you
>>>>>> credit.
>>>>>>=20
>>>>>> tools/memory-model/Documentation/explanation.txt | 7 ++++---
>>>>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>=20
>>>>>> diff --git a/tools/memory-model/Documentation/explanation.txt =
b/tools/memory-model/Documentation/explanation.txt
>>>>>> index ee819a402b69..0bca50cac5f4 100644
>>>>>> --- a/tools/memory-model/Documentation/explanation.txt
>>>>>> +++ b/tools/memory-model/Documentation/explanation.txt
>>>>>> @@ -464,9 +464,10 @@ to address dependencies, since the address =
of a location accessed
>>>>>> through a pointer will depend on the value read earlier from that
>>>>>> pointer.
>>>>>>=20
>>>>>> -Finally, a read event and another memory access event are linked =
by a
>>>>>> -control dependency if the value obtained by the read affects =
whether
>>>>>> -the second event is executed at all.  Simple example:
>>>>>> +Finally, a read event X and another memory access event Y are =
linked by
>>>>>> +a control dependency if Y syntactically lies within an arm of an =
if,
>>>>>> +else or switch statement and the condition guarding Y is either =
data or
>>>>>> +address-dependent on X.  Simple example:
>>=20
>> Thank you both for commenting!
>>=20
>>> "if, else or switch" should be just "if or switch".  In C there is =
no=20
>>> such thing as an "else" statement; an "else" clause is merely part =
of=20
>>> an "if" statement.  In fact, maybe "body" would be more appropriate =
than=20
>>> "arm", because "switch" statements don't have arms -- they have =
cases.
>>=20
>> Right. What do you think of "branch"? "Body" to me suggests that =
there's
>> only one and therefore that the else clause isn't included.
>>=20
>> Would it be fair to say that switch statements have branches? I guess
>> because switch statements are a convenient way of writing goto's, =
i.e.
>> jumps, it's a stretch and basically the same as saying "arm"?
>>=20
>> Maybe we can avoid the arm / case clash by just having a definition =
for if
>> statements and appending something like "similarly for switch =
statements"?
>=20
> That sounds good.
>=20
>>>>> 'conditioning guarding Y' sounds confusing to me as it implies to =
me that the
>>>>> condition's evaluation depends on Y. I much prefer Alan's wording =
from the
>>>>> linked post saying something like 'the branch condition is data or =
address
>>>>> dependent on X, and Y lies in one of the arms'.
>>>>>=20
>>>>> I have to ask though, why doesn't this imply that the second =
instruction never
>>>>> executes at all? I believe that would break the MP-pattern if it =
were not true.
>>>>=20
>>>> About my last statement, I believe your patch does not disagree =
with the
>>>> correctness of the earlier text but just wants to improve it. If =
that's case
>>>> then that's fine.
>>>=20
>>> The biggest difference between the original text and Paul's =
suggested=20
>>> update is that the new text makes clear that Y has to lie within the=20=

>>> body of the "if" or "switch" statement.  If Y follows the end of the=20=

>>> if/else, as in the example at the top of this email, then it does =
have=20
>>> not a control dependency on X (at least, not via that if/else), even=20=

>>> though the value read by X does determine whether or not Y will =
execute.
>>>=20
>>> [It has to be said that this illustrates a big weakness of the LKMM: =
It=20
>>> isn't cognizant of "goto"s or "return"s.  This naturally derives =
from=20
>>> limitations of the herd tool, but the situation could be improved.  =
So=20
>>> for instance, I don't think it would cause trouble to say that in:
>>>=20
>>> 	if (READ_ONCE(x) =3D=3D 0)
>>> 		return;
>>> 	WRITE_ONCE(y, 5);
>>>=20
>>> there really is a control dependence from x to y, even though the=20
>>> WRITE_ONCE is outside the body of the "if" statement.  Certainly the=20=

>>> compiler can't reorder the write before the read.  But AFAIK there's =
no=20
>>> way to include a "return" statement in a litmus test for herd.  Or a=20=

>>> subroutine definition, for that matter.]
>>>=20
>>> I agree that "condition guarding Y" is somewhat awkward.  "the=20
>>> condition of the if (or the expression of the switch)" might be =
better,=20
>>> even though it is somewhat awkward as well.  At least it's more=20
>>> explicit.
>>=20
>> Maybe we can reuse the wording from the data and address dependency
>> definition here and say "affects"?
>>=20
>> Putting it all together:
>>=20
>>> Finally, a read event X and another memory access event Y are linked =
by a
>>> control dependency if Y syntactically lies within a branch of an if =
or
>>> switch statement and X affects the evaluation of that statement's
>>> condition via a data or address dependency.
>>=20
>> Alternatively without the arm / case clash:
>>=20
>>> Finally, a read event X and another memory access event Y are linked =
by a
>>> control dependency if Y syntactically lies within an arm of an if
>>> statement and X affects the evaluation of the if condition via a =
data or
>>> address dependency.  Similarly for switch statements.
>>=20
>> What do you think?
>=20
> I like the second one.  How about combining the last two sentences? =20=

>=20
> 	... via a data or address dependency (or similarly for a switch=20=

> 	statement).

Yes, sounds good!

> Now I suppose someone will pipe up and ask about the conditional=20
> expressions in "for", "while" and "do" statements...  :-)

Happy to have obliged :-)
=
https://lore.kernel.org/all/20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de=
/

Do you think the text should explicitly address control dependencies in =
the
context of loops as well? If yes, would it be a separate patch, or would =
it
make sense to combine it with this one?

Many thanks,
Paul


