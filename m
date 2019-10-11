Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF87D3907
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfJKGBJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 02:01:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKGBJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 02:01:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46qHPp3F86z9sNx;
        Fri, 11 Oct 2019 17:01:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1570773665;
        bh=oTTi247DlGceNhM4MVDGIO6OtOx/XRmfaIEvdVAUqC8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YuZLY3Ew0BXM9XFrRRe1AZgVtROgn6ejFBEM7K0ehQpC93RuVYs/k+e5GJP4utQZH
         jHueJ25x/6MWfxYFcvH3KdeC/Q1Ai2aULyAdAKYUrzTAum25QdLH6mELw/QOyL8vMo
         z6tyN4sahqg/E1MMAQtxtjPEnjx21eDq54A/lX8w/OOhMRH7Z4lLdtVk3IKX7D71mq
         2L6BhqGlK7Z4Nz9zIrWRRmyTX5MMpiDhJ7vag0SEbYToUTWiT+g4hcAJsWdV4w6woK
         pv7UiCyfL7wNoDDE7p0rwC0w407xfguxq9940G0tWLyVoKfG/gESuz3YsJ3WgAUSvR
         FkXOKyLxhVzsw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/29] powerpc: Rename "notes" PT_NOTE to "note"
In-Reply-To: <20191011000609.29728-2-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-2-keescook@chromium.org>
Date:   Fri, 11 Oct 2019 17:00:59 +1100
Message-ID: <87blunx1lw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> The Program Header identifiers are internal to the linker scripts. In
> preparation for moving the NOTES segment declaration into RO_DATA,
> standardize the identifier for the PT_NOTE entry to "note" as used by
> all other architectures that emit PT_NOTE.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 060a1acd7c6d..81e672654789 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -19,7 +19,7 @@ ENTRY(_stext)
>  
>  PHDRS {
>  	kernel PT_LOAD FLAGS(7); /* RWX */
> -	notes PT_NOTE FLAGS(0);
> +	note PT_NOTE FLAGS(0);
>  	dummy PT_NOTE FLAGS(0);
>  
>  	/* binutils < 2.18 has a bug that makes it misbehave when taking an
> @@ -177,7 +177,7 @@ SECTIONS
>  #endif
>  	EXCEPTION_TABLE(0)
>  
> -	NOTES :kernel :notes
> +	NOTES :kernel :note
>  
>  	/* The dummy segment contents for the bug workaround mentioned above
>  	   near PHDRS.  */
> -- 
> 2.17.1
