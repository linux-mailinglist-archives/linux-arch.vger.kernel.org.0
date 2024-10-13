Return-Path: <linux-arch+bounces-8061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF099B8D5
	for <lists+linux-arch@lfdr.de>; Sun, 13 Oct 2024 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D994D2822DF
	for <lists+linux-arch@lfdr.de>; Sun, 13 Oct 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818212D20D;
	Sun, 13 Oct 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8OMxiME"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BB2AD18;
	Sun, 13 Oct 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809253; cv=none; b=ZBP2jS1zWUwdHFhlOMpJiE8y8fDIwDkgpTLiP6bjZTNSdsmxh0XI4nBiKcYdkQhdnXt1XH66Tyz8gZclfA1onLz11IcZ6nSPXjJwVVtbkWWlqDH9+KdboqfvvU4NEzlEZY5+ygVqLqmXWn5M9RdKGIDwjE0taVUCsfDaxhgXLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809253; c=relaxed/simple;
	bh=oCkJ2115ozRiZPDG4YoFw9nArbpLGJybX01Iv//69uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygnui3j1dp0vTwYL36AbZ8rQMm94Kb5QuV/3bce/6xN+todAZtzBWtCG7/n24nYsXbPsldBGWLiNWMecdojowQG9shqma41CUyUmjrMlwESL38BzRn/sNmW5e/3KEvOlWDQ26kh2r5r3NX7L+Q7pQ8XYZYpGMjIBuOKPzvdD3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8OMxiME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D61C4CECD;
	Sun, 13 Oct 2024 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728809253;
	bh=oCkJ2115ozRiZPDG4YoFw9nArbpLGJybX01Iv//69uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8OMxiMEktF+GQmyT4EDIYDJPag5y6VDyo/Ga7wsRXJJ99cwzji7jLF1sUHlppQrC
	 kfjLbesywWMnxfXjdxF/ttfJW0S6OCnAeNyYzQJk2u4D3I/IHI9w4eKpfc6/PVtfuE
	 WndRqsL5ofKVGyFE9G/gSdQ0nGfWKHlQ3BhJP58mfPjvLaZMFmHfTrH7D6YY90Mj1Y
	 Bf6s6/XciGtUwI6Emh7Lkdsn+ce052geMCuH5U+Tb+yPiRy+C2Qz+9+N2Qx0N42A/1
	 /daXS+24OOYM/5Gk5f/vkwwYyUK7ykCQAd22G6E+/Xf2yKVuhiVY41QpTSBy6H62Ks
	 p+MyUT+rRu6SQ==
Date: Sun, 13 Oct 2024 11:43:41 +0300
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
Message-ID: <ZwuIPZkjX0CfzhjS@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwjXz0dz-RldVNx0@infradead.org>

On Fri, Oct 11, 2024 at 12:46:23AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 03:57:33PM +0300, Mike Rapoport wrote:
> > On Wed, Oct 09, 2024 at 11:58:33PM -0700, Christoph Hellwig wrote:
> > > On Wed, Oct 09, 2024 at 09:08:15PM +0300, Mike Rapoport wrote:
> > > >  /**
> > > >   * struct execmem_info - architecture parameters for code allocations
> > > > + * @fill_trapping_insns: set memory to contain instructions that will trap
> > > >   * @ranges: array of parameter sets defining architecture specific
> > > >   * parameters for executable memory allocations. The ranges that are not
> > > >   * explicitly initialized by an architecture use parameters defined for
> > > >   * @EXECMEM_DEFAULT.
> > > >   */
> > > >  struct execmem_info {
> > > > +	void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
> > > >  	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
> > > 
> > > Why is the filler an indirect function call and not an architecture
> > > hook?
> > 
> > The idea is to keep everything together and have execmem_info describe all
> > that architecture needs. 
> 
> But why?  That's pretty different from our normal style of arch hooks,
> and introduces an indirect call in a security sensitive area.

Will change to __weak hook. 

-- 
Sincerely yours,
Mike.

