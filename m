Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656647A1606
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjIOGYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjIOGYJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 02:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F3A82102
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694758998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h49HJZ/O577BqKvSVyAVyTrcbTxM3sCo8B/Q+wbyQ4s=;
        b=aQMWXYcBeXTCbrRyYq8fzs6BBjH0TBlJ4I9UYJ1Xk2tfYeBYbHT26Xi8yYoYY70rbrQyGp
        jl9bjSY2OMexqhfwPG1s2n7DUf5tydfbMNw65bVf3xKdbWLPf2EYXuzNwCn/tgx3EWtNfv
        ElGF1Uwr/9MG3oDLJhfSl2PxWlZC5Js=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-iqU1zaEaNoqc8yiNPd2yMg-1; Fri, 15 Sep 2023 02:23:16 -0400
X-MC-Unique: iqU1zaEaNoqc8yiNPd2yMg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3aa142796a5so2755590b6e.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 23:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694758995; x=1695363795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h49HJZ/O577BqKvSVyAVyTrcbTxM3sCo8B/Q+wbyQ4s=;
        b=HS54klXeXh5mZ+sxmur1t+D8CyUqStMnMSUKsynm44vhq2lJ8uMEphCG5djGvKietO
         junUuo8+K5lcsK2QoBGZChM4DhBMY5ZLvOEB9cefCNcaoic9h6+Om+w4GENZ2jVWXEog
         3cRM55ixM664yYGrPATLRr2E3FS0j3hNXsl5PbV4Xiyhb7Gu+Nmtqrh9Tb8Yxt7SpYN3
         L5mlIy/X00XomNFKk/adRccGT+isO0NrfTWpFoVZYuIK5wsRRUD1AIghvn4xBxmDmenq
         vx+kkd/HKyBsXT4LTF/hxg9hWTw2Idm338CnafPDzYF5q0ky/Tk9WbVSnGzi4nI/Bo63
         8mgA==
X-Gm-Message-State: AOJu0Yw005F+401isNGmGJfV81UuRu1Tp7LCYX53AgjrQMkny2GAe24s
        yn6pruOZlt5Y8qsv7gmo8ZFZqJimVBVLBxiUsboUn+GnrqrzeYFbltiBDv0y5dsbbo8CPoOecoh
        mTZkNk9bkT1g3qY9eTihmfA==
X-Received: by 2002:a05:6808:15a4:b0:3a1:e12b:2f80 with SMTP id t36-20020a05680815a400b003a1e12b2f80mr1008566oiw.35.1694758995692;
        Thu, 14 Sep 2023 23:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnXl+iWXUNkjlGJTgGvcCE0+QSxnHePkAelhd7hHtYCVfy9sGfEJ3pO9ERuYXBQlky5+8lHw==
X-Received: by 2002:a05:6808:15a4:b0:3a1:e12b:2f80 with SMTP id t36-20020a05680815a400b003a1e12b2f80mr1008543oiw.35.1694758995419;
        Thu, 14 Sep 2023 23:23:15 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id e2-20020a9d7302000000b006c0d686f76esm1338510otk.63.2023.09.14.23.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:23:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 03:23:05 -0300
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
Subject: Re: [PATCH V11 13/17] RISC-V: paravirt: pvqspinlock: Add SBI
 implementation
Message-ID: <ZQP4SXLf00IntVWd@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-14-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-14-guoren@kernel.org>
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

On Sun, Sep 10, 2023 at 04:29:07AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Implement pv_kick with SBI implementation, and add SBI_EXT_PVLOCK
> extension detection.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/sbi.h           | 6 ++++++
>  arch/riscv/kernel/qspinlock_paravirt.c | 7 ++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index e0233b3d7a5f..3533f8d4f3e2 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -30,6 +30,7 @@ enum sbi_ext_id {
>  	SBI_EXT_HSM = 0x48534D,
>  	SBI_EXT_SRST = 0x53525354,
>  	SBI_EXT_PMU = 0x504D55,
> +	SBI_EXT_PVLOCK = 0xAB0401,
>  
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> @@ -243,6 +244,11 @@ enum sbi_pmu_ctr_type {
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>  
> +/* SBI PVLOCK (kick cpu out of wfi) */
> +enum sbi_ext_pvlock_fid {
> +	SBI_EXT_PVLOCK_KICK_CPU = 0,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
> index a0ad4657f437..571626f350be 100644
> --- a/arch/riscv/kernel/qspinlock_paravirt.c
> +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> @@ -11,6 +11,8 @@
>  
>  void pv_kick(int cpu)
>  {
> +	sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
> +		  cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);
>  	return;
>  }
>  
> @@ -25,7 +27,7 @@ void pv_wait(u8 *ptr, u8 val)
>  	if (READ_ONCE(*ptr) != val)
>  		goto out;
>  
> -	/* wait_for_interrupt(); */
> +	wait_for_interrupt();
>  out:
>  	local_irq_restore(flags);
>  }
> @@ -62,6 +64,9 @@ void __init pv_qspinlock_init(void)
>  	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
>  		return;
>  
> +	if (!sbi_probe_extension(SBI_EXT_PVLOCK))
> +		return;
> +
>  	pr_info("PV qspinlocks enabled\n");
>  	__pv_init_lock_hash();
>  
> -- 
> 2.36.1
> 

IIUC this PVLOCK extension is now a requirement to use pv_qspinlock(), and 
it allows a cpu to use an instruction to wait for interrupt in pv_wait(), 
and kicks it out of this wait using a new sbi_ecall() on pv_kick().

Overall it LGTM, but would be nice to have the reference doc in the commit
msg. I end up inferring some of the inner workings by your implementation, 
which is not ideal for reviewing.

If understanding above is right,
Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thanks!
Leo

