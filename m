Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C25706C4
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jul 2022 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiGKPPF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGKPPE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 11:15:04 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ADF23BF7;
        Mon, 11 Jul 2022 08:15:02 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id EB29193;
        Mon, 11 Jul 2022 17:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1657552496;
        bh=AG32tvZWUQivMY7wa6JiB6OXo61E9jsHNTjxNqoKtOk=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=t/0qy6KtydlTlh072BHXr0e5Y5cYKjoDu6nLgO9tv+4nVOyV1aLpjdErggDvTfEPt
         MCkliDAiuS65oTeh6T0Z0sPqsDdU4HeQLS5WK8hUQcoZNfZRH+QYbPAn0MiiqwToPh
         2faLC7KYI/EPb+ZZl2ahWDTFvTIyoEvyHGf/wrMjRZKsJe0YrTesZOOjLRElZ+dJIX
         SVYjGPO97eNLbiO3d67AChO5hN+TsCAjSjKom1TiwGeba+7tw2/hyvkHZnnonItoGQ
         EhVzSL3yq/7FlHApuNiKkugFzkVfKWiOxNih0ewuXzVNU6B4pf8OgJDZQKFCL0Et5m
         iRYbYyprdJCng==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id E3807D6; Mon, 11 Jul 2022 17:14:56 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id B52B6D2;
        Mon, 11 Jul 2022 17:14:56 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id B0AA9CE;
        Mon, 11 Jul 2022 17:14:56 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id A3A1F4A0129; Mon, 11 Jul 2022 17:14:56 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 229EA4A0115;
        Mon, 11 Jul 2022 17:14:56 +0200 (CEST)
        (Extended-Queue-bit xtech_gw@fff.in.tum.de)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] tools/memory-model: Clarify LKMM's limitations in
 litmus-tests.txt
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <20220708184749.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 11 Jul 2022 17:14:55 +0200
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE1854E3-C33D-4A4E-AC31-4194A701052B@in.tum.de>
References: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
 <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
 <CANpmjNOkXz=+221i70CWJexQWwfA_By3+7Cnimwgjmwn7RQdBg@mail.gmail.com>
 <YshC8sJ4dZq3m2wy@rowland.harvard.edu>
 <20220708184749.GW1790663@paulmck-ThinkPad-P17-Gen-1>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On 8. Jul 2022, at 20:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> On Fri, Jul 08, 2022 at 10:45:06AM -0400, Alan Stern wrote:
>> On Fri, Jul 08, 2022 at 01:44:06PM +0200, Marco Elver wrote:
>>> On Tue, 14 Jun 2022 at 17:49, Paul Heidekr=C3=BCger
>>> <paul.heidekrueger@in.tum.de> wrote:
>>>> As discussed, clarify LKMM not recognizing certain kinds of =
orderings.
>>>> In particular, highlight the fact that LKMM might deliberately make
>>>> weaker guarantees than compilers and architectures.
>>>>=20
>>>> Link: =
https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/=
#u
>>>> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
>>>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
>>>=20
>>> Reviewed-by: Marco Elver <elver@google.com>
>>>=20
>>> However with the Co-developed-by, this is missing Alan's SOB.
>>=20
>> For the record:
>>=20
>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>>=20
>> (Note that according to Documentation/process/submitting-patches.rst,=20=

>> the submitting author's SOB is supposed to come last.)
>=20
> And this is what I ended up with. Please provide additional feedback
> as needed, and in the meantime, thank you all!
>=20
> 							Thanx, Paul

Looks great - my first commit in the Linux kernel!

Thanks everyone!

Paul

> =
------------------------------------------------------------------------
>=20
> commit 3c7753e959706f39e1ee183ef8dcde3b4cfbb4c7
> Author: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
> Date: Tue Jun 14 15:48:11 2022 +0000
>=20
> tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt
>=20
> As discussed, clarify LKMM not recognizing certain kinds of orderings.
> In particular, highlight the fact that LKMM might deliberately make
> weaker guarantees than compilers and architectures.
>=20
> Link: =
https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/=
#u
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
> Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/tools/memory-model/Documentation/litmus-tests.txt =
b/tools/memory-model/Documentation/litmus-tests.txt
> index 8a9d5d2787f9e..cc355999815cb 100644
> --- a/tools/memory-model/Documentation/litmus-tests.txt
> +++ b/tools/memory-model/Documentation/litmus-tests.txt
> @@ -946,22 +946,39 @@ Limitations of the Linux-kernel memory model =
(LKMM) include:
> 	carrying a dependency, then the compiler can break that =
dependency
> 	by substituting a constant of that value.
>=20
> -	Conversely, LKMM sometimes doesn't recognize that a particular
> -	optimization is not allowed, and as a result, thinks that a
> -	dependency is not present (because the optimization would break =
it).
> -	The memory model misses some pretty obvious control dependencies
> -	because of this limitation. A simple example is:
> +	Conversely, LKMM will sometimes overestimate the amount of
> +	reordering compilers and CPUs can carry out, leading it to miss
> +	some pretty obvious cases of ordering. A simple example is:
>=20
> 		r1 =3D READ_ONCE(x);
> 		if (r1 =3D=3D 0)
> 			smp_mb();
> 		WRITE_ONCE(y, 1);
>=20
> -	There is a control dependency from the READ_ONCE to the =
WRITE_ONCE,
> -	even when r1 is nonzero, but LKMM doesn't realize this and =
thinks
> -	that the write may execute before the read if r1 !=3D 0. (Yes, =
that
> -	doesn't make sense if you think about it, but the memory model's
> -	intelligence is limited.)
> +	The WRITE_ONCE() does not depend on the READ_ONCE(), and as a
> +	result, LKMM does not claim ordering. However, even though no
> +	dependency is present, the WRITE_ONCE() will not be executed =
before
> +	the READ_ONCE(). There are two reasons for this:
> +
> + The presence of the smp_mb() in one of the branches
> + prevents the compiler from moving the WRITE_ONCE()
> + up before the "if" statement, since the compiler has
> + to assume that r1 will sometimes be 0 (but see the
> + comment below);
> +
> + CPUs do not execute stores before po-earlier conditional
> + branches, even in cases where the store occurs after the
> + two arms of the branch have recombined.
> +
> +	It is clear that it is not dangerous in the slightest for LKMM =
to
> +	make weaker guarantees than architectures. In fact, it is
> +	desirable, as it gives compilers room for making optimizations.=20=

> +	For instance, suppose that a 0 value in r1 would trigger =
undefined
> +	behavior elsewhere. Then a clever compiler might deduce that r1
> +	can never be 0 in the if condition. As a result, said clever
> +	compiler might deem it safe to optimize away the smp_mb(),
> +	eliminating the branch and any ordering an architecture would
> +	guarantee otherwise.
>=20
> 2.	Multiple access sizes for a single variable are not supported,
> 	and neither are misaligned or partially overlapping accesses.
