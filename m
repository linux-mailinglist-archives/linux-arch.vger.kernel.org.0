Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57289390109
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEYMeR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhEYMeQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 May 2021 08:34:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A5C061574
        for <linux-arch@vger.kernel.org>; Tue, 25 May 2021 05:32:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so32030818wrs.4
        for <linux-arch@vger.kernel.org>; Tue, 25 May 2021 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFy/LCaXB1SRilva8CJ6mi6jxkEQV+dWKl9QiGNHUsg=;
        b=s2myp/MyFCHOHtpxco8bZqGgOkPGygWKSZEMO5NAtVwE7ob5u1K956l3GFDdI8BvXp
         6huP+HAe5CK3gwN1qVuy1yHJgr5u1dVVw844eZ4sUbKonuWYdz7uDbugoZn7ZPs1Pijh
         RbxX8EkV57WppSRghckgfI2u2zN49d7zF0mrxQWOQevslGVYdY+W5vNXe/K6tY41C+GL
         4gD18WUuLnhhTN19n0BJxOF6Z2aY/EJ2Gqed5nPh6W1riNawh/tLQcBEp/+rhWKYfs2Z
         Uk+XNOTGlJ3BlTkWJnbNqo1hdeDOAb78BDm7BZsf2uwGyjXnG1AwvQ0MsayaKfHJ+tEQ
         KYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFy/LCaXB1SRilva8CJ6mi6jxkEQV+dWKl9QiGNHUsg=;
        b=s0aq/uZS4CLEouowOshb6rVtQLuNz/d3V9vcsDeJcuvDKm5dOFzWTs9uK6bo4VNvRY
         5AwdnWo3TpuDLrW9oQ+QXBO8ucRTZG51VRBdyLL2w3aT7GX8To5y24KTgPzG+OulJyu8
         8KIfbiY/DcNFRlMXPH9ZLPhA1qaQinV2atHLmflOjh/nKTBt+0IVytD2q4h5SqJ5j3FC
         9oxSPmv/QnLDG6N9EYNG6HNm5qwydpowKBKcrJhYvBZ22hSXzWZsQMc99acDYzJ0LyiH
         InjYFfcXyZQIb+13OBLINZ6mkn7TaC5bsNrQjrQ76b0GJ/gVd3GC/EfKjorIM+DRbYku
         mvVw==
X-Gm-Message-State: AOAM532V0IOZGtjX85Af1auTxJJv/w/jq/7duMccus94Yv0ERUThvpcH
        P+DvUGXKgj5UhOWrkc6SWylVtKdAOIJN454ZoqkYFg==
X-Google-Smtp-Source: ABdhPJwmnDH3iFAvmCNe+NjWKkYYKkEISVmzhPeoZ89aTiS5cvv29wco+Is3CTtZH/UHKJezW1DX4vg3l9OBcF2kkmY=
X-Received: by 2002:adf:e38c:: with SMTP id e12mr26636946wrm.128.1621945963328;
 Tue, 25 May 2021 05:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <1621945234-37878-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1621945234-37878-1-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 25 May 2021 18:02:31 +0530
Message-ID: <CAAhSdy3b455vEhsMtL_swSnt1udP_z_dM_zcXvRfLN5ikjY8_A@mail.gmail.com>
Subject: Re: [PATCH] arch: Cleanup unused functions
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 5:52 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These functions haven't been used, so just remove them. The patch
> has been tested with riscv, but I only use grep to check the
> microblaze's.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/microblaze/include/asm/page.h |  3 ---
>  arch/riscv/include/asm/page.h      | 10 ----------
>  2 files changed, 13 deletions(-)
>
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index bf681f2..ce55097 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -35,9 +35,6 @@
>
>  #define ARCH_SLAB_MINALIGN     L1_CACHE_BYTES
>
> -#define PAGE_UP(addr)  (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)        ((addr)&(~((PAGE_SIZE)-1)))
> -
>  /*
>   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
>   * it is set to the kernel start address (aligned on a page boundary).
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6a7761c..a1b888f 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -37,16 +37,6 @@
>
>  #ifndef __ASSEMBLY__
>
> -#define PAGE_UP(addr)  (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)        ((addr)&(~((PAGE_SIZE)-1)))
> -
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr, size)  (((addr)+((size)-1))&(~((size)-1)))
> -#define _ALIGN_DOWN(addr, size)        ((addr)&(~((size)-1)))
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr, size)     _ALIGN_UP(addr, size)
> -
>  #define clear_page(pgaddr)                     memset((pgaddr), 0, PAGE_SIZE)
>  #define copy_page(to, from)                    memcpy((to), (from), PAGE_SIZE)
>
> --
> 2.7.4
>
