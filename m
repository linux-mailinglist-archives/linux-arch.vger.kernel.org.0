Return-Path: <linux-arch+bounces-8050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F1599AAB2
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 19:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9F31C21548
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6E71C7B6F;
	Fri, 11 Oct 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcHkz36s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20091C3314
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669140; cv=none; b=Ui/OcKkwvpqOGfiyGct+fKgcRiZySGMrmF2z3ywMWG1RNm8ZEPC/D9AN9lpb2NZ2PR6zXdygaItdRybuhfc7R44nI2NdylQSKpvGJZlzLsJUfA1I/sfJgebE/JjN29QD8PPuRGYJNo54q/LI/2UjYPYR00cHHe+d45pBf+zhnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669140; c=relaxed/simple;
	bh=UbA/iFDHRQ6qK3Ht4X9Feltcke5IsxxCQungku19kWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOUymO2g/cmCV1kajxg/SccA5VWDGP7at+NpOiG/UqthXdSq7EuIUSPfLZTeUA/uPV0BafeQk+nrjkChT3iQLXp9bmeJFl+n/R1qpA1oGspYCw3Jb3LRrTPWqgGRmf9xlZw31ktkqXw6xU3F+arsbfPoVeqWSowoHEQF7Ho7UJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcHkz36s; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4603d3e0547so11801cf.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728669137; x=1729273937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFVu/0Ci5Drk+gHVAbW8VDcAFM6IjgK0BzGcAxp3FVw=;
        b=zcHkz36sijyfW6L3+oqPlDl3WZgl0pIx4cWL3ismpt0KhOIp9FYNmOvDw3QRfdbfhB
         wjJqwIB39R7OKQLgc14nmTS5w9ZaOB0uwXWDP/8oKdDUUom0oB0l6tdT4nW4OEuhIusO
         QiN8UQqlOeEEBa/6+D1OGpci8N6eqEGTt1Htv5b8GymqG23U/ELZ2min8H2RpfLDvXVv
         FtRAy3F7W0IlSAHvoGmubITdjrASOhQnzMmyX22+8HpIsgjbJXkAsWu1wvbKogrHkZcF
         p5+oqa++lDFyPLN8zc0nHTOXYuU7BSz9eKjMmVLZAxzDy1/oHNwtoR/9HuX713KDHujN
         b0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669137; x=1729273937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFVu/0Ci5Drk+gHVAbW8VDcAFM6IjgK0BzGcAxp3FVw=;
        b=HODSKjgk47Jb2n7qEctAGWJ5MwrcqU28mwkeM5Se9HCGWTK6ttRpIlnXGrdGNbNrs4
         n/MmvVTpkgzUVkurVU2mAUZHT0PUPB6+9CdTIzEKJRvoLSWYuUuHKG2F4670BZQW3O7s
         /xf89eAjQuMr2kUd56etfX4z6DzQsB041ZB8NSCaNilsGki2klj2BZpgpGWQB8bJoB4N
         o7vGMmV5Ioy/OI8yqIibwxrqgLo2Zc7bAHWcjc22anSk/rWlmKhf5755P4l1RQrYPqA0
         tsz0xcSiRfQ3hS9BxJuxhd3oaAT456Wi3MULJi+Zdo+4jy+mUz3jCpXCTPjDCE+Wuolq
         wDSg==
X-Forwarded-Encrypted: i=1; AJvYcCUSipE95aDt1cUiakm183P8bQGcATalEmt1+oqe4cuQLavTl/D6DCfzYBTC6AM/+/ADRv29irEPm/Uw@vger.kernel.org
X-Gm-Message-State: AOJu0YymXEFGzRDghEupi5cYde7aV4XiIA6mmJmXD2BE+d3DdPctAu+p
	wEYuLjwYvz3ORE0HmmDWqWSmuC/BaBjOSWYQBSc61r7ZQZojfMVJ+X6GUURxUVmnlMHFW91XZ6Y
	m22PgUIugjvr+956dozH/fUDX58RASNf2V0nY
X-Google-Smtp-Source: AGHT+IEEPPLA8HdfmHuDQ6n+ZWN9VIwgJKQNohNKF/6PyZg/dJQ0X34S6H6r+67M6aytOK48Tol7C6iHV8tyTZjxViQ=
X-Received: by 2002:a05:622a:2d11:b0:447:f108:f80e with SMTP id
 d75a77b69052e-46058edff6amr144611cf.16.1728669136519; Fri, 11 Oct 2024
 10:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-1-7fbde4d6b525@google.com> <20241011131316.5d6e5d10@eugeo>
 <CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com> <20241011171251.0bd53f01@eugeo>
In-Reply-To: <20241011171251.0bd53f01@eugeo>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Oct 2024 10:51:37 -0700
Message-ID: <CABCJKue7qT9drhgrXPEjBO=gPw79vYELAZxz747Z8WMF=vj2MQ@mail.gmail.com>
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

Hi Gary,

On Fri, Oct 11, 2024 at 9:12=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 11 Oct 2024 08:23:18 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > On Fri, Oct 11, 2024 at 5:13=E2=80=AFAM Gary Guo <gary@garyguo.net> wro=
te:
> > >
> > > On Fri, 11 Oct 2024 10:13:34 +0000
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > > +#ifndef CONFIG_JUMP_LABEL
> > > > +int rust_helper_static_key_count(struct static_key *key)
> > > > +{
> > > > +     return static_key_count(key);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
> > >
> > > ^ Explicit export should be removed. This only works because we didn'=
t
> > > remove export.h from all helpers.c yet, but there's a patch to do
> > > that and this will stop working.
> >
> > What's the benefit of removing explicit exports from the Rust helper C
> > code? It requires special casing things like modversions for these
> > files, so I assume there's a reason for this. I asked about it here,
> > but never got a response:
> >
> > https://lore.kernel.org/rust-for-linux/CABCJKudqAEvLcdqTqyfE2+iW+jeqBpn=
TGgYJvrZ0by6hGdfevQ@mail.gmail.com/
> >
> > Sami
>
> Ah, I didn't saw that email, probably because I archived the mails after
> the patch is applied.

Sometimes you might get pings about patches that are already applied too. :=
)

> We're working towards having an option that enables inlining these
> helpers into Rust; when that option is enabled, the helpers must not be
> exported. See
> https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@gary=
guo.net/
> and https://lwn.net/Articles/993163/.

Interesting, thanks for the links. It would have been helpful to
explain the motivation for the change also in the patch that was
applied.

Did you consider using the preprocessor to simply skip exporting the
helpers when cross-language LTO inlining is used? This would allow us
to use the existing C build rules for the code instead of adding a
separate rule to handle Rust-style exports, like I'm doing here:

https://github.com/samitolvanen/linux/commit/545277e4d0432dafc530b1618f0152=
aed82af2f5

> It's also quite tedious for every helper to carry this export.

It's just one line per helper, but sure, I do see your point.

Sami

