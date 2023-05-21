Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95F70AE19
	for <lists+linux-arch@lfdr.de>; Sun, 21 May 2023 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjEUMiK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 May 2023 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjEUMiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 May 2023 08:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359DC2;
        Sun, 21 May 2023 05:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7267D60F4F;
        Sun, 21 May 2023 12:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA3C433AC;
        Sun, 21 May 2023 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684672687;
        bh=F/yfHoeQVFg/Iszqcubt0GmafBS2VeuM5J2EsdRkorE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GsRudyw5Le/vW1MxI7Egj44IrRtSsL2qcnDSjrbRH9Jjk5Ftslq5CeBx+YTYNOVnp
         zPI4QxGvX6UmdJ2hQXABKjZ/TnJI6Gu1nAdoE/ygYblhEol7yjGpfurUT+q/FbrHCX
         c6Qpz14ATiApAPJEd846Ff6EFttbhO2GRnsJB3FjQSvchIdGYoOQJSyLiShVsUkTky
         TT8cxlNuYWxw551hKixFJcTsmMKRBal2jwmyxan9z5XLR2zSSVRCUz3wnPUqfzbRVu
         66vc1GoxLlK1smyqnhQh5h2wqoKUz8HUL8RSlY5DmMg/uUSnpNutUHzxCbHl9PEYdH
         2I9XSGQzykHVQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510db954476so6656329a12.0;
        Sun, 21 May 2023 05:38:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDxNp/q4HH0i2I8pIPMDVnjUZBPNTHaj4Wp8pb3vIdD3i20k7V2u
        p+nMeeFJDd6cVXMV+9aJHVU3jl68qS97yL7XjEc=
X-Google-Smtp-Source: ACHHUZ7xwFr0B8U2E4m75ywW4UFqxLS+S/YsLcMBNyTGaV28JA5fJc72cb9PwN0LTziFkSud8N29VLDJmUmJXac2joo=
X-Received: by 2002:a05:6402:1210:b0:510:5d6d:552e with SMTP id
 c16-20020a056402121000b005105d6d552emr5870163edw.40.1684672685946; Sun, 21
 May 2023 05:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9> <668be661-728d-b87f-b827-4345ad07cc61@sifive.com>
In-Reply-To: <668be661-728d-b87f-b827-4345ad07cc61@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 21 May 2023 20:37:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTnbeuFMEQewN=AG5BPiP_V6dfwwFqd18HVtOrnS23bqQ@mail.gmail.com>
Message-ID: <CAJF2gTTnbeuFMEQewN=AG5BPiP_V6dfwwFqd18HVtOrnS23bqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on
 64-bit supervisor mode
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        jszhang@kernel.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, Mark Rutland <mark.rutland@arm.com>,
        bjorn@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, rppt@kernel.org,
        anup@brainfault.org, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn, chunyu@iscas.ac.cn,
        tsu.yubo@gmail.com, wefu@redhat.com, wangjunqiang@iscas.ac.cn,
        kito.cheng@sifive.com, andy.chiu@sifive.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com, corbet@lwn.net,
        wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023 at 8:14=E2=80=AFAM Paul Walmsley <paul.walmsley@sifive=
.com> wrote:
>
> On Thu, 18 May 2023, Palmer Dabbelt wrote:
>
> > On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
> >
> > > This patch series adds s64ilp32 support to riscv. The term s64ilp32
> > > means smode-xlen=3D64 and -mabi=3Dilp32 (ints, longs, and pointers ar=
e all
> > > 32-bit), i.e., running 32-bit Linux kernel on pure 64-bit supervisor
> > > mode. There have been many 64ilp32 abis existing, such as mips-n32 [1=
],
> > > arm-aarch64ilp32 [2], and x86-x32 [3], but they are all about userspa=
ce.
> > > Thus, this should be the first time running a 32-bit Linux kernel wit=
h
> > > the 64ilp32 ABI at supervisor mode (If not, correct me).
> >
> > Does anyone actually want this?  At a bare minimum we'd need to add it =
to the
> > psABI, which would presumably also be required on the compiler side of =
things.
> >
> > It's not even clear anyone wants rv64/ilp32 in userspace, the kernel se=
ems
> > like it'd be even less widely used.
>
> We've certainly talked to folks who are interested in RV64 ILP32 userspac=
e
> with an LP64 kernel.  The motivation is the usual one: to reduce data siz=
e
> and therefore (ideally) BOM cost.  I think this work, if it goes forward,
> would need to go hand in hand with the RVIA psABI group.
>
> The RV64 ILP32 kernel and ILP32 userspace approach implemented by this
> patch is intriguing, but I guess for me, the question is whether it's
> worth the extra hassle vs. a pure RV32 kernel & userspace.
Running pure RV32 kernel on 64-bit hardware is not an intelligent
choice (such as cortex-a35/a53/a55), because they wasted 64-bit hw
capabilities, and the hardware designer would waste additional
resources & time on 32-bit machine & supervisor modes (In arm it is
called EL3/EL2/EL1 modes). Think about too many PMP CSRs, PMU CSRs,
and mode switch ... it's definitely wrong to follow the
cortex-a35/a53/a55 way to deal with riscv32 on a 64-bit hardware. The
chapter "Why s64ilp32 has better performance?" give out the
improvement v.s. pure 32-bit, I repeat it here:

 - memcpy/memset/strcmp (s64ilp32 has half of the number of
instructions and double the bandwidth per load/store instruction than
s32ilp32.)

- ebpf JIT is a 64-bit virtual ISA, which couldn't be sufficient
mapping by s32ilp32, but s64ilp32 could (just like s64lp64).

 - Atomic64 (s64ilp32 has the exact native instructions mapping as
s64lp64, but s32ilp32 only uses generic_atomic64, a tradeoff & limited
software solution.)

 - 64-bit native arithmetic instructions for "long long" type

 - riscv s64ilp32 could support cmxchg_double for slub (The 2nd 32-bit
Linux supports the feature, the 1st is i386.)

>
>
> - Paul



--=20
Best Regards
 Guo Ren
