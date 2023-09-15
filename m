Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D67A1597
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 07:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIOFnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 01:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIOFnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 01:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66B1C2717
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694756553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFO8+T730lSxbR4eXXN1KRpuEmnACBgmkqkqaO3f0p0=;
        b=GAWCknatm+LHzTipifwW3ZiIiMV6NRu/oPIzweBybj0M/LPNLlD+kanzoBcC/dPP3Yixf4
        6MlFtnyrEtbAWP5YBmQbQckQjBcedrN4vhZz4BvBjbfn/9w4Giuv9MjknzDesxRz3DMa4X
        5eR75/PI4VH0E0jelq/OZuZn9qS/Xlw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-I-PQ2ucyNW6k6OZm5rDgHQ-1; Fri, 15 Sep 2023 01:42:31 -0400
X-MC-Unique: I-PQ2ucyNW6k6OZm5rDgHQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1d56e632274so2642604fac.3
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 22:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756550; x=1695361350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFO8+T730lSxbR4eXXN1KRpuEmnACBgmkqkqaO3f0p0=;
        b=ZTfGWNxjVFldWa0pxxSsB4Y01QksQ9jUmIDXlTlj10vwo/zzYJLG3KYhmNQyrMV/ec
         6vE5NfY0nRmx+d9eComuVkb74cu0OJQg/qrW9xoMwDQ4wIVXtdilbv2Cd7bq4LBsvc1j
         WPi34l8wDHe/1M11zSqKtDNFHlO2KOL3mEXF8mdIrZ4ISeoAUUZl/aK6oZ0DH8DtWO5P
         vj3wtmyLarNkI/fkSoegH2BjoHIojQgSDiZgzfNNDG6SLacxkZIF+/lDT978CKnFmMv8
         iYndkdZn0IfUpcHOvAHD56WBC+I4u1RQhXcFQdNqhm9yYUIlRRbtR0ef+3QERECrxn+c
         yUmA==
X-Gm-Message-State: AOJu0Yw45kCZzlATgp1SU6nAKFxZyXsdEJOzsFBAKuQxD1Q/mRg/h/Ki
        UiF4+NSKtAnlfZijOOxEN4NkR5LxG7LgaeDbPmksOe+/qZW88cP+FHcKx+dWhpM9uK79svt3HzI
        eWiCh3g8p8IL0WpbyQdCEHQ==
X-Received: by 2002:a05:6870:659e:b0:1d5:a72e:154e with SMTP id fp30-20020a056870659e00b001d5a72e154emr914810oab.36.1694756550506;
        Thu, 14 Sep 2023 22:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt0gjdD2W1OMPtXYFw18q1B6hx8A/UEEDl5ieKzaDTp4knHfwN8c0lVL2v/Jr+kPERmtLQiw==
X-Received: by 2002:a05:6870:659e:b0:1d5:a72e:154e with SMTP id fp30-20020a056870659e00b001d5a72e154emr914789oab.36.1694756550218;
        Thu, 14 Sep 2023 22:42:30 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id ed23-20020a056870b79700b001cd14c60b35sm1591100oab.5.2023.09.14.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:42:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 02:42:20 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 11/17] RISC-V: paravirt: pvqspinlock: Add paravirt
 qspinlock skeleton
