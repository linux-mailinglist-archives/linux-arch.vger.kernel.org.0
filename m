Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E55262693
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 06:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgIIE75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 00:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgIIE71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 00:59:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E925C061756
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 21:59:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so1058737pfg.13
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/CFjqhupI1AWKqg+mCbgMP9R+W6vd0H8IsBhpy0/FFY=;
        b=hpg4QcQyAdlz4HPaeo1/zixNDr+qZlp7W1wiXTwWOYJ/GWcLojwWm0o9fbPsFjukK9
         2LKyXGPlUU1c8pEOjV/nFFboLir8U07CRMECpMSSX4NodajoEO5/g2YUnEdaUOliam3v
         x3A/YIoz3tB3O2UOgr2XwxOPgtcNU/pjXer6Nvjw/A4SmYd3kuVE2yhD1obX3twpm0ZJ
         uY8gePDhzkbYs2xr3tSi0I50LXoRUBZy62iivUyn1MDOazCVhaC0q5853njaJ5h6HPDo
         vFAMxiLoka/mwDjY4FpgeA2C3f1ROVcjIJ6bOqoC3xU+j3/VplUtfN7ZTq74wSoUoqgm
         nYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/CFjqhupI1AWKqg+mCbgMP9R+W6vd0H8IsBhpy0/FFY=;
        b=rIiBFWLnT6ozBL94fx/c0ty/fQlq4AReZYg10eFyInMbJeNl6b3IYh3Ud4KAZajx8R
         FTrJ66r7sRB2mkz3+hI1Nf6XKlYQ1Sy50hdhOxdeDYCubikUCtDMoI+pUEuQiRYj5BVO
         Oeo4U+7vz97Mw1JQpQkRqQJpIZeuHm5iid4bRSCbgvInC0m9iTL/HprqWhKaGhxOmZZ0
         Xn+Z4D/TioKrJo9UYj8OPnStJ9GBk4NlDRehCbF8iHJ1ZNw6GAY6BDXDJWtwfE8rbtJA
         gHGcu3USJMimen5Vfd69oh/0gNFJ33sbxIkiLQcm5QgD1Fcr+iBdZxoF0fSimZfyQLs6
         wjbw==
X-Gm-Message-State: AOAM533ogBY462VAjMuw5zYi2vThUusE8pt6SxUbhJaevEEYVWGUpcHz
        4B7Jj3W8EOXTnu5SJX/202i5aQ==
X-Google-Smtp-Source: ABdhPJwy3yBcV7Uv8j6LpvPP4ltOvLLGG22xDuMaz75P6SEw83qpXJZok8u89m0LxFNrXKeBbGOOHw==
X-Received: by 2002:a62:1bc2:: with SMTP id b185mr2014599pfb.75.1599627566376;
        Tue, 08 Sep 2020 21:59:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z18sm1034026pfn.186.2020.09.08.21.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:59:25 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:59:25 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:43:09 PDT (-0700)
