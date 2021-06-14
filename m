Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345B33A5BE6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhFNDym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 23:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhFNDym (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 13 Jun 2021 23:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B78556120E;
        Mon, 14 Jun 2021 03:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623642760;
        bh=Msfsid2dMP0z1xO8rgeqV4lboVmj2pyzEHCvjexUV90=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l+fuc2vwhawWXWs1SCV0yi4B1tW+hB2XQRLfENdg5Ys2RbOYZ5+3vWLDgJeV2dvUN
         3lkkNi3tFXCP2VSW6kSwEjxkaEwY1fksZTTmpJ0dDgb0Q0jWsRLoyXm36tpqP37Rhn
         b/vCObmFAsixC1JKlr1ynfE+WsRE3Ee0DW8ovYtCQ5lns86k5gK1kr2Id3u+XEeN8R
         Od1RpSAs/I95p4Xhh0lp3O0JFLgCA8a6RizOqM+8R6XRteWt99s81a/+nv04H/eK1L
         ZytXE2rBjzDCRpUPIXlhNKYkNVDsDjbiC/CLlwHQ1Qr+jqcB6+a5CyKKEf87VHktjq
         tSDgapbeoEAxg==
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
 <20210605014216.446867-3-npiggin@gmail.com>
 <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
 <1623629185.fxzl5xdab6.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
Date:   Sun, 13 Jun 2021 20:52:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623629185.fxzl5xdab6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/13/21 5:45 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 9, 2021 2:20 am:
>> On 6/4/21 6:42 PM, Nicholas Piggin wrote:
>>> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
>>> when it is context switched. This can be disabled by architectures that
>>> don't require this refcounting if they clean up lazy tlb mms when the
>>> last refcount is dropped. Currently this is always enabled, which is
>>> what existing code does, so the patch is effectively a no-op.
>>>
>>> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>>
>> I am in favor of this approach, but I would be a lot more comfortable
>> with the resulting code if task->active_mm were at least better
>> documented and possibly even guarded by ifdefs.
> 
> active_mm is fairly well documented in Documentation/active_mm.rst IMO.
> I don't think anything has changed in 20 years, I don't know what more
> is needed, but if you can add to documentation that would be nice. Maybe
> moving a bit of that into .c and .h files?
> 

Quoting from that file:

  - however, we obviously need to keep track of which address space we
    "stole" for such an anonymous user. For that, we have "tsk->active_mm",
    which shows what the currently active address space is.

This isn't even true right now on x86.  With your patch applied:

 To support all that, the "struct mm_struct" now has two counters: a
 "mm_users" counter that is how many "real address space users" there are,
 and a "mm_count" counter that is the number of "lazy" users (ie anonymous
 users) plus one if there are any real users.

isn't even true any more.


>> x86 bare metal currently does not need the core lazy mm refcounting, and
>> x86 bare metal *also* does not need ->active_mm.  Under the x86 scheme,
>> if lazy mm refcounting were configured out, ->active_mm could become a
>> dangling pointer, and this makes me extremely uncomfortable.
>>
>> So I tend to think that, depending on config, the core code should
>> either keep ->active_mm [1] alive or get rid of it entirely.
> 
> I don't actually know what you mean.
> 
> core code needs the concept of an "active_mm". This is the mm that your 
> kernel threads are using, even in the unmerged CONFIG_LAZY_TLB=n patch,
> active_mm still points to init_mm for kernel threads.

Core code does *not* need this concept.  First, it's wrong on x86 since
at least 4.15.  Any core code that actually assumes that ->active_mm is
"active" for any sensible definition of the word active is wrong.
Fortunately there is no such code.

I looked through all active_mm references in core code.  We have:

kernel/sched/core.c: it's all refcounting, although it's a bit tangled
with membarrier.

kernel/kthread.c: same.  refcounting and membarrier stuff.

kernel/exit.c: exit_mm() a BUG_ON().

kernel/fork.c: initialization code and a warning.

kernel/cpu.c: cpu offline stuff.  wouldn't be needed if active_mm went away.

fs/exec.c: nothing of interest

I didn't go through drivers, but I maintain my point.  active_mm is
there for refcounting.  So please don't just make it even more confusing
-- do your performance improvement, but improve the code at the same
time: get rid of active_mm, at least on architectures that opt out of
the refcounting.



> 
> We could hide that idea behind an active_mm() function that would always 
> return &init_mm if mm==NULL, but you still have the concept of an active
> mm and a pointer that callers must not access after free (because some
> cases will be CONFIG_LAZY_TLB=y).
> 
>> [1] I don't really think it belongs in task_struct at all.  It's not a
>> property of the task.  It's the *per-cpu* mm that the core code is
>> keeping alive for lazy purposes.  How about consolidating it with the
>> copy in rq?
> 
> I agree it's conceptually a per-cpu property. I don't know why it was 
> done this way, maybe it was just convenient and works well for mm and 
> active_mm to be adjacent. Linus might have a better insight.
> 
>> I guess the short summary of my opinion is that I like making this
>> configurable, but I do not like the state of the code.
> 
> I don't think I'd object to moving active_mm to rq and converting all
> usages to active_mm() while we're there, it would make things a bit
> more configurable. But I don't see it making core code fundamentally
> less complex... if you're referring to the x86 mm switching monstrosity,
> then that's understandable, but I admit I haven't spent enough time
> looking at it to make a useful comment. A patch would be enlightening,
> I have the leftover CONFIG_LAZY_TLB=n patch if you were thinking of 
> building on that I can send it to you.
> 
> Thanks,
> Nick
> 

