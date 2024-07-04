Return-Path: <linux-arch+bounces-5265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A152A9279E5
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5826C28401C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E661B11F7;
	Thu,  4 Jul 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fu1hIWQC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322781B11F4
	for <linux-arch@vger.kernel.org>; Thu,  4 Jul 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106431; cv=none; b=SgzDqP8oCEoAZRjmFCLpu8T0qmp8XOhPePypScBdl9aKCHTlUrHMPRbVHWGzejTgvKP8O/JyrxUo3jdtGqyU4lGf1afV8QBwMbQlhXuUxLdx/KPSoHGEJC3w67L6UUwbrHam9AC+hkHz5dxzP/72eyX+xkgoKFt540uAlqOHHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106431; c=relaxed/simple;
	bh=/PizTQVDlkIyNELY350ZONH8Gfc08NYf27/JwjBxgRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ8YUdQHCL0LcKvX7OrUE9euaSWCWRJNXmwFeT7bEYvEUNKOvWKY/1PMSQ7OvAHI8V1bbpytirz7CnCAJnEARpKLvko4S60yMB5S6nd1+ROX6hBWcSIRc4Wi85nc4tf4rjxQB6kCrWJAEpEq5blSaBpCTbTwyEIVu0kx+ZZpTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fu1hIWQC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb1c918860so11976625ad.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Jul 2024 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720106429; x=1720711229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMtQ8G7gYG0PtXSm+9oSte5ras/tptARhMk8vAyTBpM=;
        b=Fu1hIWQC/Sh/lpNuKEDxDoKokku3Y7aOEw1EuiIfNAFF3DTgfpsDw0pYkpgzopT6Xt
         7UECkjZaO5+TPym0K8iv7eoNWcZrmT9O5jfpKVGSkISRGVKggSoes7aGcev7nTsp9gA8
         fPXKDpkUfOp7Txy04cbUv9T5KDpQ6JLfrObHuQYnVGXn5kpt3jiphDkj0hnbapEDZFpr
         6ncJvtDOLQAtaBAZhDLGfZmSg0jeGVZD4R3WFlFeJwXmbQtYWUfYHfN8G7RG2/KTM16i
         Fh8SjLY45v6AX/qx64phLWH/9KLyYu1+/8RZwyMDiRV+Z9dffxfFgA+787OpAisg5HaL
         k1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106429; x=1720711229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMtQ8G7gYG0PtXSm+9oSte5ras/tptARhMk8vAyTBpM=;
        b=wrbscymnfxEMwwCgIqNB24yKzaHDazAPjizX29MkUWEB/9beqcolki+qWPkb4Vfad9
         dhinwkwjHogSjZLXJerE1AivPoZP+4j7lwM+1/FpiGzAqGGgYeq2miQvoXtVFSVaNBS2
         0lfAf+logryHmmlfFcmlUv7lDS1oPjWnkiwzmVUDB7XnQh1ogOgIABdVtzeTOc4efc2t
         bkw1YzAHBQpSDl8dVxfejOfweM9cAK2Rri18i9a5dIVyNtNNfZbbXjep1KtuBSV688G3
         eqFrVeZSsHWKx8HmmGvqXTF1SXajN3OX3tDV+w/9R+PSRvVkk8gSAe2SWHB7t3WVgHC1
         D/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYMCasLVBdtbSGPL/esa3v6VqC7zREb1BxxQve4BIsLsjzw42LPyQUJ/V9WBd5fg33A8yBrCkbmegiqMvFgPKrBnbti+T1EJOtqA==
X-Gm-Message-State: AOJu0YzWilkRJQoVyQKNukDnCRfZ3/uOS5S9eFgZeF4e83v+UaoeHroy
	cSUPTyTH1bSpalLYGACEZhEOa5einGAX8rS12nahh5KfFMTf76kT2Hn/HuVP6w==
X-Google-Smtp-Source: AGHT+IGCoEg+2iwgq2yFecGonukG4K9qxoer7A69funkZsv0Vc/pIw4JkTQQWYN93RAWKE9BO0pBlQ==
X-Received: by 2002:a17:902:dacd:b0:1fa:1a78:b5a9 with SMTP id d9443c01a7336-1fb3700ccffmr27138855ad.3.1720106429108;
        Thu, 04 Jul 2024 08:20:29 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388bdsm124081885ad.168.2024.07.04.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:20:28 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:20:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradaed.org>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] rust: add tracepoint support
Message-ID: <Zoa9uMODCjTfM741@google.com>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-2-353d523a9c15@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-tracepoint-v4-2-353d523a9c15@google.com>

On Fri, Jun 28, 2024 at 01:23:32PM +0000, Alice Ryhl wrote:
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/tracepoint.h      | 18 +++++++++++++++-
>  include/trace/define_trace.h    | 12 +++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 689b6d71590e..d82af4d77c9f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
>  #endif
>  
> +/*
> + * Declare an exported function that Rust code can call to trigger this
> + * tracepoint. This function does not include the static branch; that is done
> + * in Rust to avoid a function call when the tracepoint is disabled.
> + */
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)			\
nit: IMO using a __* prefix would be a better option to describe the
internal use of the macro instead of the _REAL suffix.

Other than that, this patch looks good to me:

Reviewed-by: Carlos Llamas <cmllamas@google.com>

