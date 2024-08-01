Return-Path: <linux-arch+bounces-5896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947E9452B5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2711C237D4
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393AE1474CC;
	Thu,  1 Aug 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM8HMEdn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77869143750
	for <linux-arch@vger.kernel.org>; Thu,  1 Aug 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536818; cv=none; b=Kro1SmX/cfE/pD71l0f5urN7mHnNgYCIs0TWPaC3yGfyMEPfsLy6+9g1p82raAAA6dngZUkrMVRka7YXAwjmkrjj8+ZYoIVM/wNbwVwFo2ZZQ4PrjUQDTUHJnIQ4kyp0wM8d0FLihLw3SFNkCPx81jfOVibgK8t9Od30rmG9+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536818; c=relaxed/simple;
	bh=lHbIHLFhtQNciusEsnruiPFrsux+ubJl8cotIGgu9QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWZDC/xz06v+fz3koh4M7B+iYhM0EGYoMEo6yU8krv5rNS43TZ2AUfRQ26EBLwxxxnOfzxoOAyktU6tMqwWcEmcGdil1qoMgT7knTddcigHzO/grF6y/1lOu32OHR7GaopUm57OiXR5jPk+S1IdXaZYqgEe8msY3ZOQlZCEbLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM8HMEdn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so3602692f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2024 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722536815; x=1723141615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GkfD0g8hTHOTE05py9mAwmf1QYzZu9yR2OS6+zzI80=;
        b=rM8HMEdn29YaHok0uYeb+av22l4a6P6iEOCn7o/LV9v4EdyOHlzN6IHGcd7CIJUX4E
         JZP78BzADOkLTOY7VGY9mzcY9lR6uv++P+4QzVCV1NtxeUxIG0XyNC1oggfy9WKHqHnr
         5j0ukVCpF+G0UVmRGOy318RMhnFbdGmIxT5aTPYg2vB+iIs5zRGWaOqVXQWWidujkT9n
         p+UnahzdH7A75jfvm/FO4wxFf1spK+L7Jy9iIzi8iDGP6RIGgAXcfKIwYo4nSJLI811z
         NJKXXEYTd53a8/xk+mV8Z6VM27AKDtUwwSE+V3jLZat1FcZ7Akz3iFDWExUDsyrIdUxd
         MWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536815; x=1723141615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GkfD0g8hTHOTE05py9mAwmf1QYzZu9yR2OS6+zzI80=;
        b=e3bQpUeI+bQKLj/W4MAlZMnMzMtuuM7ZbVEF12fk/Mxb1zNevHjTfayUsa0u5lUKpx
         iEc58QYnlqckaji3XwsfakJxz0OD3HZqRvg1aqtaWcW2k9ZpFVRwdxjS+91dhEY6X/ds
         lsj9wvL6naNzmoWAFaj/SQsL0j+EFLDrZdWiNfY9luyzVdJPrpXZljPNnyRVc4hipx3n
         1IX7Wnaxb6qEkM/ARHE9RRZPQHpV/TBcaDiKHPxYcfvCQnzwo3JL+amWGybTdByVPiXn
         1wq9LAdmVaojfzolj7RI7eWXXjn1QQjG27/r/qbfaWp6a8jUE9JmwahBfK/FAWGhlJuU
         EBUw==
X-Forwarded-Encrypted: i=1; AJvYcCXfq1bezoRKeZTS/vBRyEWjhE+pMClUarPw1ZpmkjaZsiaBNkDXjLYnOWl7LMur6AmKGYO7QdJcQdqEaeJkWteC03du+nuaqMqroQ==
X-Gm-Message-State: AOJu0YxLvmSu7Z+69U2SttzVNrMDf7aFDA+Rdd/+8B4joG0P35s1/UZi
	GBw7QZ+Tx/0303i8HN49NNU/l4pcEzJASuPuTUlfP88mQxdZT+4Syk57kvQUxIbSEVjbFH43QpR
	c6AzOKI/NiyhIexXCvTOEqA7hnoX5zah2BsI3
X-Google-Smtp-Source: AGHT+IGwaGkw42I/amAH0IQd6LdSV/vkI/phXZAUV/1lm1vKxK6jNhFtpwWWcpoa+ZqQDQpJUtDs/GFofzfYgLUeu2Q=
X-Received: by 2002:adf:a356:0:b0:368:3895:67d6 with SMTP id
 ffacd0b85a97d-36bbc0cbe69mr533475f8f.20.1722536814320; Thu, 01 Aug 2024
 11:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-1-353d523a9c15@google.com> <20240731170508.GJ33588@noisy.programming.kicks-ass.net>
 <CAH5fLghYodekhH-1A0BWZVwgbqkWbP3WP70-us2FtHqvOqD_Hw@mail.gmail.com> <20240801102804.GQ33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240801102804.GQ33588@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 20:26:42 +0200
Message-ID: <CAH5fLgiOe1ECCwE1cwczsT13iPyymdUTbV-9ZHeDrp_OGq5FgQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
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
	"H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, 
	Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
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

On Thu, Aug 1, 2024 at 12:28=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 31, 2024 at 11:34:13PM +0200, Alice Ryhl wrote:
>
> > > Please work harder to not have to duplicate stuff like this.
> >
> > I really didn't want to duplicate it, but it's very hard to find a
> > performant alternative. Is there any way we could accept duplication
> > only in the cases where an 'i' parameter is used? I don't have the
> > choice of using a Rust helper for 'i' parameters.
> >
> > Perhaps one option could be to put the Rust code inside jump_label.h
> > and have the header file evaluate to either C or Rust depending on the
> > value of some #ifdefs?
> >
> > #ifndef RUST_ASM
> > /* existing C code goes here */
> > #endif
> > #ifdef RUST_ASM
> > // rust code goes here
> > #endif
> >
> > That way the duplication is all in a single file. It would also avoid
> > the need for duplicating the nop5 string, as the Rust case is still
> > going through the C preprocessor and can use the existing #define.
>
> I suppose that is slightly better, but ideally you generate the whole of
> the Rust thing from the C version. After all, Clang can already parse
> this.
>
> That said, with the below patch, I think you should be able to reuse the
> JUMP_TABLE_ENTRY macro like:
>
>         JUMP_TABLE_ENTRY({0}, {1}, {2} + {3})

Yeah, I think this can work. I will submit a follow-up patch that
removes the duplication soon.

Alice

