Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BF5B4FF8
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIKQVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Sep 2022 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIKQVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2022 12:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43579220FE;
        Sun, 11 Sep 2022 09:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BC7460F3C;
        Sun, 11 Sep 2022 16:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D1BC433B5;
        Sun, 11 Sep 2022 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662913269;
        bh=cGfWdjsunVGfPSZnLvUn5+vhKZzaMGDo1120Cm21tzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJZM7TB1QZmLpOAIyyPwJcx8NRaqx5j+pAjfCr2xcwoE3+zV1aGr5/cE6kV6WqVR7
         0wAVfPHFVmmQGbgSjhbD9YEoHs1XPMlYbdzvjB+MUiWh3QMzuiAXfqGQ9J7LeKw1DW
         TVq1O8kp+Bic50n3bgVUlHhwK/klb0T0OGWMckWabjgqMSIOyyFh1r/9e6x4I9WEmC
         Jo0ge8oYF0f11+slT29Sd0CUc2G1i6QQJmoRs5T8Y9IwTH5YaMjTLVfrm45kvfp5be
         xiezNqH4HuB0gn95EKH7crldsJqvAMFBH8k1Akwo44F9fqheyF2AX5IgWGg4GSWssM
         QajM4oqxmC1fg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11e9a7135easo17337674fac.6;
        Sun, 11 Sep 2022 09:21:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo3RKP4HHPSA3qUFHA3ZsQe91SAuP58ZgIHPV3FmIJmubsGqX+M8
        XGlxLMy0M1HbGrW7+HAlAJYNowxmvbdVf47HYaU=
X-Google-Smtp-Source: AA6agR4WxSXlbU7Po+4Z/ivfavMWvRhtAeEpn4FFnOVslawINbxBs1npyJelq94Jp0sGwlqNn9hCLLS7FNwOfa+P5tA=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr2811184oao.112.1662913268609; Sun, 11
 Sep 2022 09:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-5-guoren@kernel.org>
 <Yxmaz7wJPEBQ7Vki@hirez.programming.kicks-ass.net> <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
 <Yx36JRG64DtuDrRz@hirez.programming.kicks-ass.net>
In-Reply-To: <Yx36JRG64DtuDrRz@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 12 Sep 2022 00:20:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRKJmn_+Otg4NMG0rGU6zziOgfcpsFwBcE=nEKb9s9jTg@mail.gmail.com>
Message-ID: <CAJF2gTRKJmn_+Otg4NMG0rGU6zziOgfcpsFwBcE=nEKb9s9jTg@mail.gmail.com>
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

On Sun, Sep 11, 2022 at 11:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Sep 10, 2022 at 05:17:44PM +0800, Guo Ren wrote:
>
> > > > -asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > > > +asmlinkage __visible __trap_section void noinstr name(struct pt_regs *regs)  \
> > >
> > > But now you have __trap_section and noinstr both adding a section
> > > attribute.
> >
> > Oops, thx for correcting. Here is my solution.
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 635e6ec26938..eba744caa711 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -92,9 +92,11 @@ static void do_trap_error(struct pt_regs *regs, int
> > signo, int code,
> >  }
> >
> >  #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> > -#define __trap_section         __section(".xip.traps")
> > +#define __trap_section                                                 \
> > +       noinline notrace __attribute((__section__(".xip.traps")))       \
> > +       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> >  #else
> > -#define __trap_section
> > +#define __trap_section noinstr
> >  #endif
>
> This is almost guaranteed to get out of sync when the compiler guys add
> yet another sanitizier. Please consider picking up this patch:
>
>   https://lore.kernel.org/all/20211110115736.3776-7-jiangshanlai@gmail.com/
Thx, that is what I want.

>
> and using __noinstr_section(".xip.traps")



-- 
Best Regards
 Guo Ren
