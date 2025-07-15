Return-Path: <linux-arch+bounces-12776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF3B057DF
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF67A4E45D9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC1270EB9;
	Tue, 15 Jul 2025 10:33:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742825E816;
	Tue, 15 Jul 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575584; cv=none; b=JkvQMgLOfae0Qa4uCatnpZ5xSdQIAd0hjLWQNjM6wsVRKJYCeCsrMEBeV8feFv7IvcSAksF2UDvuNYbSTACKpNraNhzh3FPO6rVs3rSeYcF/xGabV/v8TnSNkhQKf5YLAK+l1jLaXQcxoix18KdhJ/4xAr+z1OBTGXUk+eYuG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575584; c=relaxed/simple;
	bh=xwq2Wx5SphMaUmADLHLqoOqRQ+nHABl3M0HNZKp0p0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXcfHtB6GrNvS/CQFcIpiuFm1jy5yvVuPNcqBjXGxmFkxQ/yT+AdgLElHVnTBYrdkRuTl4BPVkNFGIFx132zC//xfGP/zwX5VBY3cWvIStardIqphdpn1ArzWFIkWDLHupSWsWMhcg+somrRjcBLohKNzDO93BkFpxhSpy6REL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C4A1515;
	Tue, 15 Jul 2025 03:32:52 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C689E3F694;
	Tue, 15 Jul 2025 03:32:52 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:32:47 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chris Zankel <chris@zankel.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonas Bonn <jonas@southpole.se>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 00/23] binfmt_elf,arch/*: Use elf.h for coredump note
 names
Message-ID: <aHYuT0SxX65tAEp3@e133380.arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
 <175255782864.3413694.2008555655056311560.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175255782864.3413694.2008555655056311560.b4-ty@kernel.org>

On Mon, Jul 14, 2025 at 10:37:11PM -0700, Kees Cook wrote:
> On Tue, 01 Jul 2025 14:55:53 +0100, Dave Martin wrote:
> > This series aims to clean up an aspect of coredump generation:
> > 
> > ELF coredumps contain a set of notes describing the state of machine
> > registers and other information about the dumped process.
> > 
> > Notes are identified by a numeric identifier n_type and a "name"
> > string, although this terminology is somewhat misleading.  Officially,
> > the "name" of a note is really an "originator" or namespace identifier
> > that indicates how to interpret n_type [1], although in practice it is
> > often used more loosely.
> > 
> > [...]
> 
> Applied to for-next/execve, thanks!
> 
> [01/23] regset: Fix kerneldoc for struct regset_get() in user_regset
>         https://git.kernel.org/kees/c/6fd9e1aa0784

[...]

> [23/23] binfmt_elf: Warn on missing or suspicious regset note names
>         https://git.kernel.org/kees/c/a55128d392e8
> 
> Take care,
> 
> -- 
> Kees Cook

Thanks!

Assuming nobody screams about things going wrong in next, I'll plan to
water down the paranoid check in binfmt_elf.c:fill_thread_core_info().

Anyone copy-pasting a new arch after this is in mainline shouldn't fall
foul of this.

Cheers
---Dave

