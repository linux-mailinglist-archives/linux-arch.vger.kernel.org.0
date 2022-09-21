Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F935BF620
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 08:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIUGNs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 02:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIUGNr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 02:13:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B397F111;
        Tue, 20 Sep 2022 23:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF046B82DFC;
        Wed, 21 Sep 2022 06:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D966C43149;
        Wed, 21 Sep 2022 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663740824;
        bh=w3qEuPEMK42CM+j8IWHYWqhiE1xDCn4992EpvD8JZYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g3rOtcdSxXPlKYNEoxqrdKk6KuhJTBTPnK45f9q9UUSwra/VhAMykg42NI1mKaSvJ
         8RAe60HX5+L/oX8wxsc8QTT3U8Vsvz06WXJVyp/Im1bVVuEsYR3ayPqCKsGdCGBpP2
         6zEMih1oX7JdT9tyu587G8m3NSTT4IEE0EsauJudHlOQbv4i6+hqB1LHqG4FP4qZb3
         dV5y/nDh4xfGp3PLYijEDHbYrQPhioKBeTJUQ6G60qTAYQyy6cSR2l9pi/EsKC+N6I
         aG/XRDfALXrjwXTQGY7HH3tt0hgp6b90PaqFBF90DGcRqS8OZflbBmSR+sjON785Eq
         RDNRN+TyqJsNw==
Received: by mail-oi1-f175.google.com with SMTP id m81so6795810oia.1;
        Tue, 20 Sep 2022 23:13:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf31kfaXVuqXpTqwwTm/sBs4BzPSQPCNs+J1QxeZ3EM3eW67dRuV
        vKP413/SMXibklekXOGOdNTUChmJZt/GsVBLZi8=
X-Google-Smtp-Source: AMsMyM5q2IJn/8Vtp+x/+Cdu+aYFrFtl/v1b04akIxkpyjyvBd8H1TM4s7Rvi1PoBc+lSa31XLS6/X4u2yjvlCRUdvc=
X-Received: by 2002:a05:6808:201f:b0:34f:9fdf:dbbf with SMTP id
 q31-20020a056808201f00b0034f9fdfdbbfmr3112979oiw.19.1663740823509; Tue, 20
 Sep 2022 23:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com> <7a2379cf-c1cf-46af-9172-334d2b9b88d5@www.fastmail.com>
In-Reply-To: <7a2379cf-c1cf-46af-9172-334d2b9b88d5@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 14:13:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSvaNh_m_hrub5Z=kqLAYJfRbpYzB1Mc5aOgdN+Bm8bag@mail.gmail.com>
Message-ID: <CAJF2gTSvaNh_m_hrub5Z=kqLAYJfRbpYzB1Mc5aOgdN+Bm8bag@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 20, 2022 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 20, 2022, at 2:46 AM, Guo Ren wrote:
>
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index dfe600f3526c..8def456f328c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -442,6 +442,16 @@ config IRQ_STACKS
> >           Add independent irq & softirq stacks for percpu to prevent
> > kernel stack
> >           overflows. We may save some memory footprint by disabling IRQ_STACKS.
> >
> > +config THREAD_SIZE
> > +       int "Kernel stack size (in bytes)" if EXPERT
> > +       range 4096 65536
> > +       default 8192 if 32BIT && !KASAN
> > +       default 32768 if 64BIT && KASAN
> > +       default 16384
> > +       help
> > +         Specify the Pages of thread stack size (from 4KB to 64KB), which also
> > +         affects irq stack size, which is equal to thread stack size.
>
> I still think this should be guarded in a way that prevents
> setting the stack to smaller than default values unless VMAP_STACK
> is set as well.
Current VMAP_STACK would double THREAD_SIZE. Let me see how to reduce
the VMAP_STACK.

>
>     Arnd



-- 
Best Regards
 Guo Ren
