Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320EC52FF7B
	for <lists+linux-arch@lfdr.de>; Sat, 21 May 2022 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbiEUUqn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 May 2022 16:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiEUUqm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 May 2022 16:46:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD573CA4F
        for <linux-arch@vger.kernel.org>; Sat, 21 May 2022 13:46:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p8so10439412pfh.8
        for <linux-arch@vger.kernel.org>; Sat, 21 May 2022 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zlWqB5MyIreQkH9j+kkYXZk6dwZqYqeaw6AlELt9B4o=;
        b=E44v0AuUeYoRSlY2iH+XvxjVr0c0EIR5hAkMSycOuyMJPr3jSBu4ns3e03wJKOxSY4
         YJeyDLb1pY0bRCPArVX4C7ljgDbMcjG8rPwlCdlssExjhnOyi2pmzDkCZJNG0+vD/Z4y
         NnCUgogYkC28PGSiHP2cyP4j+rKuDuqH89nvo7jPSUk20zK5Z2hXlVal5o1T/yDNG7pj
         nowdQvKdgfCFtno7ARCuVtyAq9IV3lXvMT0bJpiJg3uLkscbZHWCjr1fXP5qmR50qq7+
         vMRzHDibDvg6IfNj7rdjU2JcKJ5c5iYBssp1zgqOK6OdyItV1NG3fwngcmhFD7v4TVC3
         hQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zlWqB5MyIreQkH9j+kkYXZk6dwZqYqeaw6AlELt9B4o=;
        b=yzTvYaXEIKZ6JoanMRBoAftOqYZ4HO25UXqNWYdotOWQqptmN/gP70jzTzM4WRyj85
         W1Xdim6h160nOnge/OmPezgx9SwqHpYi2sz29v412LgoTQ8383u3u5gepXDw86O3xeqE
         V0bb4S75wK6NDhJb1mMkdBK2PO4ooK/XMVp5ZP8CIiOy2STVwqzJLJNfv+ySMNWZNOlE
         8ZIJpY3r7yOZEoe+4GvBNThmDdzLp3ddM/PGX48cIn1dPdz5kSiAZztSDiGWeimGyTRX
         yut5Gaav/Sjlf83ran7f2jYudZOTNi5l8oAqtTy2yNZp8K0qiAkanzIVTPJKybDUF9/H
         T4lQ==
X-Gm-Message-State: AOAM531f52/5TTM+1uR+ScP9PqEae9XQJ5OLlBdeNm76b2tAEa8i0gST
        mf9hFgLAZUD0Q/h8J6LzoHEmKA==
X-Google-Smtp-Source: ABdhPJzfdp/vaVS0qHAFhLrfUNDtcvDUmpdqVxuF0Szt24Yy8egw0kxuXYTnTriaRjIGjP9HXNNxVQ==
X-Received: by 2002:a63:2c3:0:b0:3f4:e639:fec9 with SMTP id 186-20020a6302c3000000b003f4e639fec9mr13867862pgc.478.1653166000007;
        Sat, 21 May 2022 13:46:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g1-20020a62f941000000b0051853e6617fsm4057808pfm.89.2022.05.21.13.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:46:39 -0700 (PDT)
