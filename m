Return-Path: <linux-arch+bounces-3153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA688AD81
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F7A1C3EFD2
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325B3398B;
	Mon, 25 Mar 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H7bFykcs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41373DABF4
	for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388704; cv=none; b=NOcPtzRiVuf7pnXpAuPMnJ3N1TcHarWE6Shgaply5E8/BLuXs3WvTzY9edzwrkCe+ywFOSkl/fr6thsSCbcw7kxKiPnhM00NFRpB24W2YVMJJ1X4A6hmFKLs25udrwJCRipPlaoOjsslPDHra/a0+FOfzFCeWwKBTSgc0LmBDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388704; c=relaxed/simple;
	bh=TpmJTEOgQOHM9HmdS/G5PTDNlrGN/J8csNvsXEYpiFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi+sbkaEv7V4H8iFmzLtrQh5hbbfRW+s068xFOEjbIBM/Q47HN/rXt7Z2JWRjc45LIfqcrxdAiTapYyQ5UILpStEfsNILRzfzpMkPbwPZ0Tz34DuJN7IrEI1A/ZMMmSdVTmXwPdKru0x3iOnxxTVe0pGiGV5BrNFRMp0FcHupCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H7bFykcs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a467d8efe78so551671366b.3
        for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711388701; x=1711993501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sd/wp9UpBSQuIXx6uQdvepokZABl7yLFwM775FKBHzQ=;
        b=H7bFykcserJ5cGU3RMufzlfQFC8FF2NhXcdeQJzj825g8dMPPYchUeKeKMwUPHkqO+
         VvLA+1PpVES5qmEoH69NHwBsIDT+M0Fve9X+2kyfIUvfMYKo0qBieY/2oK2gGYhmu4QS
         VEMKhJaZwy3Sa/Di3yMnhMw4+D1GxvE6qj0NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388701; x=1711993501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd/wp9UpBSQuIXx6uQdvepokZABl7yLFwM775FKBHzQ=;
        b=wlmahJmx14+lQyvbsZxpuLc53wsv53AoCZXv89+WJZraJUFNhn1OoQro8gbD6DW0VT
         bddFr9Y/ZqdH/XEXOWYtv+ksJYmjawl/00n0H2HMvkgP0KGEHahTlwE1SG6i6sZRCw0Q
         ITWcjqOhWNqk+G5r6K3j2BbxAtpDTQi9thYa2iUIHGIUCnmxPNxLSYJ1KrgE4PE4MnYB
         St3DNrxaNiyVtqi0X4eQcgtzyymEN48r1QvtAr33B/tGKOt4ZkW6VtiIEHMynMLikSUr
         2m8Rv84kVJAS1gcWtl1Z3H4ra/34V6Lnd8UREWWk+tUJwGM/94YmnA9hwwkLhD7HeKXI
         mOaA==
X-Forwarded-Encrypted: i=1; AJvYcCWO/u1oLmDxil3SrmTIp7mr15RbD4HaaNxQKmA6D8Qop5Ni2+AUQlEwP3uSDJbLZHiSuDhoMmEIVuJi3OAjX2FSgz8KU5A4+QduJw==
X-Gm-Message-State: AOJu0YyCl+LpEQytiWqFCdr6N/6S65iYZ7bohHckSuCibaYhWC2ey9qn
	7TqArofiHCG/3ioadcXKTDGM/yNv4VRNcE4wRjJSs/mcPcnBnNp1pjfx/43uw/Y1skdxfFHr93w
	H9xXAaw==
X-Google-Smtp-Source: AGHT+IHuoaQekcV0rmsN6RzyZnK2pb/GPM1mObSM2kJ3F1SGsqf25wcDwqUsA5lN9lBJi4i4D9LJFA==
X-Received: by 2002:a17:906:c7cc:b0:a46:f02d:8e1 with SMTP id dc12-20020a170906c7cc00b00a46f02d08e1mr5878831ejb.53.1711388701121;
        Mon, 25 Mar 2024 10:45:01 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709063b0e00b00a473774b027sm3271709ejf.207.2024.03.25.10.45.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:45:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so4980694a12.0
        for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 10:45:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDcBxpM0tfZNiOjF78/onKbK+KkT4FLP/lGsos1ZsYLNEWCwU3N9FCDcw5JXVtbhfmbb9lxow0nixc/CwYfgNdpIjn1YD1ijLBhg==
