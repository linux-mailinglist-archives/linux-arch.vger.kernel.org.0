Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACBC222B56
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGPS6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 14:58:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:59594 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPS6n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 14:58:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2493D297CAB;
        Thu, 16 Jul 2020 14:58:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jho3kzP0Uhx3; Thu, 16 Jul 2020 14:58:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B8552297D0D;
        Thu, 16 Jul 2020 14:58:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B8552297D0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594925921;
        bh=4y3OZc0uvqLRNtfhBnb/Pl6FBzMj468Y31eGzsZO15Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YgwfmSUmKI5QGNkVW/ZZ4DkKkDfr6+Hx/88oYF+i0AnoO/Z9FhYpe84gUEYocOQZs
         9YhXWYkwGT6T1MBDwQSVG52oBQHsCzbEu3te/aG2x3gC6D4Ct4Tg+ZhasUje9+KMDx
         hU95kX5H6X+56H71ssixg7KPiZhw6SOybRTXFdnfUfURYh5zYw+0WneFlzLtl/t4Tt
         JN1LzdW1iz+hxNNqnAVpLaaIAAdfyWLN/KTn9tdroxw0L7iCs0t9rq5BBsFGHyBULI
         j1YpgVOwQwHVBV5Rdk21VIMyt9QZIbAt3Xw3/fbE14m0SXc+CByVsMsZHcPrXKlX/h
         dYSAnCv5SaUAA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T-n-DAhdMKvn; Thu, 16 Jul 2020 14:58:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A1E69297CA8;
        Thu, 16 Jul 2020 14:58:41 -0400 (EDT)
Date:   Thu, 16 Jul 2020 14:58:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nicholas Piggin <npiggin@gmail.com>, paulmck <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Message-ID: <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
In-Reply-To: <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com>
References: <20200710015646.2020871-1-npiggin@gmail.com> <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none> <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com> <1594868476.6k5kvx8684.astroid@bobo.none> <1594873644.viept6os6j.astroid@bobo.none> <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com> <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: cb6zdS0KPjkbq8hxmgetruE+ExgftXKEdKLPFXA9iBY=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 16, 2020, at 12:03 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jul 16, 2020, at 11:46 AM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com wrote:
>>> I should be more complete here, especially since I was complaining
>>> about unclear barrier comment :)
>>> 
>>> 
>>> CPU0                     CPU1
>>> a. user stuff            1. user stuff
>>> b. membarrier()          2. enter kernel
>>> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
>>> d. read rq->curr         4. rq->curr switched to kthread
>>> e. is kthread, skip IPI  5. switch_to kthread
>>> f. return to user        6. rq->curr switched to user thread
>>> g. user stuff            7. switch_to user thread
>>>                         8. exit kernel
>>>                         9. more user stuff
>>> 
>>> What you're really ordering is a, g vs 1, 9 right?
>>> 
>>> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
>>> etc.
>>> 
>>> Userspace does not care where the barriers are exactly or what kernel
>>> memory accesses might be being ordered by them, so long as there is a
>>> mb somewhere between a and g, and 1 and 9. Right?
>> 
>> This is correct.
> 
> Actually, sorry, the above is not quite right. It's been a while
> since I looked into the details of membarrier.
> 
> The smp_mb() at the beginning of membarrier() needs to be paired with a
> smp_mb() _after_ rq->curr is switched back to the user thread, so the
> memory barrier is between store to rq->curr and following user-space
> accesses.
> 
> The smp_mb() at the end of membarrier() needs to be paired with the
> smp_mb__after_spinlock() at the beginning of schedule, which is
> between accesses to userspace memory and switching rq->curr to kthread.
> 
> As to *why* this ordering is needed, I'd have to dig through additional
> scenarios from https://lwn.net/Articles/573436/. Or maybe Paul remembers ?

Thinking further about this, I'm beginning to consider that maybe we have been
overly cautious by requiring memory barriers before and after store to rq->curr.

If CPU0 observes a CPU1's rq->curr->mm which differs from its own process (current)
while running the membarrier system call, it necessarily means that CPU1 had
to issue smp_mb__after_spinlock when entering the scheduler, between any user-space
loads/stores and update of rq->curr.

Requiring a memory barrier between update of rq->curr (back to current process's
thread) and following user-space memory accesses does not seem to guarantee
anything more than what the initial barrier at the beginning of __schedule already
provides, because the guarantees are only about accesses to user-space memory.

Therefore, with the memory barrier at the beginning of __schedule, just observing that
CPU1's rq->curr differs from current should guarantee that a memory barrier was issued
between any sequentially consistent instructions belonging to the current process on
CPU1.

Or am I missing/misremembering an important point here ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> 
>> Note that the accesses to user-space memory can be
>> done either by user-space code or kernel code, it doesn't matter.
>> However, in order to be considered as happening before/after
>> either membarrier or the matching compiler barrier, kernel code
>> needs to have causality relationship with user-space execution,
>> e.g. user-space does a system call, or returns from a system call.
>> 
>> In the case of io_uring, submitting a request or returning from waiting
>> on request completion appear to provide this causality relationship.
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
