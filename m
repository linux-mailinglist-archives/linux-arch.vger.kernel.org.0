Return-Path: <linux-arch+bounces-7064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30696DB87
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30BA1C250A6
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAD19DF9E;
	Thu,  5 Sep 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFlSoz8r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F712FC0A;
	Thu,  5 Sep 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545845; cv=none; b=tJJLkgLyLpLO+OFLIShffs/u95gnNcjqA89ukedIUb8eRbi2rQ6YckKl+LGnri6h99StPYBt0jt+VNs2971iZd26Hc9yYKMEU0L+n80+rMOxuTt2gVVVBD/lGWFo7ZNJvfXXZPOERbMwrYl2M/BZGwPg/2r0mAur5uke96m1ZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545845; c=relaxed/simple;
	bh=VAsU1NPVx46+oHGO/6plAI5dIfBi0YcOt0DaaDbKjLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpcI8brAgetiBJ9ER35l+Wkb1Cs6QC91PDLFK3YSigr0y5tU5kKI16dC58mQNec8KH6rD7uuEQpe/jf+SfEe9a12YJySHSgZCYjCGJyfrRnJgXQn6nmPZU+vaI+rlbTu9vAP7qSJlOyvVHGdouJNio3voUHNlmjebmTMuLp0aVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFlSoz8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8CEC4CEC5;
	Thu,  5 Sep 2024 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725545845;
	bh=VAsU1NPVx46+oHGO/6plAI5dIfBi0YcOt0DaaDbKjLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFlSoz8rkTTbo6bRypczPyDGNTAdcHGaNe4+ud1iEdvPScL5zsY6gXuQwI6CvpKrf
	 kb4ihMVDldhscSSsfHbmhoH/PWpMTKph+bqm6rpV5JhbXLyJsaKdgKQ2SY6GOkOv+V
	 jbhcXI0cJlzZlU930yYV0HyVmXnTQgBECu8rdgv1h1q1pENqG3MNrEk6YDvB8mzSOM
	 o6wcO2ZrgYztEMzYZbC5na7z7I4/F+VeCGjxgN9Li2p7NzDtlgOZ5M1rr5RGK94SKB
	 l2ETcB3SXFO01fzOF5U6dc9ITgDjmzWK9zC6yK8p1DOG30XqDsBBbrvDE4t9gCYr5F
	 kHF1NRLmB71LA==
Date: Thu, 5 Sep 2024 09:17:23 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 04/15] kbuild: add generic support for built-in boot DTBs
Message-ID: <20240905141723.GC1517132-robh@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
 <20240904234803.698424-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904234803.698424-5-masahiroy@kernel.org>

