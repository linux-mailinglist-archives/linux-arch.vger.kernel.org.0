Return-Path: <linux-arch+bounces-4803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D64902858
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E277728749C
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93214B973;
	Mon, 10 Jun 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J6Q9caiY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DE152DF5
	for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042826; cv=none; b=dQcz+ajCTKFUuQmyoD6/hWabUpEX5a0WEdMCdFlCMyH45ChKMx9Rwa8ZZtAehsTqptiFqVUVeBtnbOMFxHDjylTxTQUcscQhtowwHfwCNDSHRTM8kfy5iQ8RUGJTxc6Wc5faI/6eYOKWCF0Kgrq5cY2yCzkr9v8Y05lnCP47OEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042826; c=relaxed/simple;
	bh=IEMruENEL3ierTK2Q7GOjtcBtiocQYEg6s5U0b0zRD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxX27Ki90BHUoFym3ys3wTXUckjI4EzgS+yqYs2YqJXxyVZ9071UsXvyXUh6OtUEs8X27q0g3gqG2m9KtUJoI0Ya4DBMMat1F0rTW1v8HqbHGHV8qrt5YWStWmt23ZFk4aB/i00et7uMFwY9O9VimSjg9FEiEUZ3axn9klfLhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J6Q9caiY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso24277866b.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718042823; x=1718647623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYkLMdQHI9XJCb3iOQ1AqKkfh0e7ysMUAFGnmxGuJNM=;
        b=J6Q9caiYNLtrhbEYWTXK9tQEzxcLiCtpdXVpqblrhQwD+wrllMl3SP2Or669HomvOh
         RDW61b0bx4AQp4H5nd2Kstt+Nxc76dbIlKn/+70csLHoqWLY6YBKg47rCCHh9pExZ+gP
         xsmK7Rq/JHFb1nydiebAfmt4Gn6C4Q1mX2Ais=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042823; x=1718647623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYkLMdQHI9XJCb3iOQ1AqKkfh0e7ysMUAFGnmxGuJNM=;
        b=o45Xy9Tgah6iiU3mH5uqVcaZOwl2FwZ6o2BWcBPqFVOoVmAUhPXo2HdMAWQTjhPNsN
         7sromYEnOMQPi3M6aAyrHo7ThDteUpGnnQ00+QjoageYmihmBZyplYhAZOwgWWaUWSM+
         keuoQwn9IvkWCwEUnl009/pTZjuzt5EbaviRv8M2hfy/ENYjW8EFt5PIp1SVfaDuXczk
         AZ5+8MWHFlBa9KDZDj2PYIjVMS+K06T8hQFKVCseB9INXtlGjAVxKqo2pW0JYGNZH6C2
         RB1cu/NahHkrriYS8o+FymuOzrfviVK5dQCgjs2qpt2HmJEBsSvWguJ511gwo9fJnLnp
         ALlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi7zAcJpRhMJKca5HZbBWALK7/uejbDb7rpmEijnz+ojQRDkDxINvtCtBuT1nj32R6AwMIy8zEywHh2XFGGrLDs4aNmEnUUzeMrw==
X-Gm-Message-State: AOJu0YykT4XuOjjvQNlrO9Hb5p9WcmumMF8slrQ0hw2oomv13gp7frZr
	2joHzeC9KQrjaHdqmDB/sD+qrsLgm8qv/Jrmx/XLADJnHUMoeChyOkxdeDRu0NAoNww3bSY87uQ
	Mp08=
X-Google-Smtp-Source: AGHT+IF12pL5J6QdDyV81J1Ng6abuJMA7ZQGQXWz3/lFWEJuONIsBnkfNv+ahHcnB50ZuKoq+b2DOg==
X-Received: by 2002:a17:906:22cf:b0:a6f:df9:6da4 with SMTP id a640c23a62f3a-a6f0df96e7amr389187866b.44.1718042822965;
        Mon, 10 Jun 2024 11:07:02 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20563a26sm139729666b.129.2024.06.10.11.07.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:07:01 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so212870a12.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 11:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMCtGG6zXh1ABohnYAeeG+Jog4zZ49S9RTpc+D/QlZZtbBGoQpwJfUFC+7ZpTN2jzmnEL8AV7Jqq/VzTqwDe4RgdraJ1b6UWq/+w==
