Return-Path: <linux-arch+bounces-7205-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A4974F97
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B83F1C2223C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F79183CB8;
	Wed, 11 Sep 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbotaJ9v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B81714C7;
	Wed, 11 Sep 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050141; cv=none; b=SWn5SAI95HGlc+qa6FDixWFE+HitMAtA+LXU3NTclAQYxsTVRee2uUYmGzaKKGGPxDbCgGJ3uUE9qyWRz7/ntwxWOlsRxadW9v4PxBMz76/3sNpFzdkf6BDUYubZrUsbDMflUdXWlTNtEODghxExQOVljswvnp55yMFgBEjCvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050141; c=relaxed/simple;
	bh=8dWUooDoOxWC7Oca2MrJGx9YGMSeHFyGIMo9brZfk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpzLdAsecpb7Qe9jFUs/nEl+g3o+49nPc2KP/ip2ykp1HKeiqHlT0eB9lMVAXdBB2cyEkXsZMox7m1+wQB/pca6PXrSSxyIrSNrsF0W/s0poTjrMDRyh5TxBVx6qweI1GxkfqYnChDZUKVhxQBphKy6mYaFNO+zFnCiJ1vWiehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbotaJ9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6640EC4CEC5;
	Wed, 11 Sep 2024 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726050140;
	bh=8dWUooDoOxWC7Oca2MrJGx9YGMSeHFyGIMo9brZfk4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbotaJ9vmctcoaZuCwWhMhi9fy5FIYS+b/HAYEruiQzbymZobfKvo47gbwbW+fy1t
	 kmLvVspCoENf4YJ7MG6qyNvTNAzqVaH95FS48N7vxf5HH4w5x9HqfrCJhhZOz0qSYT
	 FD4o6UXDBrwti0gG104xpdNn7cPukgyiIL3B2k9CSxzBbiHil9QxdJScuV7IplHt5W
	 o1J96IBLlfPsULekNIV4gsIz3YvGb3R5Lz6mZ8XITZx+iA0s8RnjfUTf8lq+EpquOb
	 tNbpjbzeeIR2Bev+q9SOEtahsme33D5y9Lo7KW1fhsL38m9Zfs1kaXRBBkfiBGmn1+
	 HGqEyFiCasPYg==
Date: Wed, 11 Sep 2024 13:19:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
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
Subject: Re: [PATCH v3 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <ZuFumwtGQGOPMDo3@kernel.org>
References: <20240909064730.3290724-1-rppt@kernel.org>
 <20240909064730.3290724-7-rppt@kernel.org>
 <20240909092923.GB4723@noisy.programming.kicks-ass.net>
 <Zt8HiAzcaZS8lHT-@kernel.org>
 <20240909104940.71d8464c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909104940.71d8464c@gandalf.local.home>

On Mon, Sep 09, 2024 at 10:49:40AM -0400, Steven Rostedt wrote:
> On Mon, 9 Sep 2024 17:34:48 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > This is insane, just force BUILDTIME_MCOUNT_SORT  
> > 
> > The comment in ftrace.c says "... while mcount loc in modules can not be
> > sorted at build time"
> >  
> > I don't know enough about objtool, but I'd presume it's because the sorting
> > should happen after relocations, no?
> > 
> 
> IIRC, the sorting at build time uses scripts/sorttable.c, which from what I
> can tell, only gets called on vmlinux.

Regardless of the tool, the sorting should be done after relocation, no?

But isn't mcount loc is in data section? Then there should be no problem
just drop this patch
 
> -- Steve

-- 
Sincerely yours,
Mike.