Subject:     Re: [PATCH 6/8] riscv: refactor __get_user and __put_user
In-Reply-To: <20200907055825.1917151-7-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-e4978c15-9e83-4621-a9e6-76a550f6dcda@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 06 Sep 2020 22:58:23 PDT (-0700), Christoph Hellwig wrote:
> Add new __get_user_nocheck and __put_user_nocheck that switch on the size
> and call the actual inline assembly helpers, and move the uaccess enable
> / disable into the actual __get_user and __put_user.  This prepares for
> natively implementing __get_kernel_nofault and __put_kernel_nofault.
>
> Also don't bother with the deprecated register keyword for the error
> return.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 94 ++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 42 deletions(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index e8eedf22e90747..b67d1c616ec348 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -107,7 +107,6 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
>  do {								\
>  	uintptr_t __tmp;					\
>  	__typeof__(x) __x;					\
> -	__enable_user_access();					\
>  	__asm__ __volatile__ (					\
>  		"1:\n"						\
>  		"	" insn " %1, %3\n"			\
> @@ -125,7 +124,6 @@ do {								\
>  		"	.previous"				\
>  		: "+r" (err), "=&r" (__x), "=r" (__tmp)		\
>  		: "m" (*(ptr)), "i" (-EFAULT));			\
> -	__disable_user_access();				\
>  	(x) = __x;						\
>  } while (0)
>
> @@ -138,7 +136,6 @@ do {								\
>  	u32 __user *__ptr = (u32 __user *)(ptr);		\
>  	u32 __lo, __hi;						\
>  	uintptr_t __tmp;					\
> -	__enable_user_access();					\
>  	__asm__ __volatile__ (					\
>  		"1:\n"						\
>  		"	lw %1, %4\n"				\
> @@ -162,12 +159,30 @@ do {								\
>  			"=r" (__tmp)				\
>  		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]),	\
>  			"i" (-EFAULT));				\
> -	__disable_user_access();				\
>  	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
>  		(((u64)__hi << 32) | __lo)));			\
>  } while (0)
>  #endif /* CONFIG_64BIT */
>
> +#define __get_user_nocheck(x, __gu_ptr, __gu_err)		\
> +do {								\
> +	switch (sizeof(*__gu_ptr)) {				\
> +	case 1:							\
> +		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
> +		break;						\
> +	case 2:							\
> +		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
> +		break;						\
> +	case 4:							\
> +		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
> +		break;						\
> +	case 8:							\
> +		__get_user_8((x), __gu_ptr, __gu_err);	\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +} while (0)
>
>  /**
>   * __get_user: - Get a simple variable from user space, with less checking.
> @@ -191,25 +206,15 @@ do {								\
>   */
>  #define __get_user(x, ptr)					\
>  ({								\
> -	register long __gu_err = 0;				\
>  	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
> +	long __gu_err = 0;					\
> +								\
>  	__chk_user_ptr(__gu_ptr);				\
> -	switch (sizeof(*__gu_ptr)) {				\
> -	case 1:							\
> -		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
> -		break;						\
> -	case 2:							\
> -		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
> -		break;						\
> -	case 4:							\
> -		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
> -		break;						\
> -	case 8:							\
> -		__get_user_8((x), __gu_ptr, __gu_err);	\
> -		break;						\
> -	default:						\
> -		BUILD_BUG();					\
> -	}							\
> +								\
> +	__enable_user_access();					\
> +	__get_user_nocheck(x, __gu_ptr, __gu_err);		\
> +	__disable_user_access();				\
> +								\
>  	__gu_err;						\
>  })
>
> @@ -243,7 +248,6 @@ do {								\
>  do {								\
>  	uintptr_t __tmp;					\
>  	__typeof__(*(ptr)) __x = x;				\
> -	__enable_user_access();					\
>  	__asm__ __volatile__ (					\
>  		"1:\n"						\
>  		"	" insn " %z3, %2\n"			\
> @@ -260,7 +264,6 @@ do {								\
>  		"	.previous"				\
>  		: "+r" (err), "=r" (__tmp), "=m" (*(ptr))	\
>  		: "rJ" (__x), "i" (-EFAULT));			\
> -	__disable_user_access();				\
>  } while (0)
>
>  #ifdef CONFIG_64BIT
> @@ -272,7 +275,6 @@ do {								\
>  	u32 __user *__ptr = (u32 __user *)(ptr);		\
>  	u64 __x = (__typeof__((x)-(x)))(x);			\
>  	uintptr_t __tmp;					\
> -	__enable_user_access();					\
>  	__asm__ __volatile__ (					\
>  		"1:\n"						\
>  		"	sw %z4, %2\n"				\
> @@ -294,10 +296,28 @@ do {								\
>  			"=m" (__ptr[__LSW]),			\
>  			"=m" (__ptr[__MSW])			\
>  		: "rJ" (__x), "rJ" (__x >> 32), "i" (-EFAULT));	\
> -	__disable_user_access();				\
>  } while (0)
>  #endif /* CONFIG_64BIT */
>
> +#define __put_user_nocheck(x, __gu_ptr, __pu_err)					\
> +do {								\
> +	switch (sizeof(*__gu_ptr)) {				\
> +	case 1:							\
> +		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
> +		break;						\
> +	case 2:							\
> +		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
> +		break;						\
> +	case 4:							\
> +		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
> +		break;						\
> +	case 8:							\
> +		__put_user_8((x), __gu_ptr, __pu_err);	\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +} while (0)
>
>  /**
>   * __put_user: - Write a simple value into user space, with less checking.
> @@ -320,25 +340,15 @@ do {								\
>   */
>  #define __put_user(x, ptr)					\
>  ({								\
> -	register long __pu_err = 0;				\
>  	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
> +	long __pu_err = 0;					\
> +								\
>  	__chk_user_ptr(__gu_ptr);				\
> -	switch (sizeof(*__gu_ptr)) {				\
> -	case 1:							\
> -		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
> -		break;						\
> -	case 2:							\
> -		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
> -		break;						\
> -	case 4:							\
> -		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
> -		break;						\
> -	case 8:							\
> -		__put_user_8((x), __gu_ptr, __pu_err);	\
> -		break;						\
> -	default:						\
> -		BUILD_BUG();					\
> -	}							\
> +								\
> +	__enable_user_access();					\
> +	__put_user_nocheck(x, __gu_ptr, __pu_err);		\
> +	__disable_user_access();				\
> +								\
>  	__pu_err;						\
>  })

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
