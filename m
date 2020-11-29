Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E52C7B23
	for <lists+linux-arch@lfdr.de>; Sun, 29 Nov 2020 21:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgK2URV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Nov 2020 15:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgK2URU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 29 Nov 2020 15:17:20 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9D620870
        for <linux-arch@vger.kernel.org>; Sun, 29 Nov 2020 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606681000;
        bh=N/5rjQqJanCNkJazZn/cQ2aPW49EUqzYQDUy+Xdcge0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KiuuWU0bKgXhfhotWCf0rYVtbTbBbphVh4LCZHE/dCR9NBCC8GcNZooNBZ5Gi5zU9
         PctBfFUnw2EWNN1FkCP1+deRAWJ7usmjY0l2u58A5HXfyVqqdZ5I3lzOC6Z+jAOlZG
         E77lUb1oMr2CSCePllItgypJ/5XR6/HfDF5zPFlc=
Received: by mail-wr1-f46.google.com with SMTP id k14so12548965wrn.1
        for <linux-arch@vger.kernel.org>; Sun, 29 Nov 2020 12:16:39 -0800 (PST)
X-Gm-Message-State: AOAM532FPBnzdmMX0/h3loPXm21BuqP2C+L2xIds3TfsCoURHdEPeU0y
        dWsBHXDRlS+xR3Db981v46McNIcKb9j3px/gXp0oWA==
X-Google-Smtp-Source: ABdhPJwYikNyF98Tybzh36itlesMK1rlfrvxImOMUWZkk0NuWSWbLwn6lWsiusLeR7vr43/6ZfjVImZ+tuEfqHGf3aM=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr24072262wrs.75.1606680998232;
 Sun, 29 Nov 2020 12:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
In-Reply-To: <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 29 Nov 2020 12:16:26 -0800
X-Gmail-Original-Message-ID: <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
Message-ID: <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 28, 2020 at 7:54 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On big systems, the mm refcount can become highly contented when doing
> > a lot of context switching with threaded applications (particularly
> > switching between the idle thread and an application thread).
> >
> > Abandoning lazy tlb slows switching down quite a bit in the important
> > user->idle->user cases, so so instead implement a non-refcounted scheme
> > that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> > any remaining lazy ones.
> >
> > Shootdown IPIs are some concern, but they have not been observed to be
> > a big problem with this scheme (the powerpc implementation generated
> > 314 additional interrupts on a 144 CPU system during a kernel compile).
> > There are a number of strategies that could be employed to reduce IPIs
> > if they turn out to be a problem for some workload.
>
> I'm still wondering whether we can do even better.
>

Hold on a sec.. __mmput() unmaps VMAs, frees pagetables, and flushes
the TLB.  On x86, this will shoot down all lazies as long as even a
single pagetable was freed.  (Or at least it will if we don't have a
serious bug, but the code seems okay.  We'll hit pmd_free_tlb, which
sets tlb->freed_tables, which will trigger the IPI.)  So, on
architectures like x86, the shootdown approach should be free.  The
only way it ought to have any excess IPIs is if we have CPUs in
mm_cpumask() that don't need IPI to free pagetables, which could
happen on paravirt.

Can you try to figure out why you saw any increase in IPIs?  It would
be nice if we can make the new code unconditional.
