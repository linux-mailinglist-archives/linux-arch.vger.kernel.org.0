Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12DD2DA7
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfJJPZ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 11:25:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33680 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfJJPZZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 11:25:25 -0400
Received: from zn.tnic (p200300EC2F0A630005874FFE54801724.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:587:4ffe:5480:1724])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD39A1EC0987;
        Thu, 10 Oct 2019 17:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570721124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oFtLtIT92PEjPANVccNt8bv5ZEw6stfT1hPzmyy05AU=;
        b=XvDnIWbOWnxP5VFZO9ko7ahJhTcRm/Xsrm8HgemYJGsHSBOE6Uta44f3AIYcSZ6OfEGl/a
        AEH1A9BDC9JA4n3PgugNym5/q4Nt+C+NeHY9F4IhvYggxoRn7C5NPgZWNAKd44J4GzphzU
        Yg/gusTeVLuPtqp+cJTKXO0tNksVAHs=
Date:   Thu, 10 Oct 2019 17:25:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20191010152516.GG7658@zn.tnic>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-15-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926175602.33098-15-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> -- 

I think you can drop the "DATA" from the names as it is kinda clear
where the exception table lands:

RO_EXCEPTION_TABLE_ALIGN
RO_EXCEPTION_TABLE

The "read-only" part is the important one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
