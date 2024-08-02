Return-Path: <linux-arch+bounces-5926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CED945CF7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C81C21581
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9FC1DF67F;
	Fri,  2 Aug 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzRv3Uf8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4231DF664
	for <linux-arch@vger.kernel.org>; Fri,  2 Aug 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597154; cv=none; b=qP8Xo5VK764wI2wHx2/YxM9xgLlRnaRge5nYvYn1KnkNQtiALcmFMGhXuDm/kb5r48Rlel3STVkD7ySUKQj6ZAtmpMaSYNMSRSNbmbohuKU1XNkcPAcVT5d11Nek6bIerj5bXdrckp6l49bqgmNjOVLPuJNCx4zgvMvpGGv0wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597154; c=relaxed/simple;
	bh=gnO4O/zcd8S789cTMN1Qt5kvGy1SLpzswI2NiU04r2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4dRmc54FXQZHvlRxsNcjbnTODD5LWGn8aCKaQNsToDACpNgg9ncUp+sYfuBFrZiHVslAvQkKe3YpQGjfMnYLxOgcPoVSoJTdT5oSlsT8yi0HsFDy3EtPQEpXs0KWMGt7oldmXzNlUlSgww/AWCjr6DqASFzGoraF8ke12gLqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzRv3Uf8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so50135655e9.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Aug 2024 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722597151; x=1723201951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NckEZuTbgzBxmHzYz0RgKDaRsejCSb0E4WOQCnSKCEw=;
        b=NzRv3Uf8j9XYUci2hOMz58fa6xCSuLN9oR9B9p2cnSSUklhka/SOfrJufOaFSIoFS2
         G5RIlYRXHOWRtOdKCwtw3CTiivlkA0+SSuNAGhfU16W8E5C2dwnr3w1TEqM5ZYQLEFrq
         qBxng01LxP3SyJ0+adunwLkIYAwFZflp6YNwipjnjgacBhuR4k8oIcauyqC+YO25MpET
         P6rbgOqcADJuZN0jG78fHF00juYAk6Qh1IG6jWX76CFWtTZtUPheXJ3MZxspJ/uEWOUp
         sS0gNltaZbQvXj5oC5jHoyydBsBZ/UGUr8i3lNJ1rya7VJfohzPdQgjzDbtnpznNeSgB
         N7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597151; x=1723201951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NckEZuTbgzBxmHzYz0RgKDaRsejCSb0E4WOQCnSKCEw=;
        b=rcUc0nQqEYr5sEwz4LtilAmLHS8yZSkruK8vLktHfBuFPYkk16NcSvozdKlHQD206g
         s4OfxljB404rPZfJnu98evx92zWUrtpb0BlYFGTaGsx9e4Lacw0qRCOHpXKTekZvZj+4
         tneKAs07QHjYVxCUpYYNMENYc7MKgDfSY+9jD2g0IVkHfq74pgjpXBVYCjJnBY+Q/OOR
         IXelO/XesLFEnKTmzALPk/PjlAZqDt3oPjstGWCx4Q/fspOqZ8OLRA828ZeGSEqzX6V4
         P7MeHq/6Z1aEQR4Bal/LJeijDR0hney+GIq0mvikqc0srijwxIjYFd31CYDBHbnsIBIe
         5ruQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcWLfLptHzJ8N4cuWT9Kne2GWhBsD/m6JJ5aIGR+7h4pjdyw3sWEsaThzQEed95vovpHf6SYs9djC6Lzffe8NMTmJC22+0q5rFpg==
X-Gm-Message-State: AOJu0YxuHf00oflk8YQh1Yd2BAgnW/UFX+7cU2G4scGZwS3YuFgYptm6
	ryl/wFZ+rC8vqRral1TZCT3HzMTsshkenk6RRs1Y9D9T1b8qYx7aNr3xVb+FvrjbZJrlLI+C80P
	1Nvk8+TzwDbK/iWkQVkb7FI8aFJlPN1gB7ruw
X-Google-Smtp-Source: AGHT+IHG8YT0Tl3r67jSeYzzG/u+IjzVWq2bWRMReS90gVbkEE3+W7//BJg0NubXE694omwJobmhmLbd7NfxN4kakP4=
X-Received: by 2002:a5d:4003:0:b0:368:4edc:611e with SMTP id
 ffacd0b85a97d-36bbc0db7c9mr1721957f8f.14.1722597150322; Fri, 02 Aug 2024
 04:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-tracepoint-v5-0-faa164494dcb@google.com>
 <20240802-tracepoint-v5-1-faa164494dcb@google.com> <20240802093954.GH39708@noisy.programming.kicks-ass.net>
In-Reply-To: <20240802093954.GH39708@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 2 Aug 2024 13:12:17 +0200
Message-ID: <CAH5fLggBRBOrGb_2RLP=tFyGeiMmkH+86F-d0Pidv5z-shZ8Vg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: add static_key_false
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
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
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	WANG Rui <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Aug 02, 2024 at 09:31:27AM +0000, Alice Ryhl wrote:
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.
> >
> > It is not possible to use the existing C implementation of
> > arch_static_branch because it passes the argument `key` to inline
> > assembly as an 'i' parameter, so any attempt to add a C helper for this
> > function will fail to compile because the value of `key` must be known
> > at compile-time.
> >
> > One disadvantage of this patch is that it introduces a fair amount of
> > duplicated inline assembly. However, this is a limited and temporary
> > situation:
> >
> > 1. Most inline assembly has no reason to be duplicated like this. It is
> >    only needed here due to the use of 'i' parameters.
> >
> > 2. Alice will submit a patch along the lines of [1] that removes the
> >    duplication. This will happen as a follow-up to this patch series.
>
> You're talking about yourself in the 3rd person?

I'm not sure if commit messages are supposed to be a personal message
from me, or an impersonal description of the patch. I'm happy to
reword.

> What's the rush, why not do it right first?

Well for one, this version of the series mostly just makes changes to
the second patch.

But also, maybe I'm being too aggressive about it, but I have large
amounts of out-of-tree code that I've been working on upstreaming, and
it's a lot of work to keep it all up-to-date and rebased. I want to
reduce it as much as I can. I was hoping that I could get the changes
to include/linux/tracepoint.h off my plate, even if more work is
needed on the static_key side of things.

Alice

