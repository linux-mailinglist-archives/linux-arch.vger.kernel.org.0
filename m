Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1391038875A
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhESGKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhESGKu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 02:10:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 102B1613B4;
        Wed, 19 May 2021 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621404571;
        bh=+tng9KOkJ4vGrdnFxKm0TZVfhTzW5k68odPKowCsvhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uIFcOBsrOPaOvn2n6HLWrG+RAKH5xzptUoATriDXNQfa/02/ENtvWdaSu9rOiF5N1
         +k2R5oQrAgs3HF5e7SKOncFWi5nhVxR5BXYPQ6yPcLjpR7yj8heIO/d8Q35i/g4NAI
         KvcOnf3FI0yuBWQC5qBFFGCBe+2rWumYiZo2mvF2lHCDPQKbF8zkwmQQGGMqmSM0VM
         bBYqhyCuVt+UtTd4uZ3Z9WHzcLGN0qiJ9pTyK2IiRxrelP0OJHaYGvxMCr4tWxrUaI
         82SUAJ/G8SBrlul2epNghxGFdlMslJ08hdiYwv7LtWSAzdQWM9FRWwxqYULt/3JKJj
         7vKPlTe7DOX3A==
Received: by mail-lj1-f182.google.com with SMTP id c15so14195806ljr.7;
        Tue, 18 May 2021 23:09:30 -0700 (PDT)
X-Gm-Message-State: AOAM530GnR1EGebvX6K/3qP8LBuoJWwLqdFO4lBqEDfZ/0/5whVH54S/
        260pn3L0zeTKpyNSl1myzdN2MUg6WNWFGOHAzvA=
X-Google-Smtp-Source: ABdhPJxCD9AU161BNjQRQBYs1nLF1LGkl0Ty6pHsGbdXuhweqLk1xlX6xD5rGyODMFf4KqToUL2wB7X/Dnv9SWicVUo=
X-Received: by 2002:a2e:9d82:: with SMTP id c2mr7361177ljj.508.1621404569271;
 Tue, 18 May 2021 23:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519055555.GA27451@lst.de>
In-Reply-To: <20210519055555.GA27451@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 May 2021 14:09:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSg0TqAzmdzf7B_xASXLO-z4yVvCDnaUV4brP7tCpCdvQ@mail.gmail.com>
Message-ID: <CAJF2gTSg0TqAzmdzf7B_xASXLO-z4yVvCDnaUV4brP7tCpCdvQ@mail.gmail.com>
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

On Wed, May 19, 2021 at 1:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 19, 2021 at 01:48:23PM +0800, Guo Ren wrote:
> > The patchset just leaves a configuration chance for vendors. Before
> > RISC-V ISA fixes it, we should give the chance to let vendor solve
> > their real chip issues.
>
> No.  The vendors need to work to get a feature standardized before
> implementing it.  There is other way to have a sane kernel build that
> supports all the different SOCs.

I've said the patchset doesn't define any features, It just leaves the
chance for vendors.

It's not in conflict with any standardized riscv ISA.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
