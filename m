Return-Path: <linux-arch+bounces-7522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777798BF8C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7CD1C236D3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B991CC8AD;
	Tue,  1 Oct 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDgSa8/E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B51CBE96
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792015; cv=none; b=RDohYfd5am+6/LEn9vEgV4qI1RdccFs/55OsSoRnrxSWB4/xTw6Grz9tAJHodTCZHwkspT2p02dxJEX6HKbv/XhZKI9eq3TmFUp5j8rxl1jP3ZxDOCKgkYD6fIRaoMiNXWMZ8Lr3VITAjdh8mufi8nBSXjGbYd0vpd81nzODOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792015; c=relaxed/simple;
	bh=w8hIawvAr2J+L+amI/5+VhvadK+7PheFbsRC9H17ZV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bzx4+BO0CaSSGhro90Vb1MgUHOtZ0MgwrSC+FpOAobuBT8Hc3bGm0dAcM2BQHt7SWeQA8T6CY6XfwS+7fT9cs34aOCFXElGzz/HWu8llda5iLNieGoEreZSI3lbpNx9j5T3RmP6OIfJ6zWDt8ZNfzM4KwrOnu/FCjY5l0spaOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDgSa8/E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso2980375f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727792012; x=1728396812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5obgxVfAZEyoG+iqtZvjYkscvrOCzI2Q3//aei7Jed8=;
        b=rDgSa8/EJze7UuhBKXoxiTwcgkiP1HjeNGxToaXRvuw57kypL0UFYmwfcXpZC+Jn2p
         Jb3SrwcqEM3rNnMMC4lfWe8FoWN7GXfXxdXxblWZbGvlqS3iwEqGyIfPDlNE7emu9TMQ
         4KBbaohzVyzMVfHdxSHiCBQbuQooDzecK6KLf4t5W9Ry1d/GwuSeDs8dZ1tTbzMgxXzQ
         G2eVoObNN6ldePG92HXRcOecVDcAn9wPv65hAp+HN9+6ucTgocPXD7WEd7S8WKWXuppV
         EkgUqhBP6aCUE8HVBFdFaMP5EiYW05LEafStv7wOmP/RVHWzLtZlTDVNEGRRamaUKylT
         DT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792012; x=1728396812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5obgxVfAZEyoG+iqtZvjYkscvrOCzI2Q3//aei7Jed8=;
        b=ZKdUeGTkRSCIlO8+7sTtQYvXEq5OcD0/S31SQs8CWjJiW5OvL/6HNtaaKPAq0jlXpa
         dJRrqL8+pDVhh70T2vhj7l7yGWCmTed6uSwMNuVWmatoKidK+4wgT9JN/YqQcOtx7LO+
         A+hx1kbSmY9SIQNoIfbTfy5aWlr/AIXDcPePrziVw4IhhxNAEVn+XHCJLGRyqg5WeH0f
         wcZzCaPquAWdvjhK8xsJRby9nvAmd6HXzJFd7n9XXxjLhWsDYPxO+u9LjDr+hk2WCRHE
         vIfhOKCOOTaWK75D05UBT9QnXjtTFKNoGIBVfytMzE3Mk+R8PTdyN2AMrSbaZUWA2ExI
         yPRw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHhGqt5HrHM0FKfKQjMVCGWiyYAJ4rKrL1QRLGVr2eNxihI4CMjFubcp1bqVHtwCGgJruYEcyRylu@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/DCu3n5OeXsM3srwh4WEgoKnOsI3b94eqRbI8m2pCYpTYoPN
	gGbz1MMzz3T0HWGdgWrXX7STSh2wc1UHgI1GWsyBYPsmvCdS384oLW0PyKtofSbUHXmHT5ZLZJZ
	v3hTJUuW+vzIzMpNEvZBRlT71c5T6k+yf7xr6
X-Google-Smtp-Source: AGHT+IEGav/rdbRGd4XLNTrqSljOoF/btIXDS4OkzP2Czz8bQKx69WPhqo0AphFZ55+q0RxYyyAvw7unwTk9BVpCMtE=
X-Received: by 2002:a5d:4e09:0:b0:37c:cd0d:208f with SMTP id
 ffacd0b85a97d-37cd5aed7d3mr9191230f8f.49.1727792011796; Tue, 01 Oct 2024
 07:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
 <20241001-tracepoint-v9-1-1ad3b7d78acb@google.com> <20241001101201.7a43726d@gandalf.local.home>
In-Reply-To: <20241001101201.7a43726d@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 16:13:18 +0200
Message-ID: <CAH5fLggkS-W93KoNANGpKuCgExJ40oNEtC1JtF1ffJyjhZ9Q8g@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] rust: add generic static_key_false
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
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

On Tue, Oct 1, 2024 at 4:11=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 01 Oct 2024 13:29:58 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.
> >
> > This patch only provides a generic implementation without code patching
> > (matching the one used when CONFIG_JUMP_LABEL is disabled). Later
> > patches add support for inline asm implementations that use runtime
> > patching.
> >
> > When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
> > function, so a Rust helper is defined for `static_key_count` in this
> > case. If Rust is compiled with LTO, this call should get inlined. The
> > helper can be eliminated once we have the necessary inline asm to make
> > atomic operations from Rust.
> >
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/bindings/bindings_helper.h |  1 +
> >  rust/helpers/helpers.c          |  1 +
> >  rust/helpers/jump_label.c       | 15 +++++++++++++++
> >  rust/kernel/jump_label.rs       | 29 +++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |  1 +
> >  5 files changed, 47 insertions(+)
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index ae82e9c941af..e0846e7e93e6 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/ethtool.h>
> >  #include <linux/firmware.h>
> >  #include <linux/jiffies.h>
> > +#include <linux/jump_label.h>
> >  #include <linux/mdio.h>
> >  #include <linux/phy.h>
> >  #include <linux/refcount.h>
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 30f40149f3a9..17e1b60d178f 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -12,6 +12,7 @@
> >  #include "build_assert.c"
> >  #include "build_bug.c"
> >  #include "err.c"
> > +#include "jump_label.c"
> >  #include "kunit.c"
> >  #include "mutex.c"
> >  #include "page.c"
> > diff --git a/rust/helpers/jump_label.c b/rust/helpers/jump_label.c
> > new file mode 100644
> > index 000000000000..0e9ed15903f6
> > --- /dev/null
> > +++ b/rust/helpers/jump_label.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (C) 2024 Google LLC.
> > + */
> > +
> > +#include <linux/jump_label.h>
> > +
>
> Nit, the above line has a spurious space.

Thanks. Looks like the function body also uses 7 spaces instead of a
tab. I'll fix it.

Alice

