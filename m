Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C479389B08
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 03:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhETBtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 21:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhETBtQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 21:49:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A166135A;
        Thu, 20 May 2021 01:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621475276;
        bh=poKYit/QMpU4dKJNKCzvxCXd10ycTg0LVovaKwHdVJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/x0LyiHKaXRHAHnix8Nv4+NwnU8XbzIAYPrRmgBkgKE5WuFEZlElAeQ0/x4E72+I
         oq+W1pFg/nSfT9fgfq3sPXU/rWOQo6P20vPJa/8IdNqGhrlPgbLqIZ24inzbIviBXl
         rPX0OUVtTu3qQv4vlVtuKDRAADMTpAAeoSnbB0wA7U1xrhLPWkD2HV7J0SKmDWUEBl
         1lKfUJA6oXuvtE7R4iDGWMs7XZ4idntGYO8L69cW01UrgMuAuYqvgrPuW9iBsTNcLr
         NdIRxZAQeZWE/UN/vWMe5YGNm0T+3Fs4KsJ9KBX6xK7XzsBIJ6HbOLg8mjoKE1r3S2
         ZZenF0FOdB45Q==
Received: by mail-lf1-f50.google.com with SMTP id w33so14032715lfu.7;
        Wed, 19 May 2021 18:47:56 -0700 (PDT)
X-Gm-Message-State: AOAM533/hio93qdNZq4cvlGi5TXzK4630bD2DUHQFNZq8xDvU7ljUoC9
        3exT+8DDfK+Cq86zTSd4m3H1YSBYT1LDEHIMzlo=
X-Google-Smtp-Source: ABdhPJy3NQHcs2Ir3IlcgG3aACIm8RSgvE2z8dE72bBss58+GSqw1LTUF9Ebe2CYmIkUeJauoGs+8f7zg55rxVr/uFI=
X-Received: by 2002:a19:c49:: with SMTP id 70mr1686096lfm.555.1621475274744;
 Wed, 19 May 2021 18:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
 <20210519060617.GA28397@lst.de> <20210519065431.GB3076809@x1> <CAAhSdy3C1owsbY_9gkxkhWfCXnL_noow7F4t=5+j7q+AJO3pZQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3C1owsbY_9gkxkhWfCXnL_noow7F4t=5+j7q+AJO3pZQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 May 2021 09:47:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQKqce_6cmGQnfLOX8uXvOUWUR-pQT4yOMioMcFAPfBjQ@mail.gmail.com>
Message-ID: <CAJF2gTQKqce_6cmGQnfLOX8uXvOUWUR-pQT4yOMioMcFAPfBjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Anup Patel <anup@brainfault.org>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 3:15 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, May 19, 2021 at 12:24 PM Drew Fustini <drew@beagleboard.org> wrote:
> >
> > On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig wrote:
> > > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> > > > Since the existing RISC-V ISA cannot solve this problem, it is better
> > > > to provide some configuration for the SOC vendor to customize.
> > >
> > > We've been talking about this problem for close to five years.  So no,
> > > if you don't manage to get the feature into the ISA it can't be
> > > supported.
> >
> > Isn't it a good goal for Linux to support the capabilities present in
> > the SoC that a currently being fab'd?
> >
> > I believe the CMO group only started last year [1] so the RV64GC SoCs
> > that are going into mass production this year would not have had the
> > opporuntiy of utilizing any RISC-V ISA extension for handling cache
> > management.
>
> The current Linux RISC-V policy is to only accept patches for frozen or
> ratified ISA specs.
> (Refer, Documentation/riscv/patch-acceptance.rst)
>
> This means even if emulate CMO instructions in OpenSBI, the Linux
> patches won't be taken by Palmer because CMO specification is
> still in draft stage.
How do you think about
sbi_ecall(SBI_EXT_DMA, SBI_DMA_SYNC, start, size, dir, 0, 0, 0);
? thx
>
> Also, we all know how much time it takes for RISCV international
> to freeze some spec. Judging by that we are looking at another
> 3-4 years at minimum.
>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
