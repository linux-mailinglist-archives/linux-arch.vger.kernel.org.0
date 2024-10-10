Return-Path: <linux-arch+bounces-8002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283939992EF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52C61F298F1
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903C1CF2B9;
	Thu, 10 Oct 2024 19:43:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E519DFA2;
	Thu, 10 Oct 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589398; cv=none; b=RbKJIIJrImwLHbsW9W7sptmuushVTafakYTg+mowz9ziLjkZyQsRjlAtbr7k6BafHfgc+mOheefEuL4CSTwzEPShkB8//MKS/6+q9xbHKiEoKSZjRdrAmNNhBtStj4TPdge2HIe9hFXIn7X+JoCLcEKi0NoMBIaFSq9C+vgYDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589398; c=relaxed/simple;
	bh=Q7OewBtQ0Gea+BFYlkHx/5aubBH7TAKhTSr3FH3BPqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdcRwGCEMAoH9yewKKwFBpJCOPuGGXNwuCBT/Q85b3WNaAonKJls/5CKNybxP2QRrRTEP7CT27vf5VG1vossmmzlk2gkDek9ZRSolokc3w80oUOcbZlyTgVHWPsvDN+FyeDE+Beb/Rqao3LoD9Lky8AyUaUm6iMzIeSIQEJ3WSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75495C4CECF;
	Thu, 10 Oct 2024 19:43:12 +0000 (UTC)
Date: Thu, 10 Oct 2024 15:43:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
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
 loongarch@lists.linux.dev
Subject: Re: [PATCH v9 1/5] rust: add generic static_key_false
Message-ID: <20241010154320.6d17ba69@gandalf.local.home>
In-Reply-To: <20241001211543.qdjl4pyfhehxqfk7@treble>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
	<20241001-tracepoint-v9-1-1ad3b7d78acb@google.com>
	<20241001211543.qdjl4pyfhehxqfk7@treble>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:15:43 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Oct 01, 2024 at 01:29:58PM +0000, Alice Ryhl wrote:
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.  
> 
> Instead of extending the old deprecated static key interface into Rust,
> can we just change tracepoints to use the new one?
> 
> /me makes a note to go convert the other users...
> 
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] tracepoints: Use new static branch API
> 
> The old static key API based on 'struct static_key' is deprecated.
> Convert tracepoints to use the new API.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Alice,

Can you send a v10 with the added acks and whitespace fixes as well as
using static_branch_unlikely(), and I'll pull it into my tree.

Base it off of v6.12-rc2.

Thanks,

-- Steve

