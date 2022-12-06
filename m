Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20961643D30
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 07:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiLFGkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 01:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFGkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 01:40:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403D1C130;
        Mon,  5 Dec 2022 22:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4144B81696;
        Tue,  6 Dec 2022 06:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB47C4314C;
        Tue,  6 Dec 2022 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670308812;
        bh=2UPTSFMtC8PZoZckQhAgmrzqubqAbaCbl9+6gXlAzXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lw6Q7X3ze/epTpgAu2+Q6mEV+2cdCKEpQQZcjS99AekVVMdKNg/D8y1heYss+wJMa
         LeGNevDT/gNl18jeXnG4GuQwPfsVhsAdPcneM6cW2RYyFsLvRJornuoC76AImIJEg5
         xqQB24g8EBf7grc9kC0N4k73tsaTJa6k5RT+abb6TKi6dLVQSNh99rnt4AEVbwP4jZ
         PxUlb1W21GkXaz/oBdiTjnd+X+CdobWEPG40kiLxq+rUSUsRBwO1XrW2WS2y80Soqt
         MDLRpOZx5L8yIfOZsZAk3e0WMqg36B9hQqurHkafyfJ3o/q5Xu9ILOPSM/cGYf5ga1
         jNZ/OgSOmUAaQ==
Received: by mail-ed1-f50.google.com with SMTP id d14so13976081edj.11;
        Mon, 05 Dec 2022 22:40:12 -0800 (PST)
X-Gm-Message-State: ANoB5pk3DYtzP35XVUGhhlps4f6k1TMCtuLXGi3VLXLAU5CTFMUKRzyg
        54IyvxvP3UTp8Wmn094fTlTeXLrK93vgqplDS7A=
X-Google-Smtp-Source: AA0mqf4UiAug0DZSHJ/dNaPXC7jnuJMoHAvmbB4knjFvReiDmDy5hZFcrNclRixVqByAdMOXJcNKQZ5COMaotDSXaTg=
X-Received: by 2002:a05:6402:1117:b0:46b:6da7:e8a9 with SMTP id
 u23-20020a056402111700b0046b6da7e8a9mr28827003edv.401.1670308810687; Mon, 05
 Dec 2022 22:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20221103075047.1634923-1-guoren@kernel.org> <20221103075047.1634923-7-guoren@kernel.org>
 <874jua9lcp.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <874jua9lcp.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Dec 2022 14:39:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRsZMM9vPqRWEwzOOhW2czo8uOJEtTGjixJig1kdQP1hg@mail.gmail.com>
Message-ID: <CAJF2gTRsZMM9vPqRWEwzOOhW2czo8uOJEtTGjixJig1kdQP1hg@mail.gmail.com>
Subject: Re: [PATCH -next V8 06/14] riscv: convert to generic entry
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022 at 6:49 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch converts riscv to use the generic entry infrastructure from
> > kernel/entry/*. The generic entry makes maintainers' work easier and
> > codes more elegant. Here are the changes than before:
> >
> >  - More clear entry.S with handle_exception and ret_from_exception
> >  - Get rid of complex custom signal implementation
> >  - More readable syscall procedure
> >  - Little modification on ret_from_fork & ret_from_kernel_thread
> >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> >  - Use the standard preemption code instead of custom
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > ---
>
> [...]
>
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_risc=
v.c
> > index 5d3f2fbeb33c..c86d0eafdf6a 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -5,8 +5,10 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >
> > +#include <linux/entry-common.h>
> >  #include <linux/syscalls.h>
> >  #include <asm/unistd.h>
> > +#include <asm/syscall.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm-generic/mman-common.h>
> >
> > @@ -69,3 +71,28 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start=
, uintptr_t, end,
> >
> >       return 0;
> >  }
> > +
> > +typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ul=
ong);
> > +
> > +asmlinkage void do_sys_ecall_u(struct pt_regs *regs)
> > +{
> > +     syscall_t syscall;
> > +     ulong nr =3D regs->a7;
> > +
> > +     regs->epc +=3D 4;
> > +     regs->orig_a0 =3D regs->a0;
> > +     regs->a0 =3D -ENOSYS;
> > +
> > +     nr =3D syscall_enter_from_user_mode(regs, nr);
> > +#ifdef CONFIG_COMPAT
> > +     if ((regs->status & SR_UXL) =3D=3D SR_UXL_32)
> > +             syscall =3D compat_sys_call_table[nr];
> > +     else
> > +#endif
> > +             syscall =3D sys_call_table[nr];
> > +
> > +     if (nr < NR_syscalls)
> > +             regs->a0 =3D syscall(regs->orig_a0, regs->a1, regs->a2,
> > +                                regs->a3, regs->a4, regs->a5,
> >       regs->a6);
>
> Now that we're doing the "pt_regs to call" dance, it would make sense to
> introduce a syscall wrapper (like x86 and arm64) for riscv, so that we
> don't need to unwrap all regs for all syscalls (See __MAP() in
> include/linux/syscalls.h). That would be an optimization, so it could be
> done as a follow-up, and not part of the series.
Thx for the reminder; I will have a look at "pt_regs to call."

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
