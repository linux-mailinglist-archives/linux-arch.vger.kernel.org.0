Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734F028EA2B
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbgJOBei (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 21:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbgJOBei (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 21:34:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D12C051123
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:04:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so719227pfj.11
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HqPJcxWf/UHRmEBTt7/8+9fERJsy5yZfgCD3aK5edac=;
        b=A4NM72S6XOBlLt7ydRqFfSTY+OzBlWVuGGGaRlZDZkxqnf9MjeK3Cltt2aQwpxz7zl
         YPaTWKV0+tLK3Kb7pbXz2pJr1jB6+H/v5iYuk2OxW0AuK4tTcH+40f5MEDMJrkrAI+J2
         LoHF7HCUrNhZW1eGKcy8zqurDJKuGMnRlW63c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqPJcxWf/UHRmEBTt7/8+9fERJsy5yZfgCD3aK5edac=;
        b=oSUZKkaA2N+nZ/E8bgNHiFHV+ecM1903Brl96ghK5tkYQPtLLkl+rQedQXOP5ehgmv
         +nnQvJBqt/ueHokZnOqHM69B5AuC/tAlOumTUsK70mH+pIPsszpEmqPeGpwOR97RX7LG
         MvEObxSKImIGGbfvPK0wTQseZ7L2wTuTCwpcTVnx81IEv0LFWdAeTyA/yJL7L3qnnHVq
         Z62QcZ1gBd2+XfBehSszkKKZEibZ+uwTm15rvzCOs3EyWhUEDhryNo1AYfVuAoWKiiZD
         d8xPUHtNQqNXPE/otWwsA8LMJLwWu6twyhh/z4Q9+c66vOusQwFKuq8nSnxuobRY/3qk
         zXcg==
X-Gm-Message-State: AOAM533iLxGoUmLYY7KpLVUnUrCyxcAT6cCKYPLtr4+nn0IiNLlQ/iNu
        9BogSbNuaZvybN8GwNPK7OlFwA==
X-Google-Smtp-Source: ABdhPJxQO4z1ZaWn5pAJCV5CIuDC8XILyE1EUBiq6fM/ieZ9iTkPZPD2HOND28lI1h9ZOyny5zW2rg==
X-Received: by 2002:a63:845:: with SMTP id 66mr938293pgi.318.1602716684465;
        Wed, 14 Oct 2020 16:04:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d128sm743917pfc.8.2020.10.14.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 16:04:43 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:04:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <202010141603.49EA0CE@keescook>
References: <20201005025720.2599682-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005025720.2599682-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 04, 2020 at 07:57:20PM -0700, Kees Cook wrote:
> Under some circumstances, the compiler generates .ctors.* sections. This
> is seen doing a cross compile of x86_64 from a powerpc64el host:
> 
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/trace_clock.o' being
> placed in section `.ctors.65435'
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ftrace.o' being
> placed in section `.ctors.65435'
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ring_buffer.o' being
> placed in section `.ctors.65435'
> 
> Include these orphans along with the regular .ctors section.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Ping -- please take this for tip/urgent, otherwise we're drowning sfr in
warnings. :)

-Kees

> ---
> v2: brown paper bag version: fix whitespace for proper backslash alignment
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5430febd34be..b83c00c63997 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -684,6 +684,7 @@
>  #ifdef CONFIG_CONSTRUCTORS
>  #define KERNEL_CTORS()	. = ALIGN(8);			   \
>  			__ctors_start = .;		   \
> +			KEEP(*(SORT(.ctors.*)))		   \
>  			KEEP(*(.ctors))			   \
>  			KEEP(*(SORT(.init_array.*)))	   \
>  			KEEP(*(.init_array))		   \
> -- 
> 2.25.1
> 

-- 
Kees Cook
