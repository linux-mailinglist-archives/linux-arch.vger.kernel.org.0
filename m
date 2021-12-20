Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7904D47A6B4
	for <lists+linux-arch@lfdr.de>; Mon, 20 Dec 2021 10:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhLTJRf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 04:17:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34966 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhLTJRe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2021 04:17:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F23660F13;
        Mon, 20 Dec 2021 09:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F05C36AF8;
        Mon, 20 Dec 2021 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639991853;
        bh=4+z4MVcPf/vwKLP5WpH1FLTAs/YDepAbppw8qxij2dk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RORZ8FOw5XgCfTedf8Vy4x/Kl7XUma5ObTwalOH2cpItN6PusnsjAaknMoFb9TDJy
         Vn5HSAelSIcanbH9Z6LicVbjMkXhurbYiqRngLzWVpI/+VSU61pEtjwBO71Rjs/nAR
         /bnrwbg8l/6JHKBqbP/eov9VvGYmwwazgRY2h8GI8XJ19FbNP4MhaBoBfZH+TOrtWa
         n1vldrkZQL3PW2zxAV4xWDJh06uQHgnnkUY0HS/V24mZNsvpTT55bujoSNt25Kqqfn
         ceiu+JZ1RXYw23uIYkXwX9vLzsTf21ndZn0hkkMPkNntjcNVqIPvZTsH1S5WfLqVDz
         InAVWDfCognMA==
Received: by mail-wm1-f49.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so6212724wmb.0;
        Mon, 20 Dec 2021 01:17:33 -0800 (PST)
X-Gm-Message-State: AOAM530sFjBLyawhk2EgADOIEtAMpRM8JwfXnWQOGF3hfg0iGHwYaqxe
        vVyy5ruQTokLcxrGsmiU2ZMC0FQld9SX/xyaKP8=
X-Google-Smtp-Source: ABdhPJx5h88IXQvYmswzOZH9pshCavecGzDNWpi0p2Dn/d/bkKU5f+wXghRuyty1pglHInCAdE5taSAXaJWtpT1dxOs=
X-Received: by 2002:a1c:1f93:: with SMTP id f141mr4145000wmf.56.1639991851853;
 Mon, 20 Dec 2021 01:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
 <20211206104657.433304-13-alexandre.ghiti@canonical.com> <CAJF2gTQEHv1dVzv=JNCYSzD8oh6UxYOFRTdBOp-FFeeeOhSJrQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQEHv1dVzv=JNCYSzD8oh6UxYOFRTdBOp-FFeeeOhSJrQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Dec 2021 10:17:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHmdDKFozkoAfM-mxsxxfanhVq5HcA1qKTrkp=vAt=Umg@mail.gmail.com>
Message-ID: <CAMj1kXHmdDKFozkoAfM-mxsxxfanhVq5HcA1qKTrkp=vAt=Umg@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] riscv: Initialize thread pointer before calling
 C functions
To:     Guo Ren <guoren@kernel.org>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 20 Dec 2021 at 10:11, Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Dec 7, 2021 at 11:55 AM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > Because of the stack canary feature that reads from the current task
> > structure the stack canary value, the thread pointer register "tp" must
> > be set before calling any C function from head.S: by chance, setup_vm
> Shall we disable -fstack-protector for setup_vm() with __attribute__?

Don't use __attribute__((optimize())) for that: it is known to be
broken, and documented as debug purposes only in the GCC info pages:

https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html




> Actually, we've already init tp later.
>
> > and all the functions that it calls does not seem to be part of the
> > functions where the canary check is done, but in the following commits,
> > some functions will.
> >
> > Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > ---
> >  arch/riscv/kernel/head.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index c3c0ed559770..86f7ee3d210d 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -302,6 +302,7 @@ clear_bss_done:
> >         REG_S a0, (a2)
> >
> >         /* Initialize page tables and relocate to virtual addresses */
> > +       la tp, init_task
> >         la sp, init_thread_union + THREAD_SIZE
> >         XIP_FIXUP_OFFSET sp
> >  #ifdef CONFIG_BUILTIN_DTB
> > --
> > 2.32.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
