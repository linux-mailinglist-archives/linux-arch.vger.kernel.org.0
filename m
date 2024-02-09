Return-Path: <linux-arch+bounces-2156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1184F636
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 14:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC6B1F23D8A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1054D107;
	Fri,  9 Feb 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps+CwaIk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F0286AF;
	Fri,  9 Feb 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486916; cv=none; b=fDKHH8QVgYILUYgkp/VYRCT1eJ7RGi/Cfyvc5j1qDT+eDVmIiaOaiJHUgx1M435iRXfUeI+/hzutKjbN5GMRZu7V2WYEbG6DuszQqT8lWNQxgNcpiT3xZXISuSVX6tloAUYdXQUQvgZd19OqGb60/SNxDbWt2jfTNwqxcZvFBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486916; c=relaxed/simple;
	bh=N3GCSyWzae8ipltTZtYlaSxhj9Xw2wBHa2FcwP8g7/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4rmUOmEf5dnFvvDbVjU+xt0SAx/FUpsCFMdoAOXqPFMzIaKgU3XAT+0Y5zJrd3s38oFWzep9kxgFppacNOf3F57uzUN6N5MGLZJrESnxd8eP3+2noHittVbiMsDAJ6ERs14EvbX6qjoAFom750H09XzDrxa7Bga1Txkp6nM6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps+CwaIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB33C433F1;
	Fri,  9 Feb 2024 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707486916;
	bh=N3GCSyWzae8ipltTZtYlaSxhj9Xw2wBHa2FcwP8g7/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ps+CwaIkHu8An+k1+IwBgTtQ/zOdHfUZKQqvM3AMg8hSYTf5GPy0ogxEaPowK5cEB
	 x22/c7eWYdqQIXU3M/TOLL6llcXIEGjseYQ4zON0ar6IOG1+iGFSz4YgD3Fy6fNY0s
	 AIaHOqBota5Ag8Wgrgk9YBsJKPqHN5R6zSNezrNhV/fJdLrvhG5H9IAxVMlfQls3Lq
	 mkUVAPsnVb/CJ7CKCdBJIJJPwhKejCiLUlF6iGfEanShrol8prX8x6nV3rjat49VJo
	 qTqqG2JMM/JO0Krv2lYhi3TqTdKMiBokeMON6uyY9lCclX9Tz1WtNmce3eSwhlcTBi
	 a5SUmdSgGIg/w==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0e2adfeefso417881fa.2;
        Fri, 09 Feb 2024 05:55:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yxjziyoqw7Lo/IH3/z7F87mRTiFdT+0+MIEQf8uHC0j86ARkNeM
	rsUb/2BmeCJd2+87ybkZ4CFg4p5NZ+ZMOuOSRCwzU6lRRDXnaZty63breq7JvHmsOJr2BA/XLnP
	6A/7HLXVz/CdTxbtVTRXl+CZiCEo=
X-Google-Smtp-Source: AGHT+IFzfYCUMVeJAdR5KbdODBHTfaJGN1S3G1HPU2EUPy206ZpoIQDXAotPe3HHWpVqkMhFeZeYhE7k9yL+FNm1FXY=
X-Received: by 2002:a2e:9909:0:b0:2d0:cb36:2be0 with SMTP id
 v9-20020a2e9909000000b002d0cb362be0mr1410808lji.9.1707486914397; Fri, 09 Feb
 2024 05:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-27-ardb+git@google.com> <20240207132922.GSZcOFspSGaVluJo92@fat_crate.local>
In-Reply-To: <20240207132922.GSZcOFspSGaVluJo92@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Feb 2024 13:55:02 +0000
X-Gmail-Original-Message-ID: <CAMj1kXF+mHCYs08q58QFGuzZ4nzGd2sDr1gp2ydkOHHQ2LK5tQ@mail.gmail.com>
Message-ID: <CAMj1kXF+mHCYs08q58QFGuzZ4nzGd2sDr1gp2ydkOHHQ2LK5tQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] x86/startup_64: Drop global variables keeping
 track of LA57 state
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 13:29, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 29, 2024 at 07:05:09PM +0100, Ard Biesheuvel wrote:
> >  static inline bool pgtable_l5_enabled(void)
> >  {
> >       return __pgtable_l5_enabled;
> >  }
> >  #else
> > -#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
> > +#define pgtable_l5_enabled() !!(native_read_cr4() & X86_CR4_LA57)
> >  #endif /* USE_EARLY_PGTABLE_L5 */
>
> Can we drop this ifdeffery and simply have __pgtable_l5_enabled always
> present and contain the correct value?
>

I was trying to get rid of global variable assignments and accesses
from the 1:1 mapping, but since we cannot get rid of those entirely,
we might just keep __pgtable_l5_enabled but use RIP_REL_REF() in the
accessors, and move the assignment to the asm startup code.

> So that we don't have an expensive CR4 read hidden in
> pgtable_l5_enabled()?
>

Yeah, I didn't realize it was expensive. Alternatively, we might do
something like

static __always_inline bool pgtable_l5_enabled(void)
{
   unsigned long r;
   bool ret;

   asm(ALTERNATIVE_TERNARY(
       "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
       %P[feat], "stc", "clc")
       : [reg] "=r" (r), CC_OUT(c) (ret)
       : [feat] "i" (X86_FEATURE_LA57),
         [la57] "i" (X86_CR4_LA57_BIT)
       : "cc");
   return ret;
}

but we'd still have two versions in that case.

> For the sake of simplicity, pgtable_l5_enabled() can be defined outside
> of CONFIG_X86_5LEVEL and since both vendors support 5level now, might as
> well start dropping the CONFIG ifdeffery slowly...
>
> Other than that - a nice cleanup!
>

Thanks.

