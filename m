Return-Path: <linux-arch+bounces-8290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F469A5157
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 00:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDBC1F215B5
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2024 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20481192D69;
	Sat, 19 Oct 2024 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9THhAss"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F11F937;
	Sat, 19 Oct 2024 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729376464; cv=none; b=KtjN/bZnua7/yIsH9s5CqKxji7af6upHJ0FbAGgNKezL8uAuk2Si0oe3tRV+pq5w3gHaNt4RkswLFeWIJcWrHy0DOxDbhl9BAKyjNmzvzycl8mySAMF7ieYxbt3MJcSu2piE1dnM1xhK94ZCvFxSCKs+Dg2uzdjalwrE03E1mR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729376464; c=relaxed/simple;
	bh=5gQmz1RIfovnudLGPoWTTrhu31GiNk6o17nNTgx35kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgHbf1OP4F2ziBSKV3UVKCBS4TH/ncfLGEjGN/lDUzMXOwcJJ1T16Y4LMIzOEste83El5jqbH+BMtPl0ja8R1iEpjTclaFoE7PFkhlHIMZBBFhfciGBIJXt2+QoqJFQO5s1fUBsVdpANQDWTbrkmcGrTXQMUW5N4Nee1KtRMp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9THhAss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8C7C4CEC5;
	Sat, 19 Oct 2024 22:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729376463;
	bh=5gQmz1RIfovnudLGPoWTTrhu31GiNk6o17nNTgx35kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9THhAssNHC3TkkEIP32NhnxtjGCvkrF8IMK7gfPE5R73nlCYNjpfi7UU/mvrzeyk
	 GvKGSqwp9shJLliIAKLLtja9DuBkQWG41Cw78nVYptDdzjOkl5S/+ZSbL0Y5Qrfcp3
	 W83fHGgimj3quObRBksH/QbuKViyT7Wt1OnrHbP2p+yA26C8rFrD3HPgtYKX1j+BmS
	 WCIL91KqYeCu/6mSc7J/+nGvIGlsG5mBPltfJujjx4oyzw3GBHjVE21Kxk+4M79bKm
	 MFk4YVLCYLYdXNDHKLddhtWdWe08pTL2h0q7BLwFmfcTBDoJzrjAafMJK9hPJYq33V
	 1krzp7/nDUHgw==
Date: Sat, 19 Oct 2024 15:21:00 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 3/8] asm-generic: introduce text-patching.h
Message-ID: <ZxQwzGlyJOC2-DcG@bombadil.infradead.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-4-rppt@kernel.org>

On Wed, Oct 16, 2024 at 03:24:19PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Several architectures support text patching, but they name the header
> files that declare patching functions differently.
> 
> Make all such headers consistently named text-patching.h and add an empty
> header in asm-generic for architectures that do not support text patching.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

