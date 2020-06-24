Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E22077B3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404154AbgFXPjf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404146AbgFXPje (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 11:39:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2170CC061573;
        Wed, 24 Jun 2020 08:39:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u12so1999849qth.12;
        Wed, 24 Jun 2020 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w86BiXeWW0qXr0CkddcsMzd0Qk3FGLVo77ySYOXx/9Y=;
        b=XvOvolokMbI6BM9fwAWbp0DSocFt1o+A8uoY/Reo4LDwzU4hQMNEqsXUMCfFLmPpRt
         oCGEUO7LJxfBoH6B4ugepuzR+W4BODGMKcD7n1kE8A3WQ3SLB+IBcIoTnjNohCiQzyKt
         CBCdrmzky74TFEFrPd2Kfsr2+14tR9HsbJRf+0G5kDdkEtuuh73IrvlaLZwDuMTWfMdb
         b+KS8pKoeDZyEW9HiZwMnTpp9wrt1CTAjBBJL+PFTzvo0sggPInyyKPq+J2T92oK6+DA
         9pwLFWMXKwWdX1Nk7yDVPqpI15TQlqEik3eyKHAU8SGeuJh/Z3+7WK6+QdceBuBfHG31
         HCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w86BiXeWW0qXr0CkddcsMzd0Qk3FGLVo77ySYOXx/9Y=;
        b=tNVSVtv3Ns8wezMgihfE9gLI3DLgN9b50jsoNNcUX+rb32cifYeUXdWNCFGWPIkLsD
         2eRN7cT54ozqDLbHIsl6/4PvBYPOPMkyFr0mTQw2R02C3hJJBfH4bzdJE2O9EYfkR0fM
         KWBEdQGBkEZoN/RZF52Y1/w+VD15bjBf7vEmRRetzKG6j/+6htJWTLvCDcnUiaxmbX9A
         9Up1ei0p0/ptnnKKDDkoZoOlGvai2IADi93k/HfurCSqJVPtzVzBK2KNe3GJjWnQhXee
         euJoMxcZ6epJJFOMCT/MI9aONMxFHt5/pIW48oYWvHA1KYLhJipNAFmEEoENjQOJ0NIt
         7SmQ==
X-Gm-Message-State: AOAM531G+ZQ68rJEV0uq4JwDSncRtRod5pbq/y2g8jY5BrFhSu+Nunk+
        YGB1yBEIqoflkTgH8Mf2nBY=
X-Google-Smtp-Source: ABdhPJzqJsdRmlzGOwYnHtzAydQW9Iu1ltabpuAtDnDhT9pt2nyjZR92f7BI3Glrce11dxNr8bQdzQ==
X-Received: by 2002:ac8:51d5:: with SMTP id d21mr26957465qtn.154.1593013173114;
        Wed, 24 Jun 2020 08:39:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l56sm4306072qtl.33.2020.06.24.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:39:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 24 Jun 2020 11:39:30 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vmlinux.lds.h: Add .symtab, .strtab, and
 .shstrtab to STABS_DEBUG
Message-ID: <20200624153930.GA1337895@rani.riverdale.lan>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624014940.1204448-3-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
> so there will be no warnings when --orphan-handling=warn is used more
> widely. (They are added above comment as it is the more common

Nit 1: is "after .comment" better than "above comment"? It's above in the
sense of higher file offset, but it's below in readelf output.
Nit 2: These aren't actually debugging sections, no? Is it better to add
a new macro for it, and is there any plan to stop LLD from warning about
them?

> order[1].)
> 
> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> 
> [1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/
> 
> Reported-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1248a206be8d..8e71757f485b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -792,7 +792,10 @@
>  		.stab.exclstr 0 : { *(.stab.exclstr) }			\
>  		.stab.index 0 : { *(.stab.index) }			\
>  		.stab.indexstr 0 : { *(.stab.indexstr) }		\
> -		.comment 0 : { *(.comment) }
> +		.comment 0 : { *(.comment) }				\
> +		.symtab 0 : { *(.symtab) }				\
> +		.strtab 0 : { *(.strtab) }				\
> +		.shstrtab 0 : { *(.shstrtab) }
>  
>  #ifdef CONFIG_GENERIC_BUG
>  #define BUG_TABLE							\
> -- 
> 2.25.1
> 
