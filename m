Return-Path: <linux-arch+bounces-8043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECE099A776
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D211B210EA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1591946D0;
	Fri, 11 Oct 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ZwkN+mh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B91946DF
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660240; cv=none; b=AVT4sSBVGZ6B0gmheIJYieCFRCxebequddrShH22/9Ba45vUCFHzaQxeguNTdr+NAfOefyHJzjeY7ry2tmusZ8Wue9aC6QeSwyUBq5KtP0hrIKLLBkW2Tw0QJu9a4lskvJ+xKbhhAWtqSOwdRN72EZygIydpAztPO2Wr3xvhQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660240; c=relaxed/simple;
	bh=rSznrDKSY4WrxXDZ8t7gM3RFnJVuejTr6MEOcAB6fmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy2HW4vF+hmK87aAh8C1ZFyiJ6zshFBhCPQVd30+BpSbUjHsA9lft2aKP8lgBEfTbpEV/8NBeV43hXpl6WTMn2i6zQVKexVhYATNMX0LiY7tz2dLfGuxyZzph0k3U0tjQnYhixgcKA6UIM4qsmVFA1tmI870scarfRJOSsyOeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ZwkN+mh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4601a471aecso244871cf.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728660238; x=1729265038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJyLD+5sCaVL1I/s6JcwhAzF4bt83zRxkYYkYug2NjQ=;
        b=0ZwkN+mhKvCPoqKU7gQXN4FwHUul3KbBPwzynky9Mb71XGEHBPFgDEUT3Ffyh3ctHU
         djlWQHkPlbFjSVQjVf5LfAwyNhoEQmPGXdr0iQB63b4u2qPKH/J6BSuOycZXscLBKmFB
         s049UsZT9aLOA+T49P8IOen3FNgz3npnnt80UlENyu2KnpTEyS6h73hzCKVrAHYU2lak
         WasREDXUYcPf33yA4S903GqZWzlQFTuSDKOvHHtEPbkxX6UW7R7+mPv6YlE8b3nGeeSe
         ntT+iBDn5U9yEdYN1BZcZ3YGBUp1YAhhf1q1US3wY/2WkjW2BzYBE2TvCNsIuYTObWOR
         CBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660238; x=1729265038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJyLD+5sCaVL1I/s6JcwhAzF4bt83zRxkYYkYug2NjQ=;
        b=RDLan9NKpGvjMo1etOUJsMihE7E9IHWvao+9gvQA0y6vgXpsd33GwCkjmqsCiE34XV
         4CMurhI66wfD1cT5pt6l156U2jpSEIQQLFT5RqAdKiWVz93Oql3ECeqLtuffvBMP7pUx
         2eRHAPJOdCL0ZOKdt08UHD36vTN5F/H91o/4gKNc5bVzUCJZzU0R/GNIXkrBxFc9pCG+
         i3VG2h90BbKyfHCwIhY9CMfdJSgoqIiVU0OG6PFytrykQkoTQCt9E1KrLy5o4vM7sItC
         HAQ9k4VXkFQPsMYHUHzdPEHIXxxDzw4pbMNhCfBAzRk8XaO+jqAqdX0kS8TzjWWI7O6K
         hsAw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSyq1cznshS2LpbMUfRPut4vQ3davbt04tSbtBW1NQKj/I94RrxxoMDjwIINUr0VCKOcNZt3hfRrT@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+xcK0MvzDusV6vUf3mGrfT+P3er7s0eMNiiWMbmNivWCC28N
	LORwg/j3Z88gRkRzy3usreshGqw0zqPpVz0YEV1MChsXyuPPM65XguzjoTj1EFwMc+3FNgid8SU
	e8LgUsNjHuzVQ036UHiytJT8reQDZB/XfeVf3
X-Google-Smtp-Source: AGHT+IHfcllIoreLPh5LQZRi63Z9gY+SjozCRNWADZolB8YwBJ2VdlJgtHx4ZWrWYxemGDRWFvy4vQZfgGpiBJs66xM=
X-Received: by 2002:ac8:7e4c:0:b0:45f:68d:f0e2 with SMTP id
 d75a77b69052e-4604ac3181amr4086721cf.2.1728660237401; Fri, 11 Oct 2024
 08:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-1-7fbde4d6b525@google.com> <20241011131316.5d6e5d10@eugeo>
In-Reply-To: <20241011131316.5d6e5d10@eugeo>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Oct 2024 08:23:18 -0700
Message-ID: <CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: add static_branch_unlikely for static_key_false
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
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

On Fri, Oct 11, 2024 at 5:13=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 11 Oct 2024 10:13:34 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > +#ifndef CONFIG_JUMP_LABEL
> > +int rust_helper_static_key_count(struct static_key *key)
> > +{
> > +     return static_key_count(key);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
>
> ^ Explicit export should be removed. This only works because we didn't
> remove export.h from all helpers.c yet, but there's a patch to do
> that and this will stop working.

What's the benefit of removing explicit exports from the Rust helper C
code? It requires special casing things like modversions for these
files, so I assume there's a reason for this. I asked about it here,
but never got a response:

https://lore.kernel.org/rust-for-linux/CABCJKudqAEvLcdqTqyfE2+iW+jeqBpnTGgY=
JvrZ0by6hGdfevQ@mail.gmail.com/

Sami

