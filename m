Return-Path: <linux-arch+bounces-7221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039F975C3C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 23:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C9A1F22A9C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CBA144D18;
	Wed, 11 Sep 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG6/nCAA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A813D52A;
	Wed, 11 Sep 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089020; cv=none; b=Vfekkdesr8ZNNV3lCwfSk7R/2kxAQjBIm5M8JP8aLxs8pMTE4vijD4X539h5Dt4dQlSB/47T8y8n8zlRr0vXLcVqaOIKeGShRIR8846KN10t/J9Os0M4RgO45gUON4sIkEBHiEeA+Shu7kHjNVeZqUCFY8lYb5DjWqiFjA4V2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089020; c=relaxed/simple;
	bh=jxu1thKXJqrT04deZKVKAfMKLEIWcMCyBfEV7yX6IZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgh23d//0ss7V728XQ53NlwIbBeLopg9WLUZWSa+BpsKW6oM1JJ0ix6pguJDthF4tl/m1fLIWkEtoawDkRbxNu9elOTiB/43Kx1j4zCfAoeMiktaPZ8B8Gpw/CO/LtwH7sk/VHDyMmaNpk4Ai9eNKdnxVFVl3tHAFoG9ZW/EkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG6/nCAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8816EC4CEC0;
	Wed, 11 Sep 2024 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726089020;
	bh=jxu1thKXJqrT04deZKVKAfMKLEIWcMCyBfEV7yX6IZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG6/nCAAh0eaIzFJdJ3qfqR+/qWu6FBSKF2kR2/U5pNh/PrskMTIVJfxM79SIkimx
	 oJNLfiM6Du4xHaEdKDHtBihY0cBqXfJk7N7sI+4Nscd+lsu3M9jtRJ5zRzBqU4Dsvw
	 3zqQKt2NKyLBE8jXOFD2yMcI+1OqoaCHGjFquVp02TB2oHmZkluWWdhbfALpSlUC0v
	 3Q3LFF4qHqbf0daUsIQbzZs6hcZPLShh/MSfn9sVkGzrW9MWoLkv81iUXzTgvTkjap
	 rG5QpiWcrV2/DwmZ1YED5Qz0sgpq3rF0RLiiMO1F2AMQ17LmK8dzy0m6VGraAayT9C
	 lgGDzx+SlF/0A==
Date: Wed, 11 Sep 2024 14:10:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
	linux-arch@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3] btf: require pahole 1.21+ for DEBUG_INFO_BTF with
 default DWARF version
Message-ID: <20240911211017.GB2659844@thelio-3990X>
References: <20240911110401.598586-1-masahiroy@kernel.org>
 <20240911110401.598586-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911110401.598586-3-masahiroy@kernel.org>

On Wed, Sep 11, 2024 at 08:03:58PM +0900, Masahiro Yamada wrote:
> As described in commit 42d9b379e3e1 ("lib/Kconfig.debug: Allow BTF +
> DWARF5 with pahole 1.21+"), the combination of CONFIG_DEBUG_INFO_BTF
> and CONFIG_DEBUG_INFO_DWARF5 requires pahole 1.21+.
> 
> GCC 11+ and Clang 14+ default to DWARF 5 when the -g flag is passed.
> For the same reason, the combination of CONFIG_DEBUG_INFO_BTF and
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is also likely to require
> pahole 1.21+. (At least, it is uncertain whether the requirement is
> pahole 1.16+ or 1.21+.)
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Indeed, I think this is a safer, longterm dependency, until we bump the
minimum versions to the ones listed in the commit message, unless there
is DWARF6 by that point :)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index eff408a88dfd..011a7abc68a8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -380,7 +380,7 @@ config DEBUG_INFO_BTF
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
>  	depends on PAHOLE_VERSION >= 116
> -	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
> +	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
>  	# pahole uses elfutils, which does not have support for Hexagon relocations
>  	depends on !HEXAGON
>  	help
> -- 
> 2.43.0
> 

