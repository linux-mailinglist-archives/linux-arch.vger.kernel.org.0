Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAE70A464
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 03:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjETBn4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 21:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjETBn4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 21:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADDE116;
        Fri, 19 May 2023 18:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9550161CAB;
        Sat, 20 May 2023 01:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07925C4339B;
        Sat, 20 May 2023 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684547034;
        bh=/MFAlDt0wtJT6ilnMT0hH/mEXV8rXc92ftjgCpnLA3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h2zoj4WIIqf1y3gDpPN1FD5eTvZAhQ2NxcOcF1MU4+K6WRIwYZbzgs+1AdWY9SMkt
         wmEihANFP8MzHHECEX5XQbs+m0HfAOKNAJcTjzlf58vC1TLsrwiF8R9Whtv74tKgXo
         CShtNmh9yiGjbQ50e8vbMGMSuHGvLub5YQj4tIiCJQqg3g7pJ9KAtSg0CBFoXMJnbk
         2JY8odcEr+nWrPXZJx8o4WfGqdOWLJ08lxRtiBj6KH+uVOlkggPTR4CR97VX/NWxBX
         7kZNkLOY0+ms0YM0a9r1II1vyBiBjN7OK/BxBSDo7ecYiRPp39UOsDf7XZFiCI52Fw
         YtkjHSYN4Y9FA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso187584466b.0;
        Fri, 19 May 2023 18:43:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDwgpcOkBHfqDO/SkoAQy6h0KInJZ4uq6plmJVyEEAxOhsnyuDmZ
        nQldLNPX+4DdAOD7daCetu3MouH5h4A7pN2HKrQ=
X-Google-Smtp-Source: ACHHUZ7NXAqlZZPtIfnAbts8fbQ84+TJlZoNY4/JP72g+NSV4DhtWHHrkOiBofCFGBDO+RuN07qx8nKyurA8K30+ZxE=
X-Received: by 2002:a17:906:a143:b0:960:f1a6:6a12 with SMTP id
 bu3-20020a170906a14300b00960f1a66a12mr3138956ejb.55.1684547032269; Fri, 19
 May 2023 18:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
 <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com> <CAJF2gTRO8Qcz2EXz-ZAczpTj=Lm=GPO-UQMPqCRdqrfjg8sXbA@mail.gmail.com>
 <a9fcf1ad-a387-42a7-957a-e5a6a36fb3d7@app.fastmail.com>
In-Reply-To: <a9fcf1ad-a387-42a7-957a-e5a6a36fb3d7@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 20 May 2023 09:43:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRCW7h+PXz4JnNJVQ4cEEnNkcMfy8BUgGXuPZXJV6Q+Tg@mail.gmail.com>
Message-ID: <CAJF2gTRCW7h+PXz4JnNJVQ4cEEnNkcMfy8BUgGXuPZXJV6Q+Tg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on
 64-bit supervisor mode
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Anup Patel <anup@brainfault.org>, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        Andy Chiu <andy.chiu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, wuwei2016@iscas.ac.cn,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 20, 2023 at 12:54=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, May 19, 2023, at 17:31, Guo Ren wrote:
> > On Fri, May 19, 2023 at 2:29=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Thu, May 18, 2023, at 17:38, Palmer Dabbelt wrote:
> >> > On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
> >>
> >> If for some crazy reason you'd still want the 64ilp32 ABI in user
> >> space, running the kernel this way is probably still a bad idea,
> >> but that one is less clear. There is clearly a small memory
> >> penalty of running a 64-bit kernel for larger data structures
> >> (page, inode, task_struct, ...) and vmlinux, and there is no
> > I don't think it's a small memory penalty, our measurement is about
> > 16% with defconfig, see "Why 32-bit Linux?" section.
> >
> > This patch series doesn't add 64ilp32 userspace abi, but it seems you
> > also don't like to run 32-bit Linux kernel on 64-bit hardware, right?
>
> Ok, I'm sorry for missing the important bit here. So if this can
> still use the normal 32-bit user space, the cost of this patch set
> is not huge, and it's something that can be beneficial in a few
> cases, though I suspect most users are still better off running
> 64-bit kernels.
>
> > The motivation of s64ilp32 (running 32-bit Linux kernel on 64-bit s-mod=
e):
> >  - The target hardware (Canaan Kendryte k230) only supports MXL=3D64,
> > SXL=3D64, UXL=3D64/32.
> >  - The 64-bit Linux + compat 32-bit app can't satisfy the 64/128MB scen=
arios.
> >
> >> huge additional maintenance cost on top of the ABI itself
> >> that you'd need either way, but using a 64-bit address space
> >> in the kernel has some important advantages even when running
> >> 32-bit userland: processes can use the entire 4GB virtual
> >> space, while the kernel can address more than 768MB of lowmem,
> >> and KASLR has more bits to work with for randomization. On
> >> RISCV, some additional features (VMAP_STACK, KASAN, KFENCE,
> >> ...) depend on 64-bit kernels even though they don't
> >> strictly need that.
> >
> > I agree that the 64-bit linux kernel has more functionalities, but:
> >  - What do you think about linux on a 64/128MB SoC? Could it be
> > affordable to VMAP_STACK, KASAN, KFENCE?
>
> I would definitely recommend VMAP_STACK, but that can be implemented
> and is used on other 32-bit architectures (ppc32, arm32) without a
> huge cost. The larger virtual user address space can help even on
> machines with 128MB, though most applications probably don't care at
> that point.
Good point, I would support VMAP_STACK in ARCH_RV64ILP32.


>
> >  - I think 32-bit Linux & RTOS have monopolized this market (64/128MB
> > scenarios), right?
>
> The minimum amount of RAM that makes a system usable for Linux is
> constantly going up, so I think with 64MB, most new projects are
> already better off running some RTOS kernel instead of Linux.
> The ones that are still usable today probably won't last a lot
> of distro upgrades before the bloat catches up with them, but I
> can see how your patch set can give them a few extra years of
> updates.
Linux development costs much cheaper than RTOS, so the vendors would
first develop a Linux version. If it succeeds in the market, the
vendors will create a cost-down solution. So their first choice is to
cut down the memory footprint of the first Linux version instead of
moving to RTOS.

With the price of 128MB-DDR3 & 64MB-DDR2 being more and more similar,
32bit-Linux has more opportunities to instead of RTOS.

>
> For the 256MB+ systems, I would expect the sensitive kernel
> allocations to be small enough that the series makes little
> difference. The 128MB systems are the most interesting ones
> here, and I'm curious to see where you spot most of the
> memory usage differences, I'll also reply to your initial
> mail for that.
Thx, I aslo recommand you read about "Why s64ilp32 has better
performance?" section :)
How do you think running arm32-Linux on coretex-A35/A53/A55?

>
>        Arnd



--=20
Best Regards
 Guo Ren
