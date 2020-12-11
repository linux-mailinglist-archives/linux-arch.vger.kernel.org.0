Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A32D6C67
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 01:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgLKAOQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Dec 2020 19:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393916AbgLKAN7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Dec 2020 19:13:59 -0500
X-Gm-Message-State: AOAM530lj2WZ/k53b06FyykHlUSIrTJz2aTGYNESRsHvkmxMOVopCwgV
        QQxLZ/X8bMOi/wtHHMk5Hwz9g05qsiB/rLvqBDT0Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607645509;
        bh=Cofiyz62cvN7fzCefudCkKNVJKZ45g5WsucZa64FPpA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C+0jn6o9vwUqjjd6f6CIgI8ic4Dc1d+O9ysXMT3QZQbI4JG6cNTs1xXSKSM5DkCvV
         FhOTbsiz7Z1d6drfO1VoXxt9NP2zpaXtAh00zU8Jzp0Mx1PKhhruws1mNybQscSirZ
         TvDZcXfTovOEPMgyK5/MAkgkWU1UaGo7MMD1BPm2VaLPuGjIvVfJhqKwWdEX4rvEbg
         UOGReXpyRtUliPrTjgLUOJLCdu0KcjG5pvNOcUs+ZcY98DQ8bER9e2pFUPW246aLTC
         OLUtPW/EFWAV8JXDukqZMTlMP/DwB49qgTg9qhZ4ufDIJfxeMP1oQ9txHO71iE6w12
         qk9es7bV3hILw==
X-Google-Smtp-Source: ABdhPJxDDSK+EyEWrV85EAnSD1YFD7Ma/HEk0AvjGndG+w0b26Y9PplLtS1ujaNX2t/s+KYP+0f/cLisBWT1kfjpRfA=
X-Received: by 2002:adf:e64b:: with SMTP id b11mr10727032wrn.257.1607645507570;
 Thu, 10 Dec 2020 16:11:47 -0800 (PST)
MIME-Version: 1.0
References: <1607152918.fkgmomgfw9.astroid@bobo.none> <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
 <1607209402.fogfsh8ov4.astroid@bobo.none> <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
 <1607224014.8xeujbleij.astroid@bobo.none>
In-Reply-To: <1607224014.8xeujbleij.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Dec 2020 16:11:36 -0800
X-Gmail-Original-Message-ID: <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
Message-ID: <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Dec 5, 2020, at 7:59 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>

> I'm still going to persue shoot-lazies for the merge window. As you
> see it's about a dozen lines and a if (IS_ENABLED(... in core code.
> Your change is common code, but a significant complexity (which
> affects all archs) so needs a lot more review and testing at this
> point.

I don't think it's ready for this merge window.  I read the early
patches again, and I think they make the membarrier code worse, not
better.  I'm not fundamentally opposed to the shoot-lazies concept,
but it needs more thought and it needs a cleaner foundation.
