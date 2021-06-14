Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC173A6B86
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhFNQWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 12:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233593AbhFNQWQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 12:22:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6C6D6128C;
        Mon, 14 Jun 2021 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623687613;
        bh=VKbjFqcQXHNECj3z5tbp39B5D0sPHPpx3bkz7xFj1R8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B4/PgeQGk/3y8LrXsnAAk3/UlZ9PJiepC5f7dXKlqO2Ru2jEszjP3ATmmDv6sKchq
         REt07zCI7OMOHogr6NKfqF/BKiPh89GKz+oXpGvIopIeH5yjcpZjlwoG94Rvm6majW
         c/u1IRlmdCGE0ixbP4lT7oblapG+NCqlpgPhLhfNItfjUJI6a9H5bc5oCwUJWsH3JR
         4w8ioRnJXYNXCqvRfo32fpLkX/xkU6rBhHvWjVVOkqJ8b183XbG1Tdhoa9gvgvrPrS
         4bEAq6+CPIZHKEBZeUFyQ6vXJRqQzhwnxbMF9nZ3Reea7U3cFpWPxDu9s1zNs3STyl
         3QcPq2Gqs5Bow==
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
 <20210605014216.446867-3-npiggin@gmail.com>
 <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
 <1623629185.fxzl5xdab6.astroid@bobo.none>
 <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
 <1623643443.b9twp3txmw.astroid@bobo.none>
 <1623645385.u2cqbcn3co.astroid@bobo.none>
 <1623647326.0np4yc0lo0.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <aecf5bc8-9018-c021-287d-6a975b7a6235@kernel.org>
Date:   Mon, 14 Jun 2021 09:20:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623647326.0np4yc0lo0.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replying to several emails at once...


On 6/13/21 10:21 PM, Nicholas Piggin wrote:
> Excerpts from Nicholas Piggin's message of June 14, 2021 2:47 pm:
>> Excerpts from Nicholas Piggin's message of June 14, 2021 2:14 pm:
>>> Excerpts from Andy Lutomirski's message of June 14, 2021 1:52 pm:
>>>> On 6/13/21 5:45 PM, Nicholas Piggin wrote:
>>>>> Excerpts from Andy Lutomirski's message of June 9, 2021 2:20 am:
>>>>>> On 6/4/21 6:42 PM, Nicholas Piggin wrote:
>>>>>>> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
>>>>>>> when it is context switched. This can be disabled by architectures that
>>>>>>> don't require this refcounting if they clean up lazy tlb mms when the
>>>>>>> last refcount is dropped. Currently this is always enabled, which is
>>>>>>> what existing code does, so the patch is effectively a no-op.
>>>>>>>
>>>>>>> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>>>>>>
>>>>>> I am in favor of this approach, but I would be a lot more comfortable
>>>>>> with the resulting code if task->active_mm were at least better
>>>>>> documented and possibly even guarded by ifdefs.
>>>>>
>>>>> active_mm is fairly well documented in Documentation/active_mm.rst IMO.
>>>>> I don't think anything has changed in 20 years, I don't know what more
>>>>> is needed, but if you can add to documentation that would be nice. Maybe
>>>>> moving a bit of that into .c and .h files?
>>>>>
>>>>
>>>> Quoting from that file:
>>>>
>>>>   - however, we obviously need to keep track of which address space we
>>>>     "stole" for such an anonymous user. For that, we have "tsk->active_mm",
>>>>     which shows what the currently active address space is.
>>>>
>>>> This isn't even true right now on x86.
>>>
>>> From the perspective of core code, it is. x86 might do something crazy 
>>> with it, but it has to make it appear this way to non-arch code that
>>> uses active_mm.
>>>
>>> Is x86's scheme documented?

arch/x86/include/asm/tlbflush.h documents it a bit:

        /*
         * cpu_tlbstate.loaded_mm should match CR3 whenever interrupts
         * are on.  This means that it may not match current->active_mm,
         * which will contain the previous user mm when we're in lazy TLB
         * mode even if we've already switched back to swapper_pg_dir.
         *
         * During switch_mm_irqs_off(), loaded_mm will be set to
         * LOADED_MM_SWITCHING during the brief interrupts-off window
         * when CR3 and loaded_mm would otherwise be inconsistent.  This
         * is for nmi_uaccess_okay()'s benefit.
         */



>>>
>>>> With your patch applied:
>>>>
>>>>  To support all that, the "struct mm_struct" now has two counters: a
>>>>  "mm_users" counter that is how many "real address space users" there are,
>>>>  and a "mm_count" counter that is the number of "lazy" users (ie anonymous
>>>>  users) plus one if there are any real users.
>>>>
>>>> isn't even true any more.
>>>
>>> Well yeah but the active_mm concept hasn't changed. The refcounting 
>>> change is hopefully reasonably documented?

active_mm is *only* refcounting in the core code.  See below.