Message-ID: <ZQPuvCNq5IAYlMR6@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-12-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-12-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 04:29:05AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Using static_call to switch between:
>   native_queued_spin_lock_slowpath()    __pv_queued_spin_lock_slowpath()
>   native_queued_spin_unlock()           __pv_queued_spin_unlock()
> 
> Finish the pv_wait implementation, but pv_kick needs the SBI
> definition of the next patches.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/Kbuild               |  1 -
>  arch/riscv/include/asm/qspinlock.h          | 35 +++++++++++++
>  arch/riscv/include/asm/qspinlock_paravirt.h | 29 +++++++++++
>  arch/riscv/include/asm/spinlock.h           |  2 +-
>  arch/riscv/kernel/qspinlock_paravirt.c      | 57 +++++++++++++++++++++
>  arch/riscv/kernel/setup.c                   |  4 ++
>  6 files changed, 126 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/qspinlock.h
>  create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
>  create mode 100644 arch/riscv/kernel/qspinlock_paravirt.c
> 
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index a0dc85e4a754..b89cb3b73c13 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -7,6 +7,5 @@ generic-y += parport.h
>  generic-y += spinlock_types.h
>  generic-y += qrwlock.h
>  generic-y += qrwlock_types.h
> -generic-y += qspinlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/qspinlock.h
> new file mode 100644
> index 000000000000..7d4f416c908c
> --- /dev/null
> +++ b/arch/riscv/include/asm/qspinlock.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c), 2023 Alibaba Cloud
> + * Authors:
> + *	Guo Ren <guoren@linux.alibaba.com>
> + */
> +
> +#ifndef _ASM_RISCV_QSPINLOCK_H
> +#define _ASM_RISCV_QSPINLOCK_H
> +
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +#include <asm/qspinlock_paravirt.h>
> +
> +/* How long a lock should spin before we consider blocking */
> +#define SPIN_THRESHOLD		(1 << 15)
> +
> +void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +void __pv_init_lock_hash(void);
> +void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +
> +static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +{
> +	static_call(pv_queued_spin_lock_slowpath)(lock, val);
> +}
> +
> +#define queued_spin_unlock	queued_spin_unlock
> +static inline void queued_spin_unlock(struct qspinlock *lock)
> +{
> +	static_call(pv_queued_spin_unlock)(lock);
> +}
> +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
> +
> +#include <asm-generic/qspinlock.h>
> +
> +#endif /* _ASM_RISCV_QSPINLOCK_H */
> diff --git a/arch/riscv/include/asm/qspinlock_paravirt.h b/arch/riscv/include/asm/qspinlock_paravirt.h
> new file mode 100644
> index 000000000000..9681e851f69d
> --- /dev/null
> +++ b/arch/riscv/include/asm/qspinlock_paravirt.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c), 2023 Alibaba Cloud
> + * Authors:
> + *	Guo Ren <guoren@linux.alibaba.com>
> + */
> +
> +#ifndef _ASM_RISCV_QSPINLOCK_PARAVIRT_H
> +#define _ASM_RISCV_QSPINLOCK_PARAVIRT_H
> +
> +void pv_wait(u8 *ptr, u8 val);
> +void pv_kick(int cpu);
> +
> +void dummy_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +void dummy_queued_spin_unlock(struct qspinlock *lock);
> +
> +DECLARE_STATIC_CALL(pv_queued_spin_lock_slowpath, dummy_queued_spin_lock_slowpath);
> +DECLARE_STATIC_CALL(pv_queued_spin_unlock, dummy_queued_spin_unlock);
> +
> +void __init pv_qspinlock_init(void);
> +
> +static inline bool pv_is_native_spin_unlock(void)
> +{
> +	return false;
> +}
> +
> +void __pv_queued_spin_unlock(struct qspinlock *lock);
> +
> +#endif /* _ASM_RISCV_QSPINLOCK_PARAVIRT_H */
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> index 6b38d6616f14..ed4253f491fe 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -39,7 +39,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>  #undef arch_spin_trylock
>  #undef arch_spin_unlock
>  
> -#include <asm-generic/qspinlock.h>
> +#include <asm/qspinlock.h>
>  #include <linux/jump_label.h>
>  
>  #undef arch_spin_is_locked
> diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
> new file mode 100644
> index 000000000000..85ff5a3ec234
> --- /dev/null
> +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c), 2023 Alibaba Cloud
> + * Authors:
> + *	Guo Ren <guoren@linux.alibaba.com>
> + */
> +
> +#include <linux/static_call.h>
> +#include <asm/qspinlock_paravirt.h>
> +#include <asm/sbi.h>
> +
> +void pv_kick(int cpu)
> +{
> +	return;
> +}
> +
> +void pv_wait(u8 *ptr, u8 val)
> +{
> +	unsigned long flags;
> +
> +	if (in_nmi())
> +		return;
> +
> +	local_irq_save(flags);
> +	if (READ_ONCE(*ptr) != val)
> +		goto out;
> +
> +	/* wait_for_interrupt(); */
> +out:
> +	local_irq_restore(flags);
> +}
> +
> +static void native_queued_spin_unlock(struct qspinlock *lock)
> +{
> +	smp_store_release(&lock->locked, 0);
> +}
> +
> +DEFINE_STATIC_CALL(pv_queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
> +EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
> +
> +DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
> +EXPORT_STATIC_CALL(pv_queued_spin_unlock);
> +
> +void __init pv_qspinlock_init(void)
> +{
> +	if (num_possible_cpus() == 1)
> +		return;
> +
> +	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)

Checks like this seem to be very common on this patchset.
For someone not much familiar with this, it can be hard to 
understand.

I mean, on patch 8/17 you introduce those IDs, which look to be 
incremental ( ID == N includes stuff from ID < N ), but I am not sure as I 
couln't find much documentation on that.

Then above you test for the id being different than 
SBI_EXT_BASE_IMPL_ID_KVM, but if they are actually incremental and a new 
version lands, the new version will also return early because it passes the 
test.

I am no sure if above is right, but it's all I could understand without 
documentation.

Well, my point is: this seems hard to understand & review, so it would be 
nice to have a macro like this to be used instead:

#define sbi_fw_implements_kvm() \
	(sbi_get_firmware_id() >= SBI_EXT_BASE_IMPL_ID_KVM)

if(!sbi_fw_implements_kvm())
	return;

What do you think?

Other than that, LGTM.

Thanks!
Leo

> +		return;
> +
> +	pr_info("PV qspinlocks enabled\n");
> +	__pv_init_lock_hash();
> +
> +	static_call_update(pv_queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
> +	static_call_update(pv_queued_spin_unlock, __pv_queued_spin_unlock);
> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index c57d15b05160..88690751f2ee 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -321,6 +321,10 @@ static void __init riscv_spinlock_init(void)
>  #ifdef CONFIG_QUEUED_SPINLOCKS
>  	virt_spin_lock_init();
>  #endif
> +
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +	pv_qspinlock_init();
> +#endif
>  }
>  
>  extern void __init init_rt_signal_env(void);
> -- 
> 2.36.1
> 

