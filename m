Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C54D709DB6
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjESRSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjESRSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 13:18:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF111103
        for <linux-arch@vger.kernel.org>; Fri, 19 May 2023 10:18:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so26374135ad.0
        for <linux-arch@vger.kernel.org>; Fri, 19 May 2023 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684516730; x=1687108730;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cP/N2yy0In7+4hR77Af8fl+Cq9omuuz9NP4NSMstSE=;
        b=oJTQ1xH2esTZ6dC0S08xSuynOquMOIpWw1CET3mwKZJZ8qSJiu/xdMNUmu1Ll9fuEI
         agp84ATECKi0z/b6nnuCgXbY5J2tqimno5Gh/r3t+myryOlD62xe7Lss9IhEofCPYGbo
         IiUiugJsTiCYcKfPh97SVrDkxOen0BTWvk7idHnbSRBMnpt9mRJzgnzWl2wDz7lBvpgX
         MmxRhTbbAfSXRp4Z5BlCiHkgqY9/UCJ/pBjZZ3U+HfI4dqSuluRYnrUwBzMKNx2xfnUb
         9dTB/SeJAQqLg9vyLIc77IRzb5dBFrUQxS18GPNeIeNSmi69qCL/jgaLRJpromRjbqLN
         eK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516730; x=1687108730;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cP/N2yy0In7+4hR77Af8fl+Cq9omuuz9NP4NSMstSE=;
        b=NXVOhAkmtkfNTHWfhGIFc8P1ki2zlH97jme+RR/ojDzeDzq6inPESB4psmcsuIDFtU
         HlxqMy1RhM0keGG0h4iu639AX7FcuV1nieqAtqx5wUUsupI3KWstIhqkhGL6WvzPJnYR
         lm4bAz2ARff5eL6Uekp7G0BSRwWC3zzS6H3o8e2m9oD8O20kchPQbhScmfhMtJ0dlzrA
         vc3iC0EFh41LwVRtPn4XPhqwt1O9llq7JSWqVrHa5AwsZdPZPGGTsokA3QowbgiimgRE
         f3CRqCYMuI6I3DSWzMoL8tm4nByhpMdrfD3G7MxSkvx0rxdFIvJ5fflPSKzTs6XOzDI3
         e3Vg==
X-Gm-Message-State: AC+VfDxZDqIj+95Atmmn7kbq3DpOXo3k2cHNsEEvIuuYo6P8BHeDqkTx
        RmcU8NSFCFbi+v0suHolgeVEPg==
X-Google-Smtp-Source: ACHHUZ6sQqE4NgE4qAtzws4MDh/hCDsJ1+5Bk0BQ/KXNoITPF6sDFxlqLTzrK+z/++9G9i9iakUrMA==
X-Received: by 2002:a17:902:cecb:b0:1ae:8b4b:3273 with SMTP id d11-20020a170902cecb00b001ae8b4b3273mr1666308plg.23.1684516730147;
        Fri, 19 May 2023 10:18:50 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b001aae64e9b36sm3694651plf.114.2023.05.19.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:18:49 -0700 (PDT)
Date:   Fri, 19 May 2023 10:18:49 -0700 (PDT)
X-Google-Original-Date: Fri, 19 May 2023 10:18:25 PDT (-0700)
Subject:     Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on 64-bit supervisor mode
In-Reply-To: <a9fcf1ad-a387-42a7-957a-e5a6a36fb3d7@app.fastmail.com>
CC:     guoren@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        heiko@sntech.de, jszhang@kernel.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        Mark Rutland <mark.rutland@arm.com>, bjorn@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, rppt@kernel.org,
        anup@brainfault.org, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn, chunyu@iscas.ac.cn,
        tsu.yubo@gmail.com, wefu@redhat.com, wangjunqiang@iscas.ac.cn,
        kito.cheng@sifive.com, andy.chiu@sifive.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com, corbet@lwn.net,
        wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-073cb75e-0f8d-40b7-9e1c-8cfad53351df@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 19 May 2023 09:53:35 PDT (-0700), Arnd Bergmann wrote:
