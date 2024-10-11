Return-Path: <linux-arch+bounces-8058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092899AE08
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 23:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A131F24C27
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1D1D1519;
	Fri, 11 Oct 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0ZN+L8u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A21CF7BC
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681990; cv=none; b=Q+ZOXTF1UaO78Z6MZWzOZR5nAsfW8M59NRYJqjSq0wDGGPkYfNSdbVdYa9tg5vEhEXU2WpNyAAkzOTVzo3ipzsvY1RzrBA6hSPq5DZii2jmZstto/X2HYX027bOPFHFcdIp4TwjoecdteQC5M2sUMOy6iav9qygX4SDhkIJeMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681990; c=relaxed/simple;
	bh=Ka+AjjRuR/G5QQKRrwr0FE8Ey+JDrFkkvTACYvoWcLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRcJTtjvw31HGwnoIk0KLEYohTPl6J/tS34W2odC2UR9X5IJ56SBFWya3FqX5LCB4B2W26iMlUk0pq9cj9+qxKAe1bQaDhOux9qT08KzCRel23HtssBYljOvmoeWs14UoGRZvUmSU5AJEpF/Uhtwk80KVnOUR1EU/4dFksm7dUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0ZN+L8u; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460395fb1acso71381cf.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728681988; x=1729286788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka+AjjRuR/G5QQKRrwr0FE8Ey+JDrFkkvTACYvoWcLM=;
        b=U0ZN+L8uihImO99bgGJbn6H8ka1Xgw5xwf6XJMARnqwI73Wdn0fvNXQPqzNTPakdbY
         Rug+GWKtl+e00Xd5ELfRFvMEe+RR9CAKng/cvtr+IXqp7gqHfI0UCswCfej9Rykd9SK0
         UqNXJ0qQdOLxuAXoB2owh3RcdawxR2D1dJrepWqKdrHwctO/Zy7RnMHyIIdZHrZHV7+n
         92HwxlivEHuM4LCAyv3lk8JnTX69ULmtrL3sZrrB3vbBDKLDJnfB07RjFlllY//9lu11
         011pnrmu00wm0EV0Tao2bpXNMTuoiQDqDBmpqXTn4nyijBRzj8pjh9Hoo2TRREqOJ8zz
         2vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728681988; x=1729286788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka+AjjRuR/G5QQKRrwr0FE8Ey+JDrFkkvTACYvoWcLM=;
        b=m5/7MpJEd9NsNPhb8gNV8mk4VKcGU2myY78Wd3e/1lQsltRowibCrXWIOEQxD2krRC
         4VllEKShe0YJCeBks1KykaYqwyjoriyPZT1UDeJ+ld9f8RnV4QVB2L+A81+TMOism6MR
         Jo9SISPLUA8vQ7p93wp11KKJsxL0+fMzSjQ68p5+lPSi4XCnlfP+GzRSDSqsRYLk7y/R
         9xjvXk286Y8vnVAEgzjR36d3hLVlXkq8AGprUYvKYW3Yt8Cu6hMu6C+v5JgASYlyptch
         KAEyhQrjd0/QHxrXA6IeCYMJo+tdGtLVV7CXUSm5qDQdak6RkBcYxSgUIOd6YAlvuqyc
         2OfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt989UCzJiPj7sLoSHHwVXY8BPOhtersIATyoQQi2LJExQFYgUtrDn3070P9CkDwViZJUFkLevbiXS@vger.kernel.org
X-Gm-Message-State: AOJu0YxWf0l5DJj30IeqKg/aor/MnV2CEHD+yfSUvxNH1PGoE+ym0Y/A
	2XjvedoDoYFmrJdcSdZEKyCw5N9eqW+8nKdRL0z4DqzWlC4MIvQUixAGl2roCO9KDPyAimPX0QQ
	O4WE6xJR/nfVtK9DgROTcFkDXP0Lsnf81WomA
X-Google-Smtp-Source: AGHT+IEKEmVjWoOqBswBr3NiTYKK5Z9SghdMPP5nc66QbnU8P8zaScBXP/19wKkNBoIcY46P8FQCMYQuouKvAahW2eQ=
X-Received: by 2002:a05:622a:a60d:b0:460:48fc:3cd8 with SMTP id
 d75a77b69052e-46059bf45e5mr189701cf.5.1728681987767; Fri, 11 Oct 2024
 14:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-1-7fbde4d6b525@google.com> <20241011131316.5d6e5d10@eugeo>
 <CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com>
 <20241011171251.0bd53f01@eugeo> <CABCJKue7qT9drhgrXPEjBO=gPw79vYELAZxz747Z8WMF=vj2MQ@mail.gmail.com>
 <CANiq72nOCkzTyJCydHOrkz3MRizb27sDO_5Y_cKEv3oZDNNqqQ@mail.gmail.com>
In-Reply-To: <CANiq72nOCkzTyJCydHOrkz3MRizb27sDO_5Y_cKEv3oZDNNqqQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Oct 2024 14:25:49 -0700
Message-ID: <CABCJKuduZJ4aogg4A6idcMAPMa2N0d4f9aJgbR8HL0YEyTONmA@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: add static_branch_unlikely for static_key_false
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Fri, Oct 11, 2024 at 12:48=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 11, 2024 at 7:52=E2=80=AFPM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > It's just one line per helper, but sure, I do see your point.
>
> I guess we will have a lot of helpers added over time, so even if it
> is one line, it may end up being a lot of lines in total. The rules
> should stay constant, which would be better. Having said that, it is
> true the extra complexity of the rules isn't great either.

My only concern is that custom C build rules must be kept in sync with
Makefile.build changes, while EXPORT_SYMBOL lines should be basically
maintenance-free. However, perhaps this isn't really an issue since
most of the complexity is already contained in rule_cc_o_c that we can
conveniently reuse. Anyway, I think this is something we can worry
about later if we actually run into problems. I was mostly interested
in the reasoning behind these changes.

Sami

