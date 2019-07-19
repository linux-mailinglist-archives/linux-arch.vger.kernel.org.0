Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256756E302
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGSI7t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 04:59:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGSI7t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 04:59:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so28259592wmj.5
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2019 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r+mZG8DpAsPgWT5sar/21/BjX4up+4WpKJWqDr5y+XE=;
        b=UovNcYRJpNCwUpWYyK80hMB+LmsasMk/b+zRnOMrEiqyWDbVXt28ZRGBCmPPcZUN0Q
         /7jz/DscGGQ7KK1NVhsYrrZmsyJ1wT1ynx4YUOcbWknTuTYIitiIhSJYSjfxO7NDoc6A
         cYTtdySKxzcVDcyjoGRWTNZh5axkeqLWNaFU3JH3CGLkOMa8TXXFqu/1bhPnrwEP690/
         j7DnqohaO9uqFP/XnDXVak9aGhsnxhZrKERoM4ZBlXxPF8LvDVS/mfZ+LZ+SnCvaDFOj
         OBJIhRPnkIjaY5vjk8XEn2AqEibXwCokadCTrFNtJLDod4kk6C3EMdkFR9PqkEePJCcG
         HoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+mZG8DpAsPgWT5sar/21/BjX4up+4WpKJWqDr5y+XE=;
        b=CgDRgqoHB6kIaRlGMfNSvSND2TvfGqthh8GGBnoLVqLMEOwPytxMJwMrpnkHH3wVEi
         k1AIMe94iidO8qoC2QM45pcaaXp62p5gHK6CM+na7/2tLcdvJoY8OPqif8Nqq89DFLd9
         6/vCbgD8yBTml7pLTPr2cBa+vdxg80HhiUHTlQPYXCi5LWF/NMWVAbvTPh/Lczm4gbpj
         GJPjj3aLPrAooyBYUu/fTI8dz+6X40RNeL0K/+0aduaJV00nUr6qvpdonouZRCB6W+gJ
         XMhH4vCl/pD/zb+WMfQH7GXfTZm8JGWnfIXklOIOV/h25Smgr5vb28MMhm2bOz0H0jUc
         7MgA==
X-Gm-Message-State: APjAAAXY+b0Anm38u9iCJH8ErFmvQYh0KVyhT7ks0GsJ1S9sDRzV3rIq
        NO8O68rvgI21j5R++bRVA9sDNqtquaY=
X-Google-Smtp-Source: APXvYqwNeo4Lm2KsUkZw2PBIJv7c22XTMebEqmZ6IGLFDVHBMaZWzxlIxEOLZBcK+t8KjqIA8Sw8Mg==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr48409335wmb.129.1563526787404;
        Fri, 19 Jul 2019 01:59:47 -0700 (PDT)
Received: from brauner.io ([81.92.17.140])
        by smtp.gmail.com with ESMTPSA id j17sm39177701wrb.35.2019.07.19.01.59.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 01:59:46 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:59:45 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] riscv: enable sys_clone3 syscall for rv64
Message-ID: <20190719085944.n4ypavxdlf6go4tl@brauner.io>
References: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 09:20:01PM -0700, Paul Walmsley wrote:
> 
> Enable the sys_clone3 syscall for RV64.  We simply include the generic
> version.
> 
> Tested by running the program from
> 
>    https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> 
> and verifying that it completes successfully.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Christian Brauner <christian@brauner.io>

Thank you!

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  arch/riscv/include/uapi/asm/unistd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> index 0e2eeeb1fd27..13ce76cc5aff 100644
> --- a/arch/riscv/include/uapi/asm/unistd.h
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -18,6 +18,7 @@
>  #ifdef __LP64__
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SET_GET_RLIMIT
> +#define __ARCH_WANT_SYS_CLONE3
>  #endif /* __LP64__ */
>  
>  #include <asm-generic/unistd.h>
> -- 
> 2.22.0
> 
