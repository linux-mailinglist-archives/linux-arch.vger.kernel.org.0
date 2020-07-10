Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E127021BBCB
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgGJRFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 13:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgGJRFJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 13:05:09 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A692080D
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400708;
        bh=3S7IewpNxJBD3L+ZfZ/E6af35AY9UGg9jqOelSrpKo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1tRe4LZ68tVZGxEGQ7XeZ+yUcJKPuc4ZhIcHwk2QL6cG3SdjNkD2PO5p5HsegEww3
         gmZfDPpe4jdgPlAuSo+u1XmlaVBSKvuVGiOOZM6SQIII2HSnN7c89x9nK4D4K4r+6q
         zcxAm6d3uRrL58fmcsOUp32tlZPRex6+m3Qe/Vmk=
Received: by mail-wr1-f52.google.com with SMTP id q5so6699038wru.6
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2020 10:05:07 -0700 (PDT)
X-Gm-Message-State: AOAM532ov7SX+ZDDdm3F9SMScsztpaL4qcZVcLEKsllhfC6CyAzyFgLP
        c7bYODSNC8ioDBtfGWe3fgIGLTgxOv6s4WtfMBHL5g==
X-Google-Smtp-Source: ABdhPJwltug8Dryi9wS37jyJz6qJjriDvb96hMI47ek0pD++Bm/QsUvqdOhO95P79buU9BFsgr/1LX6a5Jbh2/sEF7w=
X-Received: by 2002:adf:e482:: with SMTP id i2mr67761053wrm.75.1594400706520;
 Fri, 10 Jul 2020 10:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-5-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 10 Jul 2020 10:04:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
Message-ID: <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> And get rid of the generic sync_core_before_usermode facility.
>
> This helper is the wrong way around I think. The idea that membarrier
> state requires a core sync before returning to user is the easy one
> that does not need hiding behind membarrier calls. The gap in core
> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
> tricky detail that is better put in x86 lazy tlb code.
>
> Consider if an arch did not synchronize core in switch_mm either, then
> membarrier_mm_sync_core_before_usermode would be in the wrong place
> but arch specific mmu context functions would still be the right place.
> There is also a exit_lazy_tlb case that is not covered by this call, which
> could be a bugs (kthread use mm the membarrier process's mm then context
> switch back to the process without switching mm or lazy mm switch).
>
> This makes lazy tlb code a bit more modular.

The mm-switching and TLB-management has often had the regrettable
property that it gets wired up in a way that seems to work at the time
but doesn't have clear semantics, and I'm a bit concerned that this
patch is in that category.  If I'm understanding right, you're trying
to enforce the property that exiting lazy TLB mode will promise to
sync the core eventually.  But this has all kinds of odd properties:

 - Why is exit_lazy_tlb() getting called at all in the relevant cases?
 When is it permissible to call it?  I look at your new code and see:

> +/*
> + * Ensure that a core serializing instruction is issued before returning
> + * to user-mode, if a SYNC_CORE was requested. x86 implements return to
> + * user-space through sysexit, sysrel, and sysretq, which are not core
> + * serializing.
> + *
> + * See the membarrier comment in finish_task_switch as to why this is done
> + * in exit_lazy_tlb.
> + */
> +#define exit_lazy_tlb exit_lazy_tlb
> +static inline void exit_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> +{
> +       /* Switching mm is serializing with write_cr3 */
> +        if (tsk->mm != mm)
> +                return;

And my brain says WTF?  Surely you meant something like if
(WARN_ON_ONCE(tsk->mm != mm)) { /* egads, what even happened?  how do
we try to recover well enough to get a crashed logged at least? */ }

So this needs actual documentation, preferably in comments near the
function, of what the preconditions are and what this mm parameter is.
Once that's done, then we could consider whether it's appropriate to
have this function promise to sync the core under some conditions.

 - This whole structure seems to rely on the idea that switching mm
syncs something.  I periodically ask chip vendor for non-serializing
mm switches.  Specifically, in my dream world, we have totally
separate user and kernel page tables.  Changing out the user tables
doesn't serialize or even create a fence.  Instead it creates the
minimum required pipeline hazard such that user memory access and
switches to usermode will make sure they access memory through the
correct page tables.  I haven't convinced a chip vendor yet, but there
are quite a few hundreds of cycles to be saved here.  With this in
mind, I see the fencing aspects of the TLB handling code as somewhat
of an accident.  I'm fine with documenting them and using them to
optimize other paths, but I think it should be explicit.  For example:

/* Also does a full barrier?  (Or a sync_core()-style barrier.)
However, if you rely on this, you must document it in a comment where
you call this function. *?
void switch_mm_irqs_off()
{
}

This is kind of like how we strongly encourage anyone using smp_?mb()
to document what they are fencing against.

Also, as it stands, I can easily see in_irq() ceasing to promise to
serialize.  There are older kernels for which it does not promise to
serialize.  And I have plans to make it stop serializing in the
nearish future.

--Andy
