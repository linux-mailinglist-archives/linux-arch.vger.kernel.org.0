Return-Path: <linux-arch+bounces-8295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A89A51A6
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 00:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B346228440D
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2024 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281C192B99;
	Sat, 19 Oct 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWWcwFHR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710121922CC;
	Sat, 19 Oct 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378307; cv=none; b=bFRRvAdCM9oIbcpz+ux12sdIRzBu3awh13uxbp4CNELJYz28gE5GYBfGkxyyekI+sJs6YYIgvujDUE73V8yi1XsQXRtMvRCtkH1m0kZBWQZi1q1mGZQAweRQCtlsFEyUKfPfGHVtQbcGH338Gih/VztW5FNNyRO6H9UlW8RVHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378307; c=relaxed/simple;
	bh=iaKyJYsgDj5oq6LrolQ8TT/cIGmsXYFI9lXbWUpr55Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjYH+MgPahDCMPiM+C+9mamJ/P15+LTbeAuU9sw5ZLdV3jqDjHTm1xXdtLYA5HDLZYs22/1T/xALK5D4UQ5PKlImXnOOqHzEaHWtTBZoDC3vv9poTtTEfjjSr+fCk6zUJOfmLRCSHtEChVh5B5E21lYRWXzx91yzQNB+bN3bXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWWcwFHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A509C4CEC5;
	Sat, 19 Oct 2024 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729378307;
	bh=iaKyJYsgDj5oq6LrolQ8TT/cIGmsXYFI9lXbWUpr55Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWWcwFHRKAv10UFeMWidR+oArwiG2+r721GO7uSmTpQx0pOBJf1X5cPUKD4gQg0+v
	 evgCS5YusRtKfCXFwytoJRX7ZRENJRAMHCt8HvG03nMPWzjaJDvjdrgLKvwNx81i5w
	 NIzDOiB7M0V+Ul7Gwqxo7hFP4wjCIx8CdeY/s0mZyLShSAGZB3TOEh3ca9PA+vMo3W
	 q8+DRfeiSbEMT2pfBoZx2+ts1c/ZoMbSDOpbvF1L4SRM4K2S0rC8EknH09OaDU5jzH
	 5NBzulTpDRDsAwrp/w7GYCrOs4CtagANrNUd5w9SX4IoQrxyUxMdI/Mnop054oa6hH
	 EFlkfWan9WOpw==
Date: Sat, 19 Oct 2024 15:51:43 -0700
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
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 0/8] x86/module: use large ROX pages for text
 allocations
Message-ID: <ZxQ3_8xNPYsQA5GH@bombadil.infradead.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-1-rppt@kernel.org>

On Wed, Oct 16, 2024 at 03:24:16PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> This is an updated version of execmem ROX caches.
> 
> Andrew, Luis, there is a conflict with Suren's "page allocation tag
> compression" patches:
> 
> https://lore.kernel.org/all/20241014203646.1952505-1-surenb@google.com
> 
> Probably taking this via mmotm would be more convenient.

Yeah, it's already there on Andrew's tree, fine with me to go through there.

The linux modules KPD [0] has picked this up from the mailing list and
tested with kdevops, and this series passes our modules test now [1], and so:

Tested-by: kdevops <kdevops@lists.linux.dev> [1]

Link https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11420097546 # [0]

  Luis

