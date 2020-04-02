Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61A19BD19
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgDBHws (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 03:52:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37457 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387652AbgDBHwr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 03:52:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id r4so8776pgg.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wMJKmTTsK/J+IkhN0DYHwWD+qI/x4I12UK39qAaI4hw=;
        b=JVhBgOBNj/ogaZ6plMcURom9R/4s6tKRMUcMQabcCnJ/9rsQpv5Ie069+tPiB7QCI1
         Y0ppqs59FxVwUEe6y3sIhTHE62x5W9Xl/nk7kcjX05pnj4FSI2lsKBg9mK+ANa2M9tUH
         DOK61ctwVrS0KCqZqrJM+wHmAX4j0XrVJ+eSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMJKmTTsK/J+IkhN0DYHwWD+qI/x4I12UK39qAaI4hw=;
        b=UHlOnwQgLUDvxsxVHRAvvrEm2nzaZB30sb9wqxQEvug6pH2FzVyTmYq9V9cHptHPfH
         eljU+BUUYjlHPzKOxrvWRL36J4cHPv6muQ22KELGrBY/LIkWReIm77omT87r54qPKIr6
         wm8B7t12s7VacrZUbxpocpo9xfB6rCmIcAJ/CYiybSepyi0azRQ44niKyuJrjMFGUncZ
         +vppf3AGITDf3XsVH6snivSCunxkm/s1bT7aJgP1x7pCtqj5fDA0QyvUmWCZuStsWcd6
         +db32x4D5M6GhQs1ZSyVfuOfc04j2zBgyTGgnGgjEztzWBnokenoz2i9gesid4z+29xI
         kgbg==
X-Gm-Message-State: AGi0PubOiUI3TZ57Dyc8Iew1rpcIQWJMO9zgdzuFqC8NuhrBt+Z8E9XT
        M9rotULKHwgaeLyY0nx7CFDWhw==
X-Google-Smtp-Source: APiQypLxyScrMFlGEbqcPJce1oUPxqcVt+1SraiQF0IBuOLbROJ84rjl6KmSAQXSXKHNuRXpGB/I/Q==
X-Received: by 2002:a63:c212:: with SMTP id b18mr2109019pgd.92.1585813964449;
        Thu, 02 Apr 2020 00:52:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q91sm3157033pjb.11.2020.04.02.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:52:43 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:52:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 4/4] powerpc/uaccess: Implement
 user_read_access_begin and user_write_access_begin
Message-ID: <202004020052.47DB88E3C@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <ebcf8256e02a7dffb292f3d800e264dce263cac5.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcf8256e02a7dffb292f3d800e264dce263cac5.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:19AM +0000, Christophe Leroy wrote:
> Add support for selective read or write user access with
> user_read_access_begin/end and user_write_access_begin/end.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/include/asm/book3s/32/kup.h |  4 ++--
>  arch/powerpc/include/asm/kup.h           | 14 +++++++++++++-
>  arch/powerpc/include/asm/uaccess.h       | 22 ++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
> index 3c0ba22dc360..1617e73bee30 100644
> --- a/arch/powerpc/include/asm/book3s/32/kup.h
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -108,7 +108,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
>  	u32 addr, end;
>  
>  	BUILD_BUG_ON(!__builtin_constant_p(dir));
> -	BUILD_BUG_ON(dir == KUAP_CURRENT);
> +	BUILD_BUG_ON(dir & ~KUAP_READ_WRITE);
>  
>  	if (!(dir & KUAP_WRITE))
>  		return;
> @@ -131,7 +131,7 @@ static __always_inline void prevent_user_access(void __user *to, const void __us
>  
>  	BUILD_BUG_ON(!__builtin_constant_p(dir));
>  
> -	if (dir == KUAP_CURRENT) {
> +	if (dir & KUAP_CURRENT_WRITE) {
>  		u32 kuap = current->thread.kuap;
>  
>  		if (unlikely(!kuap))
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
> index 92bcd1a26d73..c745ee41ad66 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -10,7 +10,9 @@
>   * Use the current saved situation instead of the to/from/size params.
>   * Used on book3s/32
>   */
> -#define KUAP_CURRENT	4
> +#define KUAP_CURRENT_READ	4
> +#define KUAP_CURRENT_WRITE	8
> +#define KUAP_CURRENT		(KUAP_CURRENT_READ | KUAP_CURRENT_WRITE)
>  
>  #ifdef CONFIG_PPC64
>  #include <asm/book3s/64/kup-radix.h>
> @@ -101,6 +103,16 @@ static inline void prevent_current_access_user(void)
>  	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
>  }
>  
> +static inline void prevent_current_read_from_user(void)
> +{
> +	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
> +}
> +
> +static inline void prevent_current_write_to_user(void)
> +{
> +	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
> +}
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_KUAP_H_ */
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 2f500debae21..4427d419eb1d 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -468,6 +468,28 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
>  #define user_access_save	prevent_user_access_return
>  #define user_access_restore	restore_user_access
>  
> +static __must_check inline bool
> +user_read_access_begin(const void __user *ptr, size_t len)
> +{
> +	if (unlikely(!access_ok(ptr, len)))
> +		return false;
> +	allow_read_from_user(ptr, len);
> +	return true;
> +}
> +#define user_read_access_begin	user_read_access_begin
> +#define user_read_access_end		prevent_current_read_from_user
> +
> +static __must_check inline bool
> +user_write_access_begin(const void __user *ptr, size_t len)
> +{
> +	if (unlikely(!access_ok(ptr, len)))
> +		return false;
> +	allow_write_to_user((void __user *)ptr, len);
> +	return true;
> +}
> +#define user_write_access_begin	user_write_access_begin
> +#define user_write_access_end		prevent_current_write_to_user
> +
>  #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
>  #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
>  #define unsafe_put_user(x, p, e) unsafe_op_wrap(__put_user_allowed(x, p), e)
> -- 
> 2.25.0
> 

-- 
Kees Cook
