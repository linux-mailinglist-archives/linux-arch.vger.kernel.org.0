Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FDC2F9E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfJAJF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 05:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbfJAJF5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Oct 2019 05:05:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4D8205F4;
        Tue,  1 Oct 2019 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569920756;
        bh=JRJjwuTCLks0eTr+fTI0jHF7WDR7bCyYfOCyezjDUU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiMkUD4EMfYhkUFgPPXqTXTSigYXcehiFZXr4ob1nkn4XKixJIOt4mWuwY67wbOYS
         lN0AGvUo98AhTsltpUiBCpglj9Jd6heH+2IlkTUxYH/l4z8+PrtKKVnnqbVdR1hNNA
         TdN/lHE0WF4MNGKjk+62gB67mLRgJS+UueJWkATI=
Date:   Tue, 1 Oct 2019 10:05:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/29] vmlinux.lds.h: Allow EXCEPTION_TABLE to live in
 RO_DATA
Message-ID: <20191001090549.xxbqarn36unvowrm@willie-the-truck>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-15-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926175602.33098-15-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 26, 2019 at 10:55:47AM -0700, Kees Cook wrote:
> Many architectures have an EXCEPTION_TABLE that needs only to be
> read-only. As such, it should live in RO_DATA. This creates a macro to
> identify this case for the architectures that can move EXCEPTION_TABLE
> into RO_DATA.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d57a28786bb8..35a6cba39d9f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -69,6 +69,17 @@
>  #define NOTES_HEADERS_RESTORE
>  #endif
>  
> +/*
> + * Some architectures have non-executable read-only exception tables.
> + * They can be added to the RO_DATA segment by specifying their desired
> + * alignment.
> + */
> +#ifdef RO_DATA_EXCEPTION_TABLE_ALIGN
> +#define RO_DATA_EXCEPTION_TABLE	EXCEPTION_TABLE(RO_DATA_EXCEPTION_TABLE_ALIGN)
> +#else
> +#define RO_DATA_EXCEPTION_TABLE
> +#endif
> +
>  /* Align . to a 8 byte boundary equals to maximum function alignment. */
>  #define ALIGN_FUNCTION()  . = ALIGN(8)
>  
> @@ -508,6 +519,7 @@
>  		__stop___modver = .;					\
>  	}								\
>  									\
> +	RO_DATA_EXCEPTION_TABLE						\
>  	NOTES								\
>  									\
>  	. = ALIGN((align));						\

I had to read this one to understand the later arm64 change. It looks
fine to me, so:

Acked-by: Will Deacon <will@kernel.org>

Will
