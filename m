Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC538873C
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhESGGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhESGGc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 02:06:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67BBB61364;
        Wed, 19 May 2021 06:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621404313;
        bh=Xwr5QpNNsC32N22bkt85qEAJwNFX8RrXNiNTTm93wus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kcQhiZ9BBe8gjdEzlwZcHnMhmtCas71Aga6bxkQmMcZEQ7gZ3t0i05nXSz55Gjtn7
         ViOJzkMJNM37yOkUz9jGlDDu7g41vlC8LyQRu8OdaYQ+W9s+dUHWSWctXYKgWNS1ZD
         ewv4eKQiyGJbMeeP4jHCB/2jKglATyFDI68hCn3awXLdScWbTda9sBsCeh8Mb+gpn9
         aBalxBJrYQow0qfDQ3gUKV+6LpiaKYaFRIrpYWjiub9eA00XKtsE0tiSklRGd0dHGv
         CA/nFwOVVOmpYYPGmCbCh/zhjuiXOBSG/ltWkrxsnDJiI/SwlVQbZxEuNDfTG7FAIH
         49w4XUdqBbJIQ==
Received: by mail-lj1-f171.google.com with SMTP id w15so14180692ljo.10;
        Tue, 18 May 2021 23:05:13 -0700 (PDT)
X-Gm-Message-State: AOAM531Vy4MRaZeyPWmt/VyECBc/8LBAiQsH9y14rHuhy8E3SmaWNN9m
        CglgasdM0EFsSfDmcAN4R3rpfyXlnB0T6hPWWs4=
X-Google-Smtp-Source: ABdhPJxS98EKiSh0CCfAv3lXvniOWIJpH2z4fy4wekWkqzlazYCilU9LFIurrbqZaH2bz1PaLXu13U1ljpl+sI6/SN0=
X-Received: by 2002:a2e:504f:: with SMTP id v15mr7695318ljd.18.1621404311670;
 Tue, 18 May 2021 23:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <20210519052048.GA24853@lst.de>
In-Reply-To: <20210519052048.GA24853@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 May 2021 14:05:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
Message-ID: <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        drew@beagleboard.org, wefu@redhat.com, lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 1:20 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 19, 2021 at 05:04:13AM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
> > vendors define the custom properties of memory regions in PTE.
>
> Err, hell no.   The ISA needs to gets this fixed first.  Then we can
> talk about alternatives patching things in or trapping in the SBI.
> But if the RISC-V ISA can't get these basic done after years we can't
> support it in Linux at all.
This is the lightest solution I could imagine, it avoids conflicts
with RISC-V ISA.

Since the existing RISC-V ISA cannot solve this problem, it is better
to provide some configuration for the SOC vendor to customize.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
