Return-Path: <linux-arch+bounces-6149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D152E94DEE4
	for <lists+linux-arch@lfdr.de>; Sat, 10 Aug 2024 23:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DAF1F221E1
	for <lists+linux-arch@lfdr.de>; Sat, 10 Aug 2024 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBB1422B4;
	Sat, 10 Aug 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CchIcJES"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C83AC2B;
	Sat, 10 Aug 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723327072; cv=none; b=C69k7qCY1PfXXk2NYFRFdw449A+h+a/kyelsruovjkW4MDvsWOfuiZe5X7iqOVmsPjyhM7FWOyNf9rp7/VTHHzFTzyszExledqeY7xnyjUlpy1nAk+TU0O/gZFuMDhloB1DBKxZI70rCCTzFSJEEYT+qAXFJw2gPDc49QnAKz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723327072; c=relaxed/simple;
	bh=6M6OcLGnp25ebgElmXz0aRTyWzB/ZimcF/NK7bAz5KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LecfqfGMsrB+x7XY3xs41YySCRlirRgGxkxPecL91WL6kVRde1wzLuiUPPvxiioooCjuJuAaJX1nlpSCareAe91NRdfbGd4ydW++IvmZ6/nFC29cl05F+akoV0d3/yAGfv+Td9bnUqjcpvFdQVgqk9YX/f1YN0JUUoq07bUXHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CchIcJES; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nv4fvDJIpIyu7ak6kOoHUmIFrheca8Dy1SaM5jKCQBw=; b=CchIcJEStTW3QCkJIHj3lmbQSu
	xf8QRZuNWJlB+wiL4FjeZvZPIThB4Ijc0mM3hrLuBpq04UhU0FgjYhY5g+dpNedWesJl/kIsq8PhD
	46rKuujxcgXCnAxFBmMNymWw/hO2A3FCudxNbjaD4fCOmNlJstMjZd+q8S0/9M/yadBGQNda4Jgez
	AnAKJfcys04AoLltQB+0vwatNC0cvDq9lezZgRPkWapjL8nHIgOTMB5dzFqmOAZy9gk7CO+vhkM/3
	LQvyL68QUnRLtiufKuwckn1MBeRo8wa1YS/BpFT0AvfTq64ilA7JxP2ll5q6O3H3ZmH4w9JN6bmlN
	134UCeEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scu5R-00000007G0f-2ye9;
	Sat, 10 Aug 2024 21:57:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6FDB5300729; Sat, 10 Aug 2024 23:57:20 +0200 (CEST)
Date: Sat, 10 Aug 2024 23:57:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 5/5] rust: add arch_static_branch
Message-ID: <20240810215720.GH11646@noisy.programming.kicks-ass.net>
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
 <20240808-tracepoint-v6-5-a23f800f1189@google.com>
 <20240810210359.GD11646@noisy.programming.kicks-ass.net>
 <CAH5fLggwLOhP_6b==dc73uJCUBcu2fNQ7SCnqovv2hVXFtUHEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggwLOhP_6b==dc73uJCUBcu2fNQ7SCnqovv2hVXFtUHEQ@mail.gmail.com>

On Sat, Aug 10, 2024 at 11:44:13PM +0200, Alice Ryhl wrote:
> On Sat, Aug 10, 2024 at 11:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Aug 08, 2024 at 05:23:41PM +0000, Alice Ryhl wrote:
> >
> > > +/// Wrapper around `asm!` that uses at&t syntax on x86.
> > > +// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
> > > +// syntax.
> > > +#[cfg(target_arch = "x86_64")]
> > > +#[macro_export]
> > > +macro_rules! asm {
> > > +    ($($asm:expr),* ; $($rest:tt)*) => {
> > > +        ::core::arch::asm!( $($asm)*, options(att_syntax), $($rest)* )
> > > +    };
> > > +}
> > > +
> > > +/// Wrapper around `asm!` that uses at&t syntax on x86.
> >
> > ^ the above line seems out of place given the 'not' below.
> 
> Comments with three slashes are what gets rendered in the html version
> of the docs [1]. This way, the rendered docs will say that the `asm!`
> macro is a wrapper around the built-in `asm!` that uses at&t syntax on
> x86 regardless of which platform you build the docs on.
> 

Urgh, that's not half-way confusing. Also, whoever wants to read HTML
when you already have the code open in your text-editor?

