Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31679FDC5
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjINIDA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjINIC7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 04:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0435AA1
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694678534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HiAk3bKOlav/oFfLlqTgtje3RXVlrppDZ8NfAR80XpM=;
        b=F5p1TBTAl2lu4wJZEUQLgihIpQInffc1Cn18P8RPGpJCBCYchL7NtsrZIR8kewUI5ue/Mr
        ZYrj5877uT1WRkesQidXSaWkBWXRyzbWvntGJfXF9uSuLYM4CG/9Tc3a3Sppbd41pPx2cm
        Ek44Ey82RW+pwQrTpcalqxxP5fn6Whk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-f5o5nce5PBazea-pWO1zcw-1; Thu, 14 Sep 2023 04:02:12 -0400
X-MC-Unique: f5o5nce5PBazea-pWO1zcw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1d5f4d5d848so1110488fac.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 01:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678532; x=1695283332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiAk3bKOlav/oFfLlqTgtje3RXVlrppDZ8NfAR80XpM=;
        b=Mn6/HT0MW77QxwcNbnL1FqU6s+ZDLZMNAiP36xZxXi0d21bH/nhrrwBur+864ucbYi
         g2KGZtP7HwTdrWo1j1wvK0am7jTW0E53YaTg7ihZsWijfFtwkSYCSXj98lYvvmB+Q1Bk
         cXnjNWLSImG/j77H7LcjYSxqRt7k2dVmBADLe3tU6HoXdE7GrHNXwb7uQeECIRsFd9y9
         zf41Tpj/CQROCCoDahmmRVK35lP400mPEAshHL5F0CiSV2HPb6r7UuvsZnW8KPoK8S7a
         OTSiK6UUwYfoo/gIDsqSCXF3EE1aQyWEw3em2BFhhXZp+8KQASc4wBJszijyU566F5bD
         zefQ==
X-Gm-Message-State: AOJu0YzycbfL5RkPj5ax2KsZ1hFPI57A3rA8RPAL3mA68Z3o+JF0gnyZ
        Oq9YZ02HlXAaJLtBzZcV7rQ8Y7bMDJtzbU3DyIisFlPdJpLBfJStxNqZAfQ8Ax8Tg+jSzVRsh/O
        6joUQeYz2/oeYjNSciGfivA==
X-Received: by 2002:a05:6870:35d3:b0:1b3:f1f7:999e with SMTP id c19-20020a05687035d300b001b3f1f7999emr5781407oak.45.1694678531985;
        Thu, 14 Sep 2023 01:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjL5jH2q/nmHiozebZyY/fKINysNQaR6CzFyALeT3Qe+deBNOrapEDdrbheaETCUL++womdw==
X-Received: by 2002:a05:6870:35d3:b0:1b3:f1f7:999e with SMTP id c19-20020a05687035d300b001b3f1f7999emr5781382oak.45.1694678531699;
        Thu, 14 Sep 2023 01:02:11 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870a3d600b001ccab369c09sm515214oak.42.2023.09.14.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:02:11 -0700 (PDT)
Date:   Thu, 14 Sep 2023 05:02:02 -0300
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
Subject: Re: [PATCH V11 08/17] riscv: qspinlock: Add virt_spin_lock() support
 for KVM guest
