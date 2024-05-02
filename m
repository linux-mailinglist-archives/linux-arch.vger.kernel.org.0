Return-Path: <linux-arch+bounces-4150-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96B8BA309
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 00:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA901F22C67
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3857CA4;
	Thu,  2 May 2024 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GJnqqqoQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC457CA2
	for <linux-arch@vger.kernel.org>; Thu,  2 May 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688234; cv=none; b=SHsMGNCpG7g8BdyYc3dZeWmJh/btYFRzwxyC5sfCM/+BPQi9Nfhps2GTDT6yGOiap4pXR8xBxoQCJuv1XqMYeLF/MI7cFeEOeStI/3oTZufBrI5EoSwfwf0O5vAZO2okw+DBIiTmm8gnCDup70OLhsw7Sft29JItJNH3c2L7CSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688234; c=relaxed/simple;
	bh=qnKN9L3Z0Au55/oPWH4SsCKSSflxsoIcUt2AGUKIs6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLMXOi9RycU8yEDgs83rqtCDO0bTBLdA80yUx3AqlyTQV6RvkE3HIOpENwDZ91aVczC2wNzEzYqCpqNKaniwFqNgriXiU29vZBAhqfeKPZ2Ro0M7m5IQ7L1yuCYlUEBMrO2Ao1CRr5d7jp/I6NuVF5l4YiwZEMJfZ5heKfGaDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GJnqqqoQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so54291201fa.3
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2024 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714688230; x=1715293030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8L1plbBpC5b8hbxFDn23VRySV0QK2bnDqJWgg6u+KQ=;
        b=GJnqqqoQsqjSI+/2oQk+iQsNFkAuNXij1BBwTXqCLQ6h3VBPulz9VeOP7cDiduETHV
         XDxLkyOBNOgjyoER5mApuViKLg63pAqz5K+vk+IcfGG5vhVSMiRaNj2jqNuNUoTKAX0u
         8UIW6aqdTtaU0QIn8Zlctft2mCHLT/I+780tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714688230; x=1715293030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8L1plbBpC5b8hbxFDn23VRySV0QK2bnDqJWgg6u+KQ=;
        b=PN1oqch9zu1qiGhvQoE6kukGwayAtpktwVBgDXv87weLQz6q+iIsme9vN/80qoy3Wf
         DBsCLIGNenSjjNffotsYdtLIPyheZ65jZ7AWheztSfx+kS2f9VdqbXrZr7XhJQniIXRu
         VsWFlMv8M+XE9KUpDOq66zaPDP9mEQM5azEbd2AipcJaPHexdg6DYCwN6NLVseaP+Oud
         RVX0g6g7Ou18XgxTfMsL9PS1tBn73EU01zXKDG/4ZhTRIMSL+xaL7kzokhyqcTCpAMTd
         Zh4CpLWpfpk4VORg3Ba+lPPdYwMbixWVzRWE7INjK7fTzMMc59WKcKB8NEHjlKoUICnK
         p3WA==
X-Forwarded-Encrypted: i=1; AJvYcCVx+OOAISicg4Wqj68cQQ01p5c0lGAXfPE+FM2NLfEjfdIlr5yyyQ1vjPyQU303DMoQZqPzkHC/a85zoEh7Yal6PlmVuSSrnwyXJQ==
X-Gm-Message-State: AOJu0Yz7gWB0ZFJmFbNbWR+VA+f4I74br/u+5lzJe/4m6JPa6wADR1Gk
	HDhqrRd2WYLwijebkeNTmHCcSL/NLpg7Q0svsPDLv9oi4V7GZ84/eY4vzO+Zv81oIwrNEnzDQo3
	nTEOc8g==
X-Google-Smtp-Source: AGHT+IHs7Py+EHWqb0NxuyJF8ghiP1Dh/TdCX361sd2R7hh4W1VBxicu3N3SojZi1Ud9GcHG1bnknw==
X-Received: by 2002:a05:651c:1691:b0:2de:c6b5:2888 with SMTP id bd17-20020a05651c169100b002dec6b52888mr472986ljb.3.1714688230111;
        Thu, 02 May 2024 15:17:10 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7d788000000b00562d908daf4sm939773edq.84.2024.05.02.15.17.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:17:09 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a55911bff66so1114265566b.0
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2024 15:17:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVWlFEn6Y8S9rHMGSuE7H3hOyt1cCLsyst1CTaPEGUZD+4B5HGNGeg4QySerpVXwvQpfhZqu5vWoBsaV32LmdiOvrVApKZMTqmbQ==
X-Received: by 2002:a17:906:2b94:b0:a59:4101:433e with SMTP id
 m20-20020a1709062b9400b00a594101433emr448463ejg.35.1714688229488; Thu, 02 May
 2024 15:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org> <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop> <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop> <20240502205345.GK2118490@ZenIV>
 <20240502210122.GA2322432@ZenIV>
In-Reply-To: <20240502210122.GA2322432@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 15:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-Jt7MgFC4-yr6DdvCVDoy1nu0W9W2zmaGZm6u=b2qTg@mail.gmail.com>
Message-ID: <CAHk-=wj-Jt7MgFC4-yr6DdvCVDoy1nu0W9W2zmaGZm6u=b2qTg@mail.gmail.com>
Subject: Re: alpha cmpxchg.h (was Re: [PATCH v2 cmpxchg 12/13] sh: Emulate
 one-byte cmpxchg)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, arnd@arndb.de, kernel-team@meta.com, 
	Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 14:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +static inline unsigned long
> +____xchg_u8(volatile char *m, unsigned long val)
> +{
> +       unsigned long ret, tmp, addr64;
> +
> +       __asm__ __volatile__(
> +       "       andnot  %4,7,%3\n"
> +       "       insbl   %1,%4,%1\n"
> +       "1:     ldq_l   %2,0(%3)\n"
> +       "       extbl   %2,%4,%0\n"
> +       "       mskbl   %2,%4,%2\n"
> +       "       or      %1,%2,%2\n"
> +       "       stq_c   %2,0(%3)\n"
> +       "       beq     %2,2f\n"
> +       ".subsection 2\n"
> +       "2:     br      1b\n"
> +       ".previous"
> +       : "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
> +       : "r" ((long)m), "1" (val) : "memory");
> +
> +       return ret;
> +}

Side note: if you move this around, I think you should just uninline
it too and turn it into a function call.

This inline asm doesn't actually take any advantage of the inlining.
The main reason to inline something like this is that you could then
deal with different compile-time alignments better than using the
generic software sequence. But that's not what the inline asm actually
does, and it uses the worst-case code sequence for inserting the byte.

Put that together with "byte and word xchg are rare", and it really
smells to me like we shouldn't be inlining this.

Now, the 32-bit and 64-bit cases are different - more common, but also
much simpler code sequences. They seem worth inlining.

That said, maybe for alpha, the "just move code around" is better than
"fix up old bad decisions" just because the effort is lower.

              Linus

