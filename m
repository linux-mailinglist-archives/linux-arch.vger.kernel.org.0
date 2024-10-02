Return-Path: <linux-arch+bounces-7617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550F98CA99
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D59B238A7
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42E1FC8;
	Wed,  2 Oct 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZrB0rAt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BA567D;
	Wed,  2 Oct 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831942; cv=none; b=PXuxc6+3eRkCcLtxnBN0a8ZU2p0nBEqxHANnim4GREVBnvNr34pwOrUm+s9acoJhxjx3sYQd23m+b8JiNA4ecSxCjSQ4xdDXSAn4Gs4hNqxo+eMavB4UqkWDhCnfZOBen45XsQtf5jrEQ2seM4dQUIHHlmOG41lWaAd4CXyCF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831942; c=relaxed/simple;
	bh=z31U8u7Saetd9Yh86iw2djS1AiJmkXhk8gUFFgbOklo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8hFMhXcEo5lddmBUCiKG4ZNUmhjIhZggC3nC2sE2GkkZCLfg8N59VN7tVWWdC8dEQvoByIego8uG17orPcMByJXe8tsa3WbuCHgTPDDxNP3hgNDltKoAIE1fYq14UX9HO+9vNjXedzkYJqjgSu04+0FVRvUUI6L3i5Thclstb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZrB0rAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690BC4CEC6;
	Wed,  2 Oct 2024 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727831942;
	bh=z31U8u7Saetd9Yh86iw2djS1AiJmkXhk8gUFFgbOklo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZrB0rAteuEIVVZH0mMb3PsniT3C5p5hMCdpGmD1l63d1VJnq+tHzzVGhZt+LE48c
	 tgkULQ4U/nNcebkdhObCHGtO2MnETeQzx1mfkN66t+tFejs9SN0NaQXejFMSLZc5XR
	 hFMq07gRUIIN1ZUveDzNKEf8w6849Bse3NZngil87XKkl02Izr5BWVkXnJHXlaLuyP
	 tdWFgqLtz5h5R94CQfiNVfT3cbHtpDi3trI9QkfOTJrGItQ5ocTmOoU1/8JQf6ynRn
	 gJC01fd6253tQcb0lF2Ge+R5u1VCC24QeB+8S99cpPoR6OopmwS6zE8IoLKVU7LS7k
	 vDcfFB7h2gD3A==
Date: Tue, 1 Oct 2024 18:18:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Wentao Zhang <wentaoz5@illinois.edu>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 4/4] x86: enable llvm-cov support
Message-ID: <20241002011858.GD555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-5-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-5-wentaoz5@illinois.edu>

On Wed, Sep 04, 2024 at 11:32:45PM -0500, Wentao Zhang wrote:
> Set ARCH_HAS_* options to "y" in kconfig and include section description in

Is description the right word here? Maybe "include the compiler generated
sections"? Open to other suggestions.

> linker script.
> 
> Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
> Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
> Tested-by: Chuck Wolber <chuck.wolber@boeing.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/Kconfig              | 2 ++
>  arch/x86/kernel/vmlinux.lds.S | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 007bab9f2..e0a8f7b42 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,8 @@ config X86
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV			if X86_64
> +	select ARCH_HAS_LLVM_COV		if X86_64
> +	select ARCH_HAS_LLVM_COV_PROFILE_ALL	if X86_64
>  	select ARCH_HAS_KERNEL_FPU_SUPPORT
>  	select ARCH_HAS_MEM_ENCRYPT
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 6e73403e8..904337722 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -191,6 +191,8 @@ SECTIONS
>  
>  	BUG_TABLE
>  
> +	LLVM_COV_DATA
> +
>  	ORC_UNWIND_TABLE
>  
>  	. = ALIGN(PAGE_SIZE);
> -- 
> 2.45.2
> 

