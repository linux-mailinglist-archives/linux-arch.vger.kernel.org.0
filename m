Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B849299CE8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 01:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411309AbgJ0AC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 20:02:27 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43477 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgJ0ACY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 20:02:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id r21so3428151uaw.10;
        Mon, 26 Oct 2020 17:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nc+LJIctkA2xokS8Hjft6K+F5HViXFmcJYECMK/0XSs=;
        b=OQJ8kzN4C8CFDTkcCh2rA49sg4uUmOh9V4Korw02JjNdE/cPq08xUFfaA8odbE+NMx
         tRuUn5bIJqDfUkoI3z6x+FzIJoAMUxD9EnTX14oCiLAOiNKLVKDrAqpUm+BzPy81a6+7
         JrCM3k/4L21kBlJ+Ybi2JVcDhV/jf5E/xcCblqNXsd00EN2Ak1SKFD1Xf/YHPPdTKhfF
         8zInTDMN9D9Ukek5LjPXoz88wj3NbBEFTAB4vedi9S9pAxvgaYqqIwdzOQ1mu6nYRY+H
         edvEBa09ronjKBMHU9qkZ7fAMFaFksVZ4X5YzHa4acETkIVPuN5JNpqdONe+rFBKZkhh
         wgKg==
X-Gm-Message-State: AOAM5332Vyl6zd4zjaSQU53d0ayl0EBE6mwc6NA2aBPjtFEkkSIFbHoy
        97JGltuXyqKGyPHyCMQwDCA=
X-Google-Smtp-Source: ABdhPJy/QDAFsVqgKvAb81ohx+BGy1Y+c+QXCmSihcIl83n+0T4UvXBmk0bLcBPHg/LfD5io82Dx1g==
X-Received: by 2002:ab0:6f81:: with SMTP id f1mr23600098uav.31.1603756943628;
        Mon, 26 Oct 2020 17:02:23 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id f195sm374846vka.21.2020.10.26.17.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 17:02:22 -0700 (PDT)
Date:   Tue, 27 Oct 2020 00:02:21 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: percpu: avoid Wshadow warning
Message-ID: <20201027000221.GA3804841@google.com>
References: <20201026155353.3702892-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026155353.3702892-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Mon, Oct 26, 2020 at 04:53:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Nesting macros that use the same local variable names causes
> warnings when building with "make W=2":
> 
> include/asm-generic/percpu.h:117:14: warning: declaration of '__ret' shadows a previous local [-Wshadow]
> include/asm-generic/percpu.h:126:14: warning: declaration of '__ret' shadows a previous local [-Wshadow]
> 
> These are fairly harmless, but since the warning comes from
> a global header, the warning happens every time the headers
> are included, which is fairly annoying.
> 
> Rename the variables to avoid shadowing and shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/percpu.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
> index 35e4a53b83e6..6432a7fade91 100644
> --- a/include/asm-generic/percpu.h
> +++ b/include/asm-generic/percpu.h
> @@ -114,21 +114,21 @@ do {									\
>  
>  #define __this_cpu_generic_read_nopreempt(pcp)				\
>  ({									\
> -	typeof(pcp) __ret;						\
> +	typeof(pcp) ___ret;						\
>  	preempt_disable_notrace();					\
> -	__ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
> +	___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
>  	preempt_enable_notrace();					\
> -	__ret;								\
> +	___ret;								\
>  })
>  
>  #define __this_cpu_generic_read_noirq(pcp)				\
>  ({									\
> -	typeof(pcp) __ret;						\
> -	unsigned long __flags;						\
> -	raw_local_irq_save(__flags);					\
> -	__ret = raw_cpu_generic_read(pcp);				\
> -	raw_local_irq_restore(__flags);					\
> -	__ret;								\
> +	typeof(pcp) ___ret;						\
> +	unsigned long ___flags;						\
> +	raw_local_irq_save(___flags);					\
> +	___ret = raw_cpu_generic_read(pcp);				\
> +	raw_local_irq_restore(___flags);				\
> +	___ret;								\
>  })
>  
>  #define this_cpu_generic_read(pcp)					\
> -- 
> 2.27.0
> 

I've applied this to percpu#for-5.10-fixes.

Thanks,
Dennis
