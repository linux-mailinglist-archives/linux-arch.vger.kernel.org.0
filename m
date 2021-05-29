Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A3394E84
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhE2XoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 May 2021 19:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE2XoP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 May 2021 19:44:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706EC06174A
        for <linux-arch@vger.kernel.org>; Sat, 29 May 2021 16:42:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e22so5440350pgv.10
        for <linux-arch@vger.kernel.org>; Sat, 29 May 2021 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nCF8S4c2UqVaSQfWVl5eT5cODWPKUpixcjFKEGaEBsg=;
        b=E5j3/R9jGWjyCkfveb2hFi3KRV59el0pmSmh+8jttzaEE49YnjYfWQrISUX64DQTYD
         CYRdBqqAhVie9tBk2A+r2dzPZRJyuQP4ps6vdHoJucMBqoeUE4mUuxgptKEKmked618I
         L7Ab8AynI+ph9zaO9IkGNdX1bYp7Nxg5H2TbkY/SYhwpws1R9fVlrkrE1LHF5r+cqVLS
         U7DxNqsMin6gbEHkEqcnymxvPahPMJwWPB5nKL8bBBKQQyP9ayWCz6441HZ8LELXsyxN
         MazOBw7l0X7C3ebInAujp8DqGA1qKg6P393sKCixoqXtj6RnfI8kVG4RTuL5Jyr88dRY
         n0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nCF8S4c2UqVaSQfWVl5eT5cODWPKUpixcjFKEGaEBsg=;
        b=Y9gRqwR/aWw4PmjOwXyLTmAdkCzPoeFRhSjLaFDKwnhp2Q2SNE3aQN4vjuywl85bm4
         Fq6qjjdqIxo8GB8ggnd4EGDdC1RZutRfB9LlJfiXUSAVgLM3PWsq3lhG5RGuTBKX6Fab
         x4omkSwbGD5icEs0n069rhbcpMWwOrSKydrMWredi+dZfP9iTQ7VmWxfonzH1DZm0d9Y
         mgLCnpRTeVlFd6QHvywAwMsKmd/fRz8DNbFODx2cwDakYvq3Hg9MBzqOROpU6JDCjE+c
         cTo9Y0IP8tRcoVmoxnRcH89pd6jPRVcJLVtoBDwfgo1o9yCvcHS0/L4Nq9cx9h4Wi6rX
         OoTw==
X-Gm-Message-State: AOAM5322s0uuW8zBT2yRuS7Z2qnq8lBSw0l/VGGqehhZ50nHx2eYyzM7
        Okr6plph6bKfNNjyOyHUNeLxCA==
X-Google-Smtp-Source: ABdhPJyBM9qTLEBjQIl1kZoPH7198QqOL+uALfz0g+QnABTxRKo7JOcZf9HC769u0b3OkMLMhkHXdQ==
X-Received: by 2002:a65:584d:: with SMTP id s13mr16053871pgr.97.1622331756137;
        Sat, 29 May 2021 16:42:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k20sm7843994pgl.72.2021.05.29.16.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 16:42:35 -0700 (PDT)
Date:   Sat, 29 May 2021 16:42:35 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 16:16:36 PDT (-0700)
From:   palmerdabbelt@google.com
X-Google-Original-From: palmer@dabbelt.com
Subject:     Re: [PATCH V4 1/2] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
In-Reply-To: <1622008161-41451-2-git-send-email-guoren@kernel.org>
CC:     guoren@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        guoren@linux.alibaba.com
To:     guoren@kernel.org
Message-ID: <mhng-60806045-5ac7-4057-b596-a4d9cb79b7be@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 25 May 2021 22:49:20 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Kernel virtual address translation should avoid to use ASIDs or it'll
> cause more TLB-miss and TLB-refill. Because the current ASID in satp
> belongs to the current process, but the target kernel va TLB entry's
> ASID still belongs to the previous process.

Sorry, I still can't quite figure out what this is trying to say.  I 
went ahead and re-wrote the commit text to

    riscv: Use global mappings for kernel pages

    We map kernel pages into all addresses spages, so they can be marked as
    global.  This allows hardware to avoid flushing the kernel mappings when
    moving between address spaces.

LMK if I'm misunderstanding something here, it's on for-next.

>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 9469f46..346a3c6 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -134,7 +134,8 @@
>  				| _PAGE_WRITE \
>  				| _PAGE_PRESENT \
>  				| _PAGE_ACCESSED \
> -				| _PAGE_DIRTY)
> +				| _PAGE_DIRTY \
> +				| _PAGE_GLOBAL)
>
>  #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
