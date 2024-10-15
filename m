Return-Path: <linux-arch+bounces-8170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EED99EB74
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03002824DB
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652751AF0B1;
	Tue, 15 Oct 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PacNLH21"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E081AF0AD
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997634; cv=none; b=bS9j4Bx0GXiXCJtFHx2UcbgzsIwJdJuxvg5hY4niBRbTcGNbbCnfc3CkuaK/wgxGryehc15TH/iH2GBoZrHiiVfhU6J9XdmDdCbAczLLH4nkBE4AQ6sRLXZYS6i9LRH1tKURONVNF+NR2qT2N+ST/M9juk9+VeSLJ6MYJ9m7XuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997634; c=relaxed/simple;
	bh=RAFtXXlMObqVzV2d+gmuJ5R6yL2BTETgZusCP73IhnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf6n3g78ENivq2YOW9y2jF/YUtY/K3KP8xzKu632OncbzmHbz0NZhesXrRBPc9ErDNiXDQYRTIUXkmR040k5lA/OicyCfqkPIIidFJGSNjOUjg3ruCz/8+YKP0FxQBjh2sbtfm/uJXqcEwfZjUQv6t7qcknpxyhIM8Q7NqZ4AUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PacNLH21; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4305413aec9so51499425e9.2
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728997631; x=1729602431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en9jFwXT2bDiA0LT5HaPdVoOH8lCOJ0LwIRdXejUMhk=;
        b=PacNLH21jg9EtiZ777S++jbmSnReEBX+Eiw0EER8eKcVl8dX6oUMoGhpc9ntPaPGFU
         tNvkF656WDjHebY888fAZtMmGNqdMgceAa5gF3ZhIACFWX5GCq8vNMiaKU9IkPlrOGLJ
         ndrO87HjcATCXrJUcfHRPQyfLTV0eQ5OwakKmvIBtp8n2/0mYEXMRGGTqtbJpBr5NKnm
         9k2qZbqjkoRIyPd+wvGYUdl4geJWuYnsn0nx/ttLZhLGTyTv5dfLIe91is0nM229KN23
         0G2J58/1gbKDOxqkswiSy5leEA4AQwoxlrIJEtujvkHd8cFcwP85SMWIyofNNKDJlf/c
         Qb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728997631; x=1729602431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=en9jFwXT2bDiA0LT5HaPdVoOH8lCOJ0LwIRdXejUMhk=;
        b=rixvERtQIEiQ7USL7/tokfV16nNtzDb6KqWHCS/C3HINz4cmU0//7GfwtBRXmvoW3j
         Kf7xdFMA1RVBHIxcnoI2jWJ+OMfm6tXQVBlRRlXGsnvjbvDlhAMzn7R9blJwt3H0C6oV
         Pb/7fasDDEzYcxZ7Wez5Dt0faZtlfvW6Rd5GjloJ3yIUs/OHaBNnu4zPKEVwpxXw4KCs
         1n318rFsBXqfofsg4xkJBA35idDU8mqtYrFdaV4R2sroa2Rv/9Qybcg8AW3RawECbP+Q
         EANbXJebHkzGzBHH8j7nS7Vvx3rC7j386iLE2enWlNMWZbWa8402lbGBcpSsv2y9klPR
         xKQw==
X-Forwarded-Encrypted: i=1; AJvYcCW9BvnsNTRyE2dSmWN0QBR5/YczFf72WGLNrFmTp6BGXe4i0zffm/0d2Ax8MR0c+caTbrz8LB8uCU8A@vger.kernel.org
X-Gm-Message-State: AOJu0YzS3hOwuij1uq4bNyZ225dcEp+Tx2SlnZ3IppAzwGxmF8QX7Ffx
	0EkxbPrldBqvodAwVfpa0tsoAf2SKJ/4Cl82Kq/w7TpgNcLuWzcrCsTi0pVasBqx4AZcHxx9hx4
	hb9N9IopHvFzEwsyHH96H/JpUM8kPoRpWZnHU
X-Google-Smtp-Source: AGHT+IF+ejFusSyTSFm0RCp9pxJc8mmToy5lXNSY48Rr+wd/q53EvtiwpWkYjw4u1eyqqetmcpQmCrujFgNR9X+o7To=
X-Received: by 2002:a05:600c:b8d:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-4314a379091mr4398285e9.22.1728997630948; Tue, 15 Oct 2024
 06:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-5-7fbde4d6b525@google.com>
 <202410151814.WmLlAkCq-lkp@intel.com> <CANiq72nn6zv9MOD2ifTXbWV3W1AgiXL=6zTX_-eGL5ggLj4fbw@mail.gmail.com>
In-Reply-To: <CANiq72nn6zv9MOD2ifTXbWV3W1AgiXL=6zTX_-eGL5ggLj4fbw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Oct 2024 15:06:59 +0200
Message-ID: <CAH5fLghJrrq2nJu7S08bBg2sAjdibkZ4D14K9cqETafnr4CR4w@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:11=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 15, 2024 at 1:06=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > >> /bin/sh: 1: cannot create rust/kernel/arch_static_branch_asm.rs: Dir=
ectory nonexistent
>
> This happens because we run `RSCPP` even when it is not a target. We
> can add the dependency conditionally:
>
> @@ -423,8 +425,10 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
>  $(obj)/kernel.o: private rustc_target_flags =3D --extern alloc \
>      --extern build_error --extern macros --extern bindings --extern uapi
>  $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.=
o \
> -    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o \
> -       $(obj)/kernel/arch_static_branch_asm.rs FORCE
> +    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
>         +$(call if_changed_rule,rustc_library)
> +ifneq ($(CONFIG_JUMP_LABEL),)
> +$(obj)/kernel.o: $(obj)/kernel/arch_static_branch_asm.rs
> +endif

Thank you. I was able to reproduce the error locally. It only happens
when CONFIG_JUMP_LABEL is disabled. I've verified that this fixes it.

Alice

