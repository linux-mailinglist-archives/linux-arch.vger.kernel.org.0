Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C9355E23
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbhDFVr1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 17:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbhDFVrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 17:47:24 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B04C06174A;
        Tue,  6 Apr 2021 14:47:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso16093056otq.3;
        Tue, 06 Apr 2021 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aJiBwTpZjE7QhEBloyE2+TbCO+3vc2O0H0G9BLE7cIQ=;
        b=otSc53xnoioIufF2kLcwnpRxJC7Q9UjbUtjqKcQkCUg3wI4dxUmLvYYQl0+/ae3L46
         kq3zeSGbXz+aGoVjeezNXfHXvG6c3PD96uIKHpYfiqQN3UleakqTaVpxuahE8G/eV/Qu
         vvZSM6dnMGboL7B6rQZNqfwFCPCuSHKbD1QSxOZY0PEGguilzbEeXZ4vTYaPn9QSX3MD
         v9T9tbz/Tidcy0ZXfnM2LF4siKgS9/okxDOf8v5QhgS/FXSqMDDDLrtFN7nlPkkVwnAU
         g/Wg+XRJetpbCfPl5FSXQBy7tMAeyJGX+EVhZZYi6kVbsDcbnggHiuK6yioVRAKn2NDz
         yqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=aJiBwTpZjE7QhEBloyE2+TbCO+3vc2O0H0G9BLE7cIQ=;
        b=XxlW5p3LBnD/a0Dq7LXusPOHoPiCFSsJKfaUTaSIAolQ3tzptmNxx3bk16FWbB3E/S
         JIjA9n57Ewn4sPL1dFhK40v7wedyBsOlJS2vQPMJALKAzkq+RdJmqtgKi82hFHXWZpgD
         6I+bGjR/Si1Vg6Rxk1b16422l7eB/f883XLUMvku/qPjtpLjCOO/PCa3mlROdGkMSJuI
         we1k/B5er2VCu4XAM9cFtGZB+UulUskUqQ+AmwJ9mz+i2bwOJx9qRqNC3TC+g8SPQceP
         Sid26bH0cQQHX/YRtEn+VqnIGKqci5g47ugk/WuHE4FT2gyynaTOfmhC6nm2Miti31rP
         ijWg==
X-Gm-Message-State: AOAM533psRYsIQUycUk1aNbrcpXgJ2/pjCAPQY2/kP8EMNf2hIrdyBN4
        HyEBTDlf/ZZjWZQGkzq3d1w=
X-Google-Smtp-Source: ABdhPJwudEr9DsPWLB6IxPyLB/LbwGssz53UrSkpaViooZbxMR5kZJssPcfMAtYdaUmzB+B804KpZg==
X-Received: by 2002:a9d:3c2:: with SMTP id f60mr147833otf.220.1617745635089;
        Tue, 06 Apr 2021 14:47:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2sm5089350ote.47.2021.04.06.14.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 14:47:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Apr 2021 14:47:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] h8300: rearrange headers inclusion order in asm/bitops
Message-ID: <20210406214713.GA75728@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 06, 2021 at 11:36:25AM -0700, Yury Norov wrote:
> The commit a5145bdad3ff ("arch: rearrange headers inclusion order in
> asm/bitops for m68k and sh") on next-20210401 fixed header ordering issue.
> h8300 has similar problem, which was overlooked by me.
> 
> h8300 includes bitmap/{find,le}.h prior to ffs/fls headers. New fast-path
> implementation in find.h requires ffs/fls. Reordering the headers inclusion
> sequence helps to prevent compile-time implicit function declaration error.
> 
> v2: change wording in the comment.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  arch/h8300/include/asm/bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
> index 7aa16c732aa9..c867a80cab5b 100644
> --- a/arch/h8300/include/asm/bitops.h
> +++ b/arch/h8300/include/asm/bitops.h
> @@ -9,6 +9,10 @@
>  
>  #include <linux/compiler.h>
>  
> +#include <asm-generic/bitops/fls.h>
> +#include <asm-generic/bitops/__fls.h>
> +#include <asm-generic/bitops/fls64.h>
> +
>  #ifdef __KERNEL__
>  
>  #ifndef _LINUX_BITOPS_H
> @@ -173,8 +177,4 @@ static inline unsigned long __ffs(unsigned long word)
>  
>  #endif /* __KERNEL__ */
>  
> -#include <asm-generic/bitops/fls.h>
> -#include <asm-generic/bitops/__fls.h>
> -#include <asm-generic/bitops/fls64.h>
> -
>  #endif /* _H8300_BITOPS_H */
> -- 
> 2.25.1
> 
