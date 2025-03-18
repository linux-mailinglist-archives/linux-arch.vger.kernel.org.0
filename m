Return-Path: <linux-arch+bounces-10927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB7A67896
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE22F3A5089
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4820F091;
	Tue, 18 Mar 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVHlHUak"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1C20E6FA;
	Tue, 18 Mar 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313596; cv=none; b=oeS/Mand7Jxau2tE7KN0QjTULTOje8cy4jkTkTRSbwgjXMdjJVRJDlyvyZ8ZWusVS7TC6ZSVEmjp1+X5iz0jwAHSlHIhO2/VGCTqLAAsOgtu/5gM9ugBowfPmutJb8Kk78yeT6njuLVdeE+rPl+aGm6/S9eE0qRs+9TlxBSLQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313596; c=relaxed/simple;
	bh=wnqlTyxAgZ8CuVhXT9duPOO4NgjQBjimZKlWtsOUGPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtNuxbEvsVojzW+7QvI93xBrqK3voNzfEGfkR3KtDUInYvUpBBq1aSF4wLJuRPQj0dePFNL+uDuqbEJwQso12VjNFc/tMypWHZORL2C34DxQBfoMRU4cECQo1rMSPOTt2wSTx13hsD6oQY2+NdGL24MCI4no+22mDotXMgSNrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVHlHUak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FD2C4CEDD;
	Tue, 18 Mar 2025 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742313596;
	bh=wnqlTyxAgZ8CuVhXT9duPOO4NgjQBjimZKlWtsOUGPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVHlHUakLlfN9xeuBYO1EJf+5CyU+WJKRkilNy467a1BnupPF2HSzG6De1fpXKFV+
	 ix9jYHBoyySgyb6uel1Y6KTQEzU4+Rwm0HghzRyuSjF71hbCSnTEGnernC5xUEtu10
	 +UeOIc/V5TKw7+jkC51H/NeBuaIOzIXiqjJlwYzUGV3n3dFHQ9MxYqNWDakJi0E6hg
	 3eBuUyUh9Yz/C8EPNMpPnQhIe07ID+3WJ5N3wJyQiVpq4Skm6z+pxWjAjp5DobEjiB
	 6Jrg3x/R+DiIvD5NG4zUjWrrB/2tNu1hT+SvmfpVy3qQGAt9drIa3KhZDqAUmDABl/
	 j7eCAm37AJZIQ==
Date: Tue, 18 Mar 2025 15:59:47 +0000
From: Will Deacon <will@kernel.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning
 backtraces
Message-ID: <20250318155946.GC13829@willie-the-truck>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-8-acarmina@redhat.com>
 <20250313122503.GA7438@willie-the-truck>
 <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Mar 13, 2025 at 05:40:59PM +0100, Alessandro Carminati wrote:
> On Thu, Mar 13, 2025 at 1:25 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Mar 13, 2025 at 11:43:22AM +0000, Alessandro Carminati wrote:
> > > diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> > > index 28be048db3f6..044c5e24a17d 100644
> > > --- a/arch/arm64/include/asm/bug.h
> > > +++ b/arch/arm64/include/asm/bug.h
> > > @@ -11,8 +11,14 @@
> > >
> > >  #include <asm/asm-bug.h>
> > >
> > > +#ifdef HAVE_BUG_FUNCTION
> > > +# define __BUG_FUNC  __func__
> > > +#else
> > > +# define __BUG_FUNC  NULL
> > > +#endif
> > > +
> > >  #define __BUG_FLAGS(flags)                           \
> > > -     asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
> > > +     asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));
> >
> > Why is 'i' the right asm constraint to use here? It seems a bit odd to
> > use that for a pointer.
> 
> I received this code as legacy from a previous version.
> In my review, I considered the case when HAVE_BUG_FUNCTION is defined:
> Here, __BUG_FUNC is defined as __func__, which is the name of the
> current function as a string literal.
> Using the constraint "i" seems appropriate to me in this case.
> 
> However, when HAVE_BUG_FUNCTION is not defined:
> __BUG_FUNC is defined as NULL. Initially, I considered it literal 0,
> but after investigating your concern, I found:
> 
> ```
> $ echo -E "#include <stdio.h>\n#include <stddef.h>\nint main()
> {\nreturn 0;\n}" | aarch64-linux-gnu-gcc -E -dM - | grep NULL
> #define NULL ((void *)0)
> ```
> 
> I realized that NULL is actually a pointer that is not a link time
> symbol, and using the "i" constraint with NULL may result in undefined
> behavior.
> 
> Would the following alternative definition for __BUG_FUNC be more convincing?
> 
> ```
> #ifdef HAVE_BUG_FUNCTION
>     #define __BUG_FUNC __func__
> #else
>     #define __BUG_FUNC (uintptr_t)0
> #endif
> ```
> Let me know your thoughts.

Thanks for the analysis; I hadn't noticed this specific issue, it just
smelled a bit fishy. Anyway, the diff above looks better, thanks.

Will

