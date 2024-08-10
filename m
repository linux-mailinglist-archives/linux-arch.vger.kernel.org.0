Return-Path: <linux-arch+bounces-6146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212894DEA2
	for <lists+linux-arch@lfdr.de>; Sat, 10 Aug 2024 23:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5F1F21560
	for <lists+linux-arch@lfdr.de>; Sat, 10 Aug 2024 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F113C83A;
	Sat, 10 Aug 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSyOlZN4"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D93AC36;
	Sat, 10 Aug 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723323877; cv=none; b=sHMUvV7+1AJKoTaHy5kOSmbRSv/MdPLaC9pphvtqysU48DkQ4g0Bpiz7peSVHwltVKjk3xix2pPeMpk4/pYBFaLw0BnsO5PwfbrDBW5bFSQZjUl79InKHst6x1H0erBDxCULr2v9Kc9pgvSZFCiu/fjP5m6XWahvzwVGok5sQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723323877; c=relaxed/simple;
	bh=U6uyqW0VIsr3ynf+I05mOzu59oLHp/XRqRKQdkUKQPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkFoGwfSWIZ9nV+AcCAuP/+Y9mk2ozoqkIHT1FL/Gy0/bqNkZApyG1qALvdmIrDjNRfr8mVuc1ZvgK2jaG05zSpCrMWz4pus+4Uj0MzhJcxKdMXMhhdAe4RU4VnZ+oo3FJq774gSkKR2EcT16lK7XWOhJO/ch8inhkoEtaSRaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSyOlZN4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L5ZaMkcysgxHBoobfCUH51gejY2SZF51sPwk8BxYjEY=; b=WSyOlZN4Nni7gLJNXzcNaOAvzJ
	AGptP8rQIgN+f0r3MKaa4DkO8n0uajfvfFHFin2/Bt8kD3YAo9vEUuRl1Bupm9EadiUsbtx7hSql/
	a8CkFGhTcyPe5ZoM/Dz28ZIEApK1jA67plyopWOnjdxd8Am17AfJWo7UaF3NqvbZcOn5fRgJ5ikG/
	p7WlXxAtLLnWnn/XjjEmwkOEdDCvSLYCRAq1X4fFc4ZgXbYymk4kT6SIvGoQtEcCkjSjqLxp+eKdj
	acvI13ItRy/3Cn738bv0ltJVQZNhgXszAuribt/HlAdGjnA9yaqgfs/Kf+cSvUsGKtI8rLZwpgI+r
	WLGtRLyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sctFn-00000007Fdg-2gux;
	Sat, 10 Aug 2024 21:04:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3BB1B300729; Sat, 10 Aug 2024 23:03:59 +0200 (CEST)
Date: Sat, 10 Aug 2024 23:03:59 +0200
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
Message-ID: <20240810210359.GD11646@noisy.programming.kicks-ass.net>
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
 <20240808-tracepoint-v6-5-a23f800f1189@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-tracepoint-v6-5-a23f800f1189@google.com>

On Thu, Aug 08, 2024 at 05:23:41PM +0000, Alice Ryhl wrote:

> +/// Wrapper around `asm!` that uses at&t syntax on x86.
> +// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
> +// syntax.
> +#[cfg(target_arch = "x86_64")]
> +#[macro_export]
> +macro_rules! asm {
> +    ($($asm:expr),* ; $($rest:tt)*) => {
> +        ::core::arch::asm!( $($asm)*, options(att_syntax), $($rest)* )
> +    };
> +}
> +
> +/// Wrapper around `asm!` that uses at&t syntax on x86.

^ the above line seems out of place given the 'not' below.

> +// For non-x86 arches we just pass through to `asm!`.
> +#[cfg(not(target_arch = "x86_64"))]
         ^^^
> +#[macro_export]
> +macro_rules! asm {
> +    ($($asm:expr),* ; $($rest:tt)*) => {
> +        ::core::arch::asm!( $($asm)*, $($rest)* )
> +    };
> +}

