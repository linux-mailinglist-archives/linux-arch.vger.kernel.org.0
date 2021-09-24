Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3479A417D80
	for <lists+linux-arch@lfdr.de>; Sat, 25 Sep 2021 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbhIXWJR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 18:09:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:39060 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344504AbhIXWJR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 18:09:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5D29F32AC16;
        Fri, 24 Sep 2021 18:07:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id huf4Uqv36A61; Fri, 24 Sep 2021 18:07:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9820632AB39;
        Fri, 24 Sep 2021 18:07:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9820632AB39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632521262;
        bh=+J8gyCSUPm6OhBHWrLdZOCcHvTo8ECONJ4VqhmzD0kg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PifoYLwz6XEEB/n/YJ4pidMrRRsL/XHatCTKsdVXEsNGc5PxTB9zfN6HdABpOpw0A
         KnjQNN33Ytgo9tRqt6lgF1S7Srfg14koq49W5Wr2p0zsKodjdwIw6w3l3qmjrt7ESv
         CTEVkFDqWS2SJmGpItk8DFvPzqdiVaVykeIBjTB8gvmgY8iEPl0GOrEBBg+9WjidB2
         bxkmDWYh+68gPTUWjGMwmxVXtGdCnEde3Zx2qEcram2rG4YA4f8Aj8yJDxImlgXkDR
         5iYufnDmk6U4F2zeFCsNPTzHPaZhChttrN+ZgLDrchvjBQfIcxlGHgDmQkfsrjUINo
         2ACHfckpUDILA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FzyTiaanLWXC; Fri, 24 Sep 2021 18:07:42 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 80EEF32ABA2;
        Fri, 24 Sep 2021 18:07:42 -0400 (EDT)
Date:   Fri, 24 Sep 2021 18:07:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1956843171.37546.1632521262378.JavaMail.zimbra@efficios.com>
In-Reply-To: <1059471848.37444.1632515991273.JavaMail.zimbra@efficios.com>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <20210924183858.GA25901@localhost> <20210924195535.GC17780@gate.crashing.org> <1059471848.37444.1632515991273.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add volatile_if()
Thread-Index: gKOgxiK5EKp+gxCUYVb9i+alyPg8k0J8RSVX
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 24, 2021, at 4:39 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Sep 24, 2021, at 3:55 PM, Segher Boessenkool segher@kernel.crashing.org
> wrote:
> 
>> Hi!
>> 
>> On Fri, Sep 24, 2021 at 02:38:58PM -0400, Mathieu Desnoyers wrote:
>>> Following the LPC2021 BoF about control dependency, I re-read the kernel
>>> documentation about control dependency, and ended up thinking that what
>>> we have now is utterly fragile.
>>> 
>>> Considering that the goal here is to prevent the compiler from being able to
>>> optimize a conditional branch into something which lacks the control
>>> dependency, while letting the compiler choose the best conditional
>>> branch in each case, how about the following approach ?
>>> 
>>> #define ctrl_dep_eval(x)        ({ BUILD_BUG_ON(__builtin_constant_p((_Bool)
>>> x)); x; })
>>> #define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm volatile goto
>>> ("" : : : "cc", "memory" : l_dummy); (x); })
>>> #define ctrl_dep_if(x)          if ((ctrl_dep_eval(x) && ctrl_dep_emit_loop(1))
>>> || ctrl_dep_emit_loop(0))
>> 
>> [The "cc" clobber only pessimises things: the asm doesn't actually
>> clobber the default condition code register (which is what "cc" means),
>> and you can have conditional branches using other condition code
>> registers, or on other registers even (general purpose registers is
>> common.]
> 
> I'm currently considering removing both "memory" and "cc" clobbers from
> the asm goto.
> 
>> 
>>> The idea is to forbid the compiler from considering the two branches as
>>> identical by adding a dummy loop in each branch with an empty asm goto.
>>> Considering that the compiler should not assume anything about the
>>> contents of the asm goto (it's been designed so the generated assembly
>>> can be modified at runtime), then the compiler can hardly know whether
>>> each branch will trigger an infinite loop or not, which should prevent
>>> unwanted optimisations.
>> 
>> The compiler looks if the code is identical, nothing more, nothing less.
>> There are no extra guarantees.  In principle the compiler could see both
>> copies are empty asms looping to self, and so consider them equal.
> 
> I would expect the compiler not to attempt combining asm goto based on their
> similarity because it has been made clear starting from the original
> requirements
> from the kernel community to the gcc developers that one major use-case of asm
> goto involves self-modifying code (patching between nops and jumps).
> 
> If this happens to be a real possibility, then we may need to work-around this
> for
> other uses of asm goto as well.

Now that I page back this stuff into my brain (I last looked at it in details some
12 years ago), I recall that letting compilers combine asm goto statements which
happen to match CSE was actually something we wanted to permit, because we don't care
about editing the nops into jumps for each individual asm goto if they happen
to have the same effect when modified.

> 
> If there is indeed a scenario where the compiler can combine similar asm goto
> statements,
> then I suspect we may want to emit unique dummy code in the assembly which gets
> placed in a
> discarded section, e.g.:
> 
> #define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm goto (
> \
>                ".pushsection .discard.ctrl_dep\n\t"                            \
>                ".long " __stringify(__COUNTER__) "\n\t"                        \
>                ".popsection\n\t"                                               \
>                "" : : : : l_dummy); (x); })
> 

So I think your point is very much valid: we need some way to make the content of the asm goto
different between the two branches. I think the __COUNTER__ approach is overkill though:
we don't care about making each of the asm goto loop unique within the entire file;
we just don't want them to match between the two legs of the branch.

So something like this should be enough:

#define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm goto (       \
                ".pushsection .discard.ctrl_dep\n\t"                            \
                ".long " __stringify(x) "\n\t"                                  \
                ".popsection\n\t"                                               \
                "" : : : : l_dummy); (x); })

So we emit respectively a 0 and 1 into the discarded section.

Thoughts ?

Thanks,

Mathieu


> But then a similar trick would be needed for jump labels as well.
> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
