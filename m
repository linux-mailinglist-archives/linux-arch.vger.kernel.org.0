Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B43BCB57
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhGFLF0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhGFLF0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:05:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE8C661A33
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569368;
        bh=rM7tOvVAdZwLlj1DOtVoGYGzfBztfGCPo6NxHNt7xFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FG3ddK2DDIEp2/Z8xQ4yGS2psC/3HLhVDjrpVGEEBBTCr21ehtDVQgHUIJ2bs94mA
         tEC25ist9FzADQ1Q4XrgJRy/3r560zWQs0VJ0hIZC3JqonB1TfGCLXAuFIQJ8EdQE5
         nSgKEijTHu65qmJoPE3yR7Wa9zxUkawNtFK168GXLV8D/vLkGbU+0I+f9Ck64LYrq0
         9EyTu+u04m4U1Wa9NynD/OCML32h4jZfdqfdPOMhvBNdxaSpa24IPeDHYMvSZT/8Ud
         7UYxstPmvN7O9dVf/uNkW/qnWosBed8R5fRrs+1l6zFKWAEV0GhghZvPDLG4K6arKw
         eAXhJ0qYfKF0Q==
Received: by mail-wr1-f52.google.com with SMTP id p8so25601138wrr.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:02:47 -0700 (PDT)
X-Gm-Message-State: AOAM532Hd4YC4lsSjAqdrulaIrUHa1RdJfZzlYuApJzVewYExptwZBOA
        3VjNvVEVIE7iTtQ/nF0bNkkd2M2MMwyo9W2cVBE=
X-Google-Smtp-Source: ABdhPJwJqkRCxJaVzYBNAg4aARmvVxhzgVvMdR2anL3jo4X4/9qvBcNNFhB9t/AOUdtOcHRWQrAoE5NlR2gReDBiRwA=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr21992043wrq.105.1625569366523;
 Tue, 06 Jul 2021 04:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-17-chenhuacai@loongson.cn> <CAK8P3a10NN4mZYtzEEiYv8jqPZbMH-LH406cZV6M4HXhr-Z9yQ@mail.gmail.com>
In-Reply-To: <CAK8P3a10NN4mZYtzEEiYv8jqPZbMH-LH406cZV6M4HXhr-Z9yQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 13:02:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Oa77Dyz3fHOTrjtkfk_qtXQkre=ABHy1hTphDiiFp8Q@mail.gmail.com>
Message-ID: <CAK8P3a0Oa77Dyz3fHOTrjtkfk_qtXQkre=ABHy1hTphDiiFp8Q@mail.gmail.com>
Subject: Re: [PATCH 16/19] LoongArch: Add VDSO and VSYSCALL support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds VDSO and VSYSCALL support (gettimeofday and its friends)
> for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/vdso.h             |  50 +++
>  arch/loongarch/include/asm/vdso/clocksource.h |   8 +
>  .../loongarch/include/asm/vdso/gettimeofday.h | 101 ++++++
>  arch/loongarch/include/asm/vdso/processor.h   |  14 +
>  arch/loongarch/include/asm/vdso/vdso.h        |  42 +++
>  arch/loongarch/include/asm/vdso/vsyscall.h    |  27 ++
>  arch/loongarch/kernel/vdso.c                  | 132 ++++++++
>  arch/loongarch/vdso/Makefile                  |  97 ++++++
>  arch/loongarch/vdso/elf.S                     |  15 +
>  arch/loongarch/vdso/genvdso.c                 | 311 ++++++++++++++++++
>  arch/loongarch/vdso/genvdso.h                 | 122 +++++++
>  arch/loongarch/vdso/sigreturn.S               |  24 ++
>  arch/loongarch/vdso/vdso.lds.S                |  65 ++++
>  arch/loongarch/vdso/vgettimeofday.c           |  26 ++

I fear you may have copied the wrong one here, the MIPS implementation seems
more complex than the rv64 or arm64 versions, and you should not need that
complexity.

Can you try removing the genvdso.c  file completely? To be honest I don't
see why this is needed here, so I may be missing something, but the other
ones don't have it either.

       Arnd