X-Received: by 2002:a17:906:6dc4:b0:a45:94bf:18e6 with SMTP id
 j4-20020a1709066dc400b00a4594bf18e6mr5614781ejt.73.1711388700462; Mon, 25 Mar
 2024 10:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com> <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
In-Reply-To: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Mar 2024 10:44:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Message-ID: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
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

On Mon, 25 Mar 2024 at 06:57, Philipp Stanner <pstanner@redhat.com> wrote:
>
> On Fri, 2024-03-22 at 17:36 -0700, Linus Torvalds wrote:
> >
> > It's kind of like our "volatile" usage. If you read the C (and C++)
> > standards, you'll find that you should use "volatile" on data types.
> > That's almost *never* what the kernel does. The kernel uses
> > "volatile"
> > in _code_ (ie READ_ONCE() etc), and uses it by casting etc.
> >
> > Compiler people don't tend to really like those kinds of things.
>
> Just for my understanding: Why don't they like it?

So I actually think most compiler people are perfectly fine with the
kernel model of mostly doing 'volatile' not on the data structures
themselves, but as accesses through casts.

It's very traditional C, and there's actually nothing particularly odd
about it. Not even from a compiler standpoint.

In fact, I personally will argue that it is fundamentally wrong to
think that the underlying data has to be volatile. A variable may be
entirely stable in some cases (ie locks held), but not in others.

So it's not the *variable* (aka "object") that is 'volatile', it's the
*context* that makes a particular access volatile.

That explains why the kernel has basically zero actual volatile
objects, and 99% of all volatile accesses are done through accessor
functions that use a cast to mark a particular access volatile.

But I've had negative comments from compiler people who read the
standards as language lawyers (which honestly, I despise - it's always
possible to try to argue what the meaning of some wording is), and
particularly C++ people used to be very very antsy about "volatile".

They had some truly _serious_ problems with volatile.

The C++ people spent absolutely insane amounts of time arguing about
"volatile objects" vs "accesses", and how an access through a cast
didn't make the underlying object volatile etc.

There were endless discussions because a lvalue isn't supposed to be
an access (an lvalue is something that is being acted on, and it
shouldn't imply an access because an access will then cause other
things in C++). So a statement expression that was just an lvalue
shouldn't imply an access in C++ originally, but obviously when the
thing was volatile it *had* to do so, and there was gnashing of teeth
over this all.

And all of it was purely semantic nitpicking about random wording. The
C++ people finally tried to save face by claiming that it was always
the C (not C++) rules that were unclear, and introduced the notion of
"glvalue", and it's all good now, but there's literally decades of
language lawyering and pointless nitpicking about the difference
between "objects" and "accesses".

Sane people didn't care, but if you reported a compiler bug about
volatile use, you had better be ready to sit back and be flamed for
how your volatile pointer cast wasn't an "object" and that the
compiler that clearly generated wrong code was technically correct,
and that your mother was a hamster.

It's a bit like the NULL debacle. Another thing that took the C++
people a couple of decades to admit they were wrong all along, and
that NULL isn't actually 'integer zero' in any sane language that
claims to care deeply about types.

[ And again, to save face, at no point did they say "ok, '(void *)0'
is fine" - they introduced a new __nullptr thing just so that they
wouldn't have to admit that their decades of arguing was just them
being wrong. You'll find another decade of arguments explaining the
finer details about _that_ difference ]

It turns out that the people who are language-lawyering nitpickers are
then happy to be "proven right" by adding some more pointless
syntacting language-lawyering language.

Which I guess makes sense, but to the rest of us it all looks a bit pointless.

                  Linus

