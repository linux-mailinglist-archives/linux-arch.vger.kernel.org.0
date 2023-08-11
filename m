Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2817797F5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHKTwa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjHKTwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 15:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE845EE
        for <linux-arch@vger.kernel.org>; Fri, 11 Aug 2023 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691783490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXxOGzkfxn/aWsd8gPttRmlIA5cRwswhSr29IEOi3U4=;
        b=aOukrqoEI/vLc6grSJ/UeizavxWMvhAA1BPM8sms7ILNGR2YriScsmIkuV79s/pnNUT20b
        l0LZ3mXpiToYmCHwbsF/7Ob6j8KGtoqXLa4oOcwMZWo8tOFd6yq4mO5KL2HFEI3DISD7fX
        bE+Yrt03W8/BFWLennSXpZIdQBCryu8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-GKeywzkZPMCI_IeqWCbtpw-1; Fri, 11 Aug 2023 15:51:28 -0400
X-MC-Unique: GKeywzkZPMCI_IeqWCbtpw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC0591C0514C;
        Fri, 11 Aug 2023 19:51:26 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEE2B40C6F4E;
        Fri, 11 Aug 2023 19:51:24 +0000 (UTC)
Message-ID: <4cc7113a-0e4e-763a-cba2-7963bcd26c7a@redhat.com>
Date:   Fri, 11 Aug 2023 15:51:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V10 05/19] riscv: qspinlock: Introduce combo spinlock
Content-Language: en-US
To:     guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-6-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230802164701.192791-6-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/23 12:46, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Combo spinlock could support queued and ticket in one Linux Image and
> select them during boot time via errata mechanism. Here is the func
> size (Bytes) comparison table below:
>
> TYPE			: COMBO | TICKET | QUEUED
> arch_spin_lock		: 106	| 60     | 50
> arch_spin_unlock	: 54    | 36     | 26
> arch_spin_trylock	: 110   | 72     | 54
> arch_spin_is_locked	: 48    | 34     | 20
> arch_spin_is_contended	: 56    | 40     | 24
> rch_spin_value_unlocked	: 48    | 34     | 24
>
> One example of disassemble combo arch_spin_unlock:
>     0xffffffff8000409c <+14>:    nop                # detour slot
>     0xffffffff800040a0 <+18>:    fence   rw,w       # queued spinlock start
>     0xffffffff800040a4 <+22>:    sb      zero,0(a4) # queued spinlock end
>     0xffffffff800040a8 <+26>:    ld      s0,8(sp)
>     0xffffffff800040aa <+28>:    addi    sp,sp,16
>     0xffffffff800040ac <+30>:    ret
>     0xffffffff800040ae <+32>:    lw      a5,0(a4)   # ticket spinlock start
>     0xffffffff800040b0 <+34>:    sext.w  a5,a5
>     0xffffffff800040b2 <+36>:    fence   rw,w
>     0xffffffff800040b6 <+40>:    addiw   a5,a5,1
>     0xffffffff800040b8 <+42>:    slli    a5,a5,0x30
>     0xffffffff800040ba <+44>:    srli    a5,a5,0x30
>     0xffffffff800040bc <+46>:    sh      a5,0(a4)   # ticket spinlock end
>     0xffffffff800040c0 <+50>:    ld      s0,8(sp)
>     0xffffffff800040c2 <+52>:    addi    sp,sp,16
>     0xffffffff800040c4 <+54>:    ret
>
> The qspinlock is smaller and faster than ticket-lock when all are in
> fast-path, and combo spinlock could provide a compatible Linux Image
> for different micro-arch design (weak/strict fwd guarantee) processors.
>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>   arch/riscv/Kconfig                |  9 +++-
>   arch/riscv/include/asm/hwcap.h    |  1 +
>   arch/riscv/include/asm/spinlock.h | 87 ++++++++++++++++++++++++++++++-
>   arch/riscv/kernel/cpufeature.c    | 10 ++++
>   4 files changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e89a3bea3dc1..119e774a3dcf 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -440,7 +440,7 @@ config NODES_SHIFT
>   
>   choice
>   	prompt "RISC-V spinlock type"
> -	default RISCV_TICKET_SPINLOCKS
> +	default RISCV_COMBO_SPINLOCKS
>   
>   config RISCV_TICKET_SPINLOCKS
>   	bool "Using ticket spinlock"
> @@ -452,6 +452,13 @@ config RISCV_QUEUED_SPINLOCKS
>   	help
>   	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
>   	  Otherwise, stay at ticket-lock.
> +
> +config RISCV_COMBO_SPINLOCKS
> +	bool "Using combo spinlock"
> +	depends on SMP && MMU
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  Select queued spinlock or ticket-lock via errata.
>   endchoice
>   
>   config RISCV_ALTERNATIVE
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index f041bfa7f6a0..08ae75a694c2 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -54,6 +54,7 @@
>   #define RISCV_ISA_EXT_ZIFENCEI		41
>   #define RISCV_ISA_EXT_ZIHPM		42
>   
> +#define RISCV_ISA_EXT_XTICKETLOCK	63
>   #define RISCV_ISA_EXT_MAX		64
>   #define RISCV_ISA_EXT_NAME_LEN_MAX	32
>   
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> index c644a92d4548..9eb3ad31e564 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -7,11 +7,94 @@
>   #define _Q_PENDING_LOOPS	(1 << 9)
>   #endif
>   

