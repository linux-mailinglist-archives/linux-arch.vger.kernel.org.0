Return-Path: <linux-arch+bounces-7063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD72D96DAAA
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683AE1F22482
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D419D063;
	Thu,  5 Sep 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG3XYGg+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE817C9AE;
	Thu,  5 Sep 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544025; cv=none; b=SlQ1MdEdeCltKV0AvzUx/JXa4+QTA9EjV463p5oiQTW1+XyWXUAf3L3ply8tPz1DMXK4X8JT/T4iqwPGpq+U7eatOuhy4GHRyb6RCquzFlQcHHn2HKXh9eDQO5jDodNdDyUbE+0+iu55I+1GCyvPeTiM1mIdQS6xRHFwH9pOXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544025; c=relaxed/simple;
	bh=sI5y1eSjN/a3YRMxRNTDqjn+umUQqLG8Dfm4wjCbFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8IU/M9USb6jtvWHkk/7QvSGidObTrWhtIH73F1ESDAA5l+EOBPHBj16HqdDtxDGh2KTy81I0o/lJ4bXKDRVgzdce0i1uemBwDJTgDi0wRz0PuUIn+zelyfbwb+OFGVjpmkuH6RvGonzZi3OAvA47g/5bI8zvfzEr6+nHi3TgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG3XYGg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A2AC4CEC3;
	Thu,  5 Sep 2024 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544025;
	bh=sI5y1eSjN/a3YRMxRNTDqjn+umUQqLG8Dfm4wjCbFBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hG3XYGg+PqbEtyngI9vHEb6I1j0nyAJYiHN5ILgGHvGp+2OlXYGrewuoVaVqMTf2w
	 Lrac4i91ypCHaxArChDtDfvVKJV9Rf7A7V5w9XBUM3sVb6Wo/2lqJGKD7f+byYFrW2
	 STFmhKuuciQNq4dMNXkvcJqO9fur6POG6X49W71ELClXa1rZE7uJyYCsT+1ZrDRwef
	 uZYTH9DFlfShePSHrtyT5B5gzy6SLOxa+h9JUvemcOmi3BCieaPOMlC2Fl5tFtNqpR
	 f1emNRzha4d12ghwG30AmwYtkWQmc+ShIX80S0tMxvoZCxmCAwu7T2I/K7hAsut9n5
	 3RTZ2d3yZvAEQ==
Date: Thu, 5 Sep 2024 08:47:04 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 03/15] kbuild: move non-boot builtin DTBs to .init.rodata
 section
Message-ID: <20240905134704.GB1517132-robh@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
 <20240904234803.698424-4-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904234803.698424-4-masahiroy@kernel.org>

On Thu, Sep 05, 2024 at 08:47:39AM +0900, Masahiro Yamada wrote:
> Some architectures support embedding boot DTB(s) in vmlinux. These
> architectures, except MIPS and MicroBlaze, expect a single DTB in
> the .dtb.init.rodata section. MIPS embeds multiple DTBs in vmlinux.
> MicroBlaze embeds a DTB in its own __fdt_blob section instead of the
> .dtb.init.rodata section.
> 
> For example, RISC-V previously allowed embedding multiple DTBs, but
> only the first DTB in the .dtb.init.rodata section was used. Commit
> 2672031b20f6 ("riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig")
> ensured only one boot DTB is embedded.
> 
> Meanwhile, commit 7b937cc243e5 ("of: Create of_root if no dtb provided
> by firmware") introduced another DTB into the .dtb.init.rodata section.
> 
> The symbol dump (sorted by address) for ARCH=riscv nommu_k210_defconfig
> is now as follows:
> 
>     00000000801290e0 D __dtb_start
>     00000000801290e0 D __dtb_k210_generic_begin
>     000000008012b571 D __dtb_k210_generic_end
>     000000008012b580 D __dtb_empty_root_begin
>     000000008012b5c8 D __dtb_empty_root_end
>     000000008012b5e0 D __dtb_end
> 
> The .dtb.init.rodata section contains the following two DTB files:
> 
>     arch/riscv/boot/dts/canaan/k210_generic.dtb
>     drivers/of/empty_root.dtb
> 
> This is not an immediate problem because the boot code chooses the
> first DTB, k210_generic.dtb. The second one, empty_root.dtb is ignored.
> However, relying on the link order (i.e., the order in Makefiles) is
> fragile.
> 
> Only the boot DTB should be placed in the .dtb.init.rodata because the
> arch boot code generally does not know the DT name, thus it uses the
> __dtb_start symbol to find it.
> 
> empty_root.dtb is looked up by name, so it can be moved to the generic
> .init.rodata section.
> 
> When CONFIG_OF_UNITTEST is enabled, more unittest DTBOs are embedded in
> the .dtb.init.rodata section. These are also looked up by name, so can
> be moved to the .init.rodata section.
> 
> I added the __initdata annotation to the overlay_info data array because
> modpost knows the .init.rodata section is discarded, and would otherwise
> warn about it.
> 
> The implementation is kind of cheesy; the section is .dtb.init.rodata
> under the arch/ directory, and .init.rodata section otherwise. This will
> be refactored later.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  drivers/of/unittest.c | 2 +-
>  scripts/Makefile.dtbs | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

