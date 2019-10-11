Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633EED3929
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfJKGHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 02:07:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfJKGHK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 02:07:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46qHXn5rSDz9sNx;
        Fri, 11 Oct 2019 17:07:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1570774027;
        bh=AJrLeG6G9D8YUo7VDIU/jBSRhH8l/uKAxqlBUz1bi84=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dJGgqoI+58ENDSNA0Me5eZnopdP/yD4mODpp5k3HE+c/wOPskcBr1ocDmTL7v4ekU
         qjpHBvYLd4OnsEYrUyo3+CrUrK6UrJQlf/73ilPLERyQb2ZKVsa3Vbj8yDLn8t5QwR
         KPMr4dG//WxDYq8YUXXc/we22B51riMsIi4n1yiTtnV2tv23x5ROvBQXoYwEWQcb9v
         athHfQX1DHgA/DvDMnQCT7h/mUmWgqly/W1MF+6MYlmVdd8DoSuzFTqO2XC+DgfWz8
         z+MmLdL0VASvJOdHd+7UjOrkIAhgbUBfEZAwteAWvEXsHOdUsxtJgtEUJ/+F3yOuf0
         PLDabEaYhHJNw==
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
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 02/29] powerpc: Remove PT_NOTE workaround
In-Reply-To: <20191011000609.29728-3-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-3-keescook@chromium.org>
Date:   Fri, 11 Oct 2019 17:07:04 +1100
Message-ID: <878sprx1br.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> In preparation for moving NOTES into RO_DATA, remove the PT_NOTE
> workaround since the kernel requires at least gcc 4.6 now.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

For the archives, Joel tried a similar patch a while back which caused
some problems, see:

  https://lore.kernel.org/linuxppc-dev/20190321003253.22100-1-joel@jms.id.au/

and a v2:

  https://lore.kernel.org/linuxppc-dev/20190329064453.12761-1-joel@jms.id.au/

This is similar to his v2. The only outstanding comment on his v2 was
from Segher:
  (And I do not know if there are any tools that expect the notes in a phdr,
  or even specifically the second phdr).

But this patch solves that by not changing the note.

cheers

> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 81e672654789..a3c8492b2b19 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -20,20 +20,6 @@ ENTRY(_stext)
>  PHDRS {
>  	kernel PT_LOAD FLAGS(7); /* RWX */
>  	note PT_NOTE FLAGS(0);
> -	dummy PT_NOTE FLAGS(0);
> -
> -	/* binutils < 2.18 has a bug that makes it misbehave when taking an
> -	   ELF file with all segments at load address 0 as input.  This
> -	   happens when running "strip" on vmlinux, because of the AT() magic
> -	   in this linker script.  People using GCC >= 4.2 won't run into
> -	   this problem, because the "build-id" support will put some data
> -	   into the "notes" segment (at a non-zero load address).
> -
> -	   To work around this, we force some data into both the "dummy"
> -	   segment and the kernel segment, so the dummy segment will get a
> -	   non-zero load address.  It's not enough to always create the
> -	   "notes" segment, since if nothing gets assigned to it, its load
> -	   address will be zero.  */
>  }
>  
>  #ifdef CONFIG_PPC64
> @@ -178,14 +164,8 @@ SECTIONS
>  	EXCEPTION_TABLE(0)
>  
>  	NOTES :kernel :note
> -
> -	/* The dummy segment contents for the bug workaround mentioned above
> -	   near PHDRS.  */
> -	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
> -		LONG(0)
> -		LONG(0)
> -		LONG(0)
> -	} :kernel :dummy
> +	/* Restore program header away from PT_NOTE. */
> +	.dummy : { *(.dummy) } :kernel
>  
>  /*
>   * Init sections discarded at runtime
> -- 
> 2.17.1
