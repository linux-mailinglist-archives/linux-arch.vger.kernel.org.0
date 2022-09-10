Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76C5B4641
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIJMqa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIJMq3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 08:46:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473075756C;
        Sat, 10 Sep 2022 05:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B435B80092;
        Sat, 10 Sep 2022 12:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F3C4314C;
        Sat, 10 Sep 2022 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662813985;
        bh=TERaEXPowMLlPVBnpM960uVa5c8eqEDlYbURBWmp8IQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VYvlF8Hk6WTeHpi4Znngv6jUgbgFfDxxDucToBQiNM2AFplug9oPfhtdSPr0meAz/
         rsT0UORc7ES8edj8IU8E2ji2+2gd/EGziCdwmKcs1+rjztU2J1X3qWddimoEe1Gdfh
         KCdDKR4AgLqqJyYSrnI1kfPrvrOH72wgCIPOYR/IB09HmORwMsFsLOgax9jwUtPS8S
         JnVpc4GCa+D8QOKGHbuR3FxCSSi8m0pZsuAREgXts4I7iJbNr3zqwhKYh12IAjgIqP
         /RBEDIWepeps0zVfqQ842gNyJCS+bXLBVgsBlO9sK3XFg2e/0Phfv2qLjiee/o0NlK
         OHAVOLFZKuaGQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-127ba06d03fso10981994fac.3;
        Sat, 10 Sep 2022 05:46:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo2m+gL+4EJP8YAsWp42w94V8+3Nbw14CKcxi9NFXROnR969MNuq
        WrajkXvslP5IKtO5IT+gES6RHCntSU4SnTVeLoY=
X-Google-Smtp-Source: AA6agR75N5rQAw3Fe3VB0v1AiIwOlOT8IXZNL9pLtjuftV4zLoDZzdEQYcxoqA/YodSDhVyFwFV8RCkaXS96FJPfedw=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr7146455oae.19.1662813984030; Sat, 10
 Sep 2022 05:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-5-guoren@kernel.org>
 <Yxmaz7wJPEBQ7Vki@hirez.programming.kicks-ass.net> <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 10 Sep 2022 20:46:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQEys9sqSi7pQ5nXHjf=pNj0CB447Hz8CWuWaMVnqbV2w@mail.gmail.com>
Message-ID: <CAJF2gTQEys9sqSi7pQ5nXHjf=pNj0CB447Hz8CWuWaMVnqbV2w@mail.gmail.com>
Subject: Re: [PATCH V4 4/8] riscv: traps: Add noinstr to prevent
 instrumentation inserted
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 10, 2022 at 5:17 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Sep 8, 2022 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Sep 07, 2022 at 10:25:02PM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Without noinstr the compiler is free to insert instrumentation (think
> > > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> > > yet ready to run this early in the entry path, for instance it could
> > > rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> > >
> > > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/kernel/traps.c | 8 ++++----
> > >  arch/riscv/mm/fault.c     | 2 +-
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index 635e6ec26938..3ed3dbec250d 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -97,7 +97,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
> > >  #define __trap_section
> > >  #endif
> > >  #define DO_ERROR_INFO(name, signo, code, str)                                \
> > > -asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > > +asmlinkage __visible __trap_section void noinstr name(struct pt_regs *regs)  \
> >
> > But now you have __trap_section and noinstr both adding a section
> > attribute.
>
> Oops, thx for correcting. Here is my solution.
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 635e6ec26938..eba744caa711 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -92,9 +92,11 @@ static void do_trap_error(struct pt_regs *regs, int
> signo, int code,
>  }
>
>  #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> -#define __trap_section         __section(".xip.traps")
> +#define __trap_section                                                 \
> +       noinline notrace __attribute((__section__(".xip.traps")))       \
> +       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
How about let __section(".xip.traps") replace the __section__(".noinstr.text")?
+#define __trap_section noinstr __attribute(__section(".xip.traps"))

>  #else
> -#define __trap_section
> +#define __trap_section noinstr
>  #endif
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren
