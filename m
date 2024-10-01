Return-Path: <linux-arch+bounces-7559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B65398C347
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D61F23530
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25611CB508;
	Tue,  1 Oct 2024 16:19:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BBB1C9EA3;
	Tue,  1 Oct 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799586; cv=none; b=NWEj/yZ/5UC9koeS78YxIQIyBciQQCuNqeR8vqpXanOS56pn7cvwQiXpuVLa+CgNK8Me1desDAr4pya/lx5dJ4kKaeq+rU34h14mAE0OA/sELfhdCCC3FyoofV+RgV/JzO6LlhAD02Q9sgRK2xFSBCiIksi+dDzSRiUj9OSdh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799586; c=relaxed/simple;
	bh=+dSQbuCtxGx+1cqCxLPHWfgLoYVU9uIXvkb4qVifEOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyVQf3mLR2N2MKDyxN4aCn1C3x2rhQVtooKJSmJakBnN5doqBeaTLYyhuks0Q6rL7nsz8S9E2CJ8jz9xwcgL7dvHHDsaTd3xEL98A8k+CAmczhe3ON5CjnenfIPT+woCcutwfbPm8uGbWrr2EK5Ex+G0nEtN+LzveBcSt6n9DpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D994C4CEC6;
	Tue,  1 Oct 2024 16:19:40 +0000 (UTC)
Date: Tue, 1 Oct 2024 12:20:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>
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
 <ubizjak@gmail.com>, Will Deacon <will@kernel.org>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Mark Rutland
 <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba
 <tabba@google.com>, linux-arm-kernel@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v9 4/5] jump_label: adjust inline asm to be consistent
Message-ID: <20241001122029.399eedde@gandalf.local.home>
In-Reply-To: <ZvwgcBzLwYkgsJ2u@arm.com>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
	<20241001-tracepoint-v9-4-1ad3b7d78acb@google.com>
	<ZvwgcBzLwYkgsJ2u@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 17:16:48 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> For the arm64 changes:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin!

-- Steve

