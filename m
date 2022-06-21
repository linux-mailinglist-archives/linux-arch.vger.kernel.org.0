Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67539553185
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349327AbiFUL7o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiFUL7i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 07:59:38 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4E2B1A1;
        Tue, 21 Jun 2022 04:59:36 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id DFFFC24C;
        Tue, 21 Jun 2022 13:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1655812768;
        bh=HJy0kdLOn3sZzNx6HdmqXo8gxMramx22W2vHUjsA2e0=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=qBeSiEI2A0dsK/gqxs78bN5dnKH6PeqrMzyddNPIIJAk57CvaI21fnWF84QUl68/k
         6f7VC4bA76KtLEQOVBlP/YjzveDKWuJ9rWOWT1n8O8aDTk+bLjsTY+AKaveSyYZSwE
         +l2UXhSnKpBMkMCoMx0NZnu2yZeGJHLBtf9+ot19D5PH80IU/k5Yr7sQ5wpnd9h0TD
         PVY12UrHz2NIY1s85xs2Fz4oMyfQJ2zWiPzoRPji7OIERKo+hIygKPqGhEREom0IxZ
         8VEmUe5Nh3SQPpDK/cn+tg3PD9zCxQYucvUDtF3k3WBgzyJ+84f4SlirmXKJ71QQ+t
         Ds1jYZz1rm/mQ==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id DAC1DDD; Tue, 21 Jun 2022 13:59:28 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id A4DE9D6;
        Tue, 21 Jun 2022 13:59:28 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 9F9C0CE;
        Tue, 21 Jun 2022 13:59:28 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 9A1864A02D7; Tue, 21 Jun 2022 13:59:28 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 6BF584A0107;
        Tue, 21 Jun 2022 13:59:27 +0200 (CEST)
        (Extended-Queue-bit xtech_sz@fff.in.tum.de)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
Date:   Tue, 21 Jun 2022 13:59:27 +0200
Cc:     llvm@lists.linux.dev, linux-toolchains@vger.kernel.org,
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
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

Thanks for taking the time to read and provide feedback - much =
appreciated!

> On 15. Jun 2022, at 16:16, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>=20
> On Wed, Jun 15, 2022 at 11:43:29AM +0000, Paul Heidekr=C3=BCger wrote:
>> Hi all,
>>=20
>> I have been confused by explanation.txt's definition of control
>> dependencies:
>>=20
>>> Finally, a read event and another memory access event are linked by =
a
>>> control dependency if the value obtained by the read affects whether
>>> the second event is executed at all.
>>=20
>> I'll go into the following:
>>=20
>> =3D=3D=3D=3D
>> 1. "At all", to me, is misleading
>> 1.1 The code which confused me
>> 1.2 The traditional definition via post-dominance doesn't work either
>> 2. Solution
>> =3D=3D=3D=3D
>>=20
>> 1. "At all", to me, is misleading:
>>=20
>> "At all" to me suggests a question for which we require a definitive
>> "yes" or "no" answer: given a programme and an input, can a certain
>> piece of code be executed? Can we always answer this this question?
>> Doesn't this sound similar to the halting problem?
>=20
> No. You're not thinking about this the right way.
>=20
> The point of view we take in this document and in the LKMM is not like=20=

> the view in a static analysis of a program. It is a dynamic analysis =
of=20
> one particular execution of a program. The halting problem does not=20
> apply. Note for instance that explanation.txt talks about "events"=20
> rather than instructions or pieces of code.
>=20
> (The single-execution-at-a-time point of view has its own limitations,=20=

> which do have some adverse affects on the LKMM. But we don't want to=20=

> exceed the capabilities of the herd7 tool.)
>=20
>> 1.1 The Example which confused me:
>>=20
>> For the dependency checker project [1], I've been thinking about
>> tracking dependency chains in code, and I stumbled upon the following
>> edge case, which made me question the "at all" part of the current
>> definition. The below C-code is derived from some optimised kernel =
code
>> in LLVM intermediate representation (IR) I encountered:
>>=20
>>> int *x, *y;
>>>=20
>>> int foo()
>>> {
>>> /* More code */
>>>=20
>>> 	 loop:
>>> 		/* More code */
>>>=20
>>> 	 	if(READ_ONCE(x)) {
>>> 	 		WRITE_ONCE(y, 42);
>>> 	 		return 0;
>>> 	 	}
>>>=20
>>> 		/* More code */
>>>=20
>>> 	 	goto loop;
>>>=20
>>> /* More code */
>>> }
>>=20
>> Assuming that foo() will return, the READ_ONCE() does not determine
>> whether the WRITE_ONCE() will be executed __at all__, as it will be
>> executed exactly when the function returns, instead, it determines
>> __when__ the WRITE_ONCE() will be executed.
>=20
> But what if your assumption is wrong?
>=20
> In any case, your question displays an incorrect viewpoint. For=20
> instance, the READ_ONCE() does not count as a single event. Rather,=20
> each iteration through the loop executes a separate instance of the=20
> READ_ONCE(), and each instance counts as its own event. Think of =
events=20
> not as static entities in the program source but instead as the items =
in=20
> the queue that gets fed into the CPU's execution unit at run time.
>=20
> Strictly speaking, one could say there is a control dependency from =
each=20
> of these READ_ONCE() events to the final WRITE_ONCE(). However the =
LKMM=20
> takes a more limited viewpoint, saying that a dependency from a load =
to=20
> the controlling expression of an "if" statement only affects the=20
> execution of the events corresponding to statements lying statically =
in=20
> the two arms of the "if". In your example the "if" has a single arm,=20=