On Thu, Sep 05, 2024 at 08:47:40AM +0900, Masahiro Yamada wrote:
> Some architectures embed boot DTBs in vmlinux. A potential issue for
> these architectures is a race condition during parallel builds because
> Kbuild descends into arch/*/boot/dts/ twice.
> 
> One build thread is initiated by the 'dtbs' target, which is a
> prerequisite of the 'all' target in the top-level Makefile:
> 
>   ifdef CONFIG_OF_EARLY_FLATTREE
>   all: dtbs
>   endif
> 
> For architectures that support the embedded boot dtb, arch/*/boot/dts/
> is visited also during the ordinary directory traversal in order to
> build obj-y objects that wrap DTBs.
> 
> Since these build threads are unaware of each other, they can run
> simultaneously during parallel builds.
> 
> This commit introduces a generic build rule to scripts/Makefile.vmlinux
> to support embedded boot DTBs in a race-free way. Architectures that
> want to use this rule need to select CONFIG_GENERIC_BUILTIN_DTB.
> 
> After the migration, Makefiles under arch/*/boot/dts/ will be visited
> only once to build only *.dtb files.
> 
> This change also aims to unify the CONFIG options used for embedded DTBs
> support. Currently, different architectures use different CONFIG options
> for the same purposes.
> 
> The CONFIG options are unified as follows:
> 
>  - CONFIG_GENERIC_BUILTIN_DTB
> 
>    This enables the generic rule for embedded boot DTBs. This will be
>    renamed to CONFIG_BUILTIN_DTB after all architectures migrate to the
>    generic rule.
> 
>  - CONFIG_BUILTIN_DTB_NAME
> 
>    This specifies the path to the embedded DTB.
>    (relative to arch/*/boot/dts/)
> 
>  - CONFIG_BUILTIN_DTB_ALL
> 
>    If this is enabled, all DTB files compiled under arch/*/boot/dts/ are
>    embedded into vmlinux. Only used by MIPS.

I started to do this a long time ago, but then decided we didn't want to 
encourage this feature. IMO it should only be for legacy bootloaders or 
development/debug. And really, appended DTB is more flexible for the 
legacy bootloader case.

In hindsight, a common config would have been easier to limit new 
arches...

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile                 |  7 ++++++-
>  drivers/of/Kconfig       |  6 ++++++
>  scripts/Makefile.vmlinux | 44 ++++++++++++++++++++++++++++++++++++++++
>  scripts/link-vmlinux.sh  |  4 ++++
>  4 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 145112bf281a..1c765c12ab9e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1417,6 +1417,10 @@ ifdef CONFIG_OF_EARLY_FLATTREE
>  all: dtbs
>  endif
>  
> +ifdef CONFIG_GENERIC_BUILTIN_DTB
> +vmlinux: dtbs
> +endif
> +
>  endif
>  
>  PHONY += scripts_dtc
> @@ -1483,7 +1487,8 @@ endif # CONFIG_MODULES
>  CLEAN_FILES += vmlinux.symvers modules-only.symvers \
>  	       modules.builtin modules.builtin.modinfo modules.nsdeps \
>  	       compile_commands.json rust/test \
> -	       rust-project.json .vmlinux.objs .vmlinux.export.c
> +	       rust-project.json .vmlinux.objs .vmlinux.export.c \
> +               .builtin-dtbs-list .builtin-dtb.S
>  
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES += include/config include/generated          \
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index dd726c7056bf..5142e7d7fef8 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -2,6 +2,12 @@
>  config DTC
>  	bool
>  
> +config GENERIC_BUILTIN_DTB
> +	bool

So that we don't add new architectures to this, I would like something 
like:

# Do not add new architectures to this list
depends on MIPS || RISCV || MICROBLAZE ...

Yes, it's kind of odd since the arch selects the option...

For sure, we don't want this option on arm64. For that, I can rely on 
Will and Catalin rejecting a select, but on some new arch I can't.

> +
> +config BUILTIN_DTB_ALL
> +	bool

Can this be limited to MIPS?

> +
>  menuconfig OF
>  	bool "Device Tree and Open Firmware support"
>  	help
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 5ceecbed31eb..4626b472da49 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -17,6 +17,50 @@ quiet_cmd_cc_o_c = CC      $@
>  %.o: %.c FORCE
>  	$(call if_changed_dep,cc_o_c)
>  
> +quiet_cmd_as_o_S = AS      $@
> +      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
> +
> +%.o: %.S FORCE
> +	$(call if_changed_dep,as_o_S)
> +
> +# Built-in dtb
> +# ---------------------------------------------------------------------------
> +
> +quiet_cmd_wrap_dtbs = WRAP    $@
> +      cmd_wrap_dtbs = {							\
> +	echo '\#include <asm-generic/vmlinux.lds.h>';			\
> +	echo '.section .dtb.init.rodata,"a"';				\
> +	while read dtb; do						\
> +		symbase=__dtb_$$(basename -s .dtb "$${dtb}" | tr - _);	\
> +		echo '.balign STRUCT_ALIGNMENT';			\

Is this always guaranteed to be at least 8 bytes? That's the required 
alignment for dtbs and assumed by libfdt.

> +		echo ".global $${symbase}_begin";			\
> +		echo "$${symbase}_begin:";				\
> +		echo '.incbin "'$$dtb'" ';				\
> +		echo ".global $${symbase}_end";				\
> +		echo "$${symbase}_end:";				\
> +	done < $<;							\
> +	} > $@

