Return-Path: <linux-arch+bounces-3227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744FE88EF66
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D25A29E9A4
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEF150995;
	Wed, 27 Mar 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKHszxO4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAC1E52C;
	Wed, 27 Mar 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568368; cv=none; b=FcxLBpnxJPTGsCQKJMaOehbjOnGZv0TNC/pyZ6T7tdFg+uBHQwVGc16bCJcdyNA+71PziK55Za2q+3nBvJUVGuDRHK1jSOYkaQ+9cYpBwUfrfdDVkO+Pv/3MXf5WgcytgMqIv95wAePvIIhynu03vdW+N3nNEUjVYn9UexMxuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568368; c=relaxed/simple;
	bh=mgDCCV9DYm3gE81YovhkygNKHO9RS0DsGnhFgu3kHyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohTEiRVoma0GCSa7EZZ90JwMYtXJic6dw9IzrR9wHmJQ9MtPyovNYumX29+ZdXjgF61t624A31HreBfXT0zzfYOWEhomcosS0n6pTOUuJuYSomT1MhJBycaoToZ++zc1eKJDPY3BzxV7cmdCFuSRbFmNes9+sEUpW4BKTRVKy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKHszxO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3492BC433C7;
	Wed, 27 Mar 2024 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711568368;
	bh=mgDCCV9DYm3gE81YovhkygNKHO9RS0DsGnhFgu3kHyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKHszxO4HY0/TKQKrYd5xjeNheZExttn6ouZSQo7RamEADgZOHEGKOgxLgWnDAQsX
	 TQk1EiCgbOjPSXUXVDKc1GHuMb8JYfr2n9dUTSMBL4fPlQCFaWvqtzr7SljGX8ozL0
	 d+GxeE8i5/jrK3YAq+PzsRs9yg9Ub9Ye0zUWxbvydciwA80gaS/Cm+ZdJSIaW62wjN
	 8mgdqhfJd0T7WESQFdfsQPBT5oU/lItq2D11cSo/Qk/7TSLc6IaPfRphmumfAFxMTP
	 w0oml1KABCZkKYStlxNthCpMKTFGN6FZPoQQlay9J46ava0AXCk2S+OoNd/Q7U91J0
	 LlcAACEC05P/g==
Date: Wed, 27 Mar 2024 19:39:20 +0000
From: Simon Horman <horms@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
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
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v2 12/14] sh: Add support for suppressing warning
 backtraces
Message-ID: <20240327193920.GV403975@kernel.org>
References: <20240325175248.1499046-1-linux@roeck-us.net>
 <20240325175248.1499046-13-linux@roeck-us.net>
 <20240327144431.GL403975@kernel.org>
 <320aacc6-b7e5-4c3d-948e-d0743ab26c5d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320aacc6-b7e5-4c3d-948e-d0743ab26c5d@roeck-us.net>

On Wed, Mar 27, 2024 at 08:10:51AM -0700, Guenter Roeck wrote:
> On 3/27/24 07:44, Simon Horman wrote:
> > On Mon, Mar 25, 2024 at 10:52:46AM -0700, Guenter Roeck wrote:
> > > Add name of functions triggering warning backtraces to the __bug_table
> > > object section to enable support for suppressing WARNING backtraces.
> > > 
> > > To limit image size impact, the pointer to the function name is only added
> > > to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
> > > CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
> > > parameter is replaced with a (dummy) NULL parameter to avoid an image size
> > > increase due to unused __func__ entries (this is necessary because __func__
> > > is not a define but a virtual variable).
> > > 
> > > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > - Rebased to v6.9-rc1
> > > - Added Tested-by:, Acked-by:, and Reviewed-by: tags
> > > - Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
> > > 
> > >   arch/sh/include/asm/bug.h | 26 ++++++++++++++++++++++----
> > >   1 file changed, 22 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
> > > index 05a485c4fabc..470ce6567d20 100644
> > > --- a/arch/sh/include/asm/bug.h
> > > +++ b/arch/sh/include/asm/bug.h
> > > @@ -24,21 +24,36 @@
> > >    * The offending file and line are encoded in the __bug_table section.
> > >    */
> > >   #ifdef CONFIG_DEBUG_BUGVERBOSE
> > > +
> > > +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> > > +# define HAVE_BUG_FUNCTION
> > > +# define __BUG_FUNC_PTR	"\t.long %O2\n"
> > > +#else
> > > +# define __BUG_FUNC_PTR
> > > +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> > > +
> > 
> > Hi Guenter,
> > 
> > a minor nit from my side: this change results in a Kernel doc warning.
> > 
> >       .../bug.h:29: warning: expecting prototype for _EMIT_BUG_ENTRY(). Prototype was for HAVE_BUG_FUNCTION() instead
> > 
> > Perhaps either the new code should be placed above the Kernel doc,
> > or scripts/kernel-doc should be enhanced?
> > 
> 
> Thanks a lot for the feedback.
> 
> The definition block needs to be inside CONFIG_DEBUG_BUGVERBOSE,
> so it would be a bit odd to move it above the documentation
> just to make kerneldoc happy. I am not really sure that to do
> about it.

FWIIW, I agree that would be odd.
But perhaps the #ifdef could also move above the Kernel doc?
Maybe not a great idea, but the best one I've had so far.

> I'll wait for comments from others before making any changes.
> 
> Thanks,
> Guenter
> 
> > >   #define _EMIT_BUG_ENTRY				\
> > >   	"\t.pushsection __bug_table,\"aw\"\n"	\
> > >   	"2:\t.long 1b, %O1\n"			\
> > > -	"\t.short %O2, %O3\n"			\
> > > -	"\t.org 2b+%O4\n"			\
> > > +	__BUG_FUNC_PTR				\
> > > +	"\t.short %O3, %O4\n"			\
> > > +	"\t.org 2b+%O5\n"			\
> > >   	"\t.popsection\n"
> > >   #else
> > >   #define _EMIT_BUG_ENTRY				\
> > >   	"\t.pushsection __bug_table,\"aw\"\n"	\
> > >   	"2:\t.long 1b\n"			\
> > > -	"\t.short %O3\n"			\
> > > -	"\t.org 2b+%O4\n"			\
> > > +	"\t.short %O4\n"			\
> > > +	"\t.org 2b+%O5\n"			\
> > >   	"\t.popsection\n"
> > >   #endif
> > > +#ifdef HAVE_BUG_FUNCTION
> > > +# define __BUG_FUNC	__func__
> > > +#else
> > > +# define __BUG_FUNC	NULL
> > > +#endif
> > > +
> > >   #define BUG()						\
> > >   do {							\
> > >   	__asm__ __volatile__ (				\
> > 
> > ...
> 

