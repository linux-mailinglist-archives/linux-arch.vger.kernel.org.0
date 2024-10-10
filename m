Return-Path: <linux-arch+bounces-7970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CE9986F4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5970288382
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D11C8FBD;
	Thu, 10 Oct 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i15xpEq/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410F1C7B8F;
	Thu, 10 Oct 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565284; cv=none; b=DcyQ2lBwhdjZpkOtJ0PVBCmjCGD1FVEdtBoY+Vt9YOPmefsw6xtUGEpcUQcKlY/F1m1LCJ42gQTfWMLWkVo3ylensI4c5KES77YOTlZs/JBfFqhWp+FaARZRjeerXjRxiyenDdvjG8bSTRX6jYFCdXBg/b9QZ2geR0losu8w+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565284; c=relaxed/simple;
	bh=0gFND+MAHX6q3fPU9Dm7aa3AX+VkNdk2ZdK9663ePGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPeAz5Ni8C8daLh6FKYFhAMiYN0TD/1HqsU8wbKvJe0Z96mlV4S/cQ4aA9JGIWhDCQX+fFSmqLW1kHLjy1Cmhn4zUraIWN9+Brw1aE5Qxw1vW6bJpPnhVMnzUg/0rvwT+mhs8pNzO7S5K0Em/Lmvh+wR4pwb5oeMN9aCafu4rkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i15xpEq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F0EC4CEC5;
	Thu, 10 Oct 2024 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728565283;
	bh=0gFND+MAHX6q3fPU9Dm7aa3AX+VkNdk2ZdK9663ePGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i15xpEq/kuFAv6DlXG15A1e80Zkeyfpm7KcH2z/4b7LHy0huNtJIfhTPl8l4m2Thz
	 DrC+EerzAtj77QkSwvdLuoM9HsdVcSXAYblfY52ni7z3rWCwNvYecLnzzamyv05TxQ
	 MvyRQw4iBhqZGVncP0l5I4u44ZK9GkUbVv2NjZJ1KmbX6KkRkPzCVKd/P5aEdD5W04
	 r/juMpxct8TYbYtPQygo8mwFvlF95PkeOYNJV8aiyjpOL0HlbI0t0P6KYVnwxFYXRs
	 bP4FdthxlHe3zfpEHTln3UXCWui5XHPdWaBkcJjwrkqkqBVwNb4EXbX5FI3Wx8W6oT
	 ueyyZehAwF8+A==
Date: Thu, 10 Oct 2024 15:57:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <ZwfPPZrxHzQgYfx7@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwd7GRyBtCwiAv1v@infradead.org>

On Wed, Oct 09, 2024 at 11:58:33PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 09:08:15PM +0300, Mike Rapoport wrote:
> >  /**
> >   * struct execmem_info - architecture parameters for code allocations
> > + * @fill_trapping_insns: set memory to contain instructions that will trap
> >   * @ranges: array of parameter sets defining architecture specific
> >   * parameters for executable memory allocations. The ranges that are not
> >   * explicitly initialized by an architecture use parameters defined for
> >   * @EXECMEM_DEFAULT.
> >   */
> >  struct execmem_info {
> > +	void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
> >  	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
> 
> Why is the filler an indirect function call and not an architecture
> hook?

The idea is to keep everything together and have execmem_info describe all
that architecture needs. 

-- 
Sincerely yours,
Mike.

