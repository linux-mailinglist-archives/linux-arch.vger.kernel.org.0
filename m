Return-Path: <linux-arch+bounces-10720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06659A5F443
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0E174850
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB2267381;
	Thu, 13 Mar 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDz7LQrx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56B265CC1;
	Thu, 13 Mar 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868714; cv=none; b=AGVC1beKQlql9FtD7z163M+otV3IBdSes/mJYt/vpjtR0Vg54ZbwBtip4YxO4ybm4ZQW5NOWm4IrksBOgW/s2CN2gCTKJJTqBEFmdx9MLhOFBR/StdWO2TIEC3mDMqQaJzt0HBtfu+A9+/uIfV+Av2ldFpnOcUZOfs7MEmMgz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868714; c=relaxed/simple;
	bh=VMUOnEKoimQN6pwJj0HJ250fPvnAR+FrAocdRJsHq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKWVDjygNtHEXnP7qDEV9x+tRapVZ90nhxsj7hoWY54rXWVrTSJNFkHFR9fxzGiDmRPt/9d94vmYs43iQ+a2Rjsy5Eyu0bKhuVp8/iL/gRYYwcohfKjpTlCDnlhIOm+fvbhVnkh268ORSVpug2PFx+EmQ1ORIWeYCfSRWUVPtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDz7LQrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED05C4CEDD;
	Thu, 13 Mar 2025 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741868713;
	bh=VMUOnEKoimQN6pwJj0HJ250fPvnAR+FrAocdRJsHq8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDz7LQrxn+5uMzYuKmUsr/MzQI/7LjUYAH6U0Rv69RHDL6kJTg7T/TlyBDu9nRw3f
	 +yscSRgZu10unC9voBYFntcNfukiIMd+J2bcz0am9R1N+EDQUjRDdCzHDa7E6jAT9G
	 elRWWLQjvLtJ+557HYrrxSzTWHiUmMyB6V6XwrGmcTe4DZAObyymSQ9P/m4v3yKCOP
	 xCAlBAwGAQVNMI3WMjv8hvbMIBFI0Nh29MW5H2CicZPp09a6Qz/dohbQ8rK8OUI9pq
	 70yUl1cBUcyKqDoTT3szQWbiaOW9pyrWRuXo8DTYexs+TSxJGXCTYPsEmUMP7nS12s
	 c+V7rKX2dyaMg==
Date: Thu, 13 Mar 2025 12:25:04 +0000
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
Message-ID: <20250313122503.GA7438@willie-the-truck>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-8-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313114329.284104-8-acarmina@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Mar 13, 2025 at 11:43:22AM +0000, Alessandro Carminati wrote:
> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> index 28be048db3f6..044c5e24a17d 100644
> --- a/arch/arm64/include/asm/bug.h
> +++ b/arch/arm64/include/asm/bug.h
> @@ -11,8 +11,14 @@
>  
>  #include <asm/asm-bug.h>
>  
> +#ifdef HAVE_BUG_FUNCTION
> +# define __BUG_FUNC	__func__
> +#else
> +# define __BUG_FUNC	NULL
> +#endif
> +
>  #define __BUG_FLAGS(flags)				\
> -	asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
> +	asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));

Why is 'i' the right asm constraint to use here? It seems a bit odd to
use that for a pointer.

Will