X-Received: by 2002:a50:8d54:0:b0:574:ec8a:5267 with SMTP id
 4fb4d7f45d1cf-57c50990bc5mr6829442a12.31.1718042821079; Mon, 10 Jun 2024
 11:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <20240610104352.GT8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240610104352.GT8774@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 11:06:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5DAR=a12cbKbxDy875hTOtPmNUDEn+dU2VS47h9MgcQ@mail.gmail.com>
Message-ID: <CAHk-=wh5DAR=a12cbKbxDy875hTOtPmNUDEn+dU2VS47h9MgcQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 03:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- linux-2.6.orig/arch/Kconfig
> +++ linux-2.6/arch/Kconfig
> @@ -1492,6 +1492,9 @@ config HAVE_SPARSE_SYSCALL_NR
>  config ARCH_HAS_VDSO_DATA
>         bool
>
> +config HAVE_RUNTIME_CONST
> +       bool

No. We're not adding a stupid config variable, when nothing actually wants it.

> +#define __runtime_const(sym, op, type)                 \
> +({                                                     \
> +       typeof(sym) __ret;                              \
> +       asm(op " %1, %0\n1:\n"                          \
> +           ".pushsection __runtime_const, \"aw\"\n\t"  \
> +           ".long %c3 - .      # sym \n\t"             \
> +           ".long %c2          # size \n\t"            \
> +           ".long 1b - %c2 - . # addr \n\t"            \
> +           ".popsection\n\t"                           \
> +           : "=r" (__ret)                              \
> +           : "i" ((type)0x0123456789abcdefull),        \
> +             "i" (sizeof(type)),                       \
> +             "i" ((void *)&sym));                      \
> +       __ret;                                          \
> +})
> +
> +#define runtime_const(sym)                                             \
> +({                                                                     \
> +       typeof(sym) __ret;                                              \
> +       switch(sizeof(sym)) {                                           \
> +       case 1: __ret = __runtime_const(sym, "movb", u8); break;        \
> +       case 2: __ret = __runtime_const(sym, "movs", u16); break;       \
> +       case 4: __ret = __runtime_const(sym, "movl", u32); break;       \
> +       case 8: __ret = __runtime_const(sym, "movq", u64); break;       \
> +       default: BUG();                                                 \
> +       }                                                               \
> +       __ret;                                                          \
> +})

And no. We're not adding magic "generic" helpers that have zero use
and just make the code harder to read, and don't even work on 32-bit
x86 anyway.

Because I didn't test, but I am pretty sure that clang will not
compile the above on x86-32, because clang verifies the inline asm,
and "movq" isn't a valid instruction.

We had exactly that for the uaccess macros, and needed to special-case
the 64-bit case for that reason.

And we don't *need* to. All of the above is garbage waiting for a use
that shouldn't exist.

> +++ linux-2.6/kernel/runtime_const.c
> @@ -0,0 +1,119 @@

And here you basically tripled the size of the patch in order to have
just one section, when I had per-symbol sections.

So no.

I envision a *couple* of runtime constants. The absolutely only reason
to use a runtime constant is that it is *so* hot that the difference
between "load a variable" and "write code with a constant" is
noticeable.

I can point to exactly one such case in the kernel right now.

I'm sure there are others, but I'd expect that "others" to be mainly a handful.

This needs to be simple, obvious, and literally designed for very targeted use.

This is a *very* special case for a *very* special code. Not for generic use.

I do not ever expect to see this used by modules, for example. There
is no way in hell I will expose the instruction rewriting to a module.
The *use* of a constant is a _maybe_, but it's questionable too. By
definition, module code cannot be all that core.

             Linus

