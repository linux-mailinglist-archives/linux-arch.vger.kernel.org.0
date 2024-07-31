Return-Path: <linux-arch+bounces-5782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78199433FB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3662FB249A7
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AF1BC081;
	Wed, 31 Jul 2024 16:15:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732A1BC2A;
	Wed, 31 Jul 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442510; cv=none; b=Wfvp/0zL/C13uDMspEjbFTjD5EGSTDvVrB+h9u5nbOI/J+9GjhjxfZtYp23ihqDWbw6ctaQeAnVrvI0nThWnmzXBVs6m1jQdfkiYDNLBofClUuIsg8YGTM80FsjZjZ5afKwvY5SCThdKnn9wk/qvvt3Iy0wc1cbbEXnUfj3XeYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442510; c=relaxed/simple;
	bh=pfHnPMYK0TtleosbWCfB/5JPB/LqQy3ukFb8Be23aPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBPNbVwP5N7Twdzu+RLivXWR0SPEroLFYPNvBCxXbJrrXIBiScysvNFjc5UA/fbl1Z+rnMYrO/NzAWk73N9AHTSTE2s5PqWvY04uIYBLU+2DtjYRdCnJEqRYxzmlv7q+dloM7M1usijOrh5Pp0tUg1yZ3BntccR35f2eYbCYXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC10C116B1;
	Wed, 31 Jul 2024 16:15:04 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:15:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, linux-trace-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradaed.org>, Sean Christopherson <seanjc@google.com>, Uros
 Bizjak <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-arm-kernel@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] rust: add tracepoint support
Message-ID: <20240731121539.0888738b@gandalf.local.home>
In-Reply-To: <20240730113527.5c9896db@eugeo>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
	<20240628-tracepoint-v4-2-353d523a9c15@google.com>
	<20240730113527.5c9896db@eugeo>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 11:35:27 +0100
Gary Guo <gary@garyguo.net> wrote:

> > +/*
> > + * Declare an exported function that Rust code can call to trigger this
> > + * tracepoint. This function does not include the static branch; that is done
> > + * in Rust to avoid a function call when the tracepoint is disabled.
> > + */
> > +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> > +#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)			\
> > +	notrace void rust_do_trace_##name(proto)			\
> > +	{								\
> > +		__DO_TRACE(name,					\
> > +			TP_ARGS(args),					\
> > +			cpu_online(raw_smp_processor_id()), 0);		\  
> 
> I guess this doesn't support conditions. Currently the conditions are
> specified during declaration and not during definition.
> 
> Would it make sense to have
> 
> 	static inline void do_trace_##name(proto)
> 	{
> 		__DO_TRACE(name, TP_ARGS(args), TP_CONDITION(cond), 0);

But where is the "cond" passed in from?

I guess in the future if you want to add conditions, you would then just
add:

#define DEFINE_RUST_DO_TRACE_REAL_CONDITION(name, proto, args, cond)			\
	notrace void rust_do_trace_##name(proto)			\
	{								\
		__DO_TRACE(name,					\
			TP_ARGS(args),					\
			cpu_online(raw_smp_processor_id()) &&		\
			TP_CONDITION(cond), 0);				\  

-- Steve

> 	}
> 
> in `__DECLARE_TRACE` and then simply call it in `rust_do_trace_##name`?
> 
> > +	}
> > +
> >  /*

