Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94A709B5D
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjESPbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjESPbW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 11:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74165106;
        Fri, 19 May 2023 08:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113E0658BA;
        Fri, 19 May 2023 15:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E50C43446;
        Fri, 19 May 2023 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684510280;
        bh=LutjUTbti1HeouoWBzB8ND73lnDjx3NcWfIcsLJYYmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AMOrYWyg6OaQgH8gau7KnuU4B6CV3WiREPoOkTofba8Ayky0BGRYjhyYI5+LPgZCW
         /DgDUYjjMBpUb6Cwvq7Zy/cxeTkGoqqSf4h1ZjSukKkeXgA/PeioMuH0QjQruIy0rx
         7tgoV8VvhgDD7TtuIyYXpJc2nq31k5JaFjBitZE5JZkN1Ib284TjJOzHJ8SYPIYwzE
         M6awRaz4TZ9wlqW+Pr0G/LYSHJ6QYVnsBqCSbspjFq7fesfynNVv8A03szXsDrwvLH
         FulyfmvZMoetpAh9/pSJrcck6HxdTI39sqToiibJ7SizImJ4ojCQ72NtkZc2OqmiuJ
         /cHfqjzhIxebg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-510e90d785fso2887136a12.2;
        Fri, 19 May 2023 08:31:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDzzcCcO5VCly1NwTmdmShEbjhpKEyDalP/Ig1LAIyZZsntQUd1h
        aQw0GBIhxHWXkot8Oam6Q62B/tSiT/YYmUcdDes=
X-Google-Smtp-Source: ACHHUZ6F1jwrc+hZPGVqYVC1J42+KZlyJm5HnfvuwPB72oAO64/VLWKkZr5Pm+u+bUmC5e6fQM9QCiYbzPCxU4SEr7c=
X-Received: by 2002:a05:6402:1217:b0:50b:faa1:e1d5 with SMTP id
 c23-20020a056402121700b0050bfaa1e1d5mr1842334edw.39.1684510278533; Fri, 19
 May 2023 08:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9> <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
In-Reply-To: <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 19 May 2023 23:31:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRO8Qcz2EXz-ZAczpTj=Lm=GPO-UQMPqCRdqrfjg8sXbA@mail.gmail.com>
Message-ID: <CAJF2gTRO8Qcz2EXz-ZAczpTj=Lm=GPO-UQMPqCRdqrfjg8sXbA@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023 at 2:29=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, May 18, 2023, at 17:38, Palmer Dabbelt wrote:
> > On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> This patch series adds s64ilp32 support to riscv. The term s64ilp32
> >> means smode-xlen=3D64 and -mabi=3Dilp32 (ints, longs, and pointers are=
 all
> >> 32-bit), i.e., running 32-bit Linux kernel on pure 64-bit supervisor
> >> mode. There have been many 64ilp32 abis existing, such as mips-n32 [1]=
,
> >> arm-aarch64ilp32 [2], and x86-x32 [3], but they are all about userspac=
e.
> >> Thus, this should be the first time running a 32-bit Linux kernel with
> >> the 64ilp32 ABI at supervisor mode (If not, correct me).
> >
> > Does anyone actually want this?  At a bare minimum we'd need to add it
> > to the psABI, which would presumably also be required on the compiler
> > side of things.
> >
> > It's not even clear anyone wants rv64/ilp32 in userspace, the kernel
> > seems like it'd be even less widely used.
>
> We have had long discussions about supporting ilp32 userspace on
> arm64, and I think almost everyone is glad we never merged it into
> the mainline kernel, so we don't have to worry about supporting it
> in the future. The cost of supporting an extra user space ABI
> is huge, and I'm sure you don't want to go there. The other two
> cited examples (mips-n32 and x86-x32) are pretty much unused now
> as well, but still have a maintenance burden until they can finally
> get removed.
>
> If for some crazy reason you'd still want the 64ilp32 ABI in user
> space, running the kernel this way is probably still a bad idea,
> but that one is less clear. There is clearly a small memory
> penalty of running a 64-bit kernel for larger data structures
> (page, inode, task_struct, ...) and vmlinux, and there is no
I don't think it's a small memory penalty, our measurement is about
16% with defconfig, see "Why 32-bit Linux?" section.
This patch series doesn't add 64ilp32 userspace abi, but it seems you
also don't like to run 32-bit Linux kernel on 64-bit hardware, right?

The motivation of s64ilp32 (running 32-bit Linux kernel on 64-bit s-mode):
 - The target hardware (Canaan Kendryte k230) only supports MXL=3D64,
SXL=3D64, UXL=3D64/32.
 - The 64-bit Linux + compat 32-bit app can't satisfy the 64/128MB scenario=
s.

> huge additional maintenance cost on top of the ABI itself
> that you'd need either way, but using a 64-bit address space
> in the kernel has some important advantages even when running
> 32-bit userland: processes can use the entire 4GB virtual
> space, while the kernel can address more than 768MB of lowmem,
> and KASLR has more bits to work with for randomization. On
> RISCV, some additional features (VMAP_STACK, KASAN, KFENCE,
> ...) depend on 64-bit kernels even though they don't
> strictly need that.

I agree that the 64-bit linux kernel has more functionalities, but:
 - What do you think about linux on a 64/128MB SoC? Could it be
affordable to VMAP_STACK, KASAN, KFENCE?
 - I think 32-bit Linux & RTOS have monopolized this market (64/128MB
scenarios), right?

>
>      Arnd



--=20
Best Regards
 Guo Ren
