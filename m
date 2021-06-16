Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C13A8D44
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 02:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFPAQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 20:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhFPAQI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 20:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE77611CE;
        Wed, 16 Jun 2021 00:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623802443;
        bh=um8wh8sgKUn6UwRW7jW75/IAT6r5mXbKNUqGtm3+9TQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tad+jIad0fSkSU3TYeZdfozEY0+IP4BcGd99jtAGninX/uSmGjkNaW+VGcbqRo6QY
         fxKXPmkaM1ETjnA2b5tFTq5bGGDl69+3/poGBHtrHnStcHjDCq3QezIEC7nvYsrLJE
         mL6Vc7GTVEa12EUEPlw3w9+v+GC7GZQgmvqsCvBv1EOujHOUD+iTvfP/tSWp1tzsFY
         +iUR91oVybd/rjs7xXT7ki9a7wLgLlqFgjH9F05LtRSf+UGo+9lDhEFZiDo+5hHOJU
         2+6H0Vac0ZrXGlU5mNMyOPA79LSpxFked9NaOXgT8RON06bwZH5AnWH+P20t/542Il
         2KMIR25oTy5mA==
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
 <20210605014216.446867-3-npiggin@gmail.com>
 <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
 <1623629185.fxzl5xdab6.astroid@bobo.none>
 <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
 <1623643443.b9twp3txmw.astroid@bobo.none>
 <1623645385.u2cqbcn3co.astroid@bobo.none>
 <1623647326.0np4yc0lo0.astroid@bobo.none>
 <aecf5bc8-9018-c021-287d-6a975b7a6235@kernel.org>
 <1623715482.4lskm3cx10.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <3b9eb877-5d1e-d565-5577-575229d18b6e@kernel.org>
Date:   Tue, 15 Jun 2021 17:14:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623715482.4lskm3cx10.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/14/21 5:55 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 15, 2021 2:20 am:
>> Replying to several emails at once...
>>

> 
> So the only documentation relating to the current active_mm value or 
> refcounting is that it may not match what the x86 specific code is 
> doing?
> 
> All this complexity you accuse me of adding is entirely in x86 code.
> On other architectures, it's very simple and understandable, and 
> documented. I don't know how else to explain this.

And the docs you referred me to will be *wrong* with your patches
applied.  They are your patches, and they break the semantics.

> 
>>>>>
>>>>>> With your patch applied:
>>>>>>
>>>>>>  To support all that, the "struct mm_struct" now has two counters: a
>>>>>>  "mm_users" counter that is how many "real address space users" there are,
>>>>>>  and a "mm_count" counter that is the number of "lazy" users (ie anonymous
>>>>>>  users) plus one if there are any real users.
>>>>>>
>>>>>> isn't even true any more.
>>>>>
>>>>> Well yeah but the active_mm concept hasn't changed. The refcounting 
>>>>> change is hopefully reasonably documented?
>>
>> active_mm is *only* refcounting in the core code.  See below.
> 
> It's just not. It's passed in to switch_mm. Most architectures except 
> for x86 require this.
> 

Sorry, I was obviously blatantly wrong.  Let me say it differently.
active_mm does two things:

1. It keeps an mm alive via a refcounting scheme.

2. It passes a parameter to switch_mm() to remind the arch code what the
most recently switch-to mm was.

#2 is basically useless.  An architecture can handle *that* with a
percpu variable and two lines of code.

If you are getting rid of functionality #1 in the core code via a new
arch opt-out, please get rid of #2 as well.  *Especially* because, when
the arch asks the core code to stop refcounting active_mm, there is
absolutely nothing guaranteeing that the parameter that the core code
will pass to switch_mm() points to memory that hasn't been freed and
reused for another purpose.

>>>>> I might not have been clear. Core code doesn't need active_mm if 
>>>>> active_mm somehow goes away. I'm saying active_mm can't go away because
>>>>> it's needed to support (most) archs that do lazy tlb mm switching.
>>>>>
>>>>> The part I don't understand is when you say it can just go away. How? 
>>
>> #ifdef CONFIG_MMU_TLB_REFCOUNT
>> 	struct mm_struct *active_mm;
>> #endif
> 
> Thanks for returning the snark.

That wasn't intended to be snark.  It was a literal suggestion, and, in
fact, it's *exactly* what I'm asking you to do to fix your patches.

>> I don't understand what contract you're talking about.  The core code
>> maintains an active_mm counter and keeps that mm_struct from
>> disappearing.  That's *it*.  The core code does not care that active_mm
>> is active, and x86 provides evidence of that -- on x86,
>> current->active_mm may well be completely unused.
> 
> I already acknowledged archs can do their own thing under the covers if 
> they want.

No.

I am *not* going to write x86 patches that use your feature in a way
that will cause the core code to pass around a complete garbage pointer
to an mm_struct that is completely unreferenced and may well be deleted.
 Doing something private in arch code is one thing.  Doing something
that causes basic common sense to be violated in core code is another
thing entirely.

>>
>> static inline void do_switch_mm(struct task_struct *prev_task, ...)
>> {
>> #ifdef CONFIG_MMU_TLB_REFCOUNT
>> 	switch_mm(...);
>> #else
>> 	switch_mm(fewer parameters);
>> 	/* or pass NULL or whatever. */
>> #endif
>> }
> 
> And prev_task comes from active_mm, ergo core code requires the concept 
> of active_mm.

I don't see why this concept is hard.  We are literally quibbling about
this single line of core code in kernel/sched/core.c:

switch_mm_irqs_off(prev->active_mm, next->mm, next);

This is not rocket science.  There are any number of ways to fix it.
For example:

#ifdef CONFIG_MMU_TLB_REFCOUNT
	switch_mm_irqs_off(prev->active_mm, next->mm, next);
#else
	switch_mm_irqs_off(NULL, next->mm, next);
#endif

If you don't like the NULL, then make the signature depend on the config
option.

What you may not do is what your patch actually does:

switch_mm_irqs_off(random invalid pointer, next->mm, next);

Now maybe it works because powerpc's lifecycle rules happen to keep
active_mm alive, but I haven't verified it.  x86's lifecycle rules *do not*.

>>>
>>> That's understandable, but please redirect your objections to the proper 
>>> place. git blame suggests 3d28ebceaffab.
>>
>> Thanks for the snark.
> 
> Is it not true? I don't mean that one patch causing all the x86 
> complexity or even making the situation worse itself. But you seem to be 
> asking my series to do things that really apply to the x86 changes over
> the past few years that got us here.

With just my patch from 4.15 applied, task->active_mm points to an
actual mm_struct, and that mm_struct will not be freed early.  If I opt
x86 into your patch's new behavior, then task->active_mm may be freed.

akpm, please drop this series until it's fixed.  It's a core change to
better support arch usecases, but it's unnecessarily fragile, and there
is already an arch maintainer pointing out that it's inadequate to
robustly support arch usecases.  There is no reason to merge it in its
present state.
