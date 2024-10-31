Return-Path: <linux-arch+bounces-8733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238CA9B70E6
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 01:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C07C1F21E35
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2838B;
	Thu, 31 Oct 2024 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tZusAJI3"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4F10E0;
	Thu, 31 Oct 2024 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333513; cv=none; b=NpVIrkxbnb+lmTQBnT3g4J/povkm3+6Q0ez8hTvo2El1DSSPmmqS9xucqLpGCafE2j8I0G5UCdw3xPvaSfHH11hq/dP7zVuV9O2W9LZnoXEiG1Lj/Hb8b9VbO07cRF+BRPIc+AlDQJSqsAJ3CrJuN4iIr+x1SkD9Pu+pcWLdang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333513; c=relaxed/simple;
	bh=Ceq1779UGAl8iOYIzrR6U8YByCcRrYMnJdZdGnLER50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbJDq4HZqlzusvl10MxsPgSKEhTXLGIt/ZVtwgpP3aGe4vLSPIRvvNf1tgN3ItQWac9ZwCuDXcEQ5v1sxOuvdb6HzhMNVQ9OUH0xjoRiRMoI/lhbwO9YHhx0A+uia8QOMox8B/8yjDGNPr+Pg0HPUmukSK/B+cQXUYriMB9fddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tZusAJI3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ADnOlDvSfcc2o2XTsLbJuVcsj8qk7QSX8jkP5KkZ5Mw=; b=tZusAJI37JDe16l2CZBpAGOoEF
	bwhxtvPkUCgV07xUfbic6dfNujjddnRpFUT28MncKLe8Cf9RmQNEQ2CluZau/8U5ySVsGog8VqShd
	EFBOOAGnSgY3OCnoxcZfxON8e5KQ8V09Hh3+bH6dtqWaa2OqpYH3DbGXF1WaZX9l4oNY7VJdjWvz0
	JulQkHoTGHzdnWrphAeFjrxUXwPucq8lnQH/pm3sH0UdPtqKBgsjh0uQgnAxpdSyzr/dvps0alFUp
	2XKigXu9odZbDzMnWUvymb2OR8E4jOpAAD3qyv2n9sn0Wx4BlrHq0O5BRCP3jFtjBx92Vj2eWcf9S
	Ynf3jZjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t6ImG-0000qB-0h;
	Thu, 31 Oct 2024 00:11:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t6Im2-0002OR-10;
	Thu, 31 Oct 2024 00:10:50 +0000
Date: Thu, 31 Oct 2024 00:10:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
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
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v12 4/5] jump_label: adjust inline asm to be consistent
Message-ID: <ZyLLCmq9-9BX7GBd@shell.armlinux.org.uk>
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
 <20241030-tracepoint-v12-4-eec7f0f8ad22@google.com>
 <20241030191316.2a27ff1b@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030191316.2a27ff1b@rorschach.local.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 30, 2024 at 07:13:16PM -0400, Steven Rostedt wrote:
> On Wed, 30 Oct 2024 16:04:27 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > To avoid duplication of inline asm between C and Rust, we need to
> > import the inline asm from the relevant `jump_label.h` header into Rust.
> > To make that easier, this patch updates the header files to expose the
> > inline asm via a new ARCH_STATIC_BRANCH_ASM macro.
> > 
> > The header files are all updated to define a ARCH_STATIC_BRANCH_ASM that
> > takes the same arguments in a consistent order so that Rust can use the
> > same logic for every architecture.
> > 
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V
> 
> Still missing an ack from the ARM maintainer (32 bit, just added) and loongarch.
> 
> I'll wait till Monday, if I don't hear anything against these patches
> I'll pull them in.

As of what has recently happened, I am not participating in technical
activities until such time that I'm told what is now acceptable. So
far, that has not been forthcoming, and thus I believe it is unwise to
engage in technical discussion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

