Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341DF43100C
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 07:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhJRGAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 02:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhJRGAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 02:00:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F0FC06161C;
        Sun, 17 Oct 2021 22:58:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so14947296pgc.12;
        Sun, 17 Oct 2021 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=X4ObKuSSQv+G50bHKT8TIyKSkdwsT91S+K4zGdNUDYc=;
        b=Lx6Kua8eCdB6ynkVlMcdhmK5TPoD66KEfA5sFkjG/jTtVfqyJExe3fuC0Puxhk8YDW
         oMbdqYvv8LDN5Fl7oeWI1jsOaMhDpBXR56LaquS2aHLuOG+chQvabNZZiYOgQw2jCRXx
         GjqHc3TmuiHshjuXyEvHVNkjO+/pj9Nt+n8rlscssMhmARCGM0bkwW3hBJxfoW2Ns9lI
         9+lZARUtvknB91k784nVDrt8t1ZL45iOFMhOZ8uIXyEdX+qkq8QlZCtWuGvFsRsuieHm
         i9hlkomX8vHYTO13Yqzs+HvKtBJi/31h/KAhjzJ06LpbBnHy8UWyCoDLACtjvJnquGex
         3DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=X4ObKuSSQv+G50bHKT8TIyKSkdwsT91S+K4zGdNUDYc=;
        b=NHUXoumfdbosONMB/vmAWf9LW247kkkxAMn0qgWgKCN4JgdM9/5kzU8NI7u8u/5ctL
         ewf/OyJultbFkcxf74pE/fJfJYzDzmCWT3NIqtCstwpq2IVRcLVqaI9a3bpwrxkDtroa
         RhdBjg86ylG1YRbsTG3AKycMcWbwJfhz6SRf4Ek2BBVcY+dHHeSr0NLs2/csD1qJMlPX
         mNMgv+vPcNXd+Pj7th9FD+0xv/07TWK/14QuRX6ttJkyYbqsZLL4Rxa2J3KL742tc9LR
         Wq5dJzr6I4908w7uE28erIE5YKR5FkSCnhr7KrZn2AwziEG34GPXIXoFliosVgx375ir
         b+6w==
X-Gm-Message-State: AOAM531AJxzNMh5SITbdGrz4CVh2eqHjJqgn1hFCU2moT/FnpZ/UnD/h
        niruDF0iU/l+i6D1se4H3Y0=
X-Google-Smtp-Source: ABdhPJwB4aZOEF4c4x+POdQ74CsyuEUoXurySgutsGWF+Sp9p2tOiLlNP0zuxpWool6b+cUy0ckW/Q==
X-Received: by 2002:a63:340c:: with SMTP id b12mr21911013pga.241.1634536707973;
        Sun, 17 Oct 2021 22:58:27 -0700 (PDT)
Received: from localhost ([1.128.241.174])
        by smtp.gmail.com with ESMTPSA id c12sm11569352pfc.161.2021.10.17.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 22:58:27 -0700 (PDT)
Date:   Mon, 18 Oct 2021 15:58:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 01/12] powerpc: Move and rename func_descr_t
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
        <637a9a11263afa216fdfa7fb470a54479c67c61c.1634457599.git.christophe.leroy@csgroup.eu>
In-Reply-To: <637a9a11263afa216fdfa7fb470a54479c67c61c.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634536669.2nedzrtfjt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 17, 2021 10:38 pm:
> There are three architectures with function descriptors, try to
> have common names for the address they contain in order to
> refactor some functions into generic functions later.
>=20
> powerpc has 'entry'
> ia64 has 'ip'
> parisc has 'addr'
>=20
> Vote for 'addr' and update 'func_descr_t' accordingly.
>=20
> Move it in asm/elf.h to have it at the same place on all
> three architectures, remove the typedef which hides its real
> type, and change it to a smoother name 'struct func_desc'.
>=20

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/code-patching.h | 2 +-
>  arch/powerpc/include/asm/elf.h           | 6 ++++++
>  arch/powerpc/include/asm/types.h         | 6 ------
>  arch/powerpc/kernel/signal_64.c          | 8 ++++----
>  4 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/incl=
ude/asm/code-patching.h
> index 4ba834599c4d..c6e805976e6f 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -110,7 +110,7 @@ static inline unsigned long ppc_function_entry(void *=
func)
>  	 * function's descriptor. The first entry in the descriptor is the
>  	 * address of the function text.
>  	 */
> -	return ((func_descr_t *)func)->entry;
> +	return ((struct func_desc *)func)->addr;
>  #else
>  	return (unsigned long)func;
>  #endif
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/el=
f.h
> index b8425e3cfd81..971589a21bc0 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -176,4 +176,10 @@ do {									\
>  /* Relocate the kernel image to @final_address */
>  void relocate(unsigned long final_address);
> =20
> +struct func_desc {
> +	unsigned long addr;
> +	unsigned long toc;
> +	unsigned long env;
> +};
> +
>  #endif /* _ASM_POWERPC_ELF_H */
> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/=
types.h
> index f1630c553efe..97da77bc48c9 100644
> --- a/arch/powerpc/include/asm/types.h
> +++ b/arch/powerpc/include/asm/types.h
> @@ -23,12 +23,6 @@
> =20
>  typedef __vector128 vector128;
> =20
> -typedef struct {
> -	unsigned long entry;
> -	unsigned long toc;
> -	unsigned long env;
> -} func_descr_t;
> -
>  #endif /* __ASSEMBLY__ */
> =20
>  #endif /* _ASM_POWERPC_TYPES_H */
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 1831bba0582e..36537d7d5191 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -933,11 +933,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset=
_t *set,
>  		 * descriptor is the entry address of signal and the second
>  		 * entry is the TOC value we need to use.
>  		 */
> -		func_descr_t __user *funct_desc_ptr =3D
> -			(func_descr_t __user *) ksig->ka.sa.sa_handler;
> +		struct func_desc __user *ptr =3D
> +			(struct func_desc __user *)ksig->ka.sa.sa_handler;
> =20
> -		err |=3D get_user(regs->ctr, &funct_desc_ptr->entry);
> -		err |=3D get_user(regs->gpr[2], &funct_desc_ptr->toc);
> +		err |=3D get_user(regs->ctr, &ptr->addr);
> +		err |=3D get_user(regs->gpr[2], &ptr->toc);
>  	}
> =20
>  	/* enter the signal handler in native-endian mode */
> --=20
> 2.31.1
>=20
>=20
>=20
