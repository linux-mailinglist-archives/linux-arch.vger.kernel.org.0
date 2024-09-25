Return-Path: <linux-arch+bounces-7430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E4986524
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2EB229B1
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8338825;
	Wed, 25 Sep 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQrBMT9I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93C17547
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282779; cv=none; b=TMGtjRMOm1fBBmk2TcSMGCaQSoeybslzcfmXGZGLI5a7Hjz+ah8xwb8YiYhCCgUERidXnOd/OqJdxD8+3BPLvkMDSCHR9hhnWB1eNR6iLXJePzji9v73lKcjEumYjSLSdhOFClvZ2xRqbp8ibM1V+vha0glrCudhC7ZEU7TDgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282779; c=relaxed/simple;
	bh=/t+YSp2gvbsBW9hsAIIEsn2fOHY2XQVupxHXFI22op4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeXz+pUku6iyGD5J4Lwhew9C1mePYyIuq4+VNTTNZ4d/wzi8vaBkegM9xKmd1jt84XAMM8yFRtE+KAQg7/kGFuZOi3lXe5zbwVSfMol3uyrrDjlllvJeLyydIS3m6687cBR+s6fFA/XHG3tRew8hE1ujAjaOThbKkgPDtuj3i28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TQrBMT9I; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d4979b843so6207066b.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727282776; x=1727887576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=TQrBMT9IqCRxC+KoCI//aa5MoW5n1cgmnBVA9IFDmmOKdslNcMZIVlHXF28KuO/62q
         8ER1imbKJcG3gPwk8GyjCj02aJ120muqFoSp557+ncXFTiyOpur13wcjMpLWiI7xWtuq
         8BX7VuEP7tbPeVwVjNmJsGjSSUt3KgiG6/JvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282776; x=1727887576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=AmL8LyuMltSh/IMpDFaCimsGukjzSJ6wFBMutBL4rEmOPqu6oBKv2+aVB5hVXnchlV
         vtoPFGzhNTxLAbihwER8Jhe/SypONr8eiXFqbWUToD5CFCwj5jKWtgeDjEyyq170MzMM
         sv3RucmWsYlgJJUcwp/KVdJZV4AzUKTwRMTJGzSZz+7rbPGXCp3HBxWBRKD8C7NWw4nY
         ddq8CesFaDE7VP/cuiIq7aTq4Uaj4G/uQKTsuBvcUmpHL8LB06kcxnsMhp8yKNC24OVf
         uKWEfxYghceEPK0p2CMUwD2WDE2yF2mddTLBDSYKAqU1cQV7H42XkHXyoM5CjWxfuz4Q
         AUxw==
X-Forwarded-Encrypted: i=1; AJvYcCUtktOojbgTQTcK6mwMJZSz6TL/kH1xk+4xfTRBvV5yl2+//vrRvhzgxykuDvq5nnTCeHj2BnGhXWLo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1O0E2RXkSdhjG+7XSF/58DIXjMV2ml6tvoiYK1NLOvWO5aVS3
	bxysXST+Bz0W5AYdmdplRAYv/wZ9p5Ayn8zjRLGXaeV4RHTHJh2yx7nQgq3u1jpCCDpeVIDM7lA
	8brxdaQ==
X-Google-Smtp-Source: AGHT+IHKfMl1VchGm6z0z8LP3tCajHJcemx3gdVK6leyK57ftACCxzqH0XqxkBDOJPHGRTb78iVRRg==
X-Received: by 2002:a17:907:7b82:b0:a86:a1cd:5a8c with SMTP id a640c23a62f3a-a93a036a4famr292469366b.22.1727282776014;
        Wed, 25 Sep 2024 09:46:16 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f51e33sm229664866b.78.2024.09.25.09.46.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:46:15 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so102795e9.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 09:46:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXunA7Fwi7i41S1X7bydBh5xzVcvff5JQRxs1BwhG0ZZhbIcWTNhSzw0iNnKtkfSpbMkAkfABavtjat@vger.kernel.org
X-Received: by 2002:a17:906:f5a9:b0:a86:9d39:a2a with SMTP id
 a640c23a62f3a-a93a0330c37mr309689066b.8.1727282382886; Wed, 25 Sep 2024
 09:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-44-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-44-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 09:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/28] x86/rethook: Use RIP-relative reference for
 return address
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 08:16, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Instead of pushing an immediate absolute address, which is incompatible
> with PIE codegen or linking, use a LEA instruction to take the address
> into a register.

I don't think you can do this - it corrupts %rdi.

Yes, the code uses  %rdi later, but that's inside the SAVE_REGS_STRING
/ RESTORE_REGS_STRING area.

And we do have special calling conventions that aren't the regular
ones, so %rdi might actually be used elsewhere. For example,
__get_user_X and __put_user_X all have magical calling conventions:
they don't actually use %rdi, but part of the calling convention is
that the unused registers aren't modified.

Of course, I'm not actually sure you can probe those and trigger this
issue, but it all makes me think it's broken.

And it's entirely possible that I'm wrong for some reason, but this
just _looks_ very very wrong to me.

I think you can do this with a "pushq mem" instead, and put the
relocation into the memory location.

                 Linus

