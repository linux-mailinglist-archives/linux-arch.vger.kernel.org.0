Return-Path: <linux-arch+bounces-8166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7B99E90E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5927A1F24013
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B581EF958;
	Tue, 15 Oct 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8K/+ZdF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0E1EBA14;
	Tue, 15 Oct 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994280; cv=none; b=bCOaN0qEMvOC1hW71tby8tAKAFqPn5VTrRtRuV99/67X97crlEAe609y9twSkv3tQAaKIGDA4VQr7t4LyoRptaoRJGW8rkw+wUFbEqb/zDt5pdI3Kgdo9L0aDsfxMsNRPvZHXwcfE4yMoQ8tjsNf/2UkyyHTgQZEYGNkbJXf9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994280; c=relaxed/simple;
	bh=dnnZUgzCwws9KYXi6ot0s1d3Fp6NN+N4r5wRaq6PAzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMaUpFmXuNZjgfhcgTyelzspAZq3pibdtf4U3dTExwz5cdEw0qQ40/gGHmMWlVjSt/MJmmxHcwfOgewgFYCqiR5zuSm3BzHwIEIX6y5r1x9dyWiytS9JkqrlhXGFIkt1mXh+5ZZQUVjCakdbd2HhT4NNgozQFVUnNhAIikLvMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8K/+ZdF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2b71fd16fso933923a91.3;
        Tue, 15 Oct 2024 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728994278; x=1729599078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV8FOLSLhwtyiWp+lk7vSGC6JLIndGdKNovPdihlpN4=;
        b=E8K/+ZdF86VVS6vFSt1cUiTKmfbzevFKsTpPZftMWpD/qphneyrxP1mhKv46QX0WL0
         FXn8JATRSOS85AGScHWbnndB8TKmBUIxgsihiKSEFr8GRtaPaTvw7V6RkvGk7ygvSz6B
         SHWyNiiIjk5jHZGyLQ7lPU9A0zAk63Hvcxx97Pu8KLyGhEAtCUWWp3qmJfZ2L3j9o2IX
         1ozRz3GscpDoMD2vHXzzhU6keiWLtjAv96P+t4kkwFP7XQ5E7c6n8d4Ps73HbTxeq6ir
         ILpCCGj8ZPYa+6p75kO0lckavdwWz5FrWFi6L219JcMnpWM64tjEAg6YUdBzk+suUost
         CTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994278; x=1729599078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV8FOLSLhwtyiWp+lk7vSGC6JLIndGdKNovPdihlpN4=;
        b=Oqo658pyfTq8ToyXsu3iGRhYYpsLbkrk/wIS8HdUXXL1x4UBWgdemcTf/+3+bFO+f5
         o3Rksw8HUZoljEXFIXyZufcCelFj+l3dMm1LLM6SIXTrblYROXpZMrLuuf+7n8l0ajyd
         GHmELexQC1EV8CdFO0UOeyk585kHwTOfoOU38a6D7sTikUqC7/abfOhCLeNudKHkg4H+
         DfuoVxVCuUzEH6l+Y52NGzk63MLC1OvKpmdPnOJ5idkg86hlNanATZKeWGAILMJlEEB8
         Y7Pg8IZyWAfHY4deqazoezrcpZeMd0f3IzUCGGxaE5MHuvJ7cgVRPJ4AGU+xfTHZUCj1
         NghA==
X-Forwarded-Encrypted: i=1; AJvYcCUaTO04ctzz0E+bIWNV/clAaxRyyaixHmI676eos2nzd0OerHP0fRPazWPfI8zi0a9lRqTnII3UQ1pcv7MggaI=@vger.kernel.org, AJvYcCVFyvxPL/i/cIH32k1BDaQdH6w1f34lvf3jYNIQRo1NwxHSVxm7Etw3OsjpMJH3f8PUDch9G8DOkp95bZip@vger.kernel.org, AJvYcCW2LUcxpeoGUUsc+pZVFSwijsOebugQRzJkQLibC1BfgmZJenLj3MSqUEl6FTVFme5AyUI5J10v33yQpn0+iwgjRZ0N@vger.kernel.org, AJvYcCXoLKqraPdjsXc6zMH59BVIe0lo75TbR1Di+I7aLHqktYBak7xExbgIhKp2maBIYlkaVYALkGhL4f5o@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuTkObTV9j0ECMr+72ZW493sXyP2CJnMndN1p0pI/jyr1Yu0U
	dcq0NhohoJfoZrtpMQh8FoNkIjXz4Qb9kV+O5P9ARFKi8QO5OlF6BbfyRnd+Cupoqt4XtOomuPk
	8q2U30Bluk9HvyITpD+uyuu5/OgI=
X-Google-Smtp-Source: AGHT+IFSfFq5YCrErjt8c8UA+f+PBcvIWdJRqe/AN44rKjjupOA/NWpgra6o1nxcyv+5NZeBZYXbe5CQMWH68x1Ky44=
X-Received: by 2002:a17:90a:bf91:b0:2e2:e860:f69d with SMTP id
 98e67ed59e1d1-2e2f0d788cbmr7356172a91.7.1728994278289; Tue, 15 Oct 2024
 05:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-5-7fbde4d6b525@google.com> <202410151814.WmLlAkCq-lkp@intel.com>
In-Reply-To: <202410151814.WmLlAkCq-lkp@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Oct 2024 14:11:05 +0200
Message-ID: <CANiq72nn6zv9MOD2ifTXbWV3W1AgiXL=6zTX_-eGL5ggLj4fbw@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
To: kernel test robot <lkp@intel.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

On Tue, Oct 15, 2024 at 1:06=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> >> /bin/sh: 1: cannot create rust/kernel/arch_static_branch_asm.rs: Direc=
tory nonexistent

This happens because we run `RSCPP` even when it is not a target. We
can add the dependency conditionally:

@@ -423,8 +425,10 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
 $(obj)/kernel.o: private rustc_target_flags =3D --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o =
\
-    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o \
-       $(obj)/kernel/arch_static_branch_asm.rs FORCE
+    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
        +$(call if_changed_rule,rustc_library)
+ifneq ($(CONFIG_JUMP_LABEL),)
+$(obj)/kernel.o: $(obj)/kernel/arch_static_branch_asm.rs
+endif

Cheers,
Miguel

