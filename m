Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926B27A9EB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfG3Nnj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 09:43:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45241 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3Nni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 09:43:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so58110265qtp.12;
        Tue, 30 Jul 2019 06:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUMgES4eSdx7Gb1wHf4vgNUcT1viL6l/JJUreDv7DAI=;
        b=rvgYy2Z0k649zlfGfNIVsM/rbnnF6m3wP1uGvhhhuDcf8C0DW014P0oGFSAfJWaHxR
         DREOPuw6Ow6640D3q4IUeohjLMGw0R0OU2QNfvRD8ovgvaMcCCzUnlRhILWarpsQSs1n
         8FUib1Iu+8Vbbyou77raJqQbcHcEBR6JufQlmabd0PF7tQErv2ecT9DUbWQsMtCU8nDB
         KgDMdVWA5BrNB2xnEBAmEmBmojXs+icMAKYq1W6c3KVgzHjJcH0NtiTV5ardV1rI4L4E
         3CD+b5vlueGnN/JzUu+xPj7J6MVBlOCVo2pWi1gmnEebN/ERh48ayO7Zoy0XaLZO31sP
         WZMw==
X-Gm-Message-State: APjAAAVuUf77BZ77JAjX9/CleFtVULpFHCxa627p1LKRMgE47RAc6Ssq
        AAaScmiazxls44yg7wSYV8IGmtvpnI/dStM8tCs=
X-Google-Smtp-Source: APXvYqzk4myI3khjNxlQnHaI9ZcgvMI5FOmQpZ2ORwmh2H4e5fyHlvNQY96ZcLDUkT4i2hDktBvBnnKAR3H1vEsYzAU=
X-Received: by 2002:ac8:f99:: with SMTP id b25mr73930879qtk.142.1564494217063;
 Tue, 30 Jul 2019 06:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org> <1564488945-20149-4-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-4-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 15:43:20 +0200
Message-ID: <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 30, 2019 at 2:16 PM <guoren@kernel.org> wrote:
> From: Guo Ren <ren_guo@c-sky.com>

> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 3f1ff9d..d8f0f81 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
>                 cache_op(paddr, size, dma_wb_range);
>                 break;
>         case DMA_FROM_DEVICE:
> +               cache_op(paddr, size, dma_inv_range);
> +               break;
>         case DMA_BIDIRECTIONAL:
>                 cache_op(paddr, size, dma_wbinv_range);
>                 break;
> @@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>                 cache_op(paddr, size, dma_wb_range);
>                 break;
>         case DMA_FROM_DEVICE:
> +               cache_op(paddr, size, dma_inv_range);
> +               break;
>         case DMA_BIDIRECTIONAL:
>                 cache_op(paddr, size, dma_wbinv_range);
>                 break;

When syncing 'for_cpu', you should not need to write back, because
there won't be any dirty cache lines.

If you have a CPU core that does not do speculative loads, you also don't
need to invalidate here, because you have already done that in the
_for_device() case, the only reason to invalidate the CPU cache
again is if a speculative load created a stale cache line that now
shadows the data received from the device.

        Arnd
