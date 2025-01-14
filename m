Return-Path: <linux-arch+bounces-9739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9445A1024A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8CE18889BA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F920284A7F;
	Tue, 14 Jan 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpYgILLP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNLDwfdu"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1580284A5B;
	Tue, 14 Jan 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844023; cv=none; b=dQQ8fZrUdxjRxRIH3u28ppxfkxSASg+oBOh2yJLzRhmzUImtxhs+NfmPDG5bVIOsJ7koWUTAmjQl1G1cxG28OQy4fgt9S096czCop3xs7fanbQkPHHVeegBREi8ztCRg3li4mE4xw+ToGB/SHVQfmRJOCtpIdrEcX6mxHCU+zrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844023; c=relaxed/simple;
	bh=DZ9oOi5bm2IZgGdx0vZw9OiIJJcnUomT4Qpz04iKtgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3L8qnFZ1pkCiTqVNM6tg/ab5PooJjHPdHw8xYrbMDCq067Jv0pCuuvwiB1FfXTpl+0ZJxeBBXg25Ie1MZpIMGCwhTI2+OlKhOY2FMYsfDi89OKbyJneL5Rq/xqeiwx4GJHYA98E3Fw9UQLCYiNK0btDqAFkRrCoCsO37JxyQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpYgILLP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNLDwfdu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Jan 2025 09:40:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736844014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO/nQTULVjGFS4TV539Ayp3ZWEmdmkrMeax/kxGzbA4=;
	b=hpYgILLPXQ7SmDpUn60QinBCupBkKGG01dSa+3FTRxgCNWqRO6deM+5ajnF8F0Od2hJi0z
	cpxkUWPEgYxlKuFJaMAU5lKMBOMsqCHOy8bQU1BqkIFPZmu3C6m9guZo5f5gQe7CgWfAgj
	wXlrJ+vaLY79yRCYtXdOy7ekdepzM2+FdVeCX/9qEmHH9Disy0/cKsvFF+W1CBIVrlQCea
	CdXCh/v5ERdvmGs43kWOXeLO4kjwv39L0SRYilloKSbhCM9dQG/0V+AKwY49Zz5COQvlml
	dgkfNHCH4XX6YPAxAxjBf1Hw2izDtl+kF8Vz8wbVdA0kf1Oan0fsv7K9pzMvpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736844014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO/nQTULVjGFS4TV539Ayp3ZWEmdmkrMeax/kxGzbA4=;
	b=mNLDwfduAqnNjlxAvy66A4s1VI9taFFzoR0Bjcd3QoK3m68hFryx0HiKPwHcCzZrImHOWD
	IoGhvQiZnGydi4Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>, linux-csky@vger.kernel.org
Subject: Re: [PATCH v2 09/18] riscv: vdso: Switch to generic storage
 implementation
Message-ID: <20250114093609-6cb25835-f912-4f64-9ba7-54c67d4e2904@linutronix.de>
References: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
 <20250110-vdso-store-rng-v2-9-350c9179bbf1@linutronix.de>
 <20250113-kissable-monstrous-aace0cf7182e@spud>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113-kissable-monstrous-aace0cf7182e@spud>

On Mon, Jan 13, 2025 at 07:48:15PM +0000, Conor Dooley wrote:
> On Fri, Jan 10, 2025 at 04:23:48PM +0100, Thomas Weiﬂschuh wrote:
> > The generic storage implementation provides the same features as the
> > custom one. However it can be shared between architectures, making
> > maintenance easier.
> > 
> > Co-developed-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> For rv64, nommu:
>   LD      vmlinux
> ld.lld: error: undefined symbol: vmf_insert_pfn
> >>> referenced by datastore.c
> >>>               lib/vdso/datastore.o:(vvar_fault) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: _install_special_mapping
> >>> referenced by datastore.c
> >>>               lib/vdso/datastore.o:(vdso_install_vvar_mapping) in archive vmlinux.a
> 
> Later patches in the series don't make it build again.
> rv32 builds now though, so thanks for fixing that.

Thanks for the report.
Can you try to diff below?

I'm adding rv64 and arm nommu configs to my test matrix and
doublechecking all kconfig dependencies.


diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 335cbbd4dddb..583c55910612 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
        select ARCH_HAS_SYSCALL_WRAPPER
        select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
        select ARCH_HAS_UBSAN
-       select ARCH_HAS_VDSO_ARCH_DATA
+       select ARCH_HAS_VDSO_ARCH_DATA if GENERIC_VDSO_DATA_STORE
        select ARCH_KEEP_MEMBLOCK if ACPI
        select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE if 64BIT && MMU
        select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -115,7 +115,7 @@ config RISCV
        select GENERIC_SCHED_CLOCK
        select GENERIC_SMP_IDLE_THREAD
        select GENERIC_TIME_VSYSCALL if MMU && 64BIT
-       select GENERIC_VDSO_DATA_STORE
+       select GENERIC_VDSO_DATA_STORE if MMU
        select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
        select HARDIRQS_SW_RESEND
        select HAS_IOPORT if MMU

