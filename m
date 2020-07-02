Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2602128BD
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBPy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGBPyz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 11:54:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A751CC08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 08:54:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d10so11473859pls.5
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MeAooFE7BzOJmYHcj5OvJQ3TIg8iS0KIUniqk0qo5RE=;
        b=E231RZrQeNOxHh/UTusOKpx/9GZyqw7QxQJkPeqUZz6CUpMxg+PQ93lPWTHg6A7njf
         9/s9/DtLeQECLL3mPfiHy/zYgSl8SvJa1wS3GmTkJELVt6l7Yh5Xb07gOsTpgYaMInDs
         NWAAtwUQgGR66y9UiGHjay3pOw/x2zgzhXHgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MeAooFE7BzOJmYHcj5OvJQ3TIg8iS0KIUniqk0qo5RE=;
        b=tcNAmHFM/ILRJd87nK+ucsDwMg2sAmmJoCMzFNc8CCxj/UCNm+sOlvLyPg0HjraAXv
         oGqgUAentSunr2nKc9d/F/YrJzWJkgoOvdVFIMdksvFIHzH23zu6M487fyVdjyAKlLmj
         e/IMZ3GWR5YjnG016jHEb1M6sth1h4xrgkvHa4Tbm6x0P60EG1uRy1iOMTiBZmIfNWzo
         DoUbmJAzo4ZiuAPxjq/1QU8DMlGPNZ6Bn1r3XgAaGhfDmjRoQjH5ptZk2te4ryG8ljS+
         Yv0ZbiCSLynMyh8L0ab/o92Vs3/p8OLhUBT73qSLrXrv85M47qqgmrQF4lzyJWomj6bA
         a8CA==
X-Gm-Message-State: AOAM5326hSv+aZI+l5HP/e4pZFZ7/qGdVJT8MAgRVViIlozwtr/l+uvT
        aNgkEIwrx58/HnCH2bRl6KCRcQ==
X-Google-Smtp-Source: ABdhPJzxtf0wMlXhoQG2ZQz9ws5/QOLGYc1LqvaoXLWTDjY8edkVA5cT+vVZslEfFySrxdY9yW4VTw==
X-Received: by 2002:a17:902:bb95:: with SMTP id m21mr26850948pls.111.1593705295142;
        Thu, 02 Jul 2020 08:54:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n65sm9219269pfn.17.2020.07.02.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:54:54 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:54:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds.h: Coalesce transient LLVM dead code
 elimination sections
Message-ID: <202007020853.5F15B5DDD@keescook>
References: <20200702085400.2643527-1-danny@kdrag0n.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702085400.2643527-1-danny@kdrag0n.dev>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 02, 2020 at 01:54:00AM -0700, Danny Lin wrote:
> A recent LLVM 11 commit [1] made LLD stop implicitly coalescing some
> temporary LLVM sections, namely .{data,bss}..compoundliteral.XXX:
> 
>   [30] .data..compoundli PROGBITS         ffffffff9ac9a000  19e9a000
>        000000000000cea0  0000000000000000  WA       0     0     32
>   [31] .rela.data..compo RELA             0000000000000000  40965440
>        0000000000001d88  0000000000000018   I      2238    30     8
>   [32] .data..compoundli PROGBITS         ffffffff9aca6ea0  19ea6ea0
>        00000000000033c0  0000000000000000  WA       0     0     32
>   [33] .rela.data..compo RELA             0000000000000000  409671c8
>        0000000000000948  0000000000000018   I      2238    32     8
>   [...]
>   [2213] .bss..compoundlit NOBITS           ffffffffa3000000  1d85c000
>        00000000000000a0  0000000000000000  WA       0     0     32
>   [2214] .bss..compoundlit NOBITS           ffffffffa30000a0  1d85c000
>        0000000000000040  0000000000000000  WA       0     0     32
>   [...]
> 
> While these extra sections don't typically cause any breakage, they do
> inflate the vmlinux size due to the overhead of storing metadata for
> thousands of extra sections.
> 
> It's also worth noting that for some reason, some downstream Android
> kernels can't boot at all if these sections aren't coalesced.
> 
> This issue isn't limited to any specific architecture; it affects arm64
> and x86 if CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is forced on.
> 
> Example on x86 allyesconfig:
>     Before: 2241 sections, 1170972 KiB
>     After:    56 sections, 1171169 KiB
> 
> [1] https://github.com/llvm/llvm-project/commit/9e33c096476ab5e02ab1c8442cc3cb4e32e29f17
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/958
> Cc: stable@vger.kernel.org # v4.4+
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> ---
>  include/asm-generic/vmlinux.lds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index db600ef218d7..18968cba87c7 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -94,10 +94,10 @@
>   */
>  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX* .data..compoundliteral*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
>  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
> -#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
> +#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*

Are there .data.. and .bss.. sections we do NOT want to collect? i.e.
why not include .data..* and .bss..* ?

-- 
Kees Cook
