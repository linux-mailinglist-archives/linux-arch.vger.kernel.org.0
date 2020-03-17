Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263DD1890C5
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQVxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 17:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQVxF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 17:53:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25DB20724;
        Tue, 17 Mar 2020 21:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584481984;
        bh=4fpXMStLT3ChZUSNNoR5DM0vAh+pn633V+leBozCyWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9izuxAJEYWfwOlyHm+dzHMrstapzlPoXAEYb7DfotjV7f8+lIrKsh/8yjOmRey35
         G6BkqEvgCCE0/nxL4u9SrTR3Ai5Q51DCYkWMsq7w+HwzxaZHlQeiS4oaslEAOKqBXs
         HfHocYpm5b4/XhOJrKH+WzAynGxE3ddRp080wgDc=
Date:   Tue, 17 Mar 2020 21:52:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64/build: Use common DISCARDS in linker script
Message-ID: <20200317215256.GA20788@willie-the-truck>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228002244.15240-7-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 04:22:41PM -0800, Kees Cook wrote:
> Use the common DISCARDS rule for the linker script in an effort to
> regularize the linker script to prepare for warning on orphaned
> sections.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 497f9675071d..c61d9ab3211c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -6,6 +6,7 @@
>   */
>  
>  #define RO_EXCEPTION_TABLE_ALIGN	8
> +#define RUNTIME_DISCARD_EXIT
>  
>  #include <asm-generic/vmlinux.lds.h>
>  #include <asm/cache.h>
> @@ -19,7 +20,6 @@
>  
>  /* .exit.text needed in case of alternative patching */
>  #define ARM_EXIT_KEEP(x)	x
> -#define ARM_EXIT_DISCARD(x)
>  
>  OUTPUT_ARCH(aarch64)
>  ENTRY(_text)
> @@ -94,12 +94,8 @@ SECTIONS
>  	 * matching the same input section name.  There is no documented
>  	 * order of matching.
>  	 */
> +	DISCARDS
>  	/DISCARD/ : {
> -		ARM_EXIT_DISCARD(EXIT_TEXT)
> -		ARM_EXIT_DISCARD(EXIT_DATA)
> -		EXIT_CALL
> -		*(.discard)
> -		*(.discard.*)
>  		*(.interp .dynamic)
>  		*(.dynsym .dynstr .hash .gnu.hash)
>  		*(.eh_frame)

Acked-by: Will Deacon <will@kernel.org>

Will
