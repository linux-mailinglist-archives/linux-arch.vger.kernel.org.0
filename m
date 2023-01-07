Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F87D660E6A
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jan 2023 12:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjAGLta (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Jan 2023 06:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjAGLtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2023 06:49:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A52F78C;
        Sat,  7 Jan 2023 03:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90B12B81F8B;
        Sat,  7 Jan 2023 11:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43717C43398;
        Sat,  7 Jan 2023 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673092158;
        bh=kTlmPIB5+SKLRyeIWaGd1ToAz+B7IfaNZb/VN9D8Br0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4tzApx4JoIplSyq0UV2lhEo24AGkMOtN7pg0xmXWMjhBr6QPLcg2dBLvY6yzZcgI
         SfCFoVG8noNUdqqipcdKQTllXvTPzgzg/NC5iGGxF3O3JAG7PyowEPqPZ0Yx4pPEgB
         AvLVITSVl+GBs6SL7ma+mi+zOOvxMJS4MuY2nAL3AN/9MfI1Kwi6W9uWpMhT0LMgpM
         mz454M0fpi57OmawwVYlLd5HLKgqCBZiCuzaX3xGT5Nql0H9qrO7SSZ/5Y52gRsLnU
         ImZq3hHDGHXmo2W4ATkGvh6fGiTAeXwQYtRful9aqnp/lsFmf2kl0CRci3V+cAC8of
         aYekkNW2RzU2g==
Received: by mail-ej1-f42.google.com with SMTP id ss4so1738824ejb.11;
        Sat, 07 Jan 2023 03:49:18 -0800 (PST)
X-Gm-Message-State: AFqh2kqKJNBQ4MwVjaSHt0YTHaJcbIu33gGgUnPHoiOTff3AI1hVohp8
        XJvwPibeeVrHeVyL6iqI1/SQEighdr4L5JoElNE=
X-Google-Smtp-Source: AMrXdXvBg9tr/kB+0KHKNPtvYYtBZn6/eI6f0f8EhL+v5nmOXFae28WlXsLrCphcY/eAy/rfkHOtgqMBNW6KzzGwzoA=
X-Received: by 2002:a17:906:cc87:b0:7c4:ec55:59e with SMTP id
 oq7-20020a170906cc8700b007c4ec55059emr3580124ejb.611.1673092156509; Sat, 07
 Jan 2023 03:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20230103033531.2011112-1-guoren@kernel.org> <20230103033531.2011112-4-guoren@kernel.org>
 <Y7VpN/fFjqGJbxPu@FVFF77S0Q05N>
In-Reply-To: <Y7VpN/fFjqGJbxPu@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 7 Jan 2023 19:49:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSYhX1Yh_BZTOxgvOpKeaBSrxfnQ-LfUCh7Qiy58SgJkg@mail.gmail.com>
Message-ID: <CAJF2gTSYhX1Yh_BZTOxgvOpKeaBSrxfnQ-LfUCh7Qiy58SgJkg@mail.gmail.com>
Subject: Re: [PATCH -next V12 3/7] riscv: entry: Add noinstr to prevent
 instrumentation inserted
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, ben@decadent.org.uk, bjorn@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
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

On Wed, Jan 4, 2023 at 7:55 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Jan 02, 2023 at 10:35:27PM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Without noinstr the compiler is free to insert instrumentation (think
> > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> > yet ready to run this early in the entry path, for instance it could
> > rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
>
> That's generally true, and makes sense to me, but ....
>
> > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.progra=
mming.kicks-ass.net/
> > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/traps.c | 4 ++--
> >  arch/riscv/mm/fault.c     | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 549bde5c970a..96ec76c54ff2 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -95,9 +95,9 @@ static void do_trap_error(struct pt_regs *regs, int s=
igno, int code,
> >  }
> >
> >  #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> > -#define __trap_section               __section(".xip.traps")
> > +#define __trap_section __noinstr_section(".xip.traps")
> >  #else
> > -#define __trap_section
> > +#define __trap_section noinstr
> >  #endif
> >  #define DO_ERROR_INFO(name, signo, code, str)                         =
       \
> >  asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index d86f7cebd4a7..b26f68eac61c 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -204,7 +204,7 @@ static inline bool access_error(unsigned long cause=
, struct vm_area_struct *vma)
> >   * This routine handles page faults.  It determines the address and th=
e
> >   * problem, and then passes it off to one of the appropriate routines.
> >   */
> > -asmlinkage void do_page_fault(struct pt_regs *regs)
> > +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
>
> ... why do you need that for do_page_fault? That doesn't (currently) do a=
ny
> entry/exit logic, so this seems unnecessary per the commit description.
Yes, the above is unnecessary; I've fixed it in v13.

>
> Thanks,
> Mark.
>
> >  {
> >       struct task_struct *tsk;
> >       struct vm_area_struct *vma;
> > --
> > 2.36.1
> >



--=20
Best Regards
 Guo Ren
