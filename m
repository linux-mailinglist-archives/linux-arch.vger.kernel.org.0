Return-Path: <linux-arch+bounces-1869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658FA843106
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 00:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A085B253CC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C857993B;
	Tue, 30 Jan 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxdcQwez"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123278B70
	for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656584; cv=none; b=ET1zBL2OaGmE21JjXYyd4oJZEqAovNedFTyLwarZk61o4ZeSCVaE315mw71qus9qe3pay6LojvDOLPG+SK/FgaToVXS8oymyGgqGqBKouvxMW8cFPD4hxXLB9CQAdREWn0P3gJJwwALyfL/cgXBnbaXsYGJPS7wWG5zavfwOhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656584; c=relaxed/simple;
	bh=8HUiHdc+ibKN+Ur+tXnhLRORbN73eAOd7u4PFL/scZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHg8SHwLIMI8JBl75yD70JblExWhDq9U+WUONwBdkr9glsxbZAEl6lID2TLtvMyW1UJg7tSyH0rvr1mnweMjr2FkXWWstrLbuBh4JAwR79Dkel1TpCMU+fHC80CVojjr1IM+ae54B5viGXchUgzru/h8Svqj5sxJ5uCyb6xtPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxdcQwez; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2df857929so1974200241.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706656581; x=1707261381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5dtCbU1Q3SdQupNf6FgVTBSHBjEi2YVyb9X02Fgq+c=;
        b=sxdcQwezfSLgVaSQ8rr0d/EC3e2v63lGwwlaTIUZDKEm/kTdyK+fwuf14qitt8tLqS
         1zqGaXdbpqTgrRoT8FkIe+QYGpmMj829KUSTBni2gpOsWynelRJ3n6XkAyxARG18ESKR
         rFgXMVrZ6PmG5SqprNS5+HxlSr/8ORWiV9VBrHoQfO7lQZDW0If+B8axCkvBv7ivYg2f
         hCKFKATKvW2nGDQlwCMGTfl5T+Qfhl6MVkJ0sM6h6o7LC/oWWOpfrNbzAVZTqbQZAJcy
         ObjYgOKqj9igk+zunjMi7bQv/sj//0R1WA/UqnVmn9EK2SeDmddAk0Ma91XzhmSpYUSq
         yYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656581; x=1707261381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5dtCbU1Q3SdQupNf6FgVTBSHBjEi2YVyb9X02Fgq+c=;
        b=LvjcR6efdjGW68tP4v4TA4KknEoMJvTmH7nO+FaYbl7SNxYPCDaqsGAsrg4iSr7cL1
         3TMzz05cK7OSOrA/NQ05c1LuSgI9bF6UuCayI+LOG0w/ySO+odv17/OoIyDs3vsvDMVv
         +JC2Zk+Idb86sbe1brRkgePScOY9YrgpWP/TGyxButbwM6ux83KIGo9a3ok+wyIyzTMF
         9qByd0lRPHhzFR9wl3UyImGBEX2UYiYUhqyrUHf5dsMVw9y+JWH4pCBgp+1KoPwEPhIG
         GWLklpGhWo/pppoKJN0M7Uub7mBcU9QelKXXTrMIr2fPmMFiB1biJZw3cGamMdlME5WN
         AQ5A==
X-Gm-Message-State: AOJu0Yz9/fdWhG7eE6Oz37nVTtaArID8MRSu/RyhyJEgVYwgfDQZRg3y
	lRIh+fJQKBxsquzdpxbyGvDCKr31xDLtPeE6eBB3+oA7B6lGH/yN53xxaKeLcFvPdY9AMUg96+N
	24Sd80EsNPlPOX+eKaMI402cXbaWMe+HJjrBd
X-Google-Smtp-Source: AGHT+IHVeZnWZzX9x8MwziS5Z9VLveTfJkLYZmbBNObwr2EDXGgzT2Yz8dfelIQ/4Pz45SqzPUgDy83l9kcP8lU4+j0=
X-Received: by 2002:a05:6102:3bf0:b0:46b:3e99:7813 with SMTP id
 be16-20020a0561023bf000b0046b3e997813mr5251130vsb.9.1706656580881; Tue, 30
 Jan 2024 15:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com> <20240129180502.4069817-35-ardb+git@google.com>
In-Reply-To: <20240129180502.4069817-35-ardb+git@google.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Tue, 30 Jan 2024 15:16:09 -0800
Message-ID: <CAGdbjmKDZ8R+EjR-u09r9c4Y8Y0HjWaXPARSKsW0R5zVBSLPPA@mail.gmail.com>
Subject: Re: [PATCH v3 14/19] x86/coco: Make cc_set_mask() static inline
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:06=E2=80=AFAM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Setting the cc_mask global variable may be done early in the boot while
> running fromm a 1:1 translation. This code is built with -fPIC in order
> to support this.
>
> Make cc_set_mask() static inline so it can execute safely in this
> context as well.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/coco/core.c        | 7 +------
>  arch/x86/include/asm/coco.h | 8 +++++++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..d07be9d05cd0 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -14,7 +14,7 @@
>  #include <asm/processor.h>
>
>  enum cc_vendor cc_vendor __ro_after_init =3D CC_VENDOR_NONE;
> -static u64 cc_mask __ro_after_init;
> +u64 cc_mask __ro_after_init;
>
>  static bool noinstr intel_cc_platform_has(enum cc_attr attr)
>  {
> @@ -148,8 +148,3 @@ u64 cc_mkdec(u64 val)
>         }
>  }
>  EXPORT_SYMBOL_GPL(cc_mkdec);
> -
> -__init void cc_set_mask(u64 mask)
> -{
> -       cc_mask =3D mask;
> -}
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index 6ae2d16a7613..ecc29d6136ad 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -13,7 +13,13 @@ enum cc_vendor {
>  extern enum cc_vendor cc_vendor;
>
>  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> -void cc_set_mask(u64 mask);
> +static inline void cc_set_mask(u64 mask)

In the inline functions I changed/added to core.c in [0], I saw an
objtool warning on clang builds when using inline instead of
__always_inline; I did not see the same warning for gcc . Should we
similarly use __always_inline to strictly-enforce here?

[0] https://lore.kernel.org/lkml/20240130220845.1978329-2-kevinloughlin@goo=
gle.com/#Z31arch:x86:coco:core.c

