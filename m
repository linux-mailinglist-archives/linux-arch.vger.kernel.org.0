Return-Path: <linux-arch+bounces-3506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61A89CCC2
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822F02841DA
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD41465B5;
	Mon,  8 Apr 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z5ir6u5T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF59146596
	for <linux-arch@vger.kernel.org>; Mon,  8 Apr 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606743; cv=none; b=LiaMTU9acn4QMq/NpPd7UUboS9MYA5tFu83GGIIx37oXZDyW57a5zDLd6WxtvQ8fcWyLbRAME03H8igyhpse3kbn6w+d/Wpju+osZHa7Mg+Il0zaWMMS+TFykqQNcyXl+qndImbSTKvB2VNYcxWPGGGUf7HFw1uFrtC6G/7jZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606743; c=relaxed/simple;
	bh=82F1MgsQLgdYIQgatWxiRfAXR/TCmhkAjQEqWWRhptw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmIIkTfzu2af70orcKU4byzZHHmy2flaPjqQgkmN4raY0QMMFjgr6B8Kq/vQumDu5rcAjVxRP+lkr3lV9kaB5VvHK02lLgxBgZMhpFuGSUeTyI0A0t+DCFd1N6ehajhHu7Xo1sCnUnXP0Ghm3/gc2nF3ejkr9SXAaYhOIb9+xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z5ir6u5T; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so6110668e87.3
        for <linux-arch@vger.kernel.org>; Mon, 08 Apr 2024 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712606740; x=1713211540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRKPouMe4xkFwANgjkQYrxaOlNKZlWPMAGzB1iq7Iyc=;
        b=Z5ir6u5TTSrqp2kfcCqQQa7plMKqZZ++fUjPyADCsDbaO3AsrDV3x3BRDeDzNMUHAd
         6vZlMhVWYZcKq1cXOqCO6hCDc1v+Epgvo6ERiSklQTL4THHGRKzQOty42mPqrQmf/NnE
         qbl81x42hbtlXmRRQGezjdgo3wMaeCiSjFuUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712606740; x=1713211540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRKPouMe4xkFwANgjkQYrxaOlNKZlWPMAGzB1iq7Iyc=;
        b=vpIBlmvzMGwq4Zs3FmK5AzBSXm98Cc63iJhdnZVLhNGJJpKSDGtSTsce84PT3BJbZn
         DBckrZWd9UMCo21rflqn2nJWbshpDa+42dXHDqNuFRxDSne+uHWSlcFLWZ5yootEFEem
         /BtMbuHb1wxDvFj1x272qsQ42o8M52QJBSy+m6EZFsk5JfO4CtEy3li/ByTN3wvHAp5H
         BC4avG15cA25PL4/Lbpfw8DcaoiL2uZIPRx45lr3NzHWj8dKeiu5fzhsEm8YbRMT1NY8
         dzBdrxIxMM8FzOVDBxIivCCOyzfVJieie8bjiAyIflyTeUrYWdnLrTajXN7SjbbbegS8
         QoTA==
X-Forwarded-Encrypted: i=1; AJvYcCW3xpHYq4pcxXXEhBKFh1fURs9CIg4/WsXd4TjHELM3pDu/OUE/Lf4Tps7crZFZ/tPTbeDlNbvBsi4TzklzFJn00jHqsiwvxJfvMw==
X-Gm-Message-State: AOJu0YzoYzBD2jDjVDlsN9dtC8BOnnVHrNqKT0DtCr7CtESkco5za5/i
	xEXgCDPFAjfsLH24ik4T5nx5ogR71QJbJrDpMti86X08uF2XMtDcz6sU1Ky1eVtcB53Y00+2I/H
	sI9QvhQ==
X-Google-Smtp-Source: AGHT+IEbUnDmlhn879knYfWpTq1BM/W67smQ/OeFP7gaUijso0cWSwFXbON1lCc8F9YSAjVZMUar0g==
X-Received: by 2002:a19:6a0a:0:b0:513:b062:98c4 with SMTP id u10-20020a196a0a000000b00513b06298c4mr6227995lfu.11.1712606739677;
        Mon, 08 Apr 2024 13:05:39 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id i16-20020ac25230000000b00513d13ede82sm1283166lfl.147.2024.04.08.13.05.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:05:39 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d487659bso4707344e87.2
        for <linux-arch@vger.kernel.org>; Mon, 08 Apr 2024 13:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVslaOANKb9Zj63h1ckhHtluQUHLk2BiVAfax0urK+TBltd6TKq1s4jbPYCe38F7/S96SzLgoRT70QED5hGdHQ2aEKNrns9qRHRmA==
X-Received: by 2002:a05:6512:60f:b0:516:9fdc:2621 with SMTP id
 b15-20020a056512060f00b005169fdc2621mr6538971lfe.0.1712606737016; Mon, 08 Apr
 2024 13:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org> <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
 <20240408181436.GO538574@ZenIV>
In-Reply-To: <20240408181436.GO538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 13:05:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wispSt+JezguriGPKnJ0xOUWG_LFDgaM-NVJu6cVa+-xw@mail.gmail.com>
Message-ID: <CAHk-=wispSt+JezguriGPKnJ0xOUWG_LFDgaM-NVJu6cVa+-xw@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Philipp Stanner <pstanner@redhat.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 11:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, PA-RISC is no better - the same "fetch and replace with constant"
> kind of primitive as for sparc32, only the constant is (u32)0 instead
> of (u8)~0.  And unlike sparc64, 64bit variant didn't get better.

Heh. The thing about PA-RISC is that it is actually *so* much worse
that it was never useful for an arithmetic type.

IOW, the fact that sparc used just a byte meant that the aotmic_t
hackery on sparc still gave us 24 useful bits in a 32-bit atomic_t.

So long ago, we used to have an arithmetic atomic_t that was 32-bit on
all sane architectures, but only had a 24-bit range on sparc.

And I know you know all this, I'm just explaining the horror for the audience.

On PA-RISC you couldn't do that horrendous trick, so parist just used
the "we use a hashed spinlock for all atomics", and "atomic_t" was a
regular full-sized integer type.

Anyway, the sparc 24-bit atomics were actually replaced by the PA-RISC
version back twenty years ago (almost to the day):

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=373f1583c5c5

and while we still had some left-over of that horror in the git tree
up until 2011 (until commit 348738afe530: "sparc32: drop unused
atomic24 support") we probably should have made the
"arch_atomic_xyz()" ops work on generic types rather than "atomic_t"
for a long long time, so that you could use them on other things than
"atomic_t" and friends.

You can see the casting horror here, for example:

   include/asm-generic/bitops/atomic.h

where we do that cast from "volatile unsigned long *p" to
"atomic_long_t *" just to use the raw_atomic_long_xyz() operations.

It would make more sense if the raw atomics took that "native"
volatile unsigned long pointer directly.

(And here that "volatile" is not because it's necessary used as a
volatile - it is - but simply because it's the most permissive type of
pointer. You can see other places using "const volatile unsigned long"
pointers for the same reason: passing in a non-const or non-volatile
pointer is perfectly fine).

              Linus

