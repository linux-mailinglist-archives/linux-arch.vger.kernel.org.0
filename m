Return-Path: <linux-arch+bounces-8169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5299EB5E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6461F250EE
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D241C07DB;
	Tue, 15 Oct 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/j4EvjW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFF1C1AC7
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997565; cv=none; b=eNywQl77vPb0/vUOVujJD03m5fYvEeN5Zc185OXb7n2CGXUplKgyzlzxQeXsKiNB2eyJPeQhjAc4zcYVI7EJAHyNujbjDjuNmF6BIYru5FKHzwgr1O9fWlzF9UZtIULXmACaiI6rLKfarKt6lA7wi7XRcHYbPdaACXu7ixIvgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997565; c=relaxed/simple;
	bh=UVrKYOv7Wne8Pbm7/twfB1U4G+wKmoSCClCmoMN2kAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFlj5YVrBoPoeiR1TK9XU/7uPodkv9xSaoI4pAgzIgm5P6PyIVC6B3kx5hXHh1gZ1WQhyFJeLG4RzdQPQ+wHL4zdEKQpu4RBvFSqia0aZcBUzMX78y4w+/bayFbb5o0C/1Kvt8EEDtVwcpB2RIkvLzvUvw0kEZLKq2kNlr6Gmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/j4EvjW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1735881f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728997562; x=1729602362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UYUP5eDoCpJlZIv+2MviNVABJNyofFegvCIyfWDvSM=;
        b=G/j4EvjWPH+RdEo3rc1VFgE/a3zvfrsTi61HdFWqWI5EZQdMlyXNxXmIBUJ/Jvy/LW
         oOO7BJ24m/PB3Ppy45Wfo1q5N2QFrvRirySZCCX1F8p4UAEW3kcxBOEz10ncHJ1TTmG8
         +0BRan9yZVY/jfaVoMQ72LogBZthKbqLqImpB7MXOI13dtyx1VRHgJ2Yb6rLn/jFw7Ml
         65cPIj5tbvoOXE0lLIgC2tGdu+sFh8GGDkgyo/mMZHZLZv2Y4yhryQPRTOIaIjpd4zCx
         MgvgBpM1u+Zas2CtZ6L916czce0eZOa2skdz4+ZtxbV1IfeF5bT8ZaODigHpLXNJNZva
         VU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728997562; x=1729602362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UYUP5eDoCpJlZIv+2MviNVABJNyofFegvCIyfWDvSM=;
        b=qh/61yVw/23kbCFPp46GE+ePJp0HsRvd6uUaufRczXclQE7/HRGbmpy6g8iEClRe8a
         7C1zCXds1VIhwFZpBzWpzBxlFFUoCGi+CVHvuYRwQnWucm0Za9ArnezOJFhI6AeMgTh3
         +iVCQM0l1BXo4Pr+Km2FPbajI0hUnFQhVCRaho8Js0DbAXmEDgUS2ZEESxRioZa3RECy
         GGieZWf2wQcf61F8dG8QSfDaWnedvJV8M24tFcZSJDLIlUMS/4Yl2Kt/nWTkKqXSB+7J
         dpPWrHWfGdBMmJtFtUNe/M1/7HDyQifSxf91E2qK33dYF6Tu8uFDUbcuaQoNC9EF+5LR
         wNNg==
X-Forwarded-Encrypted: i=1; AJvYcCVaorewXpmTMmermuN1mCKRaz8Z9XwHa6ztSEfmdDzg3dMj6mJkolx2+rPXJomsBho8o9QNGavUE9oO@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTAf9oIcYsCWTxXO0kCQ6uaYHJS47migJZNE8KHBQ1nqXFK2s
	BPJiuKiKO+nwEz5QsHIII8n7pnvAiP5/aXz+GBeEcnDrSW4nonAaoOrcWajQrJTcePg6mGsglbq
	sUcidig7p9v2i6EdADnx0kYPgkWDqQrcehuXb
X-Google-Smtp-Source: AGHT+IEIAKlwW8UiEFpPs4Fcbd4nUGuOBW7hWDjxjph18K+ejeS+IZz53ZJefCSDaToXnGBf3Uc6jj4wb7rxRNzd/8k=
X-Received: by 2002:adf:e98c:0:b0:37c:d4f8:3f2e with SMTP id
 ffacd0b85a97d-37d552d8b43mr9076130f8f.55.1728997561878; Tue, 15 Oct 2024
 06:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-5-7fbde4d6b525@google.com> <20241011152312.r5sy7k7hsunmmbfo@treble>
In-Reply-To: <20241011152312.r5sy7k7hsunmmbfo@treble>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Oct 2024 15:05:49 +0200
Message-ID: <CAH5fLgh5EbHFn+47LpdVWjdYaq8fEm0Okm8fd1GwLprLqzt2pg@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Fri, Oct 11, 2024 at 5:24=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Fri, Oct 11, 2024 at 10:13:38AM +0000, Alice Ryhl wrote:
> > +#[cfg(CONFIG_JUMP_LABEL)]
> > +#[cfg(not(CONFIG_HAVE_JUMP_LABEL_HACK))]
> > +macro_rules! arch_static_branch {
> > +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_labe=
l: {
> > +        $crate::asm!(
> > +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_stati=
c_branch_asm.rs"));
> > +            l_yes =3D label {
> > +                break 'my_label true;
> > +            },
> > +            symb =3D sym $key,
> > +            off =3D const ::core::mem::offset_of!($keytyp, $field),
> > +            branch =3D const $crate::jump_label::bool_to_int($branch),
> > +        );
> > +
> > +        break 'my_label false;
> > +    }};
> > +}
> > +
> > +#[macro_export]
> > +#[doc(hidden)]
> > +#[cfg(CONFIG_JUMP_LABEL)]
> > +#[cfg(CONFIG_HAVE_JUMP_LABEL_HACK)]
> > +macro_rules! arch_static_branch {
> > +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_labe=
l: {
> > +        $crate::asm!(
> > +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_stati=
c_branch_asm.rs"));
> > +            l_yes =3D label {
> > +                break 'my_label true;
> > +            },
> > +            symb =3D sym $key,
> > +            off =3D const ::core::mem::offset_of!($keytyp, $field),
> > +            branch =3D const 2 | $crate::jump_label::bool_to_int($bran=
ch),
> > +        );
> > +
> > +        break 'my_label false;
> > +    }};
>
> Ouch... could we get rid of all this duplication by containing the hack
> bit to ARCH_STATIC_BRANCH_ASM() like so?

Good idea, thanks.

Alice

