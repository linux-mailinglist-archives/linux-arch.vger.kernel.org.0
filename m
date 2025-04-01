Return-Path: <linux-arch+bounces-11200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27BA78126
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CF7A2ED9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB820CCDC;
	Tue,  1 Apr 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SkQff7ui"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE20AF7B;
	Tue,  1 Apr 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527337; cv=none; b=fju/AiWp91R9Ry4CUlK6YzuFDnhMu32pbpVev1JxKoHYch6OVhHraYApbtjdMxqlzcXUIBWQAMFJsIjU7SEci+1RHmswr+hcJ/eSYYiu7Y4WBP7DrEuON45UeLEqbsQh6cjtzVP1tHqwzz+WXUtB9OUg4BBUTjTvpqipZNFl9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527337; c=relaxed/simple;
	bh=GUzy16aTLlH7sr2A2gaAj7B7cH08SXs/6kcxiqPwrQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1da5VXcmUF0S3r8uMl65ffvDujLOKuuARb3kUD+STWmHaq7NsvmENMCyWl8Fy2Vx262XazCY1kICOhV7wQpTjpYy36h2Nf16Gq1HnXaeKGmKOdZmNreKqHRxCh48A8Qq6pAN+GLiJj51Hjwzi6W9Iifcked4pSA1VjMcb94s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SkQff7ui; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QwFzB9rgmSr+DDy/b0Hd/aaJjyUrXEHFSgwJ+5QTAZE=; b=SkQff7ui2dNykAT/PDqf0vlSCq
	JvsCdACSYe6T3hSLfM3FS6XnoTUAWaC8QlDsGfSHAfpe3/1xMVYJjq+Ehpkz9GRAJZCdFb8EvtwBF
	iljWyv4a77vp98tDoDmbknBxwJr/Ku7C441orgCjgmX5MTGO1jD0vg5GjeLbUkjz7kfmLhYFNDD1Q
	XlvxjXhT4fRnPenmqAN0T7HKdRn6O7ymBiNQB6qVgVVnoc6IYGnALtk9chuv+O9zRJ3YCbXis/703
	u/jnLw1FwOHLiS4NfA9/hp64nCVZZHYbIfpxDLawE14K4BvpIe4Kdf2BHTdR3CHh1eLXfeo3Dtz1N
	pbzxgLSw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzf6D-00000006qiQ-3phb;
	Tue, 01 Apr 2025 17:08:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1849630049D; Tue,  1 Apr 2025 19:08:29 +0200 (CEST)
Date: Tue, 1 Apr 2025 19:08:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 06/14] x86: Add support for suppressing warning
 backtraces
Message-ID: <20250401170829.GO5880@noisy.programming.kicks-ass.net>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-7-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313114329.284104-7-acarmina@redhat.com>

On Thu, Mar 13, 2025 at 11:43:21AM +0000, Alessandro Carminati wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Add name of functions triggering warning backtraces to the __bug_table
> object section to enable support for suppressing WARNING backtraces.
> 
> To limit image size impact, the pointer to the function name is only added
> to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
> CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
> parameter is replaced with a (dummy) NULL parameter to avoid an image size
> increase due to unused __func__ entries (this is necessary because __func__
> is not a define but a virtual variable).
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> ---
>  arch/x86/include/asm/bug.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index e85ac0c7c039..f6e13fc675ab 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -35,18 +35,28 @@
>  
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  
> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> +# define HAVE_BUG_FUNCTION
> +# define __BUG_FUNC_PTR	__BUG_REL(%c1)
> +# define __BUG_FUNC	__func__
> +#else
> +# define __BUG_FUNC_PTR
> +# define __BUG_FUNC	NULL
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +
>  #define _BUG_FLAGS(ins, flags, extra)					\
>  do {									\
>  	asm_inline volatile("1:\t" ins "\n"				\
>  		     ".pushsection __bug_table,\"aw\"\n"		\
>  		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
>  		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
> -		     "\t.word %c1"        "\t# bug_entry::line\n"	\
> -		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
> -		     "\t.org 2b+%c3\n"					\
> +		     "\t"  __BUG_FUNC_PTR "\t# bug_entry::function\n"	\
> +		     "\t.word %c2"        "\t# bug_entry::line\n"	\
> +		     "\t.word %c3"        "\t# bug_entry::flags\n"	\
> +		     "\t.org 2b+%c4\n"					\
>  		     ".popsection\n"					\
>  		     extra						\
> -		     : : "i" (__FILE__), "i" (__LINE__),		\
> +		     : : "i" (__FILE__), "i" (__BUG_FUNC), "i" (__LINE__),\
>  			 "i" (flags),					\
>  			 "i" (sizeof(struct bug_entry)));		\
>  } while (0)
> @@ -92,7 +102,8 @@ do {								\
>  do {								\
>  	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
>  	instrumentation_begin();				\
> -	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
> +	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__))			\
> +		_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
>  	instrumentation_end();					\
>  } while (0)

NAK, this grows the BUG site for now appreciable reason.

