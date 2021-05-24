Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE65038E444
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEXKoQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 06:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhEXKoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2021 06:44:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B2C061574
        for <linux-arch@vger.kernel.org>; Mon, 24 May 2021 03:42:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so28020806wrq.6
        for <linux-arch@vger.kernel.org>; Mon, 24 May 2021 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eUOrn9lE2HWE5uWnHqSiVPbmorQyM5RkNMwB1g8oIs=;
        b=0yAdh939lZC+DNZj9zX08KI/2bh/2h7zmkHMSnczbPROY1mBpcwAmg0BQPTddC33YH
         4poJ7dKhhKT4R4TGNXdtorC9bI2PVGH3oXRIPpAS/DKiuIxy/TzYsazkdd3Qpzv1SG/2
         r9YwVzaeFmSJAJ3aqiEVi9Ry0XwMT4iGOOiqcC9zemBuKsWaAgalXyA5WRQrcMbcdMoY
         sOdd9GnmW7iWCEJydL+7x3rrUSV+8pYIOL2gETTo15dqXQtU/3MvCuijaryNcvW2d3fA
         DRH8il9kC3BqiomKign1XqgPFDcyL8bPJvmkWu1ndPqOrDtLgeCriIec0SZ8emwQGmU5
         IH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eUOrn9lE2HWE5uWnHqSiVPbmorQyM5RkNMwB1g8oIs=;
        b=FXxMlLAMcYaHlDCPJKM2hNKDfFUuYX6KlsvQU4vZvDXNgBBLywgMzqOOS7wynXaVah
         LcCdaxVh2LkdYo/r1/J28IvdnyZuAFA7YbkpzTezPahJDBJcJ52f1qMG2ZW+34Z6rTL8
         EWx/4Al2lHdXMMblhtVhzQNG8sCMk/spJRwTRLk33WL4skZ2c21WH8sUY+YQRaOmzZWC
         VmStlSwCke906fMV5ad3kUQF+toxOJqfSe9kB7wy/672iUyXEmZLrdwaUiexCbceUQV9
         W1rVjy6zfer2ZCskwENkPCbMBcXGPC8ztbPgyIE/Jfbbx3kTMSromRnWbS1iod4rY7Pt
         ybhQ==
X-Gm-Message-State: AOAM530VxaZpllWB00BNiSJBxt6RAHlzgn1ST2AM0f2d98gmIYWQqA9j
        lmvIPEyY/mkGHN30ZoaD58QkwEGQp68gpTRiu+iE7A==
X-Google-Smtp-Source: ABdhPJyWPhOVNAkgUqE7qc9+oTrs7UQSenUtFjVASUHEuOyt8RBQDzntOc1bcLlVhXlvtZH0j/l7d8a1Eumaxmy0RFw=
X-Received: by 2002:a5d:6701:: with SMTP id o1mr22084731wru.390.1621852958251;
 Mon, 24 May 2021 03:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <1621839068-31738-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1621839068-31738-1-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 24 May 2021 16:12:26 +0530
Message-ID: <CAAhSdy1QsyddHG3u=+Sv3mrVmtB15pr-hvg7+UT1evmNSwyY1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 12:22 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Kernel virtual address translation should avoid care asid or it'll
> cause more TLB-miss and TLB-refill. Because the current asid in satp
> belongs to the current process, but the target kernel va TLB entry's
> asid still belongs to the previous process.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 78f2323..017da15 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -135,6 +135,7 @@
>                                 | _PAGE_PRESENT \
>                                 | _PAGE_ACCESSED \
>                                 | _PAGE_DIRTY \
> +                               | _PAGE_GLOBAL \
>                                 | _PAGE_CACHE)

It seems this patch is not based on the upstream kernel. The
_PAGE_CACHE seems to be from your other patch series.

Please rebase these patches on the latest upstream kernel without
dependency on any other patch series.

Regards,
Anup

>
>  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
> --
> 2.7.4
>