Message-ID: <ZQK9-tn2MepXlY1u@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-9-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-9-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 04:29:02AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add a static key controlling whether virt_spin_lock() should be
> called or not. When running on bare metal set the new key to
> false.
> 
> The KVM guests fall back to a Test-and-Set spinlock, because fair
> locks have horrible lock 'holder' preemption issues. The
> virt_spin_lock_key would shortcut for the
> queued_spin_lock_slowpath() function that allow virt_spin_lock to
> hijack it.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +++
>  arch/riscv/include/asm/sbi.h                  |  8 +++++
>  arch/riscv/include/asm/spinlock.h             | 22 ++++++++++++++
>  arch/riscv/kernel/sbi.c                       |  2 +-
>  arch/riscv/kernel/setup.c                     | 30 ++++++++++++++++++-
>  5 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 61cacb8dfd0e..f75bedc50e00 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3927,6 +3927,10 @@
>  	no_uaccess_flush
>  	                [PPC] Don't flush the L1-D cache after accessing user data.
>  
> +	no_virt_spin	[RISC-V] Disable virt_spin_lock in KVM guest to use
> +			native_queued_spinlock when the nopvspin option is enabled.
> +			This would help vcpu=pcpu scenarios.
> +
>  	novmcoredd	[KNL,KDUMP]
>  			Disable device dump. Device dump allows drivers to
>  			append dump data to vmcore so you can collect driver
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 501e06e52078..e0233b3d7a5f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -50,6 +50,13 @@ enum sbi_ext_base_fid {
>  	SBI_EXT_BASE_GET_MIMPID,
>  };
>  
> +enum sbi_ext_base_impl_id {
> +	SBI_EXT_BASE_IMPL_ID_BBL = 0,
> +	SBI_EXT_BASE_IMPL_ID_OPENSBI,
> +	SBI_EXT_BASE_IMPL_ID_XVISOR,
> +	SBI_EXT_BASE_IMPL_ID_KVM,
> +};
> +
>  enum sbi_ext_time_fid {
>  	SBI_EXT_TIME_SET_TIMER = 0,
>  };
> @@ -269,6 +276,7 @@ int sbi_console_getchar(void);
>  long sbi_get_mvendorid(void);
>  long sbi_get_marchid(void);
>  long sbi_get_mimpid(void);
> +long sbi_get_firmware_id(void);
>  void sbi_set_timer(uint64_t stime_value);
>  void sbi_shutdown(void);
>  void sbi_send_ipi(unsigned int cpu);
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> index 8ea0fee80652..6b38d6616f14 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -4,6 +4,28 @@
>  #define __ASM_RISCV_SPINLOCK_H
>  
>  #ifdef CONFIG_QUEUED_SPINLOCKS
> +/*
> + * The KVM guests fall back to a Test-and-Set spinlock, because fair locks
> + * have horrible lock 'holder' preemption issues. The virt_spin_lock_key
> + * would shortcut for the queued_spin_lock_slowpath() function that allow
> + * virt_spin_lock to hijack it.
> + */
> +DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +
> +#define virt_spin_lock virt_spin_lock
> +static inline bool virt_spin_lock(struct qspinlock *lock)
> +{
> +	if (!static_branch_likely(&virt_spin_lock_key))
> +		return false;
> +
> +	do {
> +		while (atomic_read(&lock->val) != 0)
> +			cpu_relax();
> +	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
> +
> +	return true;
> +}
> +
>  #define _Q_PENDING_LOOPS	(1 << 9)
>  #endif
>  
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 88eea3a99ee0..cdd45edc8db4 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -555,7 +555,7 @@ static inline long sbi_get_spec_version(void)
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
>  }
>  
> -static inline long sbi_get_firmware_id(void)
> +long sbi_get_firmware_id(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
>  }
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 0f084f037651..c57d15b05160 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -26,6 +26,7 @@
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
> +#include <asm/cpufeature.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable.h>
>  #include <asm/setup.h>
> @@ -283,16 +284,43 @@ DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
>  EXPORT_SYMBOL(combo_qspinlock_key);
>  #endif
>  
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +static bool no_virt_spin_key = false;

I suggest no _key, also there is no need for "= false".
To be consistent with enable_qspinlock, I also suggest
adding __ro_after_init:

static bool no_virt_spin __ro_after_init; 



> +DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +
> +static int __init no_virt_spin_setup(char *p)
> +{
> +	no_virt_spin_key = true;
> +
> +	return 0;
> +}
> +early_param("no_virt_spin", no_virt_spin_setup);
> +
> +static void __init virt_spin_lock_init(void)
> +{
> +	if (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM ||
> +	    no_virt_spin_key)
> +		static_branch_disable(&virt_spin_lock_key);
> +	else
> +		pr_info("Enable virt_spin_lock\n");
> +}
> +#endif
> +

A new virt_no_spin kernel parameter was introduced, but without 
CONFIG_QUEUED_SPINLOCKS it will silently fail.

I would suggest an #else clause here with a function to print an error / 
warning message about no_virt_spin being invalid in this scenario.
It will probably help future debugging.


>  static void __init riscv_spinlock_init(void)
>  {
>  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> -	if (!enable_qspinlock_key) {
> +	if (!enable_qspinlock_key &&
> +	    (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)) {
>  		static_branch_disable(&combo_qspinlock_key);
>  		pr_info("Ticket spinlock: enabled\n");
>  	} else {
>  		pr_info("Queued spinlock: enabled\n");
>  	}
>  #endif
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +	virt_spin_lock_init();
> +#endif
>  }
>  
>  extern void __init init_rt_signal_env(void);
> -- 
> 2.36.1
> 

I am probably missing something out, but it looks to me that this patch is 
causing 2 different changes:
1 - Enabling no_virt_spin parameter
2 - Disabling queued spinlocks for some firmware_id

Wouldn't be better to split those changes in multiple patches? 
Or am I missing the point on why they need to be together?

Thanks!
Leo

