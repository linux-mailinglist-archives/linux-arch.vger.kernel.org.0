Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211C729FB4
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbjFIQKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242132AbjFIQKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 12:10:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD335BE
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 09:10:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f624daccd1so2441611e87.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Jun 2023 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686327042; x=1688919042;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A4fU6QoWxC0y2Sy3FIgTg9nFgE7RuqgyoUp2KWf0Go=;
        b=XTRb6KWtvjOWlVe6ijBWSXNL5zPLJVAIKcPEDxX7UFHLqkCvY76bG3mzmi1sXlytUz
         DftRWFb9+0I0QmyWzpszBUn4AtfS1FJym9LdbwQ24SJ5QyJpvQdfigbxeJ2XySzXxnCM
         aw0a32JQsTgz9mfFwcmsHr1V5N81hU+6Yr9ECaIy6dm0L3Bm8qrYUOQRwaZb1Aad7f0d
         VtbB0iON1neb4qmal8SWqe+CQRBGLskxXOHGhYk0yXaaRaTVOO8CAumS8nzdQBPRrsG7
         zoS9BJAp6eWzAR8r09dElcaQEKo8EY4rTlzaYhqwH9J32xpUF3GqXzlgh91JQNb7T4zW
         E+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327042; x=1688919042;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A4fU6QoWxC0y2Sy3FIgTg9nFgE7RuqgyoUp2KWf0Go=;
        b=NZZP3JG+PX4FAcsETzN99/eTKtJqJXKz4jCWLsOZU6S3Qx3LDdQjcd0WeoN2E0M+jw
         Aji+qFt6yofdXEYQDAlwEaz4BUX7rmrIGThqHtMJxlebLhccTQz6xWtR2lrXuO9ulK7j
         JFbU3VniAM4zDY9RRxAvFBJfhZbcA/SIVgTWolnyRl5fDK4DrQ3+pxQBSpz3cbjQ0YkE
         LYNjpyC/50DUrPT8ehAo3J+L2IQ09uu44UwrPTm6J8rakVKzMFdu7jwJ+UdbA4OTBfZT
         nWTVcreOill4qR/UbrfkcB30Ja3onR1lWsQWBMuetxp4cdHQBEVtIFJ2rhMKrY9J0ykU
         YfWw==
X-Gm-Message-State: AC+VfDxorOfX47VWd5cVTLhqypIKn1nSuNeqPTujZrO5BPXMiXVozDPO
        4O0S2lEHsGI/qAhPUfMpABI5EA==
X-Google-Smtp-Source: ACHHUZ5ZGgSMiJfuI5fvPzb//LBZ0VtwD8E//F+BiE2R6HZ2SAPeeNmjeUuvenzCgUluIhSQRSB/mg==
X-Received: by 2002:a19:671e:0:b0:4f4:3418:4726 with SMTP id b30-20020a19671e000000b004f434184726mr1117317lfc.56.1686327041951;
        Fri, 09 Jun 2023 09:10:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id f14-20020a19ae0e000000b004f4e637db2fsm587260lfc.167.2023.06.09.09.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:10:41 -0700 (PDT)
Message-ID: <f320f021-88c4-c5c9-0781-c82d0b88f67d@linaro.org>
Date:   Fri, 9 Jun 2023 18:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/12] percpu: Add {raw,this}_cpu_try_cmpxchg()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
References: <20230531132323.587480729@infradead.org>
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
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
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531132323.587480729@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 31.05.2023 15:08, Peter Zijlstra wrote:
> Add the try_cmpxchg() form to the per-cpu ops.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
+CC Nathan, llvm list

Hi all, this patch seems to break booting on Qualcomm ARM64 platforms
when compiled with clang (GCC works fine) for some reason..:

next-20230605 - works
next-20230606 - doesn't

grev -m 1 dc4e51fd9846 on next-20230606 - works again
b4 shazam <this_msgid> -P 1-4 - still works
b4 shazam <this_msgid> -P 5 - breaks

Confirmed on at least Qualcomm QCM2290, SM8250.

Checking the serial console, it hits a BUG_ON:

