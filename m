Return-Path: <linux-arch+bounces-7569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DCD98C835
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 00:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154DC1F254D1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48B1CEE84;
	Tue,  1 Oct 2024 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpHxOA0c"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7C18754F;
	Tue,  1 Oct 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821699; cv=none; b=NsgC/DEn1hGKjNm03tKqM3EtVZudjTa6MsSMbr5d3SkdSKKUYB6octmc/+mT+P2AYN0sf3z713h/NPdY5ssw29w70cVVI5zQAFmOV6LPz9sOAehvPctyvLJyYrtw3C2gOa/utT9QGAICn3LNUlqZaucMnte1C9v2gMXj/v7ZR64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821699; c=relaxed/simple;
	bh=vfQYcN9QNqCf3FQOMas6JN5EPo8jB5OVUjI8WKebzyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tye224FWh8WwP4F5tk5jJVspYxERMAgpAXrlOQlIaX8D988ciM3MxuoxLF4XVaGI4t7DCp2PjL+0VUHY23SG/OT3EFTbnXMAcxQrejLTXOzU+9tUZeg0RLk27LAXpxZ4F1J0w674c6749NYNeYWXnxYXeRRsbhoCPe5qV1xbFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpHxOA0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFEBC4CEC6;
	Tue,  1 Oct 2024 22:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727821697;
	bh=vfQYcN9QNqCf3FQOMas6JN5EPo8jB5OVUjI8WKebzyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpHxOA0cKLF3JUl9Jo0H0vq1L10cA3BcmwR917sd341feGUA9Dr7bpWQt8aYwKngd
	 RXW17oNPU6hXU26ivd/0TeakuSXCjO0Zo23e7lMyz3IZ26NzHKcyE4j7TWqN5G9mjN
	 hEWyvThnVqPHX1vpue+mcMtfTlnyKEpWn5v03/8lD0ZeLqysSqFUoJ/d2iNBzqy+s3
	 eOseZkl8sIdYViK80DpZwhIsnWeGxweAru0n8tvahV6/Tx46feq0fwAcVWRegkFcww
	 3i9Qyz4vpJLFrgtE/mjQZSx88+QDpAgQGrxxZV5q2gGNlEAYf1AVTt+HUVPzkgiRLG
	 5jBq4Z1n+ldVA==
Date: Tue, 1 Oct 2024 15:28:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v9 1/5] rust: add generic static_key_false
Message-ID: <20241001222814.4n7wrazj6okgcovd@treble>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
 <20241001-tracepoint-v9-1-1ad3b7d78acb@google.com>
 <20241001211543.qdjl4pyfhehxqfk7@treble>
 <20241001174606.6f396dfd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001174606.6f396dfd@gandalf.local.home>

On Tue, Oct 01, 2024 at 05:46:06PM -0400, Steven Rostedt wrote:
> On Tue, 1 Oct 2024 14:15:43 -0700
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > On Tue, Oct 01, 2024 at 01:29:58PM +0000, Alice Ryhl wrote:
> > > Add just enough support for static key so that we can use it from
> > > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > > deprecated, so we add the same functionality to Rust.  
> > 
> > Instead of extending the old deprecated static key interface into Rust,
> > can we just change tracepoints to use the new one?
> 
> Sure, care to send the patch properly, and I can add it to my queue.

Done:

https://lore.kernel.org/03da49e81c50eb2a9f47918409e4c590c0f28060.1727817249.git.jpoimboe@kernel.org

-- 
Josh

