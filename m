Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC57C2D7F70
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbgLKTda (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 14:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393576AbgLKTdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 14:33:16 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286ACC0613D6
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 11:32:36 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so2872496pjb.4
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9QrTgvGnEakPURCqXO9kVzpnI7sAnsn5QLKAoF8jKto=;
        b=YlRVVR0J3SWrOJLo/jmkZifU0GgnWNus/X2mN9j9Dpcm7OnTYCv0w8dDeiXJOhRtKq
         qntCWLVR/OxbTujk2vmdnbE+xvAC7RGanwD7OUpSCuC6myv5NZOsA1/lV5o5GCQIcu3w
         ysXWmzmxZxCXJMR5DqDqZeAn155foWYOHtnKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QrTgvGnEakPURCqXO9kVzpnI7sAnsn5QLKAoF8jKto=;
        b=IJ1Y4YN5IiwIQ7027ppqHL2fLGAOUr67lsXj7wJ1STIJz6pOnsr0Ya9jK3W24MHPcC
         B8tS+1Zs1AkkkZQEuix7F1bd/zDHAYhRCewpR+3tRI1hXKN7iIwSqPmyVgNxohxogPVs
         3/IaBdiPnfEb5Br1/WUUFZaBj0dIMcJZUS7azPF7AoA34Jz6DtRhnyah+ea8vd2q0TBq
         qbd1w+Fwn7zAdGvJEEYDEtHwYW+SVyHkS+ZoBGgolmkc4cuJ3EJ6YtGQaSqrIdsGntp3
         cUmG0HwWThCZRpxMLbhPBMg38wrsolUNH2MRe8iRkV5yZUQvI5XHbIhYC/W/TuqUdIP0
         +zmA==
X-Gm-Message-State: AOAM531LyPK4OQPgJ74WxhMwB4S1PIWW9aBR0gXSxmarK91aF3LB3qk3
        6wCGA6fFLS2H7wlrgmsp0y1DOQ==
X-Google-Smtp-Source: ABdhPJxsthqMVhRTxK9zln6OgOykAvCX/6nw+GaT6GPANSQFH6ft5S0zc7PNaBcACeYW35bsdNRUig==
X-Received: by 2002:a17:902:123:b029:da:420e:aab0 with SMTP id 32-20020a1709020123b02900da420eaab0mr12377208plb.30.1607715155648;
        Fri, 11 Dec 2020 11:32:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s65sm10821175pgb.78.2020.12.11.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 11:32:34 -0800 (PST)
Date:   Fri, 11 Dec 2020 11:32:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 06/16] kbuild: lto: add a default list of used symbols
Message-ID: <202012111131.E41AFFCDB@keescook>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211184633.3213045-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 11, 2020 at 10:46:23AM -0800, Sami Tolvanen wrote:
> With CONFIG_LTO_CLANG, LLVM bitcode has not yet been compiled into a
> binary when the .mod files are generated, which means they don't yet
> contain references to certain symbols that will be present in the final
> binaries. This includes intrinsic functions, such as memcpy, memmove,
> and memset [1], and stack protector symbols [2]. This change adds a
> default symbol list to use with CONFIG_TRIM_UNUSED_KSYMS when Clang's
> LTO is used.
> 
> [1] https://llvm.org/docs/LangRef.html#standard-c-c-library-intrinsics
> [2] https://llvm.org/docs/LangRef.html#llvm-stackprotector-intrinsic
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  init/Kconfig                | 1 +
>  scripts/lto-used-symbollist | 5 +++++
>  2 files changed, 6 insertions(+)
>  create mode 100644 scripts/lto-used-symbollist
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 0872a5a2e759..e88c919c1bf1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2297,6 +2297,7 @@ config TRIM_UNUSED_KSYMS
>  config UNUSED_KSYMS_WHITELIST
>  	string "Whitelist of symbols to keep in ksymtab"
>  	depends on TRIM_UNUSED_KSYMS
> +	default "scripts/lto-used-symbollist" if LTO_CLANG
>  	help
>  	  By default, all unused exported symbols will be un-exported from the
>  	  build when TRIM_UNUSED_KSYMS is selected.
> diff --git a/scripts/lto-used-symbollist b/scripts/lto-used-symbollist
> new file mode 100644
> index 000000000000..38e7bb9ebaae
> --- /dev/null
> +++ b/scripts/lto-used-symbollist
> @@ -0,0 +1,5 @@
> +memcpy
> +memmove
> +memset
> +__stack_chk_fail
> +__stack_chk_guard
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 

bikeshed: Should this filename use some kind of extension, like
lto-user-symbols.txt or .list, to make it more human-friendly?

-- 
Kees Cook
