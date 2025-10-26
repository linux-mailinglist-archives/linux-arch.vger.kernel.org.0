Return-Path: <linux-arch+bounces-14347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EFCC0B4DF
	for <lists+linux-arch@lfdr.de>; Sun, 26 Oct 2025 22:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 045B54EA915
	for <lists+linux-arch@lfdr.de>; Sun, 26 Oct 2025 21:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227542FE071;
	Sun, 26 Oct 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dILcPccV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB59284B3B;
	Sun, 26 Oct 2025 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761515801; cv=none; b=iLBUoykpQ8h2FEL6pMymI77F+uzYl6qcLo+VTDSOu9UvCoJzELIa+n9FHZA1WKqnM58ry6HT80RQyhfocjkV9jG5NHcWX4YYQlvfnoUAujjeqcAIfw+/WXZ6RnKo6fkYcU0FHsMPO4oYVodV4gf9nWYZvvH43EPm4ORaqo5RTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761515801; c=relaxed/simple;
	bh=N7pfa/rz8J4rDZgorv5glLRk7KFVV0w1P6TxdQKGMLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akuy6tJP3+x82anoLKu3pxyUCRwkUlNnaXmZov3VZGHknnrmiXxx2niTXDlVZjeFGJmJo5Novtiv5kMt/VEvtjMK8MrVk/g1pYSxwc3KasDFEm212TFHd66OVEtZrJLUOn9/pCcMSkjFpefn9SbHLwat3XXCfYwpQ/rvd5krSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dILcPccV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B5C4CEE7;
	Sun, 26 Oct 2025 21:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761515800;
	bh=N7pfa/rz8J4rDZgorv5glLRk7KFVV0w1P6TxdQKGMLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dILcPccVr1nI8dc2SI2gfVKsf9ej96UpGycU6OgxW1yhUHKV3WWtQ7V1WfbfFOYLz
	 gBYTfPNJqZvreOgfOQ+L6n35EfWtkqOu6OEQIWGyhv42Oeh6cUMySd1tm6I23xyT/5
	 IGsZEWIbrWs12DofP2ba+h85Yk08xD5gINY9Pj/PUuSL/jvSruZ9m4s5sSADssG2up
	 hh5HIBXarHrHpxYD6527OKsJOPkwibQCCjwoY5e/0RqxDF8Cs7WmGnm3yd5AeuQ4Ww
	 QRI2A7dZ/loGacYGz9uhWmNoXc5qFKbnnYOvA5lL1chATNaszeiICqqoMp5xHk0U9y
	 +QnE1h1cNoraw==
Date: Sun, 26 Oct 2025 14:56:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	masahiroy@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org,
	legion@kernel.org, nsc@kernel.org
Subject: Re: [PATCH] kbuild: align modinfo section for Secureboot
 Authenticode EDK2 compat
Message-ID: <20251026215635.GA2368369@ax162>
References: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk>

Hi Dimitri,

On Sun, Oct 26, 2025 at 08:21:00PM +0000, Dimitri John Ledkov wrote:
> Previously linker scripts would always generate vmlinuz that has sections
> aligned. And thus padded (correct Authenticode calculation) and unpadded

Was this something that was guaranteed to happen or did it just always
happen by coincidence? Is there a way to enforce this?

> calculation would be same. As in https://github.com/rhboot/pesign userspace
> tool would produce the same authenticode digest for both of the following
> commands:
> 
>     pesign --padding --hash --in ./arch/x86_64/boot/bzImage
>     pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage
> 
> The commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
> vmlinux.unstripped") added .modinfo section of variable length. Depending
> on kernel configuration it may or may not be aligned.
> 
> All userspace signing tooling correctly pads such section to calculation
> spec compliant authenticode digest.

I might be missing something here but .modinfo should not be in the
final vmlinux since it gets stripped out via the strip_relocs rule in
scripts/Makefile.vmlinux. Does this matter because an unaligned .modinfo
section could potentially leave sections after it in the linker scripts
unaligned as well?

> However, if bzImage is not further processed and is attempted to be loaded
> directly by EDK2 firmware, it calculates unpadded Authenticode digest and

Could this affect other bootloaders as well? I noticed this report about
rEFInd and pointed them here in case it was related:

https://lore.kernel.org/CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com/

> fails to correct accept/reject such kernel builds even when propoer
> Authenticode values are enrolled in db/dbx. One can say EDK2 requires
> aligned/padded kernels in Secureboot.
> 
> Thus add ALIGN(8) to the .modinfo section, to esure kernels irrespective of
> modinfo contents can be loaded by all existing EDK2 firmware builds.
> 
> Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")

I took this change via the Kbuild tree for 6.18-rc1 so I can pick this
up for kbuild-fixes or Arnd can take this if he has anything pending for
fixes in the asm-generic tree.

> Cc: stable@vger.kernel.org
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 8a9a2e732a65b..e04d56a5332e6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -832,7 +832,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  
>  /* Required sections not related to debugging. */
>  #define ELF_DETAILS							\
> -		.modinfo : { *(.modinfo) }				\
> +		.modinfo : { *(.modinfo) . = ALIGN(8); }		\
>  		.comment 0 : { *(.comment) }				\
>  		.symtab 0 : { *(.symtab) }				\
>  		.strtab 0 : { *(.strtab) }				\
> -- 
> 2.51.0
> 