> and so only the access in that arm is considered to have a control=20
> dependency from the preceding instance of the READ_ONCE(). And it=20
> doesn't have a control dependency from any of the earlier iterations =
of=20
> the READ_ONCE(), because it doesn't lie in any of the arms of the=20
> earlier iterations of the "if".

OK. So, LKMM limits the scope of control dependencies to its arm(s), =
hence
there is a control dependency from the last READ_ONCE() before the loop
exists to the WRITE_ONCE().

But then what about the following:

> int *x, *y;
>=20
> int foo()
> {
> 	/* More code */
>=20
> 	if(READ_ONCE(x))
> 		return 42;
>=20
> 	/* More code */
>=20
> 	WRITE_ONCE(y, 42);
>=20
> 	/* More code */
>=20
> 	return 0;
> }

The READ_ONCE() determines whether the WRITE_ONCE() will be executed at =
all,
but the WRITE_ONCE() doesn't lie in the if condition's arm. However, by
"inverting" the if, we get the following equivalent code:

> if(!READ_ONCE(x)) {
> 	/* More code */
>=20
> 	WRITE_ONCE(y, 42);
>=20
> 	/* More code */
>=20
> 	return 0;
> }
>=20
> return 42;

Now, the WRITE_ONCE() is in the if's arm, and there is clearly a control
dependency.

Similar cases:

> if(READ_ONCE())
> 	foo(); /* WRITE_ONCE() in foo() */
> return 42;

or

> if(READ_ONCE())
>     goto foo; /* WRITE_ONCE() after foo */
> return 42;

In both cases, the WRITE_ONCE() again isn't in the if's arm =
syntactically
speaking, but again, with rewriting, you can end up with a control
dependency; in the first case via inlining, in the second case by simply
copying the code after the "foo" marker.

>> 1.2. The definition via post-dominance doesn't work either:
>>=20
>> I have seen control dependencies being defined in terms of the first
>> basic block that post-dominates the basic block of the if-condition,
>> that is the first basic block control flow must take to reach the
>> function return regardless of what the if condition returned.
>>=20
>> E.g. [2] defines control dependencies as follows:
>>=20
>>> A statement y is said to be control dependent on another statement x
>>> if (1) there exists a nontrivial path from x to y such that every
>>> statement z !=3D x in the path is post-dominated by y, and (2) x is =
not
>>> post-dominated by y.
>>=20
>> Again, this definition doesn't work for the example above. As the =
basic
>> block of the if branch trivially post-dominates any other basic =
block,
>> because it contains the function return.
>=20
> Again, not applicable as basic blocks, multiple paths, and so on =
belong=20
> to static analysis.
>=20
>> 2. Solution:
>>=20
>> The definition I came up with instead is the following:
>>=20
>>> A basic block B is control-dependent on a basic block A if
>>> B is reachable from A, but control flow can take a path through A
>>> which avoids B. The scope of a control dependency ends at the first
>>> basic block where all control flow paths running through A meet.
>>=20
>> Note that this allows control dependencies to remain "unresolved".

The "unresolved" part in my initial definition was inspired by cases =
such as
the ones above and the loop example from my previous email, where the
"paths" could be somewhat thought of as executions. But yes, as you =
said,
that's static analysis and not the position LKMM takes.

Many thanks,
Paul

--
PS replacing "Palmer Dabbelt <palmerdabbelt@google.com>" with "Palmer
Dabbelt <palmer@dabbelt.com>" in recipients - my maintainers file was
outdated.

>> I'm happy to submit a patch which covers more of what I mentioned =
above
>> as part of explanation.txt, but figured that in the spirit of keeping
>> things simple, leaving out "at all" might be enough?
>>=20
>> What do you think?
>=20
> Not so good. A better description would be that there is a control=20
> dependency from a read event X to a memory access event Y if there is =
a=20
> dependency (data or address) from X to the conditional branch event of=20=

> an "if" statement which contains Y in one of its arms. And similarly=20=

> for "switch" statements.
>=20
> Alan
>=20
>> Many thanks,
>> Paul
>>=20
>> [1]: =
https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/T/#=
u
>> [2]: Optimizing Compilers for Modern Architectures: A =
Dependence-Based
>> Approach, Randy Allen, Ken Kennedy, 2002, p. 350
>>=20
>> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
>> Cc: Marco Elver <elver@google.com>
>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
>> Cc: Martin Fink <martin.fink@in.tum.de>
>> ---
>> tools/memory-model/Documentation/explanation.txt | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/memory-model/Documentation/explanation.txt =
b/tools/memory-model/Documentation/explanation.txt
>> index ee819a402b69..42af7ed91313 100644
>> --- a/tools/memory-model/Documentation/explanation.txt
>> +++ b/tools/memory-model/Documentation/explanation.txt
>> @@ -466,7 +466,7 @@ pointer.
>>=20
>> Finally, a read event and another memory access event are linked by a
>> control dependency if the value obtained by the read affects whether
>> -the second event is executed at all. Simple example:
>> +the second event is executed. Simple example:
>>=20
>> 	int x, y;
>>=20
>> --=20
>> 2.35.1
