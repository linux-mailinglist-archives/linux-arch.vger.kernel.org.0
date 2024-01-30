Return-Path: <linux-arch+bounces-1870-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9F843159
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FCC1C22517
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823078B7B;
	Tue, 30 Jan 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQBTpCVV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109917EF06;
	Tue, 30 Jan 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657789; cv=none; b=loG3Dug4XWSRgyHbWkhBYloH/yBi0vxnIqgIptQeX8wN3/JnUDkTpprx0B38IpKqBAPXfsVqX/dTPdYb8/6c0rfDXEjUb717a6IFbgu8Iurr2v2YP6X992k6QdBFo0ItxvScCmjbmEuewFsPtVvRISNS8MxCCEcn/hQ5n6jKYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657789; c=relaxed/simple;
	bh=sLwv6+dGl8oHWbDEHeRaajMfbIGR/+C6zSrAA66CSOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB2CsMFNPH6ffMcz2UFQD7e27Wg1VgO62KH9V2zi3btCYZcHifBnBGOq+VCe/bAKPhW1VeDxX7MWSt9shEE+YHteUMgvsNfIsDK8lCJhMmx9sOjQfkjMj4dJbpCLOtF6FsVxLBz6Yj1rspqcJi51gFhh8EbKSk1EtT3X5BXEVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQBTpCVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92910C433F1;
	Tue, 30 Jan 2024 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706657788;
	bh=sLwv6+dGl8oHWbDEHeRaajMfbIGR/+C6zSrAA66CSOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UQBTpCVVO1vP7QYDHfbZW4bRc3cwWDKU9QY6qudNNcBhelR5M3FDpXwKpx2p+S9h2
	 R5PSM+p/KMJjDpolr/N2wZG0m302QXEUeAlETB6f49O1lqpNgUMUAx36MxbyjShXB6
	 90bnJK3XhGdoeoja2Mzm0VWicbiCumPsaFTO5anj6JPfv6KoGyPMdgKRgScy6RohUZ
	 y+CSu9X5Edg1U+iKEx9OAOwnwzttaj/Nn0Q1fsYrSwZESPL3prHmOwL2wsxIgc08Tz
	 CcqbtUl0lPdZq1x7fuoKPJ58jBXpMyqEjlUHn1Pr8qjixTmi+Bmc1Zrs66KgUEG3Rs
	 5prOaj2i12DNA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51124d43943so184294e87.2;
        Tue, 30 Jan 2024 15:36:28 -0800 (PST)
X-Gm-Message-State: AOJu0YzxlnvN65/GGEdoyuwEKIiW9Ul6e7rRu5DyG05lxf+fw5jrUwyE
	KIcrKPx/nUarj4W1A/CQVUiiNMySI6Szwl0Se9CFy5L4cf6OUC0vWUV1j4ADY8q4monVbR61E9K
	QutmpnvIna2nChLYPO6EFG39p7Uc=
X-Google-Smtp-Source: AGHT+IEiHNjigsuZQ7CdEKsrXuS85Ldf2QtzveLMFD6chDrnkNvw/yJzorFrzdlZEIRvNTh/mIXvWsXjUnfNWmq0mqY=
X-Received: by 2002:a19:6518:0:b0:511:18f5:9480 with SMTP id
 z24-20020a196518000000b0051118f59480mr75132lfb.60.1706657786812; Tue, 30 Jan
 2024 15:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-35-ardb+git@google.com> <CAGdbjmKDZ8R+EjR-u09r9c4Y8Y0HjWaXPARSKsW0R5zVBSLPPA@mail.gmail.com>
In-Reply-To: <CAGdbjmKDZ8R+EjR-u09r9c4Y8Y0HjWaXPARSKsW0R5zVBSLPPA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 00:36:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECr7SDTynefURwGYVYnAY+i+TDjW-i9hqf_5EFV2Qeqw@mail.gmail.com>
Message-ID: <CAMj1kXECr7SDTynefURwGYVYnAY+i+TDjW-i9hqf_5EFV2Qeqw@mail.gmail.com>
Subject: Re: [PATCH v3 14/19] x86/coco: Make cc_set_mask() static inline
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 00:16, Kevin Loughlin <kevinloughlin@google.com> wro=
te:
>
> On Mon, Jan 29, 2024 at 10:06=E2=80=AFAM Ard Biesheuvel <ardb+git@google.=
com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Setting the cc_mask global variable may be done early in the boot while
> > running fromm a 1:1 translation. This code is built with -fPIC in order
> > to support this.
> >
> > Make cc_set_mask() static inline so it can execute safely in this
> > context as well.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/coco/core.c        | 7 +------
> >  arch/x86/include/asm/coco.h | 8 +++++++-
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> > index eeec9986570e..d07be9d05cd0 100644
> > --- a/arch/x86/coco/core.c
> > +++ b/arch/x86/coco/core.c
> > @@ -14,7 +14,7 @@
> >  #include <asm/processor.h>
> >
> >  enum cc_vendor cc_vendor __ro_after_init =3D CC_VENDOR_NONE;
> > -static u64 cc_mask __ro_after_init;
> > +u64 cc_mask __ro_after_init;
> >
> >  static bool noinstr intel_cc_platform_has(enum cc_attr attr)
> >  {
> > @@ -148,8 +148,3 @@ u64 cc_mkdec(u64 val)
> >         }
> >  }
> >  EXPORT_SYMBOL_GPL(cc_mkdec);
> > -
> > -__init void cc_set_mask(u64 mask)
> > -{
> > -       cc_mask =3D mask;
> > -}
> > diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> > index 6ae2d16a7613..ecc29d6136ad 100644
> > --- a/arch/x86/include/asm/coco.h
> > +++ b/arch/x86/include/asm/coco.h
> > @@ -13,7 +13,13 @@ enum cc_vendor {
> >  extern enum cc_vendor cc_vendor;
> >
> >  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> > -void cc_set_mask(u64 mask);
> > +static inline void cc_set_mask(u64 mask)
>
> In the inline functions I changed/added to core.c in [0], I saw an
> objtool warning on clang builds when using inline instead of
> __always_inline; I did not see the same warning for gcc . Should we
> similarly use __always_inline to strictly-enforce here?
>
> [0] https://lore.kernel.org/lkml/20240130220845.1978329-2-kevinloughlin@g=
oogle.com/#Z31arch:x86:coco:core.c

This assembles to a single instruction

movq %rsi, cc_mask(%rip)

and the definition is in a header file, so I'm not convinced it makes
a different.

And looking at your series, I think there is no need to modify coco.c
at all if you just take this patch instead: the other code in that
file should not be called early at all (unless our downstream has
substantial changes there)

