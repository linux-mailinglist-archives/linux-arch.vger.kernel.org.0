Return-Path: <linux-arch+bounces-7220-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52554975C38
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 23:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBB11F21D8B
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B8154425;
	Wed, 11 Sep 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWTQvgYX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D714F132;
	Wed, 11 Sep 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088931; cv=none; b=HdSEl9mRO888xJaE4BiHV9w22Lb8IJlc+IfvMs3dZZWLpkQfn/q4o8UHHuIP1j9XKhXQUFCEO1BiLGQ6UQwXZHBJz+5hL1KcIUjoWZW9xczqQJ9+9Alhcgqg+n1RykURtXtFjLNuMj6amIDRy4HUSJ48Mo3dZDSCgdnXrUw64l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088931; c=relaxed/simple;
	bh=Yq5DwLNoDoEmAmclkRLNu5BQeMSQf6MxRyplYJiqxEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQnzfG3qIPiwrZspoC38yhOR9/Va6jPUgmoiJgreOOU5NuytNErqGUt215JcmC9xx47tGuggaKi+rE8v7FpaXsrfAy1q3mG+dzrP8xu/qa7eKjJnonFCcLyYhAVnLAR+9hGvwH2BHiV/hYA6B5fejQx2VVX3bRJ6p/DHo6LXXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWTQvgYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07419C4CEC0;
	Wed, 11 Sep 2024 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726088930;
	bh=Yq5DwLNoDoEmAmclkRLNu5BQeMSQf6MxRyplYJiqxEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWTQvgYXHks9kd8DRb4CA3zzz/e7YyEkw9PcrqtDLIzSwNrdEh/twqoDNUjzxAPty
	 uPfma4vlRy6IjZhBK0RvwIZgz9GZ4K8XemB/sjPA+eFb68flycBttPsXsrdY8efbWI
	 SdFAgXeIKreWrEznqHtwzARwZD8hS4iTi/WJpgeeXEUMsEozpBOhqm9M96VlsPfwAK
	 mz4+DvTvQ5sZNzAQ+oARggoNhp0Nd0pW8fJKoiHekdnnPRiD4nexPjh4cBdpyhURxX
	 iIaqakaCkt5+5KW8+svjtZ+v7/zNUSw6tP7oFZ84C40KgIAjieU5lTpi7OL7E42BNl
	 Pk/JbA3NuBuEQ==
Date: Wed, 11 Sep 2024 14:08:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
	linux-arch@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/3] btf: move pahole check in scripts/link-vmlinux.sh to
 lib/Kconfig.debug
Message-ID: <20240911210848.GA2659844@thelio-3990X>
References: <20240911110401.598586-1-masahiroy@kernel.org>
 <20240911110401.598586-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911110401.598586-2-masahiroy@kernel.org>

On Wed, Sep 11, 2024 at 08:03:57PM +0900, Masahiro Yamada wrote:
> When DEBUG_INFO_DWARF5 is selected, pahole 1.21+ is required to enable
> DEBUG_INFO_BTF.
> 
> When DEBUG_INFO_DWARF4 or DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is selected,
> DEBUG_INFO_BTF can be enabled without pahole installed, but a build error
> will occur in scripts/link-vmlinux.sh:
> 
>     LD      .tmp_vmlinux1
>   BTF: .tmp_vmlinux1: pahole (pahole) is not available
>   Failed to generate BTF for vmlinux
>   Try to disable CONFIG_DEBUG_INFO_BTF
> 
> We did not guard DEBUG_INFO_BTF by PAHOLE_VERSION when previously
> discussed [1].
> 
> However, commit 613fe1692377 ("kbuild: Add CONFIG_PAHOLE_VERSION")
> added CONFIG_PAHOLE_VERSION at all. Now several CONFIG options, as
> well as the combination of DEBUG_INFO_BTF and DEBUG_INFO_DWARF5, are
> guarded by PAHOLE_VERSION.
> 
> The remaining compile-time check in scripts/link-vmlinux.sh now appears
> to be an awkward inconsistency.
> 
> This commit adopts Nathan's original work.
> 
> [1]: https://lore.kernel.org/lkml/20210111180609.713998-1-natechancellor@gmail.com/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  lib/Kconfig.debug       |  3 ++-
>  scripts/link-vmlinux.sh | 12 ------------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5e2f30921cb2..eff408a88dfd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -379,12 +379,13 @@ config DEBUG_INFO_BTF
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
> +	depends on PAHOLE_VERSION >= 116
>  	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
>  	# pahole uses elfutils, which does not have support for Hexagon relocations
>  	depends on !HEXAGON
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
> -	  Turning this on expects presence of pahole tool, which will convert
> +	  Turning this on requires presence of pahole tool, which will convert
>  	  DWARF type info into equivalent deduplicated BTF type info.
>  
>  config PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index cfffc41e20ed..53bd4b727e21 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -111,20 +111,8 @@ vmlinux_link()
>  # ${1} - vmlinux image
>  gen_btf()
>  {
> -	local pahole_ver
>  	local btf_data=${1}.btf.o
>  
> -	if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
> -		return 1
> -	fi
> -
> -	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
> -	if [ "${pahole_ver}" -lt "116" ]; then
> -		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.16"
> -		return 1
> -	fi
> -
>  	info BTF "${btf_data}"
>  	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>  
> -- 
> 2.43.0
> 