[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at mm/vmalloc.c:1638!
[    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted [snip]
[    0.000000] Hardware name: Qualcomm Technologies, Inc. Robotics RB1 (DT)
[    0.000000] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : alloc_vmap_area+0xafc/0xb08
[    0.000000] lr : alloc_vmap_area+0x9e4/0xb08
[    0.000000] sp : ffffa50137f53c20
[    0.000000] x29: ffffa50137f53c60 x28: ffffa50137f30c18 x27: 0000000000000000
[    0.000000] x26: 0000000000007fff x25: ffff800080000000 x24: 000000000000cfff
[    0.000000] x23: ffffffffffff8000 x22: ffffa50137fef970 x21: fffffbfff0000000
[    0.000000] x20: ffff022982003208 x19: ffff0229820031f8 x18: ffffa50137f64f70
[    0.000000] x17: ffffa50137fef980 x16: ffffa501375e6d08 x15: 0000000000000001
[    0.000000] x14: ffffa5013831e1a0 x13: ffffa50137f30c18 x12: 0000000000402dc2
[    0.000000] x11: 0000000000000000 x10: ffff022982003018 x9 : ffffa5013831e188
[    0.000000] x8 : ffffcb55ff003228 x7 : 0000000000000000 x6 : 0000000000000048
[    0.000000] x5 : 0000000000000000 x4 : ffffa50137f53bd0 x3 : ffffa50136490000
[    0.000000] x2 : 0000000000000001 x1 : ffffa5013831e190 x0 : ffff022982003208
[    0.000000] Call trace:
[    0.000000]  alloc_vmap_area+0xafc/0xb08
[    0.000000]  __get_vm_area_node+0x108/0x1e8
[    0.000000]  __vmalloc_node_range+0x1fc/0x728
[    0.000000]  __vmalloc_node+0x5c/0x70
[    0.000000]  init_IRQ+0x90/0x11c
[    0.000000]  start_kernel+0x1ac/0x3bc
[    0.000000]  __primary_switched+0xc4/0xcc
[    0.000000] Code: f000e300 91062000 943bd9ba 17ffff8f (d4210000)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

Compiled with clang 15.0.7 from Arch repos, with
make ARCH=arm64 LLVM=1

Konrad
>  include/asm-generic/percpu.h |  113 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/percpu-defs.h  |   19 +++++++
>  2 files changed, 128 insertions(+), 4 deletions(-)
> 
> --- a/include/asm-generic/percpu.h
> +++ b/include/asm-generic/percpu.h
> @@ -89,16 +89,37 @@ do {									\
>  	__ret;								\
>  })
>  
> -#define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
> +#define __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, _cmpxchg)		\
> +({									\
> +	typeof(pcp) __val, __old = *(ovalp);				\
> + 	__val = _cmpxchg(pcp, __old, nval);				\
> +	if (__val != __old)						\
> +		*(ovalp) = __val;					\
> +	__val == __old;							\
> +})
> +
> +#define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
>  ({									\
>  	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
> -	typeof(pcp) __ret;						\
> -	__ret = *__p;							\
> -	if (__ret == (oval))						\
> +	typeof(pcp) __val = *__p, __old = *(ovalp);			\
> +	bool __ret;							\
> +	if (__val == __old) {						\
>  		*__p = nval;						\
> +		__ret = true;						\
> +	} else {							\
> +		*(ovalp) = __val;					\
> +		__ret = false;						\
> +	}								\
>  	__ret;								\
>  })
>  
> +#define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
> +({									\
> +	typeof(pcp) __old = (oval);					\
> +	raw_cpu_generic_try_cmpxchg(pcp, &__old, nval);			\
> +	__old;								\
> +})
> +
>  #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
>  ({									\
>  	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
> @@ -170,6 +191,16 @@ do {									\
>  	__ret;								\
>  })
>  
> +#define this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
> +({									\
> +	bool __ret;							\
> +	unsigned long __flags;						\
> +	raw_local_irq_save(__flags);					\
> +	__ret = raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval);		\
> +	raw_local_irq_restore(__flags);					\
> +	__ret;								\
> +})
> +
>  #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
>  ({									\
>  	typeof(pcp) __ret;						\
> @@ -282,6 +313,43 @@ do {									\
>  #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
>  #endif
>  
> +#ifndef raw_cpu_try_cmpxchg_1
> +#ifdef raw_cpu_cmpxchg_1
> +#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_1)
> +#else
> +#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
> +	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +#ifndef raw_cpu_try_cmpxchg_2
> +#ifdef raw_cpu_cmpxchg_2
> +#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_2)
> +#else
> +#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
> +	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +#ifndef raw_cpu_try_cmpxchg_4
> +#ifdef raw_cpu_cmpxchg_4
> +#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_4)
> +#else
> +#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
> +	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +#ifndef raw_cpu_try_cmpxchg_8
> +#ifdef raw_cpu_cmpxchg_8
> +#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_8)
> +#else
> +#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
> +	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +
>  #ifndef raw_cpu_cmpxchg_1
>  #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
>  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
> @@ -407,6 +475,43 @@ do {									\
>  #define this_cpu_xchg_8(pcp, nval)	this_cpu_generic_xchg(pcp, nval)
>  #endif
>  
> +#ifndef this_cpu_try_cmpxchg_1
> +#ifdef this_cpu_cmpxchg_1
> +#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_1)
> +#else
> +#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
> +	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +#ifndef this_cpu_try_cmpxchg_2
> +#ifdef this_cpu_cmpxchg_2
> +#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_2)
> +#else
> +#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
> +	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +#ifndef this_cpu_try_cmpxchg_4
> +#ifdef this_cpu_cmpxchg_4
> +#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_4)
> +#else
> +#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
> +	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +#ifndef this_cpu_try_cmpxchg_8
> +#ifdef this_cpu_cmpxchg_8
> +#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
> +	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_8)
> +#else
> +#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
> +	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
> +#endif
> +#endif
> +
>  #ifndef this_cpu_cmpxchg_1
>  #define this_cpu_cmpxchg_1(pcp, oval, nval) \
>  	this_cpu_generic_cmpxchg(pcp, oval, nval)
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -343,6 +343,21 @@ static __always_inline void __this_cpu_p
>  	pscr2_ret__;							\
>  })
>  
> +#define __pcpu_size_call_return2bool(stem, variable, ...)		\
> +({									\
> +	bool pscr2_ret__;						\
> +	__verify_pcpu_ptr(&(variable));					\
> +	switch(sizeof(variable)) {					\
> +	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
> +	case 2: pscr2_ret__ = stem##2(variable, __VA_ARGS__); break;	\
> +	case 4: pscr2_ret__ = stem##4(variable, __VA_ARGS__); break;	\
> +	case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break;	\
> +	default:							\
> +		__bad_size_call_parameter(); break;			\
> +	}								\
> +	pscr2_ret__;							\
> +})
> +
>  /*
>   * Special handling for cmpxchg_double.  cmpxchg_double is passed two
>   * percpu variables.  The first has to be aligned to a double word
> @@ -426,6 +441,8 @@ do {									\
>  #define raw_cpu_xchg(pcp, nval)		__pcpu_size_call_return2(raw_cpu_xchg_, pcp, nval)
>  #define raw_cpu_cmpxchg(pcp, oval, nval) \
>  	__pcpu_size_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
> +#define raw_cpu_try_cmpxchg(pcp, ovalp, nval) \
> +	__pcpu_size_call_return2bool(raw_cpu_try_cmpxchg_, pcp, ovalp, nval)
>  #define raw_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
>  	__pcpu_double_call_return_bool(raw_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
>  
> @@ -513,6 +530,8 @@ do {									\
>  #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
>  #define this_cpu_cmpxchg(pcp, oval, nval) \
>  	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
> +#define this_cpu_try_cmpxchg(pcp, ovalp, nval) \
> +	__pcpu_size_call_return2bool(this_cpu_try_cmpxchg_, pcp, ovalp, nval)
>  #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
>  	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
>  
