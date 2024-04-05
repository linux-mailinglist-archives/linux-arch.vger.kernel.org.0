Return-Path: <linux-arch+bounces-3474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEC89A42E
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A2C2839AB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF0C16EC0D;
	Fri,  5 Apr 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjsNhh0f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620F1CA87;
	Fri,  5 Apr 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341871; cv=none; b=mivwRx7cOnANIQEOdIzbZx6Yl7y4rKHAv+Wp0RV44hCBr5lcHv0lKqrNhwcb4NhuyNtiKKUpeXho9blF8YBOOQePTGvkBgLnWYHCSuf7ghNwfqQPWKnI8u6w6+qbDP02JK0aY4kgNXTEjAZUi6D7cSEa7DOdsytdASKags1CJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341871; c=relaxed/simple;
	bh=SpJ5IQ9UhqrJWD/qugetHjxi8hPNKx//RaZUEP7dXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSEkRGUj4YO3kqDQ6tWQAqyluFYXGnwxoAB/8Q6iKHrcxjNOZiqatuMhajZKC7wQw/nWHPXXkXkruWARn7hAyl4gSMXLPSoiOxRdxm15C8/fi2WCzYFToQCFRvVFfCpHqmFy6ujWQIK28xXm06yd4hTbirI6kSkoPCGzGEUlKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjsNhh0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78FFC433F1;
	Fri,  5 Apr 2024 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712341871;
	bh=SpJ5IQ9UhqrJWD/qugetHjxi8hPNKx//RaZUEP7dXMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjsNhh0fjSHbdf2868fr6XGX0ymVpLd72hs4QqY449d2ixqqIbiOZ9KGWsTScBEdM
	 MmD6oO1ZFR5n/8XBcvJfrg+1fJuE6RWAslDhUeScY/894NlfAHOyDlBtG+Jpj6Xgim
	 AEpzgBbfrsVfqV97+U4MIZvB6mlskGvejsxy0uQkrvJ6HQBnEonvJPKwG4UwRXSFPC
	 sokGvl/2IbsBR2HRjgP5VVh/y6bBeOez+JNtA6wzhbGF/BxyaWGie9mhpM3y8Fsgqy
	 nccatqMs+mRkE11DcKuPOVmzq2/2RT6tsP9WZvm4sK8QAsHlkDj+GzXZn741rHxhYU
	 UZgSQsgWkKskQ==
Date: Fri, 5 Apr 2024 19:31:02 +0100
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
	netdev@vger.kernel.org, x86@kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v3 13/15] sh: Move defines needed for suppressing warning
 backtraces
Message-ID: <20240405183102.GU26556@kernel.org>
References: <20240403131936.787234-1-linux@roeck-us.net>
 <20240403131936.787234-14-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403131936.787234-14-linux@roeck-us.net>

On Wed, Apr 03, 2024 at 06:19:34AM -0700, Guenter Roeck wrote:
> Declaring the defines needed for suppressing warning inside
> '#ifdef CONFIG_DEBUG_BUGVERBOSE' results in a kerneldoc warning.
> 
> .../bug.h:29: warning: expecting prototype for _EMIT_BUG_ENTRY().
> 	Prototype was for HAVE_BUG_FUNCTION() instead
> 
> Move the defines above the kerneldoc entry for _EMIT_BUG_ENTRY
> to make kerneldoc happy.
> 
> Reported-by: Simon Horman <horms@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Added patch. Possibly squash into previous patch.

FWIIW, this looks good to me.

>  arch/sh/include/asm/bug.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
> index 470ce6567d20..bf4947d51d69 100644
> --- a/arch/sh/include/asm/bug.h
> +++ b/arch/sh/include/asm/bug.h
> @@ -11,6 +11,15 @@
>  #define HAVE_ARCH_BUG
>  #define HAVE_ARCH_WARN_ON
>  
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> +# define HAVE_BUG_FUNCTION
> +# define __BUG_FUNC_PTR	"\t.long %O2\n"
> +#else
> +# define __BUG_FUNC_PTR
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +#endif /* CONFIG_DEBUG_BUGVERBOSE */
> +
>  /**
>   * _EMIT_BUG_ENTRY
>   * %1 - __FILE__
> @@ -25,13 +34,6 @@
>   */
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  
> -#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> -# define HAVE_BUG_FUNCTION
> -# define __BUG_FUNC_PTR	"\t.long %O2\n"
> -#else
> -# define __BUG_FUNC_PTR
> -#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> -
>  #define _EMIT_BUG_ENTRY				\
>  	"\t.pushsection __bug_table,\"aw\"\n"	\
>  	"2:\t.long 1b, %O1\n"			\
> -- 
> 2.39.2
> 