Date:   Sat, 21 May 2022 13:46:39 -0700 (PDT)
X-Google-Original-Date: Sat, 21 May 2022 11:33:09 PDT (-0700)
Subject:     Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with .aqrl annotation
In-Reply-To: <20220505035526.2974382-6-guoren@kernel.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        mark.rutland@arm.com, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Daniel Lustig <dlustig@nvidia.com>, parri.andrea@gmail.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org, parri.andrea@gmail.com
Message-ID: <mhng-7ebff936-b0d8-4f65-bd51-46bcd7e0d5c8@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 04 May 2022 20:55:26 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current implementation is the same with 8e86f0b409a4
> ("arm64: atomics: fix use of acquire + release for full barrier
> semantics"). RISC-V could combine acquire and release into the SC
> instructions and it could reduce a fence instruction to gain better
> performance. Here is related descriptio from RISC-V ISA 10.2
> Load-Reserved/Store-Conditional Instructions:
>
>  - .aq:   The LR/SC sequence can be given acquire semantics by
>           setting the aq bit on the LR instruction.
>  - .rl:   The LR/SC sequence can be given release semantics by
>           setting the rl bit on the SC instruction.
>  - .aqrl: Setting the aq bit on the LR instruction, and setting
>           both the aq and the rl bit on the SC instruction makes
>           the LR/SC sequence sequentially consistent, meaning that
>           it cannot be reordered with earlier or later memory
>           operations from the same hart.
>
>  Software should not set the rl bit on an LR instruction unless
>  the aq bit is also set, nor should software set the aq bit on an
>  SC instruction unless the rl bit is also set. LR.rl and SC.aq
>  instructions are not guaranteed to provide any stronger ordering
>  than those with both bits clear, but may result in lower
>  performance.
>
> The only difference is when sc.w/d.aqrl failed, it would cause .aq
> effect than before. But it's okay for sematic because overlap
> address LR couldn't beyond relating SC.

IIUC that's not accurate, or at least wasn't in 2018.  The ISA tends to 
drift around a bit, so it's possible things have changed since then.  
5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences") 
describes the issue more specifically, that's when we added these 
fences.  There have certainly been complains that these fences are too 
heavyweight for the HW to go fast, but IIUC it's the best option we have 
given the current set of memory model primitives we implement in the 
ISA (ie, there's more in RVWMO but no way to encode that).

The others all look good, though, and as these are really all 
independent cleanups I'm going to go ahead and put those three on 
for-next.

There's also a bunch of checkpatch errors.  The ones about "*" seem 
spurious, but the alignment ones aren't.  Here's my fixups:

    diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
    index 34f757dfc8f2..0bde499fa8bc 100644
    --- a/arch/riscv/include/asm/atomic.h
    +++ b/arch/riscv/include/asm/atomic.h
    @@ -86,9 +86,9 @@ ATOMIC_OPS(xor, xor,  i)
      * versions, while the logical ops only have fetch versions.
      */
     #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
    -					     atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,			\
    +					   atomic##prefix##_t *v)	\
     {									\
     	register c_type ret;						\
     	__asm__ __volatile__ (						\
    @@ -98,9 +98,9 @@ c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
     		: "memory");						\
     	return ret;							\
     }									\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,		\
    -					     atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_fetch_##op##_acquire(c_type i,			\
    +					   atomic##prefix##_t *v)	\
     {									\
     	register c_type ret;						\
     	__asm__ __volatile__ (						\
    @@ -110,9 +110,9 @@ c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,		\
     		: "memory");						\
     	return ret;							\
     }									\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,		\
    -					     atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_fetch_##op##_release(c_type i,			\
    +					   atomic##prefix##_t *v)	\
     {									\
     	register c_type ret;						\
     	__asm__ __volatile__ (						\
    @@ -122,8 +122,8 @@ c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,		\
     		: "memory");						\
     	return ret;							\
     }									\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
     {									\
     	register c_type ret;						\
     	__asm__ __volatile__ (						\
    @@ -135,28 +135,28 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
     }
    
     #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,		\
    -					      atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_##op##_return_relaxed(c_type i,			\
    +					    atomic##prefix##_t *v)	\
     {									\
    -        return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
    +	return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
     }									\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_##op##_return_acquire(c_type i,		\
    -					      atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_##op##_return_acquire(c_type i,			\
    +					    atomic##prefix##_t *v)	\
     {									\
    -        return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;	\
    +	return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;	\
     }									\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_##op##_return_release(c_type i,		\
    -					      atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_##op##_return_release(c_type i,			\
    +					    atomic##prefix##_t *v)	\
     {									\
    -        return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;	\
    +	return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;	\
     }									\
    -static __always_inline							\
    -c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
    +static __always_inline c_type						\
    +arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
     {									\
    -        return arch_atomic##prefix##_fetch_##op(i, v) c_op I;		\
    +	return arch_atomic##prefix##_fetch_##op(i, v) c_op I;		\
     }
    
     #ifdef CONFIG_GENERIC_ATOMIC64


>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Dan Lustig <dlustig@nvidia.com>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/riscv/include/asm/atomic.h  | 24 ++++++++----------------
>  arch/riscv/include/asm/cmpxchg.h |  6 ++----
>  2 files changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 34f757dfc8f2..aef8aa9ac4f4 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -269,9 +269,8 @@ static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int
>  		"0:	lr.w     %[p],  %[c]\n"
>  		"	beq      %[p],  %[u], 1f\n"
>  		"	add      %[rc], %[p], %[a]\n"
> -		"	sc.w.rl  %[rc], %[rc], %[c]\n"
> +		"	sc.w.aqrl  %[rc], %[rc], %[c]\n"
>  		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		: [a]"r" (a), [u]"r" (u)
> @@ -290,9 +289,8 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
>  		"0:	lr.d     %[p],  %[c]\n"
>  		"	beq      %[p],  %[u], 1f\n"
>  		"	add      %[rc], %[p], %[a]\n"
> -		"	sc.d.rl  %[rc], %[rc], %[c]\n"
> +		"	sc.d.aqrl  %[rc], %[rc], %[c]\n"
>  		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		: [a]"r" (a), [u]"r" (u)
> @@ -382,9 +380,8 @@ static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
>  		"0:	lr.w      %[p],  %[c]\n"
>  		"	bltz      %[p],  1f\n"
>  		"	addi      %[rc], %[p], 1\n"
> -		"	sc.w.rl   %[rc], %[rc], %[c]\n"
> +		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
>  		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		:
> @@ -402,9 +399,8 @@ static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
>  		"0:	lr.w      %[p],  %[c]\n"
>  		"	bgtz      %[p],  1f\n"
>  		"	addi      %[rc], %[p], -1\n"
> -		"	sc.w.rl   %[rc], %[rc], %[c]\n"
> +		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
>  		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		:
> @@ -422,9 +418,8 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
>  		"0:	lr.w     %[p],  %[c]\n"
>  		"	addi     %[rc], %[p], -1\n"
>  		"	bltz     %[rc], 1f\n"
> -		"	sc.w.rl  %[rc], %[rc], %[c]\n"
> +		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
>  		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		:
> @@ -444,9 +439,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
>  		"0:	lr.d      %[p],  %[c]\n"
>  		"	bltz      %[p],  1f\n"
>  		"	addi      %[rc], %[p], 1\n"
> -		"	sc.d.rl   %[rc], %[rc], %[c]\n"
> +		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
>  		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		:
> @@ -465,9 +459,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
>  		"0:	lr.d      %[p],  %[c]\n"
>  		"	bgtz      %[p],  1f\n"
>  		"	addi      %[rc], %[p], -1\n"
> -		"	sc.d.rl   %[rc], %[rc], %[c]\n"
> +		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
>  		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		:
> @@ -486,9 +479,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
>  		"0:	lr.d     %[p],  %[c]\n"
>  		"	addi      %[rc], %[p], -1\n"
>  		"	bltz     %[rc], 1f\n"
> -		"	sc.d.rl  %[rc], %[rc], %[c]\n"
> +		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
>  		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		:
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 1af8db92250b..9269fceb86e0 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -307,9 +307,8 @@
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\
>  			"	bne  %0, %z3, 1f\n"			\
> -			"	sc.w.rl %1, %z4, %2\n"			\
> +			"	sc.w.aqrl %1, %z4, %2\n"		\
>  			"	bnez %1, 0b\n"				\
> -			"	fence rw, rw\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
>  			: "rJ" ((long)__old), "rJ" (__new)		\
> @@ -319,9 +318,8 @@
>  		__asm__ __volatile__ (					\
>  			"0:	lr.d %0, %2\n"				\
>  			"	bne %0, %z3, 1f\n"			\
> -			"	sc.d.rl %1, %z4, %2\n"			\
> +			"	sc.d.aqrl %1, %z4, %2\n"		\
>  			"	bnez %1, 0b\n"				\
> -			"	fence rw, rw\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
>  			: "rJ" (__old), "rJ" (__new)			\
