Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877FD43673E
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJUQIR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUQIQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:08:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8C8C061348
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:06:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t184so727888pgd.8
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yWeHzUERSXKWqA9vu4MK2Mcg7GEbRrkufGusTDoj7oU=;
        b=aw2Ky+2egFUz7ZwBeA25xgiRYb//Eb4WxZHMvdz1Nhm8VJ+9UsfBahokgFKu0WTXRU
         ioS13HknU+hohn/GoeXFlJNxlW+yceAH6Z5l8VaV/35rVXloZOWpSgbkhodtvTYwnjhZ
         6NPoJB89XM7KdnSSzIGPn6iUMVZ0Bx4vWzlXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yWeHzUERSXKWqA9vu4MK2Mcg7GEbRrkufGusTDoj7oU=;
        b=LUQZABlYgbGNceFYSHdFrUQ6p1m//o0D6YihRtAiZDyM3+m0v5oIu/L5xxUHzSl8Z1
         IwEBKIBz2sC32dac3XFhrpLWZUakz69jkOb0PUi4U6QviVuo4lM7yQL19r58SXgSY39N
         aXKCO+IwLoVb+V0gMctZEgniA/TmX+XHNBgP0Ny2V1Nf4TqNQ8FcVmYd4x3XKNPy1mHE
         xt5eXgnY8b+wW+jqmGAM29rdcKilbbwbIlNb1PeCQW4diSeaXnTV/LWzfGo8o76KsJLK
         ytZlTEv+6ogsGFH/pz3LoydDCny9O6gWfpWCXczc5E89FuW09+neVCgEpYqHhPR4CiPo
         93+g==
X-Gm-Message-State: AOAM531ulw/Ei25zRPW2ftLGWIoj0+fXHmiUhN9tVg9Ss+v5xs7+kqf7
        mJHmSyaL9p9c0E4vbOEilM50mg==
X-Google-Smtp-Source: ABdhPJzwqmxec2zFyF/Psq8CluHSGbMOo9olg3yQlsJua+g98ACLLulSEqWyS3fABzGs26mqKe+fFg==
X-Received: by 2002:a05:6a00:2311:b0:431:c19f:2a93 with SMTP id h17-20020a056a00231100b00431c19f2a93mr6532217pfh.11.1634832359599;
        Thu, 21 Oct 2021 09:05:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13sm7569916pfk.175.2021.10.21.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:05:59 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:05:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH 04/20] signal/sparc32: Remove unreachable do_exit in
 do_sparc_fault
Message-ID: <202110210905.8CA101674@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-4-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:50PM -0500, Eric W. Biederman wrote:
> The call to do_exit in do_sparc_fault immediately follows a call to
> unhandled_fault.  The function unhandled_fault never returns.  This
> means the call to do_exit can never be reached.

Same thought: replace with unreachable() just to make this more
self-documenting? Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Cc: David Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Fixes: 2.3.41
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/sparc/mm/fault_32.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index fa858626b85b..90dc4ae315c8 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -248,7 +248,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
>  	}
>  
>  	unhandled_fault(address, tsk, regs);
> -	do_exit(SIGKILL);
>  
>  /*
>   * We ran out of memory, or some other thing happened to us that made
> -- 
> 2.20.1
> 

-- 
Kees Cook
