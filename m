Return-Path: <linux-arch+bounces-6242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECE9546D8
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B691F2300E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 10:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADCB17C9BB;
	Fri, 16 Aug 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjmJMktD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205113C689;
	Fri, 16 Aug 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804899; cv=none; b=YGheySBNoKXFoWPZwhKTRTe0cuPAhyymwCF5zinv/KWQWBP91kFELMQ9h0AWAL4PYS+IZCIFdEU6TZVK6dErnqXsGYWieVWwA+yZye84T6usriiD8/mBJpmJ/ei8r5TDMwcDEMXSGjP4IbQ4KKhwA5a5ANSbxg5/1zbIVk6ruI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804899; c=relaxed/simple;
	bh=m7F3trX3Iy+tmgN/SeUmcnfUZs8twzxG5ul00EHwQYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnQVtuG+b7j8c6APvoJKfQPlbDmeIdmhe2RnGudr4ED4SG4Y69bI1WozYMDLM6YT+HrEZ+ehQh1TqnGdsqPzIgvXgyjQUwK8CMUM0Xq5pn5irbqkmcKifvpL1QPEgtpcZEXa4CRq11uId7qELklUaC6k8bTWZiTtV1pOZ5nToqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjmJMktD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D42C32782;
	Fri, 16 Aug 2024 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723804899;
	bh=m7F3trX3Iy+tmgN/SeUmcnfUZs8twzxG5ul00EHwQYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjmJMktDJqlIRAxYHz/45AlfkAdYqkYdbnZFKKXlDkqoKq8yf7tWz4evzWfdQGcHs
	 hPuC+KR+aBPbtV3Y14+QBxUZku7WWqXMe8TJp+dF5x1ynT6Q51hQ38lUygJmQUyRTd
	 ARv9EWWlCAK+7hQRfMBefdkeaLZTsYXbUstIHJGLhkHUokQbycHp1UJAXutMgKMrUF
	 y2khSdAxejyNtaUvirNnHIQgRzpEoOOXy3Bpl8sgX4pmxO/n2+IwJv7Bb0WV3efkGj
	 A2FyaIw7OnjR8glxZ5xpGABLUx6eYI5LwJUg26MXasHYKZj/eH/1O3wPVchvItcxHS
	 pHvcTraoy5+mA==
Date: Fri, 16 Aug 2024 11:41:32 +0100
From: Will Deacon <will@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] runtime constants: move list of constants to
 vmlinux.lds.h
Message-ID: <20240816104132.GB23304@willie-the-truck>
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 30, 2024 at 10:15:16PM +0200, Jann Horn wrote:
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I'm not sure whose tree this has to go through - I guess Arnd's?
> ---
>  arch/arm64/kernel/vmlinux.lds.S   | 3 +--
>  arch/s390/kernel/vmlinux.lds.S    | 3 +--
>  arch/x86/kernel/vmlinux.lds.S     | 3 +--
>  include/asm-generic/vmlinux.lds.h | 4 ++++
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 55a8e310ea12..58d89d997d05 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -261,14 +261,13 @@ SECTIONS
>  		*(.init.altinstructions .init.bss)	/* from the EFI stub */
>  	}
>  	.exit.data : {
>  		EXIT_DATA
>  	}
>  
> -	RUNTIME_CONST(shift, d_hash_shift)
> -	RUNTIME_CONST(ptr, dentry_hashtable)
> +	RUNTIME_CONST_VARIABLES
>  
>  	PERCPU_SECTION(L1_CACHE_BYTES)
>  	HYPERVISOR_PERCPU_SECTION
>  
>  	HYPERVISOR_RELOC_SECTION

Acked-by: Will Deacon <will@kernel.org>

I'm assuming Arnd will pick this up.

Will

