Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F35B45A7
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIJJT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 05:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIJJTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 05:19:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F02ED7D;
        Sat, 10 Sep 2022 02:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EB50B80066;
        Sat, 10 Sep 2022 09:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BEAC4314C;
        Sat, 10 Sep 2022 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662801478;
        bh=HGThmz2kdpZLbH5ZdT+4zlH5sl6WAOA/3pwhDNqZIbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGxQpxA+0rDEwqf0D/VjU10YH9+YYMHHE6WcmIJq2Zxsuv1mdsZRvqbeW8OItWT0V
         KTmRTHD2+fYKqsQywCxS3tNFR4lTfKjhxL6ONCPaS10dcyYbr4fKkGZ4krg0SspcWR
         fOqfyCTeI1Gszwkq0zC+z0xIjNNonmPYYaSX1/mwIJzik6Xigw7Ly4IdR+tHTT5QgP
         nF5LmV4f66OevPkMO/apJuiCWMB8TmOf2KJaK7CJArBSdu+9xp5YCrKboQXfD/ER32
         sjHISJzFejSXXWreoy3Hme9dw2l47q1Cl7QIwY63OBv/+zN+1Is7fcyq0Y2pnc79Kk
         RWBcBBRjRVV0A==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278624b7c4so10170851fac.5;
        Sat, 10 Sep 2022 02:17:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo3+++2hyKWt5wgvTsUAfSXkgapR92xpP0kBddxR2/QGG4zeOsbc
        e0Fsj1UDQZLR1OhXZFNcBZfqqsy8TapDaF/yWXI=
X-Google-Smtp-Source: AA6agR5ljS5jux9vYvs3d5lajECfg2pY1US7JHgjNigOsBR2XljS39jtvb510F8+GsznBLG/AVBR45wNgnWOxIuJZeU=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr135196oao.112.1662801476887; Sat, 10
 Sep 2022 02:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-5-guoren@kernel.org>
 <Yxmaz7wJPEBQ7Vki@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxmaz7wJPEBQ7Vki@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 10 Sep 2022 17:17:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
Message-ID: <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
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

On Thu, Sep 8, 2022 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 07, 2022 at 10:25:02PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Without noinstr the compiler is free to insert instrumentation (think
> > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> > yet ready to run this early in the entry path, for instance it could
> > rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> >
> > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/traps.c | 8 ++++----
> >  arch/riscv/mm/fault.c     | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 635e6ec26938..3ed3dbec250d 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -97,7 +97,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
> >  #define __trap_section
> >  #endif
> >  #define DO_ERROR_INFO(name, signo, code, str)                                \
> > -asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > +asmlinkage __visible __trap_section void noinstr name(struct pt_regs *regs)  \
>
> But now you have __trap_section and noinstr both adding a section
> attribute.

Oops, thx for correcting. Here is my solution.

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 635e6ec26938..eba744caa711 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -92,9 +92,11 @@ static void do_trap_error(struct pt_regs *regs, int
signo, int code,
 }

 #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
-#define __trap_section         __section(".xip.traps")
+#define __trap_section                                                 \
+       noinline notrace __attribute((__section__(".xip.traps")))       \
+       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
 #else
-#define __trap_section
+#define __trap_section noinstr
 #endif


-- 
Best Regards
 Guo Ren
