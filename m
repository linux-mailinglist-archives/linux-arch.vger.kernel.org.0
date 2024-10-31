Return-Path: <linux-arch+bounces-8734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2959B70EE
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 01:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4354DB20F9A
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E5EC2;
	Thu, 31 Oct 2024 00:14:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C1360;
	Thu, 31 Oct 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333655; cv=none; b=mWMGN5WFg3mRBrrnTtvciooM+ckgKrGhoiO5Fl2jaIGjR/lLCILDXAiXbqkCTSOpLuH7yslX/E75BC8ADbNkAuis+UM1VTL80asSIZM+RsKROBUdWRZwiyl6i+hGWvgpblaStcdh4jbCkwJLi6Jc+nwjzNId85BfO2MH/sUnsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333655; c=relaxed/simple;
	bh=Cb+W+pVunO2LoGhA6b9apl9QwWngOitHlidshvRfXoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMfS+69VMsfjThzStMbrwdRqfZQSw6pZK1GhA+6LEs2BByI0Bso2F5a2E3Xct3JAm+RzSWXPUyAFAZ7iK7lKhPNnt2Jc8oWXDDOQzf3PUuQ3yj+ka02j2SvLnH/2rrj7ex40OlhruCGAq22YLN3ZoubIH/WbQb+NioHMVQ0U+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4CFC4CECE;
	Thu, 31 Oct 2024 00:14:10 +0000 (UTC)
Date: Wed, 30 Oct 2024 20:14:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak
 <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
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
 loongarch@lists.linux.dev, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v12 4/5] jump_label: adjust inline asm to be consistent
Message-ID: <20241030201408.732cebd5@rorschach.local.home>
In-Reply-To: <ZyLLCmq9-9BX7GBd@shell.armlinux.org.uk>
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
	<20241030-tracepoint-v12-4-eec7f0f8ad22@google.com>
	<20241030191316.2a27ff1b@rorschach.local.home>
	<ZyLLCmq9-9BX7GBd@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 00:10:50 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> > Still missing an ack from the ARM maintainer (32 bit, just added) and loongarch.
> > 
> > I'll wait till Monday, if I don't hear anything against these patches
> > I'll pull them in.  
> 
> As of what has recently happened, I am not participating in technical
> activities until such time that I'm told what is now acceptable. So
> far, that has not been forthcoming, and thus I believe it is unwise to
> engage in technical discussion.

Oh, OK. Thanks for letting me know.

-- Steve

