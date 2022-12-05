Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8B6426EF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 11:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLEKtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 05:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 05:49:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1E12AEC;
        Mon,  5 Dec 2022 02:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA23B80E9B;
        Mon,  5 Dec 2022 10:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BCCC433D6;
        Mon,  5 Dec 2022 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670237353;
        bh=TM/r0k5u2Pt27z45OlKDLTYpA4Gk6ZH5Ef+T3t89ykk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ti/4YSEDFaEqaGcI7l/+n+Qk5FdH8M8W/Jj6RMEljTcdEmrrWR98uFpjDzg0Xcu1U
         BW5UgAChKM6rXv1Quq6kw/hbl+y5f4GF1D9h63WlOeMtiavJFNeBEJJYiLGH5RGokn
         uzEcYDaVp/Z6xFP7BDs7MyTwZmuSrhyoKZ0Fn0JnRMeAo8XiKzFRPuWAiGSJF+RuUC
         NH4ddmq1MdWbIbGwQHH6nLB0ZF6O3QN0nk/HUaZn0Pa4691idOiWwAUIzGYUnHnLvc
         u3B94j9Bb7mOIVZQ6MtdNfy3kxOPkEDH8QrbAi/CAXeTEFC82GrYasvC2QgdOIym6H
         ngMl6Uk0GYpbA==
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
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V8 06/14] riscv: convert to generic entry
In-Reply-To: <20221103075047.1634923-7-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <20221103075047.1634923-7-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 11:49:10 +0100
Message-ID: <874jua9lcp.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
> This patch converts riscv to use the generic entry infrastructure from
> kernel/entry/*. The generic entry makes maintainers' work easier and
> codes more elegant. Here are the changes than before:
>
>  - More clear entry.S with handle_exception and ret_from_exception
>  - Get rid of complex custom signal implementation
>  - More readable syscall procedure
>  - Little modification on ret_from_fork & ret_from_kernel_thread
>  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
>  - Use the standard preemption code instead of custom
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> ---

[...]

> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 5d3f2fbeb33c..c86d0eafdf6a 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -5,8 +5,10 @@
>   * Copyright (C) 2017 SiFive
>   */
>=20=20
> +#include <linux/entry-common.h>
>  #include <linux/syscalls.h>
>  #include <asm/unistd.h>
> +#include <asm/syscall.h>
>  #include <asm/cacheflush.h>
>  #include <asm-generic/mman-common.h>
>=20=20
> @@ -69,3 +71,28 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, =
uintptr_t, end,
>=20=20
>  	return 0;
>  }
> +
> +typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ulon=
g);
> +
> +asmlinkage void do_sys_ecall_u(struct pt_regs *regs)
> +{
> +	syscall_t syscall;
> +	ulong nr =3D regs->a7;
> +
> +	regs->epc +=3D 4;
> +	regs->orig_a0 =3D regs->a0;
> +	regs->a0 =3D -ENOSYS;
> +
> +	nr =3D syscall_enter_from_user_mode(regs, nr);
> +#ifdef CONFIG_COMPAT
> +	if ((regs->status & SR_UXL) =3D=3D SR_UXL_32)
> +		syscall =3D compat_sys_call_table[nr];
> +	else
> +#endif
> +		syscall =3D sys_call_table[nr];
> +
> +	if (nr < NR_syscalls)
> +		regs->a0 =3D syscall(regs->orig_a0, regs->a1, regs->a2,
> +				   regs->a3, regs->a4, regs->a5,
>  	regs->a6);

Now that we're doing the "pt_regs to call" dance, it would make sense to
introduce a syscall wrapper (like x86 and arm64) for riscv, so that we
don't need to unwrap all regs for all syscalls (See __MAP() in
include/linux/syscalls.h). That would be an optimization, so it could be
done as a follow-up, and not part of the series.


Bj=C3=B6rn
