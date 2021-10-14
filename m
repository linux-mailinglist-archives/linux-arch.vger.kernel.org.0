Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FE42E33F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhJNV2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhJNV2c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 17:28:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13641C061762
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 14:26:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id np13so5720588pjb.4
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CLaFJ0M9ufD0uCBwTkgOwQCLYTA2acJBA4tvaXF3j60=;
        b=nySJqlSwO+ULk3udlcOszY6Ia0XQFeH789zFbu7K9HOE2rbb+01FRBlzqYTOfLe01Y
         UjBibChKl+lLjdMq7H2G6UmdoL4DkJBBd2xPkhVd/NnmKnnR8gnnU7EkmSiSJ0GL6yHC
         xyAObJJcyavoFkvMN+kslHElYwm+54tEYY9dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CLaFJ0M9ufD0uCBwTkgOwQCLYTA2acJBA4tvaXF3j60=;
        b=wxEZaoqIJPSnDLLcQp3WPydhhUV/Ns8zLaxBYNdwrAeMMXHYmSnYj8tQbkrF2Zh05y
         PbpYD+wtoCr5bu4bK2eoPc4XfIr9/SN2FSwvhWpWzO8vAR8EOSfsb/KdLeDsmODNpy8q
         bdkjAbt5xrIrFIv3QIJTsqYbTMWJdExoSwTjxnHv1kQvkWFfMmtA+VidhojF+pDXAIkv
         /vbtmp1VdxO80yRlteNk2bzYMj7/gXp7o+iTNXKHsfZTJ8MslYHTV0J5KSgw3KvIslve
         7yNVfUZtQlgtQVW8iADNTj/Q1Fpvtkjq7BhaHx1O5BqnTapKPJ6wW4cudlcnevPmHLYQ
         4qKg==
X-Gm-Message-State: AOAM532DiMglIZ1L2Gqmco3OHwDDoYhKknLhpOtVDxFyRT5mS4PS5a+/
        G5LT6SGFAwQ1tyZDCqmx+Qjkqg==
X-Google-Smtp-Source: ABdhPJw845LVBzEpWwR4bMZtD/PFJA96pgIe4GSulaOTJBUImwok7XHbH5FT4bUDZgXBEMZc0+GWdQ==
X-Received: by 2002:a17:90a:6a8f:: with SMTP id u15mr22641531pjj.212.1634246786410;
        Thu, 14 Oct 2021 14:26:26 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:4901:2fb9:ed97:3a3e])
        by smtp.gmail.com with ESMTPSA id i128sm3261169pfc.47.2021.10.14.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 14:26:25 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 01/13] powerpc: Move 'struct ppc64_opd_entry' back
 into asm/elf.h
In-Reply-To: <42d2a571677e60082c0a5b3e52e855aa58c0b1fc.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <42d2a571677e60082c0a5b3e52e855aa58c0b1fc.1634190022.git.christophe.leroy@csgroup.eu>
Date:   Fri, 15 Oct 2021 08:26:22 +1100
Message-ID: <87czo747sx.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

> 'struct ppc64_opd_entry' doesn't belong to uapi/asm/elf.h
>
> It was initially in module_64.c and commit 2d291e902791 ("Fix compile
> failure with non modular builds") moved it into asm/elf.h
>
> But it was by mistake added outside of __KERNEL__ section,
> therefore commit c3617f72036c ("UAPI: (Scripted) Disintegrate
> arch/powerpc/include/asm") moved it to uapi/asm/elf.h

As Michael said on v1, I'm a little nervous about moving it out of uAPI
after so long, although I do take the points of Arnd and Kees that we're
not breaking compiled binaries, nor should people be using this struct
to begin with...

I've cc:ed the linux-api@ list.

Kind regards,
Daniel

> Move it back into asm/elf.h, this brings it back in line with
> IA64 and PARISC architectures.
>
> Fixes: 2d291e902791 ("Fix compile failure with non modular builds")
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/elf.h      | 6 ++++++
>  arch/powerpc/include/uapi/asm/elf.h | 8 --------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index b8425e3cfd81..a4406714c060 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -176,4 +176,10 @@ do {									\
>  /* Relocate the kernel image to @final_address */
>  void relocate(unsigned long final_address);
>  
> +/* There's actually a third entry here, but it's unused */
> +struct ppc64_opd_entry {
> +	unsigned long funcaddr;
> +	unsigned long r2;
> +};
> +
>  #endif /* _ASM_POWERPC_ELF_H */
> diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
> index 860c59291bfc..308857123a08 100644
> --- a/arch/powerpc/include/uapi/asm/elf.h
> +++ b/arch/powerpc/include/uapi/asm/elf.h
> @@ -289,12 +289,4 @@ typedef elf_fpreg_t elf_vsrreghalf_t32[ELF_NVSRHALFREG];
>  /* Keep this the last entry.  */
>  #define R_PPC64_NUM		253
>  
> -/* There's actually a third entry here, but it's unused */
> -struct ppc64_opd_entry
> -{
> -	unsigned long funcaddr;
> -	unsigned long r2;
> -};
> -
> -
>  #endif /* _UAPI_ASM_POWERPC_ELF_H */
> -- 
> 2.31.1
