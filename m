Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC1223D17
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQNjd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 09:39:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:49166 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNj1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 09:39:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1C9DE29F146;
        Fri, 17 Jul 2020 09:39:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a15JU_fDvL6I; Fri, 17 Jul 2020 09:39:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 97BDF29EF4F;
        Fri, 17 Jul 2020 09:39:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 97BDF29EF4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594993165;
        bh=ho3rQgiZeUOl9J/OSDI/gUB2Ws43sIkMwoNwsX55GPA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oGIDAZ6EOIzYWMIZ5+6XDCyoz4E4lrtFs31tP5HpcGze+6LjTM3T0kPAIrN4uUg8s
         7kFHqjKF43K3O5IvtcK87G1flnjoG0QUJ5E86lfx17AqcimzhK6xRNvSwHf+AgIo6A
         VTQ2wZF3iQG+rAu/otjNMFRnvOVWLBqOaP6fNHHa/9OAbOwjjI41BB7GXPSHiVPrWn
         CRb7rbHFWfvwQlxcPBfZL8R7AHk3SgfbPk5rGherwvbO252Mrypgj0lzJGyvRht8x0
         1dkpbYYjyg+w9bVx9a6hbpigNgs9rgFGWum+fLWjUjj1F9F+NksTfndzkaMUql9E1F
         zM652Us5g+YcQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HrNAfA0SCl91; Fri, 17 Jul 2020 09:39:25 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 809AA29F380;
        Fri, 17 Jul 2020 09:39:25 -0400 (EDT)
Date:   Fri, 17 Jul 2020 09:39:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Nicholas Piggin <npiggin@gmail.com>, paulmck <paulmck@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Message-ID: <1770378591.18523.1594993165391.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200716212416.GA1126458@rowland.harvard.edu>
References: <20200710015646.2020871-1-npiggin@gmail.com> <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com> <1594868476.6k5kvx8684.astroid@bobo.none> <1594873644.viept6os6j.astroid@bobo.none> <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com> <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com> <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com> <20200716212416.GA1126458@rowland.harvard.edu>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: e+Q5q0VLw7mhLri8n+Io1sYRjSAWBg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 16, 2020, at 5:24 PM, Alan Stern stern@rowland.harvard.edu wrote:

> On Thu, Jul 16, 2020 at 02:58:41PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 16, 2020, at 12:03 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > ----- On Jul 16, 2020, at 11:46 AM, Mathieu Desnoyers
>> > mathieu.desnoyers@efficios.com wrote:
>> > 
>> >> ----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> >>> I should be more complete here, especially since I was complaining
>> >>> about unclear barrier comment :)
>> >>> 
>> >>> 
>> >>> CPU0                     CPU1
>> >>> a. user stuff            1. user stuff
>> >>> b. membarrier()          2. enter kernel
>> >>> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
>> >>> d. read rq->curr         4. rq->curr switched to kthread
>> >>> e. is kthread, skip IPI  5. switch_to kthread
>> >>> f. return to user        6. rq->curr switched to user thread
>> >>> g. user stuff            7. switch_to user thread
>> >>>                         8. exit kernel
>> >>>                         9. more user stuff
>> >>> 
>> >>> What you're really ordering is a, g vs 1, 9 right?
>> >>> 
>> >>> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
>> >>> etc.
>> >>> 
>> >>> Userspace does not care where the barriers are exactly or what kernel
>> >>> memory accesses might be being ordered by them, so long as there is a
>> >>> mb somewhere between a and g, and 1 and 9. Right?
>> >> 
>> >> This is correct.
>> > 
>> > Actually, sorry, the above is not quite right. It's been a while
>> > since I looked into the details of membarrier.
>> > 
>> > The smp_mb() at the beginning of membarrier() needs to be paired with a
>> > smp_mb() _after_ rq->curr is switched back to the user thread, so the
>> > memory barrier is between store to rq->curr and following user-space
>> > accesses.
>> > 
>> > The smp_mb() at the end of membarrier() needs to be paired with the
>> > smp_mb__after_spinlock() at the beginning of schedule, which is
>> > between accesses to userspace memory and switching rq->curr to kthread.
>> > 
>> > As to *why* this ordering is needed, I'd have to dig through additional
>> > scenarios from https://lwn.net/Articles/573436/. Or maybe Paul remembers ?
>> 
>> Thinking further about this, I'm beginning to consider that maybe we have been
>> overly cautious by requiring memory barriers before and after store to rq->curr.
>> 
>> If CPU0 observes a CPU1's rq->curr->mm which differs from its own process
>> (current)
>> while running the membarrier system call, it necessarily means that CPU1 had
>> to issue smp_mb__after_spinlock when entering the scheduler, between any
>> user-space
>> loads/stores and update of rq->curr.
>> 
>> Requiring a memory barrier between update of rq->curr (back to current process's
>> thread) and following user-space memory accesses does not seem to guarantee
>> anything more than what the initial barrier at the beginning of __schedule
>> already
>> provides, because the guarantees are only about accesses to user-space memory.
>> 
>> Therefore, with the memory barrier at the beginning of __schedule, just
>> observing that
>> CPU1's rq->curr differs from current should guarantee that a memory barrier was
>> issued
>> between any sequentially consistent instructions belonging to the current
>> process on
>> CPU1.
>> 
>> Or am I missing/misremembering an important point here ?
> 
> Is it correct to say that the switch_to operations in 5 and 7 include
> memory barriers?  If they do, then skipping the IPI should be okay.
> 
> The reason is as follows: The guarantee you need to enforce is that
> anything written by CPU0 before the membarrier() will be visible to CPU1
> after it returns to user mode.  Let's say that a writes to X and 9
> reads from X.
> 
> Then we have an instance of the Store Buffer pattern:
> 
>	CPU0			CPU1
>	a. Write X		6. Write rq->curr for user thread
>	c. smp_mb()		7. switch_to memory barrier
>	d. Read rq->curr	9. Read X
> 
> In this pattern, the memory barriers make it impossible for both reads
> to miss their corresponding writes.  Since d does fail to read 6 (it
> sees the earlier value stored by 4), 9 must read a.
> 
> The other guarantee you need is that g on CPU0 will observe anything
> written by CPU1 in 1.  This is easier to see, using the fact that 3 is a
> memory barrier and d reads from 4.

Right, and Nick's reply involving pairs of loads/stores on each side
clarifies the situation even further.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
