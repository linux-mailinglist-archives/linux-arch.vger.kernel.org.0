Return-Path: <linux-arch+bounces-6162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130494EE3D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 15:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ED31C21F69
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C717B43F;
	Mon, 12 Aug 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1dhUITP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50917C210
	for <linux-arch@vger.kernel.org>; Mon, 12 Aug 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469595; cv=none; b=hThIrRKHQxU/bVv1xn4FYF/UMfVEpfZkkMXru1VfU9mZ4k3TbMhyUKhDBNJ8D0eTgnD4IdoWTsalM+d0NgNvf4wKKXLrHrKHhlRd0cBPgGRythuOp9drAfAi9+ncTB3lrJDOyqbfJq6ACDrj9EPecwfvANuf1ZBuqBsaQrAAFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469595; c=relaxed/simple;
	bh=yQGH4wTqdj6UgcbMWJ/OlXYfokf0rrWK3E7OaiXkuCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNJ8HijyZyc6279VVPsKXAHnaANXG5mUjLwoZ6Mmdt2MABM0U1+yJem28jjzdNfTC23yqEBm27REjVKyV6Um03OD8clJimgy1E4kBUCirjwo7TNsVADedeS5IqlN/S/s9rroKLWznlPdzICheqFKHwafrHZ9qLKl3MCF2k1Eu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1dhUITP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso33458025e9.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Aug 2024 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723469592; x=1724074392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQGH4wTqdj6UgcbMWJ/OlXYfokf0rrWK3E7OaiXkuCI=;
        b=r1dhUITPF2KaKWUHuGt9L0UVrLIpXu1j3oDeBfzMj3qb/7xnIdSOHJDaeFjXBqA+/j
         3L4JhAgndp58gnheOPPVWwym12IrrbyovNAOIukmUPJkzw40p82jTbrHsBdLdJJDIkXT
         yj5IuHlkvpw86z0YdjKB2jF3trnGfBzhrtVAK6eJBsUSD6g3YNRfa9xYcIjNXKDLmbzS
         feQ9Xs0YAVbSGJkCoZB/Od1A72G27YYP2gmE8kOgLuqPpdzZ5foyrWmnakaXyjoEboiB
         g7WUnHfQqro1LEPUKcMOJr9vmW6vu7UsUsVgv6629ko65W6WYwQjbnWmfWt5oUZhavck
         5U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469592; x=1724074392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQGH4wTqdj6UgcbMWJ/OlXYfokf0rrWK3E7OaiXkuCI=;
        b=JJavlVIVrvwRxKzQo91cGg7W4Kp7CkGGT6EZAlKsAO0X41jTwoEufBI53V5MmaynmQ
         DlP0OeiUWf1UVi//LnuRNBzjJzF/I3+r9r8Tl7OZN4bEwy7taujnjs+tQ1zGG4VxEz3S
         KFD0O2+hqFDBX7Wi0KPYpCnAr7IPakrXgyrhTRW4KvISHMGh27QOaaj/k1ty4zqMBkCP
         lxElskCMfiRazn3M/7J3agnViEOWBu5oN3StXOBQxe6d/OCI3ltJ7d6O40MWaejRV0B9
         OmRt/0uL5kYCoq6m5lsg3nQhyM2Nnwu3PPoW4v7KiNF2IBpCYUw2WdhZACQ37AqiRv4j
         Uq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/sO/XYt2GVc/fPFfySbvzv/Q5+auhqG/bljUoX3ceOhqCduN0xRQlf8D/n95Zv/4jhw3w3RRroP3KioKSKNXxITGyl2aM8YKdlA==
X-Gm-Message-State: AOJu0YwDQQ6ZpJFMU8SYM5wRMKMaSpE0lG29gVv7RqES/dwcunQXu5mk
	7BglB9AZoCv6yrOyiWemPWgwBUPVn4kLlhThqrV2Afg1YEM+LPET+xgYHewonF0rIJpUrbtB48g
	es1O5SRJiZVhFOcdOQmpVArFnye6Qf50ahoY5
X-Google-Smtp-Source: AGHT+IHW60xClnCiQEYYTC8Z9PZ33xaYy4WZgALT6Q+LMP95jazFgPNu9OZ8W3SxyYi1G4TpTJOyz0WQCdXu9YQVFvk=
X-Received: by 2002:a05:6000:b42:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-3716cd267abmr226021f8f.55.1723469591316; Mon, 12 Aug 2024
 06:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com> <20240808-tracepoint-v6-4-a23f800f1189@google.com>
In-Reply-To: <20240808-tracepoint-v6-4-a23f800f1189@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Aug 2024 15:32:59 +0200
Message-ID: <CAH5fLggC_73YQGLLjUsGnsUjAr9vOS-ebG0=-dWGqS7euzzf4Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] jump_label: adjust inline asm to be consistent
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> To avoid duplication of inline asm between C and Rust, we need to
> import the inline asm from the relevant `jump_label.h` header into Rust.
> To make that easier, this patch updates the header files to expose the
> inline asm via a new ARCH_STATIC_BRANCH_ASM macro.
>
> The header files are all updated to define a ARCH_STATIC_BRANCH_ASM that
> takes the same arguments in a consistent order so that Rust can use the
> same logic for every architecture.
>
> Link: https://lore.kernel.org/r/20240725183325.122827-7-ojeda@kernel.org =
[1]

This link is in the wrong place. It's supposed to be mentioned as a
dependency for this series. Also, I intended to have the same tags
here as I did on the last patch.

Alice

