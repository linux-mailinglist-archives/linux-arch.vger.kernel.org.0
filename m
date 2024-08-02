Return-Path: <linux-arch+bounces-5915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187F945B31
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E121F24D25
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F711DAC69;
	Fri,  2 Aug 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zw/KFesV"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476E1C2BD;
	Fri,  2 Aug 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591620; cv=none; b=hmsmlMeQwSwJ1SzFTuVFl9DxZfFZ8/6MQsE96XU6P54JGSuIt4GFc/nSwJOFc0vBbl2XgrenNjeGZNbKX24DiHR7xc0eImuY2Xs6HIuesN2pgVbaXm0U09prYmxVIOWlbZHCt8mp/BiuVugmELgwHTEfKaUAzOiDkbZSG592h3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591620; c=relaxed/simple;
	bh=msG2bFBQBZqPQE+/Mc9DqGJxJPZH2XOVibyXJ4vjKh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd7GzLm6K/uQ4IZYPmDM6zGfWOv97dipwj2luUUe0B49BFs4rb47WltcQLF4r56SNqofOKoezyqt22NOIS+rVgeKkd4YENVqciHm+TKequNhVnog+LYl42YxePnwVXwuO9JOJW4MbAM3vjHNsnJ1eHrKEDoxvphSSzBKjBbHP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zw/KFesV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Z+aZs0SZ0YC0bCCXeGs8Vm6t97KZ36rxeFA4yv6VTs=; b=Zw/KFesVnIdv3zfmHq5Lgrs5Kv
	latri07BG8i4S1nwE+kxVm9CRqcaJllTU0uxtIwT+uKPxG/dphWK7zASeRnTfEmWTLCOvBAx4B+z1
	Ern+lvCmTDVXbcv1dPN0zqMgMzI33TKcRsu4+hzgnhPyCmKqs/Bp988YBtzUM25rpb14ipJQ85AVw
	A1qBCb2qKv9XsTXMMRilLG3dSTaFmu2TAPcrSPMf3fgPRaPA0fNV8MXpDhCO0KnujT0DRLJAQNj5X
	5mfm7dVDr1DErxLIcmXKv4X2gk+qdWI705etIfroB8ccBkAw6pd1ol+D+g0iBbcD4UIEBWrLj46po
	txqO3NeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZolO-00000005g5O-43JP;
	Fri, 02 Aug 2024 09:39:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E0F230088D; Fri,  2 Aug 2024 11:39:54 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:39:54 +0200
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
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev,
	WANG Rui <wangrui@loongson.cn>
Subject: Re: [PATCH v5 1/2] rust: add static_key_false
Message-ID: <20240802093954.GH39708@noisy.programming.kicks-ass.net>
References: <20240802-tracepoint-v5-0-faa164494dcb@google.com>
 <20240802-tracepoint-v5-1-faa164494dcb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-tracepoint-v5-1-faa164494dcb@google.com>

On Fri, Aug 02, 2024 at 09:31:27AM +0000, Alice Ryhl wrote:
> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
> 
> It is not possible to use the existing C implementation of
> arch_static_branch because it passes the argument `key` to inline
> assembly as an 'i' parameter, so any attempt to add a C helper for this
> function will fail to compile because the value of `key` must be known
> at compile-time.
> 
> One disadvantage of this patch is that it introduces a fair amount of
> duplicated inline assembly. However, this is a limited and temporary
> situation:
> 
> 1. Most inline assembly has no reason to be duplicated like this. It is
>    only needed here due to the use of 'i' parameters.
> 
> 2. Alice will submit a patch along the lines of [1] that removes the
>    duplication. This will happen as a follow-up to this patch series.

You're talking about yourself in the 3rd person?

What's the rush, why not do it right first?

