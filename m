Return-Path: <linux-arch+bounces-13293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02120B37336
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E9463AF6
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDAA374293;
	Tue, 26 Aug 2025 19:34:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018A1A0BD0;
	Tue, 26 Aug 2025 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236884; cv=none; b=Q4Nf/t/Fruj1M6jYsT5yOzCYdTx6/sUKfAI8zstv7QQvRngdRGAilJeN3tPQIfZiUiJUfwB8jM69TwIrER9dYBy5KFUCuo/ny+1hhD+e9QFprlPBWGWvlTcKuMtYgfuXwsnLCWCEdKzYphO1ryK+Lhw1rDUc106NjuVy1INUtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236884; c=relaxed/simple;
	bh=0PIxGqsNu2o5Bjhc/cWLVmkGbMcZXP2uAlg8QoJFphA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLKcA4KfYLVI/C+2Rc5C0kPJaAuz5Wc2i0uFXMPXPP19vHeALJJZTJII2PAzZXUv7Hw+UVgp+dvL+iWoXW/if9Y397CgYt39SGxUWWYli99fUWd4Lau5SPkvPcFxeYa2gldXP7Os00rlOPdwkMbmNaExktm6tv/WgYM1nXM1mE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D17BC4CEF1;
	Tue, 26 Aug 2025 19:34:37 +0000 (UTC)
Date: Tue, 26 Aug 2025 20:34:39 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nam Cao <namcao@linutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 10/11] vdso: Drop kconfig GENERIC_VDSO_TIME_NS
Message-ID: <aK4MTxWGoe461HGb@arm.com>
References: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
 <20250826-vdso-cleanups-v1-10-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826-vdso-cleanups-v1-10-d9b65750e49f@linutronix.de>

On Tue, Aug 26, 2025 at 08:17:13AM +0200, Thomas Weiﬂschuh wrote:
> All architectures implementing time-related functionality in the vDSO are
> using the generic vDSO library which handles time namespaces properly.
> 
> Remove the now unnecessary kconfig symbol.
> 
> Enables the use of time namespaces on architectures, which use the
> generic vDSO but did not enable GENERIC_VDSO_TIME_NS, namely MIPS and arm.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> Technically this is still too restrictive, as it prevents architectures
> without a real vDSO to enable CONFIG_TIME_NS. Right now this restriction
> only protects the SPARC vDSO. I have patches to drop it completely,
> as soon as SPARC is usingthe generic vDSO.
> ---
>  arch/arm64/Kconfig                   | 1 -

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

