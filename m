Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2136E19BD15
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgDBHwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 03:52:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbgDBHwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 03:52:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so1471461pgm.8
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDhcDFzxnB0LzwhhhavzuQofpQqoxKbtsiZ2UHnUGxU=;
        b=A6ZJzATVZMdYm6aYjzbAsFnbVu+/ukE/HUOrWoX6wNSXH7TjId503hbalZIcER3qhr
         Y5qB/1CFmXiQvAttlkjKxpgOTqSerdCjb/TPzMe6QvKL8r5gTbbRJSL4V6e2L7JhAA5B
         DOCsSudHTl/uKCgBkojQz+0LCaSqXe0yQNm4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDhcDFzxnB0LzwhhhavzuQofpQqoxKbtsiZ2UHnUGxU=;
        b=hcYKcxgrNNAkl7mAn9+BSpXWraXSX8tvotbIT8IegVxfec5zGbpW9BT8s9BpHxP6//
         O472T+MS4lYLaetDCgu7wxQ4vXc8r3yl69TKc3Hf+t07wzEYLaW5ZUAVNLT03RMxtNqi
         IJptL1HRE+vHNqIncYz3RXywPfZtOqLnS/Y8LaDDo/WL1UjXD6KLkmhuHEV8DUPmHmcL
         2xOZ5aeAXT6Bbh5x1f0Tt5nAlJjhBpS9qm5BMi+KRhoswuPtArOJTEGKXR6J+C3yRzlU
         kPs47kpF1XWdE5SXYJikPGfXMkRnVMqypL/F11WV7y5Z4tWY028l4XqfpoN4ieGtyI7W
         cVZA==
X-Gm-Message-State: AGi0PubywIH+EUp8S3NRCmGSFFIMJUx/BA77jY1pUEubSxrS8xSi89wJ
        o1w8Pw+qd2lya+TIhf+Ko7ZKqw==
X-Google-Smtp-Source: APiQypKB4nOuEy27sAy36sblXB+uB0SHnxgxvV5A0l19f7PmP5vbDtzIT9/IOshcLycLAXLiPPMwyg==
X-Received: by 2002:a63:8c13:: with SMTP id m19mr2113657pgd.44.1585813937373;
        Thu, 02 Apr 2020 00:52:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm3216861pje.19.2020.04.02.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:52:16 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:52:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 3/4] drm/i915/gem: Replace user_access_begin by
 user_write_access_begin
Message-ID: <202004020051.649C6B8@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <6da6fa391c0d6344cc9ff99a69fcaa65666f3947.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da6fa391c0d6344cc9ff99a69fcaa65666f3947.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:18AM +0000, Christophe Leroy wrote:
> When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
> that's only to perform unsafe_put_user() so use
> user_write_access_begin() in order to only open write access.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Why is this split from the other conversions?

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 7643a30ba4cd..4be8205a70b6 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1611,14 +1611,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  		 * happened we would make the mistake of assuming that the
>  		 * relocations were valid.
>  		 */
> -		if (!user_access_begin(urelocs, size))
> +		if (!user_write_access_begin(urelocs, size))
>  			goto end;
>  
>  		for (copied = 0; copied < nreloc; copied++)
>  			unsafe_put_user(-1,
>  					&urelocs[copied].presumed_offset,
>  					end_user);
> -		user_access_end();
> +		user_write_access_end();
>  
>  		eb->exec[i].relocs_ptr = (uintptr_t)relocs;
>  	}
> @@ -1626,7 +1626,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  	return 0;
>  
>  end_user:
> -	user_access_end();
> +	user_write_access_end();
>  end:
>  	kvfree(relocs);
>  	err = -EFAULT;
> @@ -2991,7 +2991,8 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>  		 * And this range already got effectively checked earlier
>  		 * when we did the "copy_from_user()" above.
>  		 */
> -		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
> +		if (!user_write_access_begin(user_exec_list,
> +					     count * sizeof(*user_exec_list)))
>  			goto end;
>  
>  		for (i = 0; i < args->buffer_count; i++) {
> @@ -3005,7 +3006,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>  					end_user);
>  		}
>  end_user:
> -		user_access_end();
> +		user_write_access_end();
>  end:;
>  	}
>  
> -- 
> 2.25.0
> 

-- 
Kees Cook
