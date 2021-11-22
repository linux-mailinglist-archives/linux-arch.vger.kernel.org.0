Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC445936F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Nov 2021 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhKVQyZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Nov 2021 11:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbhKVQyZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Nov 2021 11:54:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44208C061574;
        Mon, 22 Nov 2021 08:51:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d27so33942616wrb.6;
        Mon, 22 Nov 2021 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=APE9ce1oamnPdQjXEcMukuKqcJOxL3i0qU2D/3ee32Y=;
        b=VZFBq1ErQERStcDQb/RfavsYGCXwgxmYoWSKcpcMPPSv1L6iDHUHXmjGL+ALaUajIc
         zyvnV0494M2isgnA1IWQ9p4TpjnufkRB4TnCGAevuvWuJxZOvBxvvZF0DodYXM9AvYlE
         mA05DPwpbdtyTjgGzBD/ky5Sct5ZRUlfUAsMLrETcxnP535JdTB5b9z+1HpKo1kssz/m
         xJ/ulE3KEjLbvZxiGiwdvpNv6Osz9elXtH65e9NAdsGhs5wy8n+32WDqj34AI5jhLrzI
         Rpt+Hkz/TNi4NpVugyCsu5f0ASPSqIjigtHEYEypxxGKRLIrnwpDXVMKd/u+WaV1i6X0
         NCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=APE9ce1oamnPdQjXEcMukuKqcJOxL3i0qU2D/3ee32Y=;
        b=ixe8n45EFEVqxKO8k8bsLcWe38JU3WfjsymlepjgyVXd9CzlT2g1gTKXbOUO79oNJ0
         OHjTMLr2wWAR2n+pJIl0O1W4gr5e6yjKB0C1KPViXFBZEfhtkpVd0D+sb0lOWeMQTaWj
         2PzYKQSZNiBAlgZ1QoaQK9+ToGkK5feKGd58FWQ4nZVaLGqRzxuI0uLVDoROQVzEHNrB
         RDpXhKJrBgRLPRNnRDlXthDo3lyF7P8xHaqqeH3YO7OPJ3z52DrpFl6ydgazpiCiGIb+
         4ZFfMcrNYezI+VU2dF0D9EvYWfA//37kNROJymwRo3F4xMQ7iA+cm52ngq9Kj3FwoQhS
         5dew==
X-Gm-Message-State: AOAM532jl6ajYKTzukI+ZlLIcOqCr9wb0DfSGzr2Avm+BuCl4DYyzFNF
        FRWjn/NWx/S8LK7/4wPWQSsUplz7i+y+3Q==
X-Google-Smtp-Source: ABdhPJwiCdHnVEJcvSR3PYQyyVUEvELVqDkgOhTYvCGt/mA5mTfb+wjYeTcjhlkJLajz8I2ECfSaLg==
X-Received: by 2002:a05:6000:1a88:: with SMTP id f8mr39590723wry.54.1637599876815;
        Mon, 22 Nov 2021 08:51:16 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id o25sm10501981wms.17.2021.11.22.08.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 08:51:16 -0800 (PST)
Message-ID: <8dfbe1be-0b4d-cdda-2c71-7a098faf07da@gmail.com>
Date:   Mon, 22 Nov 2021 17:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Reply-To: alx.manpages@gmail.com
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Language: en-US
To:     Cyril Hrubis <chrubis@suse.cz>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, ltp@lists.linux.it
References: <YZvIlz7J6vOEY+Xu@yuki>
From:   "Alejandro Colomar (mailing lists)" <alx.mailinglists@gmail.com>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Cyril,

On 11/22/21 17:43, Cyril Hrubis wrote:
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.
> 
> This allows us to use the kernel structure definitions in userspace. For
> example we can use PRIu64 and PRId64 modifiers in printf() to print
> structure members. Morever with this there would be no need to redefine
> these structures in libc implementations as it is done now.
> 
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
> 
> 	printf("%" PRIu64 "\n", stx.stx_size);
> 
> We get:
> 
> 	warning: format '%lu' expects argument of type 'long unsigned int',
> 	         but argument 5 has type '__u64' {aka 'long long unsigned int'}
> 
> After this patch the types match and no warnings are generated.
This would make it even easier to ignore the existence of different 
kernel types, and let userspace use standard types.

Related recent discussion:
<https://lore.kernel.org/linux-man/20210423230609.13519-1-alx.manpages@gmail.com/>

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Acked-by: Alejandro Colomar <alx.manpages@gmail.com>

Thanks,
Alex

> ---
>   include/uapi/asm-generic/types.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
> index dfaa50d99d8f..ae748a3678a4 100644
> --- a/include/uapi/asm-generic/types.h
> +++ b/include/uapi/asm-generic/types.h
> @@ -1,9 +1,16 @@
>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>   #ifndef _ASM_GENERIC_TYPES_H
>   #define _ASM_GENERIC_TYPES_H
> +
> +#include <asm/bitsperlong.h>
> +
>   /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
>    */
> -#include <asm-generic/int-ll64.h>
> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)

BTW, C2X adds LONG_WIDTH in <limits.h> (and in general TYPE_WIDTH) to 
get the bits of a long.

> +# include <asm-generic/int-l64.h>
> +#else
> +# include <asm-generic/int-ll64.h>
> +#endif
>   
>   #endif /* _ASM_GENERIC_TYPES_H */
> 