I see why you separated the _Q_PENDING_LOOPS out.


> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +#include <asm-generic/ticket_spinlock.h>
> +
> +#undef arch_spin_is_locked
> +#undef arch_spin_is_contended
> +#undef arch_spin_value_unlocked
> +#undef arch_spin_lock
> +#undef arch_spin_trylock
> +#undef arch_spin_unlock
> +
> +#include <asm-generic/qspinlock.h>
> +#include <asm/hwcap.h>
> +
> +#undef arch_spin_is_locked
> +#undef arch_spin_is_contended
> +#undef arch_spin_value_unlocked
> +#undef arch_spin_lock
> +#undef arch_spin_trylock
> +#undef arch_spin_unlock
Perhaps you can add a macro like __no_arch_spinlock_redefine to disable 
the various arch_spin_* definition in qspinlock.h and ticket_spinlock.h.
> +
> +#define COMBO_DETOUR				\
> +	asm_volatile_goto(ALTERNATIVE(		\
> +		"nop",				\
> +		"j %l[ticket_spin_lock]",	\
> +		0,				\
> +		RISCV_ISA_EXT_XTICKETLOCK,	\
> +		CONFIG_RISCV_COMBO_SPINLOCKS)	\
> +		: : : : ticket_spin_lock);
> +
> +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	COMBO_DETOUR
> +	queued_spin_lock(lock);
> +	return;
> +ticket_spin_lock:
> +	ticket_spin_lock(lock);
> +}
> +
> +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	COMBO_DETOUR
> +	return queued_spin_trylock(lock);
> +ticket_spin_lock:
> +	return ticket_spin_trylock(lock);
> +}
> +
> +static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	COMBO_DETOUR
> +	queued_spin_unlock(lock);
> +	return;
> +ticket_spin_lock:
> +	ticket_spin_unlock(lock);
> +}
> +
> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	COMBO_DETOUR
> +	return queued_spin_value_unlocked(lock);
> +ticket_spin_lock:
> +	return ticket_spin_value_unlocked(lock);
> +}
> +
> +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> +{
> +	COMBO_DETOUR
> +	return queued_spin_is_locked(lock);
> +ticket_spin_lock:
> +	return ticket_spin_is_locked(lock);
> +}
> +
> +static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> +{
> +	COMBO_DETOUR
> +	return queued_spin_is_contended(lock);
> +ticket_spin_lock:
> +	return ticket_spin_is_contended(lock);
> +}
> +#else /* CONFIG_RISCV_COMBO_SPINLOCKS */
> +
>   #ifdef CONFIG_QUEUED_SPINLOCKS
>   #include <asm/qspinlock.h>
> -#include <asm/qrwlock.h>
>   #else
> -#include <asm-generic/spinlock.h>
> +#include <asm-generic/ticket_spinlock.h>
>   #endif
>   
> +#endif /* CONFIG_RISCV_COMBO_SPINLOCKS */
> +
> +#include <asm/qrwlock.h>
> +
>   #endif /* __ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index bdcf460ea53d..e65b0e54152d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -324,6 +324,16 @@ void __init riscv_fill_hwcap(void)
>   		set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
>   		set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
>   
> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +		/*
> +		 * The RISC-V Linux used queued spinlock at first; then, we used ticket_lock
> +		 * as default or queued spinlock by choice. Because ticket_lock would dirty
> +		 * spinlock value, the only way is to change from queued_spinlock to
> +		 * ticket_spinlock, but can not be vice.

The phrase "but can not be vice" is confusing. I think you mean "but not 
vice versa". Right?

Cheers,
Longman

