Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7128E9DA
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 03:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgJOBUD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 21:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbgJOBTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AEC05BD33
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:50:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so732862pfj.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3VrWtG2Nzyu2csFSOGvGre3/3hIZgGNscPNIfDNpl2k=;
        b=hr4N6hwj+08gozMcwrEdmSN1/DHjJ1wV/rjoECw8Rb2Lo+XQgEYgDpitXER6aen3HX
         eXkJa61f3G1/5SOO7jrmjCFOzgysn3m/odJ4K0c9h+p6mhA72fUnwN1sijYXM89+e5/y
         E6EY2141rat0DkfG+cb3u9htDo0fyWs7u+jCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VrWtG2Nzyu2csFSOGvGre3/3hIZgGNscPNIfDNpl2k=;
        b=WjuCIMTIDSr4+2tMtHC+PgSIIpqDrq9Iz4l+yz4H7UEhhrf38qRdn/ApxhR31qugp5
         qYFqSP82IgBcNzepv0ywFfTRt34on8Wg7bFekaLYMSV407cYK70ihO8j9zJszrnq4Uy9
         7/iY2OWevQ8+pMNl9YEeQEB21jhT/djc0uMic20VRDe/nWo8KWsPV5NB/P2NFaAjmhyg
         tWwoAmq6wSX8XwJrQSNgHhWA1dw2wd8z+3inMvxLrLi7F8y8pIBNGHrFLi3N9cRh0KFg
         cnNByP8LZNOEsOFCmX1VGfEoj3Nk7ou6xYbL3IJzf0YkxUA+Py1oarcxY6N9k/mKIBak
         mc+w==
X-Gm-Message-State: AOAM532whBeTj9lsQALBjph89dk4sqbG7VQPAUX5OxkExWPurWMBIZV4
        gXK2NUVVfEroaxcLSRCROuFC3g==
X-Google-Smtp-Source: ABdhPJy3mXoDsP85zSkY2lnijaDX4p6o9n8i+9WfyCkbfe3bfD5GCGw8G2jBei5i1UDoglc5TJDPQA==
X-Received: by 2002:a62:1856:0:b029:155:1718:91a3 with SMTP id 83-20020a6218560000b0290155171891a3mr1359345pfy.66.1602715830672;
        Wed, 14 Oct 2020 15:50:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 143sm704359pfw.13.2020.10.14.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:50:29 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:50:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 14/25] kbuild: lto: remove duplicate dependencies from
 .mod files
Message-ID: <202010141549.412F2BF0@keescook>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 12, 2020 at 05:31:52PM -0700, Sami Tolvanen wrote:
> With LTO, llvm-nm prints out symbols for each archive member
> separately, which results in a lot of duplicate dependencies in the
> .mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
> consists of several compilation units, the output can exceed the
> default xargs command size limit and split the dependency list to
> multiple lines, which results in used symbols getting trimmed.
> 
> This change removes duplicate dependencies, which will reduce the
> probability of this happening and makes .mod files smaller and
> easier to read.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hi Masahiro,

This appears to be a general improvement as well. This looks like it can
land without depending on the rest of the series.

-Kees

> ---
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index ab0ddf4884fd..96d6c9e18901 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -266,7 +266,7 @@ endef
>  
>  # List module undefined symbols (or empty line if not enabled)
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
> -cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
> +cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
>  else
>  cmd_undef_syms = echo
>  endif
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

-- 
Kees Cook
