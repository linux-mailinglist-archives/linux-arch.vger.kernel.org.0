Return-Path: <linux-arch+bounces-1895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3E843A91
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E659828E6D9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E869953;
	Wed, 31 Jan 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odasfKXG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52E6994D;
	Wed, 31 Jan 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692346; cv=none; b=GtoH7n9dVlYWspOQ2ioyPuqRHGi3oA/+mZOkeBvwXvhca/ujleKLTszCBhESqFvWqnbJUxsy6561fB3C/ZHwYrjle6bCw6Q2KDTB6NcSzATSLbZzayYbJMD+QS8WeDLBia91GmWXoEdz7Dt6nj7hh50sHgWNU5bLfhAdcjFBFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692346; c=relaxed/simple;
	bh=zx+jBP2L20Ye5mfDOJ7pzJPOr2fj4xiBpmo5wgEoBg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2dsW5Ife4gBicHAvgbRjUj+I26Rp/eNrfeCk0lmsQoLZ4nV0kf6p8JssckY4DpwW4ufWlyH15AbUfNkVnBb6JvWxFO6TV43oYntdllt6totwkU9oA6VF4KIkDb2xP7DGBr1At+gRABy4cobIpKZXOEtkUCdJm2KVhXxT3da6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odasfKXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209C8C433F1;
	Wed, 31 Jan 2024 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692346;
	bh=zx+jBP2L20Ye5mfDOJ7pzJPOr2fj4xiBpmo5wgEoBg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=odasfKXGCEVWm+n+kzir6Xm6EZVzZRzDoL+45cD11BJ5v4Bcn1p9ww19eFIrT5sCV
	 VBsY4m3GukB8tUBQ2/eJhpVI50um67vRRMyce5hvaFXHexmJjAzPl7FUt7GeCBcZfM
	 uHaqAEKQ54yPf04XYNnACdN8SenbL6eoL7w814xY/I2g70IT2ZNuoSZpOcIF9yv5Px
	 8CzPZv2l96IfL9chWZg+T1HFkIlzR/K6TRGVkETET5eRDvqjKOzaZ513oq9kMQFLw1
	 x8ssT76wND+CIkvH39Nw1hKRD+ACm5jSCFs5rj2OHPE0t33nQk2K+Ln4z4TXKWRUiR
	 WzxDq5/sEYASA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso8355198e87.0;
        Wed, 31 Jan 2024 01:12:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwPVcYthH0zcaFFBNEhxAOVjfQlLslOXSCMnJ1sHh+9ggIgTSsa
	5N4HjBLSn8gKrTB3S+lkkrxOo8dq90nH++9lan7HnPUXKZiQKvNNMsFZannFmk8h2n+qGTsdrY3
	EEgDpjsA+6O4PDXs9uGFchyPN3V4=
X-Google-Smtp-Source: AGHT+IGKJh4aTcDvm3ZTQdt05N8TV7ie7Jl38Yz55BFxqWqqzCELKVQ/rFcFhsPxqCN+qciTi1uZSp0ntuHJtUQxzNg=
X-Received: by 2002:a05:6512:616:b0:510:a0b:52e3 with SMTP id
 b22-20020a056512061600b005100a0b52e3mr809444lfe.68.1706692344331; Wed, 31 Jan
 2024 01:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com> <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
In-Reply-To: <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 10:12:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
Message-ID: <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the decompressor
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
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:35=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Jan 29, 2024 at 07:05:05PM +0100, Ard Biesheuvel wrote:
> > +/*
> > + * Set the memory encryption xloadflag based on the mem_encrypt=3D com=
mand line
> > + * parameter, if provided. If not, the consumer of the flag decides wh=
at the
> > + * default behavior should be.
> > + */
> > +static void set_mem_encrypt_flag(struct setup_header *hdr)
>
> parse_mem_encrypt
>

OK

> > +{
> > +     hdr->xloadflags &=3D ~(XLF_MEM_ENCRYPTION | XLF_MEM_ENCRYPTION_EN=
ABLED);
> > +
> > +     if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT)) {
>
> That's unconditionally enabled on x86:
>
>         select ARCH_HAS_MEM_ENCRYPT
>
> in x86/Kconfig.
>
> Which sounds like you need a single XLF_MEM_ENCRYPT and simplify this
> more.
>

OK, but that only means I can drop the if().

The reason we need two flags is because there is no default value to
use when the command line param is absent.

There is CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT but that one is AMD
specific. There is CONFIG_X86_MEM_ENCRYPT which is shared between
SME/SEV and TDX, which has no default setting.

> > +             int on =3D cmdline_find_option_bool("mem_encrypt=3Don");
> > +             int off =3D cmdline_find_option_bool("mem_encrypt=3Doff")=
;
> > +
> > +             if (on || off)
> > +                     hdr->xloadflags |=3D XLF_MEM_ENCRYPTION;
> > +             if (on > off)
> > +                     hdr->xloadflags |=3D XLF_MEM_ENCRYPTION_ENABLED;
> > +     }
> > +}
>
> Otherwise, I like the simplification.
>

Cheers.