> On Fri, May 19, 2023, at 17:31, Guo Ren wrote:
>> On Fri, May 19, 2023 at 2:29 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, May 18, 2023, at 17:38, Palmer Dabbelt wrote:
>>> > On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
>>>
>>> If for some crazy reason you'd still want the 64ilp32 ABI in user
>>> space, running the kernel this way is probably still a bad idea,
>>> but that one is less clear. There is clearly a small memory
>>> penalty of running a 64-bit kernel for larger data structures
>>> (page, inode, task_struct, ...) and vmlinux, and there is no
>> I don't think it's a small memory penalty, our measurement is about
>> 16% with defconfig, see "Why 32-bit Linux?" section.
>>
>> This patch series doesn't add 64ilp32 userspace abi, but it seems you
>> also don't like to run 32-bit Linux kernel on 64-bit hardware, right?
>
> Ok, I'm sorry for missing the important bit here. So if this can
> still use the normal 32-bit user space, the cost of this patch set
> is not huge, and it's something that can be beneficial in a few
> cases, though I suspect most users are still better off running
> 64-bit kernels.

Running a normal 32-bit userspace would require HW support for the 
32-bit mode switch for userspace, though (rv32 isn't a subset of rv64, 
so there's nothing we can do to make those binaries function correctly 
with uABI).  The userspace-only mode switch is a bit simpler than the 
user+supervisor switch, but it seems like vendors who really want the 
memory savings would just implement both mode switches.

>> The motivation of s64ilp32 (running 32-bit Linux kernel on 64-bit s-mode):
>>  - The target hardware (Canaan Kendryte k230) only supports MXL=64,
>> SXL=64, UXL=64/32.
>>  - The 64-bit Linux + compat 32-bit app can't satisfy the 64/128MB scenarios.
>>
>>> huge additional maintenance cost on top of the ABI itself
>>> that you'd need either way, but using a 64-bit address space
>>> in the kernel has some important advantages even when running
>>> 32-bit userland: processes can use the entire 4GB virtual
>>> space, while the kernel can address more than 768MB of lowmem,
>>> and KASLR has more bits to work with for randomization. On
>>> RISCV, some additional features (VMAP_STACK, KASAN, KFENCE,
>>> ...) depend on 64-bit kernels even though they don't
>>> strictly need that.
>>
>> I agree that the 64-bit linux kernel has more functionalities, but:
>>  - What do you think about linux on a 64/128MB SoC? Could it be
>> affordable to VMAP_STACK, KASAN, KFENCE?
>
> I would definitely recommend VMAP_STACK, but that can be implemented
> and is used on other 32-bit architectures (ppc32, arm32) without a
> huge cost. The larger virtual user address space can help even on
> machines with 128MB, though most applications probably don't care at
> that point.

At least having them as an option seems reasonable.  Historically we 
haven't gated new base systems on having every feature the others do, 
though (!MMU, rv32, etc).

>>  - I think 32-bit Linux & RTOS have monopolized this market (64/128MB
>> scenarios), right?
>
> The minimum amount of RAM that makes a system usable for Linux is
> constantly going up, so I think with 64MB, most new projects are
> already better off running some RTOS kernel instead of Linux.
> The ones that are still usable today probably won't last a lot
> of distro upgrades before the bloat catches up with them, but I
> can see how your patch set can give them a few extra years of
> updates.

We also have 32-bit kernel support.  Systems that have tens of MB of RAM 
tend to end up with some memory technology that doesn't scale to 
gigabytes these days, and since that's fixed when the chip is built it 
seems like those folks would be better off just having HW support for 
32-bit kernels (and maybe not even bothering with HW support for 64-bit 
kernels).

> For the 256MB+ systems, I would expect the sensitive kernel
> allocations to be small enough that the series makes little
> difference. The 128MB systems are the most interesting ones
> here, and I'm curious to see where you spot most of the
> memory usage differences, I'll also reply to your initial
> mail for that.

Thanks.  I agree we need to see some real systems that benefit from 
this, as it's a pretty big support cost.  Just defconfig sizes doesn't 
mean a whole lot, as users on these very constrained systems aren't 
likely to run defconfig anyway.

If someone's going to use it then I'm fine taking the code, it just 
seems like a very thin set of possible use cases.  We've already got 
almost no users in RISC-V land, I've got a feeling this is esoteric 
enough to actually have zero.

>
>        Arnd
