Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A668F018
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 14:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBHNph (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjBHNpK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 08:45:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A23B3F6;
        Wed,  8 Feb 2023 05:45:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j1so12548713pjd.0;
        Wed, 08 Feb 2023 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alfJUZBV+BrVmvoYfSmGRjxyktkbme4Dc/pX5IUBNAo=;
        b=qOV7ysnAAE47VMzfW+KW7uRQ3waC/E8XmADC10hm4irUlpgyQ7W9iYPxZ4ELgAqlhT
         LjIlmiu2gGIqass/jeVRMyvjNwUEv+WV5tdMSo2zQLMRN2vxuod8wxnC6nkM3y/R+I+h
         K8aFy5z+AEHJZW5D7ypP7nruC1fDjCbfW2Ce/nkXTsnVFsJ86n5MCU4QSDWSSK+YQC1V
         eR7xjDBpbTf+S+YnpbqpO3YFtt4f2FioYXoa7qazR595af1e5Vo1MyyVHSzK9M+3XQCB
         tZ+YpRzE0Ktq/8lxY6zE8zSXlnjcecUsfEcPZIpiBBxPwscyLA9a8qvnWbtq6WFjvcKS
         imlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alfJUZBV+BrVmvoYfSmGRjxyktkbme4Dc/pX5IUBNAo=;
        b=MnsJNTX4TAfzXIsKsS8jskLfOat+iq7B4ctpS7Y5HTVMmIsEwvUtwbAYCCcF4ULn49
         Cxr02jSixQqdaLJA87mUEzMc1dn+hKyANKB5wV00IxH4UZsZ+hKSR4PELSN20Pmi+WdR
         OKtwLdk3HWzoEtKkSkGgLJpLKjZ3iC7ADCu84etPwVQLs+lxNHg1LcB3ZfHWmVIQN4Z/
         /fnZhS1UlaxkuiQZnW5RmbWohBjcWG6fiVFkRXTXAXXYEav4gK2ZKL5mGSAmpPFPdPTY
         SCyp1u5gcdHo3p6UqD9ddiS70EIjEucAuWfJxqA7t5+fW2ReVTMBLDHoqkDG0WsR0DSj
         Iftw==
X-Gm-Message-State: AO0yUKUar6sEBP2fYdnzmHDa4OTNoshCZtlHsBw/6zc078ajSUEvke9S
        scA/bnD/3e+uT9EHfInIb1o=
X-Google-Smtp-Source: AK7set+sPEOSedwTYT2y4bNUQKcEXNgoZqhXS89DjZ61bh7BdhGz84e05koI5bATzWm0v/BjRJNztQ==
X-Received: by 2002:a17:903:120b:b0:194:58c7:ab79 with SMTP id l11-20020a170903120b00b0019458c7ab79mr9146382plh.63.1675863904496;
        Wed, 08 Feb 2023 05:45:04 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id jc10-20020a17090325ca00b00199190b00efsm6056928plb.97.2023.02.08.05.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:45:02 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:44:49 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 09/10] arch: Remove cmpxchg_double
Message-ID: <Y+OnUXkKcT2Y7Yiq@localhost>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.746130134@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.746130134@infradead.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:39PM +0100, Peter Zijlstra wrote:
> No moar users, remove the monster.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/core-api/this_cpu_ops.rst    |    2 -
>  arch/arm64/include/asm/atomic_ll_sc.h      |   33 ----------------
>  arch/arm64/include/asm/atomic_lse.h        |   36 ------------------
>  arch/arm64/include/asm/cmpxchg.h           |   46 -----------------------
>  arch/arm64/include/asm/percpu.h            |   10 -----
>  arch/s390/include/asm/cmpxchg.h            |   34 -----------------
>  arch/s390/include/asm/percpu.h             |   18 ---------
>  arch/x86/include/asm/cmpxchg.h             |   25 ------------
>  arch/x86/include/asm/cmpxchg_32.h          |    1 
>  arch/x86/include/asm/cmpxchg_64.h          |    1 
>  arch/x86/include/asm/percpu.h              |   41 --------------------
>  include/asm-generic/percpu.h               |   58 -----------------------------
>  include/linux/atomic/atomic-instrumented.h |   17 --------
>  include/linux/percpu-defs.h                |   38 -------------------
>  scripts/atomic/gen-atomic-instrumented.sh  |   17 ++------
>  15 files changed, 6 insertions(+), 371 deletions(-)
> 
> --- a/arch/x86/include/asm/cmpxchg.h
> +++ b/arch/x86/include/asm/cmpxchg.h
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -385,30 +368,6 @@ do {									\
>  #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
>  #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
>  #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
> -
> -/*
> - * Pretty complex macro to generate cmpxchg16 instruction.  The instruction
> - * is not supported on early AMD64 processors so we must be able to emulate
> - * it in software.  The address used in the cmpxchg16 instruction must be
> - * aligned to a 16 byte boundary.
> - */
> -#define percpu_cmpxchg16b_double(pcp1, pcp2, o1, o2, n1, n2)		\
> -({									\
> -	bool __ret;							\
> -	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
> -	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
> -	alternative_io("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \

I guess now arch/x86/lib/cmpxchg*b_emu.S could be dropped too?

> -		       "cmpxchg16b " __percpu_arg(1) "\n\tsetz %0\n\t",	\
> -		       X86_FEATURE_CX16,				\
> -		       ASM_OUTPUT2("=a" (__ret), "+m" (pcp1),		\
> -				   "+m" (pcp2), "+d" (__o2)),		\
> -		       "b" (__n1), "c" (__n2), "a" (__o1) : "rsi");	\
> -	__ret;								\
> -})
> -
> -#define raw_cpu_cmpxchg_double_8	percpu_cmpxchg16b_double
> -#define this_cpu_cmpxchg_double_8	percpu_cmpxchg16b_double
> -
>  #endif
