Return-Path: <linux-arch+bounces-10675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60757A5D244
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 23:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E352B189C1BC
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60410264A8C;
	Tue, 11 Mar 2025 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JMh6fI6C"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE391199FBA;
	Tue, 11 Mar 2025 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730784; cv=none; b=YHCBTqvoymG0w3fwSHvUnPaeVnbt1zkNElUXgvLHIOSSNwtCiYpheK+SF/FFH5kKna95M6EsPJCi7xz2nf2h/PgLWVeLUoWuDa5mDhw8W6DiWCONg0koMGnpSwl0dr/CWddhFKBaZgAwqQ27cRqlDWDAqpap+WMjbJurOhuwQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730784; c=relaxed/simple;
	bh=1FsEAoBQCwul9SXkYZakBAby+nof+BFT5YLa9ZLbmWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE5bBFsU4YQI5slNlwSO4amX1ivljkuFZHYXDhy4K2frMb6sbqTYqeyyExw/IhYSZi7Dvo4UFJyk3lZJHGqEN9ZpbhBogVuvoTzcTmYqB9thFvFWzM2Se1e7cCf8GWeLqogCXL/azMkhWpuEMSun2TuuByr5FTr9aithxY12Wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JMh6fI6C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VEtYjw1bJy2FyEgqNltD6h1CKY3ei2RKfjZVJcAYac8=; b=JMh6fI6ClsD77q6QFlO594QFyv
	sKF4LPcJaQcTQzRqy28KBHvEvNbva/Q4T4karOQKqy3zGz5C6FZf26kql8lG10rd/yWDclC8ace2t
	E8nv+RSCOd4MSUMTE37Jd6pwCjUlHw6IB88o86uJeQeu1vXLQvCcelUpTMH5zI9UW1Ln/0xzTIYnc
	+ZxX47CDZdxAPYKw9IFXZpxwHKBPV2C5StuOVk/ouA+IPkzqmTobJn+hz8OlhffXTedE2VG2aUA6F
	6ipRngplcXCrRC298lr1CqzLj89tc6A4tBT19pldI+iCk9Vc5UcPgIif4YSb1J3UDshYyiuaHWSri
	JsTs7FhA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ts7j7-0004gC-0h;
	Tue, 11 Mar 2025 22:05:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ts7j4-0003rB-0F;
	Tue, 11 Mar 2025 22:05:26 +0000
Date: Tue, 11 Mar 2025 22:05:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z9CzpTlA2e0jR7UJ@shell.armlinux.org.uk>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
 <Z9Cl8JKkRGhaRrgM@kernel.org>
 <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 11, 2025 at 09:33:29PM +0000, Mark Brown wrote:
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.14.0-rc6-next-20250311 (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1741691801
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x00000000

If that CMA address is correct, then it's wrong. virt machines start
DRAM at 0x40000000. This is a small memory VM:

[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x0000000045ffffff]
[    0.000000]   HighMem  empty

and this is a larger memory VM:

[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
[    0.000000]   HighMem  [mem 0x0000000070000000-0x000000007fffffff]

Neither have CMA enabled (it's not necessary for a VM).

On a real platform where CMA and highmem is enabled, then:

[    0.000000] cma: Reserved 16 MiB at 0x4f000000 on node -1
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x000000003fffffff]
[    0.000000]   HighMem  [mem 0x0000000040000000-0x000000004fffffff]

So that "cma:" line you are seeing is indicating that something is very
very wrong - it should definitely not be zero.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

