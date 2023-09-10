Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555AD799D6F
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbjIJJRE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 05:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjIJJRE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 05:17:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC07C7;
        Sun, 10 Sep 2023 02:17:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FBEC433B8;
        Sun, 10 Sep 2023 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694337420;
        bh=+JBZQJzotIOYs9fXSQFX8sizkN6DRxWti0Yre7ZIJX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gZ59VqAjC/z+rERsUUL4+ZXtm+WO5006wx1jnl11U81wJuab+zgpyey/kgk108jCZ
         ipAxJeGoiPz/C5dJdmMRjPrJa+VYexYxrp/6JyFDM0amtAZnwWsL1AhX2mil0MLU8d
         +WuBvrpFpjb0K3B9lRIlf1hAAgkuCWl05ELy6sDAFwl3ZcSACpcOfCy7qMiExG3wYh
         kA9oJ0TpQWfD6fVj7uiutH4jNGTXV/VaBm8D+MmVCE/Y1DvskIMA6zTALIx4l4K6yv
         1J9dRSSLUWsCvEVSskInB2tB+7k4PkcBuys7gZx/D+rZvjcHCQJP28uDd7UbrTtbie
         o60TMOic52Jpg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-500c7796d8eso5695762e87.1;
        Sun, 10 Sep 2023 02:17:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YzoHHpzm6UCfTNIN/qhK1PWlo7yVdAA6MGay41kE/+tq+VM0chU
        YfKoFHCtNYxqFa46EnyiW5H5dbzz7KtmRd+Zkmg=
X-Google-Smtp-Source: AGHT+IFpF+LgwLC9jMuH3fyzLk6H5NxjEAwfEs9DH+cBxZFoOziKJXI+MVzuCCAr7xmvmidUJE/jFbRbHqFEIsgcywo=
X-Received: by 2002:a05:6512:456:b0:4fe:1681:9378 with SMTP id
 y22-20020a056512045600b004fe16819378mr4859204lfk.66.1694337418174; Sun, 10
 Sep 2023 02:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910-esteemed-exodus-706aaae940b1@spud>
In-Reply-To: <20230910-esteemed-exodus-706aaae940b1@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 10 Sep 2023 17:16:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
Message-ID: <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:
>
> > Changlog:
> > V11:
> >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
> >  - Remove abusing alternative framework and use jump_label instead.
>
> btw, I didn't say that using alternatives was the problem, it was
> abusing the errata framework to perform feature detection that I had
> a problem with. That's not changed in v11.
I've removed errata feature detection. The only related patches are:
 - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
 - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors

Which one is your concern? Could you reply on the exact patch thread? Thx.

>
> A stronger forward progress guarantee is not an erratum, AFAICT.
Sorry, there is no erratum of "stronger forward progress guarantee" in the =
V11.

>
> >  - Introduce prefetch.w to improve T-HEAD processors' LR/SC forward pro=
gress
> >    guarantee.
> >  - Optimize qspinlock xchg_tail when NR_CPUS >=3D 16K.



--
Best Regards
 Guo Ren
