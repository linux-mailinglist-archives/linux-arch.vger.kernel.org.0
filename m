Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396053886FE
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 07:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhESFvj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 01:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344733AbhESFvP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 01:51:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2AF0613AE;
        Wed, 19 May 2021 05:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621403316;
        bh=1M/78skAnJ0O2EA7jNQp+kPITl517U87tfk5kFLTNwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lncOtVDAEu7HiiRH4NkTlbuFCw039Zi8FHl47j/D8o8b6429d7pMItzt92Zuqn/md
         1k+rbV+ujbbDaXukjm0H+1NkPpRruxJUxHosKCKcTPnfO6GNB2cIPjYaZNGrcS4NaE
         GHVDbor7fM1s6Abpb3MI0t36fipqE5D8L9qat0/El/+e3kqejTkZ/+k+/nWPZ1mAzc
         PuHDXrty+uIaYvgimxcHDmatLZfVnBz1m9NmKx/pMsYHPhhU/LaDAkRTimQGn8DGza
         QJUH2Wr6BcISqxxFuI7L3y/p6NxUoWyT+xqpmuXHfj3/CzbkZ80qIsBFio5u6tyKDc
         Ze99bV9iojkDQ==
Received: by mail-lf1-f51.google.com with SMTP id i22so17125635lfl.10;
        Tue, 18 May 2021 22:48:36 -0700 (PDT)
X-Gm-Message-State: AOAM530Z5YNbPBOQZEcshdj85YLKgo1Nb7sIpeoJsQEYczyW3I7rN9zJ
        BKJGf3XYyHCzjNxazYpSZpVx6h/+dLBbx7A6Y6w=
X-Google-Smtp-Source: ABdhPJyZmJGTwo2722UUz7WdRiEPE80dASqU/bVhjb4FY4dMa4G28pS/d7JsiaV39IWXLH9tUctL90X9qaaj9JfV8T0=
X-Received: by 2002:ac2:5493:: with SMTP id t19mr7208809lfk.346.1621403315041;
 Tue, 18 May 2021 22:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <20210519052048.GA24853@lst.de>
In-Reply-To: <20210519052048.GA24853@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 May 2021 13:48:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
Message-ID: <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
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

The patchset just leaves a configuration chance for vendors. Before
RISC-V ISA fixes it, we should give the chance to let vendor solve
their real chip issues.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
