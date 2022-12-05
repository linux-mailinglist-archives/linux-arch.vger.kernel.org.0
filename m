Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D1642586
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLEJOE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLEJNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 04:13:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F72197;
        Mon,  5 Dec 2022 01:13:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFDF60FDE;
        Mon,  5 Dec 2022 09:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA70AC433C1;
        Mon,  5 Dec 2022 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670231615;
        bh=ggVmgdZ2s5j3TLZVKMkeQhvmxbiWFWAWsgD6rDz4n+k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ph7ywJxoRhu/Dl+2LXiBI2gfN9ERiT4GpoHROYh3cBmY/Au4Jcr/7jmmrNPfRgBh2
         m7bqOGHrvLxqPGzENsDIm9yLa5TC5A1d2vdDKcvhY4zbc1xhkJ8HAA4p2TD1K9GgFN
         5IVLwmlKBDU9XBdpha/8ggXIyKNNCZiiAyySNirq6+AOn4Ye5pjF+oUfuUFOjfmFb5
         NO+HFIFbpWUnlMj2sTGbB3NQOSHcNSJplGqFD6QHfpcDxi+3y+TPPZfljc672vZa/s
         ynH0pEJ4Zv2GSzfLCOP+xarY+tt64hylG6gdn1hPbED71SwugZTN6I5ds6p7WgewPw
         1WTt+6a2ov0Eg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -next V8 03/14] riscv: compat_syscall_table: Fixup
 compile warning
In-Reply-To: <20221103075047.1634923-4-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <20221103075047.1634923-4-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 10:13:32 +0100
Message-ID: <87h6ya9ps3.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> ../arch/riscv/kernel/compat_syscall_table.c:12:41: warning: initialized
> field overwritten [-Woverride-init]
>    12 | #define __SYSCALL(nr, call)      [nr] = (call),
>       |                                         ^
> ../include/uapi/asm-generic/unistd.h:567:1: note: in expansion of macro
> '__SYSCALL'
>   567 | __SYSCALL(__NR_semget, sys_semget)
>
> Fixes: 59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/riscv/kernel/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index db6e4b1294ba..ab333cb792fd 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -9,6 +9,7 @@ CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
>  endif
>  CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
> +CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
>  
>  ifdef CONFIG_KEXEC
>  AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)

Like patch 2, this is just a generic fix! Please have this as a separate
patch, and not part of the series.
