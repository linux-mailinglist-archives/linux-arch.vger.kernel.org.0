Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79F417C53
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348414AbhIXUYN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 16:24:13 -0400
Received: from mail.efficios.com ([167.114.26.124]:56612 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348406AbhIXUYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 16:24:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4F88B32A286;
        Fri, 24 Sep 2021 16:22:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ubnydGavbSbG; Fri, 24 Sep 2021 16:22:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9519632A046;
        Fri, 24 Sep 2021 16:22:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9519632A046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632514956;
        bh=YOIiaTIjSWSIDVY7x919ScLocg4hGeXlWAaaAgSsT3g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EcWiwkWHgCbolkPK54UoSOGHyBh7sLnqQysFiJ6LBzQqRavhhHJEFqSHcv6uz7Q7D
         eAs2k9d5EKD3DPviyLjnW3+3SRYGZZ+yXFMGyGOQRNEzuJlM+EMy/KS+qGIjVOBSbe
         ourNAhWdTdzxTLT6RhoCDtrTnf42fvy8oIVOLcc3+OLQVuDTi1qLAawaxDehGXjNEJ
         zR0WxyEA4dPzKj2Znh6Nx841pM4iNBXk4IRbRFkQNJCdqwBNC9ajNV8DNipmpw2OLU
         DS3yRuh1fGM9rwl0Z/QGb4+RNq/glWZwWXXa2NWleakxIIPNSYY4GGdiyFjWFcVht6
         aqkXxS6x+fLDQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6uiIKt2BVKzp; Fri, 24 Sep 2021 16:22:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7FB4032A30A;
        Fri, 24 Sep 2021 16:22:36 -0400 (EDT)
Date:   Fri, 24 Sep 2021 16:22:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>, akiyks@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1103437077.37428.1632514956401.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210924195223.GA287835@rowland.harvard.edu>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <20210924183858.GA25901@localhost> <20210924195223.GA287835@rowland.harvard.edu>
Subject: Re: [RFC] LKMM: Add volatile_if()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add volatile_if()
Thread-Index: gKJxIHbLtmSI3npLIydDVLk94GMdmg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 24, 2021, at 3:52 PM, Alan Stern stern@rowland.harvard.edu wrote:

> On Fri, Sep 24, 2021 at 02:38:58PM -0400, Mathieu Desnoyers wrote:
>> Hi,
>> 
>> Following the LPC2021 BoF about control dependency, I re-read the kernel
>> documentation about control dependency, and ended up thinking that what
>> we have now is utterly fragile.
>> 
>> Considering that the goal here is to prevent the compiler from being able to
>> optimize a conditional branch into something which lacks the control
>> dependency, while letting the compiler choose the best conditional
>> branch in each case, how about the following approach ?
>> 
>> #define ctrl_dep_eval(x)        ({ BUILD_BUG_ON(__builtin_constant_p((_Bool)
>> x)); x; })
>> #define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm volatile goto
>> ("" : : : "cc", "memory" : l_dummy); (x); })
>> #define ctrl_dep_if(x)          if ((ctrl_dep_eval(x) && ctrl_dep_emit_loop(1))
>> || ctrl_dep_emit_loop(0))
>> 
>> The idea is to forbid the compiler from considering the two branches as
>> identical by adding a dummy loop in each branch with an empty asm goto.
>> Considering that the compiler should not assume anything about the
>> contents of the asm goto (it's been designed so the generated assembly
>> can be modified at runtime), then the compiler can hardly know whether
>> each branch will trigger an infinite loop or not, which should prevent
>> unwanted optimisations.
>> 
>> With this approach, the following code now keeps the control dependency:
>> 
>> 	z = READ_ONCE(var1);
>>         ctrl_dep_if (z)
>>                 WRITE_ONCE(var2, 5);
>>         else
>>                 WRITE_ONCE(var2, 5);
>> 
>> And the ctrl_dep_eval() checking the constant triggers a build error
>> for:
>> 
>>         y = READ_ONCE(var1);
>>         ctrl_dep_if (y % 1)
>>                 WRITE_ONCE(var2, 5);
>>         else
>>                 WRITE_ONCE(var2, 6);
>> 
>> Which is good to have to ensure the compiler don't end up removing the
>> conditional branch because the resulting evaluation ends up evaluating a
>> constant.
>> 
>> Thoughts ?
> 
> As I remember the earlier discussion, Linus felt that the kernel doesn't
> really need any sort of explicit control dependency (although we called
> it "volatile if").  In many cases there is an actual semantic
> dependency, so it doesn't matter what the compiler does -- the hardware
> will enforce the actual dependency.  In other cases, we can work around
> the issue by using acquire loads or release stores.

IMHO, having to chase down what the instruction selection does on every
architecture for every supported compiler for each control dependency in
order to confirm that the control dependency is still present in the resulting
assembly is fragile. If the kernel really doesn't need explicit control
dependency, then maybe the whole notion of "control dependency"-based
ordering should be removed in favor of explicit acquire loads/release stores
and barriers.

> In fact, Linus's biggest wish was to have a weak form of compiler
> barrier, one which would block the compiler from reordering accesses
> across the barrier but wouldn't invalidate the compiler's knowledge
> about the values of earlier reads (which barrier() would do).

Then maybe we could simply tweak the ctrl_dep_emit_loop() implementation and
remove the "memory" clobber. Then its only effect is to prevent the compiler
from knowing whether there is an infinite loop, thus preventing reordering
accesses across the conditional branch without requiring the compiler to
discard earlier reads:

#define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm_volatile_goto ("" : : : : l_dummy); (x); })

and for the records, the ctrl_dep_eval(x) implementation needs extra parentheses:

#define ctrl_dep_eval(x)        ({ BUILD_BUG_ON(__builtin_constant_p((_Bool) (x))); (x); })

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
