Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDF2C729B
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbgK1VuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732135AbgK1SBz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Nov 2020 13:01:55 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEBB246EA
        for <linux-arch@vger.kernel.org>; Sat, 28 Nov 2020 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606586151;
        bh=ZZhMRxdkDiUtjJhs9EzGkFNzkESkUN3IT5oRokS68Qo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=epX46Lo5gyxVc+A48tcBI9o2KY5N0B8LeGVmlne+5FIJLCKzXxKJbO8s5nD3xgFEq
         X4i5sPbFp4pWFdxVxrkkA2Zo+E6LU8KzScdnd4wUs/DuAJxVyePHnhRMsXt1NPg65k
         bczZ20BbxsSWXKhjoKXb+3UfQFkWGyoh+eDumXHw=
Received: by mail-wm1-f52.google.com with SMTP id h21so9875768wmb.2
        for <linux-arch@vger.kernel.org>; Sat, 28 Nov 2020 09:55:50 -0800 (PST)
X-Gm-Message-State: AOAM5328bSNkriDdYVDt37Fb2eYI/ZkJJXl40mJPnxyV61GaY77bsnaW
        /BCbk1wo90+ZxeC7l51eceytLbrcm+qZGsCokVcpiQ==
X-Google-Smtp-Source: ABdhPJzaqB8K8IiW/9cIJ/CJ9BqnrVUcLDZBaHBUttYrz8GGSHowF+hWwUHxhG80vPrg9fActeSCQFpfFgxQjqhRUUg=
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr436606wmc.49.1606586149355;
 Sat, 28 Nov 2020 09:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-3-npiggin@gmail.com>
In-Reply-To: <20201128160141.1003903-3-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Nov 2020 09:55:37 -0800
X-Gmail-Original-Message-ID: <CALCETrXYkbuJJnDv9ijfT+5tLQ2FOvvN1Ugoh5NwOy+zHp9HXA@mail.gmail.com>
Message-ID: <CALCETrXYkbuJJnDv9ijfT+5tLQ2FOvvN1Ugoh5NwOy+zHp9HXA@mail.gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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

On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> And get rid of the generic sync_core_before_usermode facility. This is
> functionally a no-op in the core scheduler code, but it also catches
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

I have a couple of membarrier fixes that I want to send out today or
tomorrow, and they might eliminate the need for this patch.  Let me
think about this a little bit.  I'll cc you.  The existing code is way
to subtle and the comments are far too confusing for me to be quickly
confident about any of my conclusions :)
