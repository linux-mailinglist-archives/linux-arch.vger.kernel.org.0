Return-Path: <linux-arch+bounces-8177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F399EFEA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926701C22CF6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA221C4A21;
	Tue, 15 Oct 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPaMjyek"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2B1C4A0C;
	Tue, 15 Oct 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003440; cv=none; b=tF7LyfcidX/fAysfZ8GfW6pdjMN5FBJfdM+sFufsgGq3MCRMttKAGa+TfAz8SUgN1zIleOV5KjjWL0yBecLZ26+DIDuuBLCWhX0d+ZkZgsYf2xGzAbLeOQRRUtc+LYKCMiV9BejW3Akq9rRNn7B0uJQ2CVdQGQILBRR4kRhaO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003440; c=relaxed/simple;
	bh=A7CxIg3FylzHgSJxPQ/0P9yWq+JAO79Um66+WxhE0R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEwtDQLYd2mK4KKyTlONxGGbVQSHcADm7i0Ob1GZ77uSxTth9FB49752uOUONUL/vt57+XjMAWKwLrPJvF01SSANS6VxAtpDFh9ukCO8H2AVfC76HxXOq5IlU0EwIuhlEBGDCs7evz9nkexR3fm0jPq0VBh8gLTry1rT3SAOQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPaMjyek; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c53efc14fso3243605ad.0;
        Tue, 15 Oct 2024 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003438; x=1729608238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7CxIg3FylzHgSJxPQ/0P9yWq+JAO79Um66+WxhE0R8=;
        b=IPaMjyekCcsDjjWOmDOQgvnLLW1bn1wuzuzvKihAo1iSSn5IphTlBnzGHkkrFxNh1o
         sSb+t1DvKlA8/3ClgG1sSrqNS5jV8Z/1rrebUvxhD/HQ+kLpAQJDSEFAqaH1qU9mF6/v
         2OOqRPA8QFV3TJyT4sbpo+n/QJtLvY956dztY6nVUHI5nl0mPWlm0ZX/TNpKfaih1gkr
         s5gvRScQP9sko1YHMOZj5QsdBi3xFDV25tq/T7CM731qvaVOVWmhiZy1dKqEqjg77RbW
         9cZH1ADByJU7+0+WfOZqqtIWXGinyuJ3rxRHpcxchjPHDBhYerQ0X/8i0BcDyUHo2WW8
         ukkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003438; x=1729608238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7CxIg3FylzHgSJxPQ/0P9yWq+JAO79Um66+WxhE0R8=;
        b=hcZGghSKxkJpiWORTQiAX/VN6x9luBXTyRz91lErzoXdJkM6RzPxbfitb8qTnuPAe7
         R2AhE0hcLrQjl2u/6zLBW4rJZN2EjbYKBR0EyeeDOoD8i8hXf76mJs65Sy/Xc41tOVeJ
         ptSO4FOXTp7C2+8PiTxVe1ay2bZ75UaaqVvxWiPz7/Vzo0cG2iWqAipL8HGKTmXki6DJ
         OcxG3fEJc9yCG8s8APQWQcxxk38e58xvEZSRaBWvifjqhxVNNhcE0X88hvUhyI0sKeXK
         /G6rmaHgqKDAQ9xfoPMtSWA6JpzdpoK5r6i/Rqc58TgWBk9dXFKcmZbOGGvOjW5BOd37
         VLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixrvi37hvsNzjTeWKuX78aiY6kercAaz+pkkmxG1xLouk5pfb7GA2ZAnO0mJeONEB7xiOG9FCxw8SIHWHzw8=@vger.kernel.org, AJvYcCV5+GTE6y3EEiDL6CgBtEulDPnGh627R5xkBYfGK3HTn1P3yvw5Hzpb8f29gzpbKrwDWP2MVs+b3OB/1/BA@vger.kernel.org, AJvYcCVvaSzQMmZtHvLuwRajnPufZnrxg5gwprzg2fird5TPBADGHNIXixzEG12ewXJdRUV/SYWUzaFGYqrvC7NuSpIfQNPu@vger.kernel.org, AJvYcCW118WfRCmlyGV/UrU6Y2vSmc51HXmxukR4BkXgBr2uw8MWWTc8SCTeIYevUmK7yY+2zIm4yUnLiiun@vger.kernel.org
X-Gm-Message-State: AOJu0YzsldiTl0hiQKd1I7bUg6l8+WWAy2v4ohRqGB14w2k9hIUNwVjP
	eTMVGmEk9KxQW5QY4VOnJ7PzpvdQGV89KTPL1mCMz2x8kU9sDk7CR1dqFIJNYgpzj5/g6YSj8L4
	fj58p3hkt6YumsEQkpvpwJ/ge3dqFP0yF/G+tDQ==
X-Google-Smtp-Source: AGHT+IFoXEBo1ZT1pXaD7KXeYP4P5odzuHy9MKmBB6t4PDsesuSr1w9SzhznkWVEoeEweWV6j6xd4RR7WhJRY5Fpauk=
X-Received: by 2002:a17:903:2343:b0:20b:b93f:2fec with SMTP id
 d9443c01a7336-20ca169ee11mr87190225ad.8.1729003438182; Tue, 15 Oct 2024
 07:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-5-7fbde4d6b525@google.com>
 <202410151814.WmLlAkCq-lkp@intel.com> <CANiq72nn6zv9MOD2ifTXbWV3W1AgiXL=6zTX_-eGL5ggLj4fbw@mail.gmail.com>
 <CAH5fLghJrrq2nJu7S08bBg2sAjdibkZ4D14K9cqETafnr4CR4w@mail.gmail.com>
In-Reply-To: <CAH5fLghJrrq2nJu7S08bBg2sAjdibkZ4D14K9cqETafnr4CR4w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Oct 2024 16:43:44 +0200
Message-ID: <CANiq72kRiQvw3xWbMGRxcVJhHN0LMRa0RewxnkofVr=71KQvEA@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
To: Alice Ryhl <aliceryhl@google.com>
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

On Tue, Oct 15, 2024 at 3:07=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Thank you. I was able to reproduce the error locally. It only happens
> when CONFIG_JUMP_LABEL is disabled. I've verified that this fixes it.

You're welcome!

By the way, if you end up sending a new version, then you could
simplify to `ifdef CONFIG_JUMP_LABEL`.

Cheers,
Miguel

