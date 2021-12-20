Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD047AA7B
	for <lists+linux-arch@lfdr.de>; Mon, 20 Dec 2021 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhLTNlH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 08:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLTNlG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2021 08:41:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B80C061574;
        Mon, 20 Dec 2021 05:41:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E6C9B80EA2;
        Mon, 20 Dec 2021 13:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B994C36AE9;
        Mon, 20 Dec 2021 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640007663;
        bh=sEhqYPxM4z19kGZYE2peDh+u0pT/5DH5Q0sa/WgLz2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oT13uPmkAxGD5Bshuprq6DF7tVZgmsbYCW7m81SlEheTzmKYwN9cteS2Qm0f+yzG6
         FxEZ90zHRkBUkkldie3P2GUorJw1P9OF2hEnTx8f/v+ToJqdVDYWB/RZ1XHjnjfRxL
         fLVSWyLXsF5rXhpcI2KLW7oGXDoL1S/kUska8UuCqrAnXLgCH77Juo+nSxz7bV+YX3
         3WfuXF6l3rrDlcVq5dlYauRBATyJZitLDYYQCif2MaHz6a5dvEw228kOuvYnysWwa9
         APhZ9+umMMMIfdZxyvdYYy+6SLkJwLHrNpa2baLRP4StlCKGzXgQu+j2Qe1Fq0Q/Z8
         2W1x/QxmwJyOQ==
Received: by mail-ua1-f54.google.com with SMTP id o1so17725858uap.4;
        Mon, 20 Dec 2021 05:41:02 -0800 (PST)
X-Gm-Message-State: AOAM533SMp5A/u+oBrZeD2y/zBD71doYSiFNpX9Sa1mxW40hpKMaRaJr
        PpTwsONAqV+SNvyXUEDHCIMmWPpjSyzD5j+ow4k=
X-Google-Smtp-Source: ABdhPJwGr/+MFfoW7ipUpJBlTl+ZN+AB5Gr6EIJrZEEcp5Ttg/AYr9iCWiGr8Ukebm4uIUfe9nTB/0FRTqyMvS0jIYU=
X-Received: by 2002:a05:6102:316e:: with SMTP id l14mr233250vsm.8.1640007662059;
 Mon, 20 Dec 2021 05:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
 <20211206104657.433304-13-alexandre.ghiti@canonical.com> <CAJF2gTQEHv1dVzv=JNCYSzD8oh6UxYOFRTdBOp-FFeeeOhSJrQ@mail.gmail.com>
 <CAMj1kXHmdDKFozkoAfM-mxsxxfanhVq5HcA1qKTrkp=vAt=Umg@mail.gmail.com>
In-Reply-To: <CAMj1kXHmdDKFozkoAfM-mxsxxfanhVq5HcA1qKTrkp=vAt=Umg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 20 Dec 2021 21:40:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2pDN8vvknmE2s1nj2WSuCfTkXYkU074rCck+CCwQv7Q@mail.gmail.com>
Message-ID: <CAJF2gTR2pDN8vvknmE2s1nj2WSuCfTkXYkU074rCck+CCwQv7Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] riscv: Initialize thread pointer before calling
 C functions
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Dec 20, 2021 at 5:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 20 Dec 2021 at 10:11, Guo Ren <guoren@kernel.org> wrote:
> >
> > On Tue, Dec 7, 2021 at 11:55 AM Alexandre Ghiti
> > <alexandre.ghiti@canonical.com> wrote:
> > >
> > > Because of the stack canary feature that reads from the current task
> > > structure the stack canary value, the thread pointer register "tp" must
> > > be set before calling any C function from head.S: by chance, setup_vm
> > Shall we disable -fstack-protector for setup_vm() with __attribute__?
>
> Don't use __attribute__((optimize())) for that: it is known to be
> broken, and documented as debug purposes only in the GCC info pages:
>
> https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
Oh, thx for the link.

>
>
>
>
> > Actually, we've already init tp later.
> >
> > > and all the functions that it calls does not seem to be part of the
> > > functions where the canary check is done, but in the following commits,
> > > some functions will.
> > >
> > > Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
> > > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > > ---
> > >  arch/riscv/kernel/head.S | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > > index c3c0ed559770..86f7ee3d210d 100644
> > > --- a/arch/riscv/kernel/head.S
> > > +++ b/arch/riscv/kernel/head.S
> > > @@ -302,6 +302,7 @@ clear_bss_done:
> > >         REG_S a0, (a2)
> > >
> > >         /* Initialize page tables and relocate to virtual addresses */
> > > +       la tp, init_task
> > >         la sp, init_thread_union + THREAD_SIZE
> > >         XIP_FIXUP_OFFSET sp
> > >  #ifdef CONFIG_BUILTIN_DTB
> > > --
> > > 2.32.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