>>>>
>>>> I looked through all active_mm references in core code.  We have:
>>>>
>>>> kernel/sched/core.c: it's all refcounting, although it's a bit tangled
>>>> with membarrier.
>>>>
>>>> kernel/kthread.c: same.  refcounting and membarrier stuff.
>>>>
>>>> kernel/exit.c: exit_mm() a BUG_ON().
>>>>
>>>> kernel/fork.c: initialization code and a warning.
>>>>
>>>> kernel/cpu.c: cpu offline stuff.  wouldn't be needed if active_mm went away.
>>>>
>>>> fs/exec.c: nothing of interest
>>>
>>> I might not have been clear. Core code doesn't need active_mm if 
>>> active_mm somehow goes away. I'm saying active_mm can't go away because
>>> it's needed to support (most) archs that do lazy tlb mm switching.
>>>
>>> The part I don't understand is when you say it can just go away. How? 

#ifdef CONFIG_MMU_TLB_REFCOUNT
	struct mm_struct *active_mm;
#endif

>>>
>>>> I didn't go through drivers, but I maintain my point.  active_mm is
>>>> there for refcounting.  So please don't just make it even more confusing
>>>> -- do your performance improvement, but improve the code at the same
>>>> time: get rid of active_mm, at least on architectures that opt out of
>>>> the refcounting.
>>>
>>> powerpc opts out of the refcounting and can not "get rid of active_mm".
>>> Not even in theory.
>>
>> That is to say, it does do a type of reference management that requires 
>> active_mm so you can argue it has not entirely opted out of refcounting.
>> But we're not just doing refcounting for the sake of refcounting! That
>> would make no sense.
>>
>> active_mm is required because that's the mm that we have switched to 
>> (from core code's perspective), and it is integral to know when to 
>> switch to a different mm. See how active_mm is a fundamental concept
>> in core code? It's part of the contract between core code and the
>> arch mm context management calls. reference counting follows from there
>> but it's not the _reason_ for this code.

I don't understand what contract you're talking about.  The core code
maintains an active_mm counter and keeps that mm_struct from
disappearing.  That's *it*.  The core code does not care that active_mm
is active, and x86 provides evidence of that -- on x86,
current->active_mm may well be completely unused.

>>
>> Pretend the reference problem does not exit (whether by refcounting or 
>> shootdown or garbage collection or whatever). We still can't remove 
>> active_mm! We need it to know how to call into arch functions like 
>> switch_mm.

static inline void do_switch_mm(struct task_struct *prev_task, ...)
{
#ifdef CONFIG_MMU_TLB_REFCOUNT
	switch_mm(...);
#else
	switch_mm(fewer parameters);
	/* or pass NULL or whatever. */
#endif
}

>>
>> I don't know if you just forgot that critical requirement in your above 
>> list, or you actually are entirely using x86's mental model for this 
>> code which is doing something entirely different that does not need it 
>> at all. If that is the case I really don't mind some cleanup or wrapper 
>> functions for x86 do entirely do its own thing, but if that's the case
>> you can't criticize core code's use of active_mm due to the current
>> state of x86. It's x86 that needs documentation and cleaning up.
> 
> Ah, that must be where your confusion is coming from: x86's switch_mm 
> doesn't use prev anywhere, and the reference scheme it is using appears 
> to be under-documented, although vague references in changelogs suggest 
> it has not actually "opted out" of active_mm refcounting.

All of this is true, except I don't believe I'm confused.

> 
> That's understandable, but please redirect your objections to the proper 
> place. git blame suggests 3d28ebceaffab.

Thanks for the snark.

Here's the situation.

Before that patch, x86 more or less fully used the core scheme.  With
that patch, x86 has the property that loaded_mm (which is used) either
points to init_mm (which is permanently live) or to active_mm (which the
core code keeps alive, which is the whole point).  x86 still uses the
core active_mm refcounting scheme.  The result is a bit overcomplicated,
but it works, and it enabled massive improvements to the x86 arch code.

You are proposing a whole new simplification in which an arch can opt in
to telling the core code that it doesn't need to keep active_mm alive.
Great!  But now it's possible to get quite confused -- either an
elaborate dance is needed or current->active_mm could point to freed
memory.  This is poor design.

I'm entirely in favor of allowing arches to opt out of active_mm
refcounting.  As you've noticed, it's quite expensive on large systems.
x86 would opt out, too, if given the opportunity [1].  But I think you
should do it right.  If an arch opts out of active_mm refcounting, then
keeping a lazy mm (if any!) alive becomes entirely the arch code's
responsibility.  Once that happens, task->active_mm is not just a waste
of 4-8 bytes of memory per task, it's actively harmful -- some code,
somewhere in the kernel, might dereference it and access freed memory!

So please do your patches right.  By all means add a new config option,
but make that config option make active_mm go away entirely.  Then it
can't be misused.

NAK to the current set.

--Andy

[1] Hi Rik!  I think you had benchmarks that made mm refcounting look
quite bad.  If x86 can opt out of the core scheme, we can just rejigger
the exit_mm path to force-IPI everyone instead of allowing the paravirt
code to possibly optimize that path.  Or we can use a hazard pointer
scheme like my WIP patch.
