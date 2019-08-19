Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6667E9274B
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHSOoI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 10:44:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSOoI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 10:44:08 -0400
Received: from zn.tnic (p200300EC2F04B7003923E3AC7BEA9973.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:3923:e3ac:7bea:9973])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD7211EC04CD;
        Mon, 19 Aug 2019 16:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566225846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aiF2Pwcn1Ttln+Ose3qbWIgsrTCu8+BwU+USO7+83k4=;
        b=FTYNv20re79J8PzD/9y7V6Jh9kBr3W4s+dgAcNySz3ANhDbomTrLPb82d+7hIwSs3GPyEY
        fAoaUTPk1T7DsegZOlYkhQOH3FUs7/Jo/bXSuEJ9IMlqrmkel86WxQffz0W9k36RwsN6Vx
        f2RCgQC0Y7z0ata06gxWU6ZlYCrum3U=
Date:   Mon, 19 Aug 2019 16:44:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/28] x86/boot/compressed: annotate local functions
Message-ID: <20190819144401.GA4522@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-8-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-8-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:33PM +0200, Jiri Slaby wrote:
> relocated, paging_enabled, and no_longmode are self-standing local
> functions, annotate them as such. paging_enabled is annotated as
> NOALIGN, since the trampoline code has to be compact.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/boot/compressed/head_32.S | 3 ++-
>  arch/x86/boot/compressed/head_64.S | 9 ++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 37380c0d5999..7e8ab0bb6968 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -209,7 +209,7 @@ ENDPROC(efi32_stub_entry)
>  #endif
>  
>  	.text
> -relocated:
> +SYM_FUNC_START_LOCAL(relocated)
>  
>  /*
>   * Clear BSS (stack is currently empty)
> @@ -260,6 +260,7 @@ relocated:
>   */
>  	xorl	%ebx, %ebx
>  	jmp	*%eax
> +SYM_FUNC_END(relocated)
>  
>  #ifdef CONFIG_EFI_STUB
>  	.data
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 6233ae35d0d9..c8ce6ffc9fe5 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -511,7 +511,7 @@ ENDPROC(efi64_stub_entry)
>  #endif
>  
>  	.text
> -relocated:
> +SYM_FUNC_START_LOCAL(relocated)
>  
>  /*
>   * Clear BSS (stack is currently empty)
> @@ -540,6 +540,7 @@ relocated:
>   * Jump to the decompressed kernel.
>   */
>  	jmp	*%rax
> +SYM_FUNC_END(relocated)
>  
>  /*
>   * Adjust the global offset table
> @@ -635,9 +636,10 @@ ENTRY(trampoline_32bit_src)
>  	lret
>  
>  	.code64
> -paging_enabled:
> +SYM_FUNC_START_LOCAL_NOALIGN(paging_enabled)
>  	/* Return from the trampoline */
>  	jmp	*%rdi
> +SYM_FUNC_END(paging_enabled)
>  
>  	/*
>           * The trampoline code has a size limit.
> @@ -647,11 +649,12 @@ paging_enabled:
>  	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
>  
>  	.code32
> -no_longmode:
> +SYM_FUNC_START_LOCAL(no_longmode)
>  	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
>  1:
>  	hlt
>  	jmp     1b
> +SYM_FUNC_END(no_longmode)
>  
>  #include "../../kernel/verify_cpu.S"
>  
> -- 

All can be local labels prepended with .L

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
