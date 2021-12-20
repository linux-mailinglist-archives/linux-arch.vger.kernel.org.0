Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D247247A6A3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Dec 2021 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhLTJLU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 04:11:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43832 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhLTJLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2021 04:11:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3C7BB80E2F;
        Mon, 20 Dec 2021 09:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C06C36AF1;
        Mon, 20 Dec 2021 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639991477;
        bh=nEOzzl3wgkRPT0ygPKzT3y34sfnV1NTZVShiBXQle80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+pQs5PylnYAzTQdboNEcFEcb/0jEv235YQ31EGzXeMNcNWFYDzI2wRBRs75VPCZo
         A6o71kUHuefFXz25TPekWC/tqGShH7/xuyF2uQNXW7aoNHBBi4OjIfgWj5nrvpv9wE
         fTk9wXuIR2O5A1JgAo1v4ectbqb9S3o8AkF8SjZfqjIJmcCFPexSnyuvnFZ+aaXfsQ
         VYHbHoSqvDIVC2KRrygV2Gxe0WKtX3SJn7BEv+uULTy6pa33iGoYu5CW0f11JRgCDI
         sNZ2pODyIgIxISqGX9atx2cRHiRqV8gVCiyVP0CM+nIdkCFsnU37aWYtREBkmMGthR
         7QlP2UUR7W5+w==
Received: by mail-ua1-f53.google.com with SMTP id p37so16464475uae.8;
        Mon, 20 Dec 2021 01:11:17 -0800 (PST)
X-Gm-Message-State: AOAM533KCzZ969lQtWNl0dOydZQUsidLKZMI11ebZ5TQ/eb5wiiK+j4u
        wRcIpb66uBoFaoPB75BKt/Y90vdBhH9aAukrYpw=
X-Google-Smtp-Source: ABdhPJwE5vVG3rt8d+HcTmKlAQnW1OXabBV+eLKlgaa5VIIm58YsDnEYQVdu+coTipMz0kob8hRz5mDIgjhyqqjdiuc=
X-Received: by 2002:ab0:3055:: with SMTP id x21mr4783242ual.97.1639991476313;
 Mon, 20 Dec 2021 01:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com> <20211206104657.433304-13-alexandre.ghiti@canonical.com>
In-Reply-To: <20211206104657.433304-13-alexandre.ghiti@canonical.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 20 Dec 2021 17:11:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQEHv1dVzv=JNCYSzD8oh6UxYOFRTdBOp-FFeeeOhSJrQ@mail.gmail.com>
Message-ID: <CAJF2gTQEHv1dVzv=JNCYSzD8oh6UxYOFRTdBOp-FFeeeOhSJrQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] riscv: Initialize thread pointer before calling
 C functions
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 7, 2021 at 11:55 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Because of the stack canary feature that reads from the current task
> structure the stack canary value, the thread pointer register "tp" must
> be set before calling any C function from head.S: by chance, setup_vm
Shall we disable -fstack-protector for setup_vm() with __attribute__?
Actually, we've already init tp later.

> and all the functions that it calls does not seem to be part of the
> functions where the canary check is done, but in the following commits,
> some functions will.
>
> Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  arch/riscv/kernel/head.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index c3c0ed559770..86f7ee3d210d 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -302,6 +302,7 @@ clear_bss_done:
>         REG_S a0, (a2)
>
>         /* Initialize page tables and relocate to virtual addresses */
> +       la tp, init_task
>         la sp, init_thread_union + THREAD_SIZE
>         XIP_FIXUP_OFFSET sp
>  #ifdef CONFIG_BUILTIN_DTB
> --
> 2.32.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
