Return-Path: <linux-arch+bounces-3121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2959887629
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 01:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816281F2248F
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41C137E;
	Sat, 23 Mar 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ciEMuvBI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8F624
	for <linux-arch@vger.kernel.org>; Sat, 23 Mar 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154183; cv=none; b=QCoOqD6PqYxzgiO8mLZXc0eDRS3U+vkdpN78i7xg5F/SQ+rXi6q1pLQqYDT2i1IDBylBR1NipBbdaB/oD0nAawo2V6Iy3rJu56eqGzcWDsOHz+hJDFJjwhglO4z3pvjkj1AlhyK45a0AeFozcCLgoFDISYmO+yrZziTqh9RNd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154183; c=relaxed/simple;
	bh=j7JyDQ2Yopzv+1fWqR18eqoGt0JNvJeLXCqR09mac8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0z/koc+/aqtj8ZWeyHoaGcyNJj/2aRTocMQ1hVXaFExGsf3nOQatS1n9fNh0wBYiT9KySPWrOWMBC6gqoBLXgl7JaDwFbC7/3Qx+8dxAJ5RDBApRts/9Ue6jw8rx+cSDTeZFJ//GwSWumeYVWYT6PJcjxqJhbk5NhJezHfwk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ciEMuvBI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso33043951fa.1
        for <linux-arch@vger.kernel.org>; Fri, 22 Mar 2024 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711154179; x=1711758979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNrld7J3rRC7RvH2KCmmyzFGDmF8jJ8gCeKdRT3S6xQ=;
        b=ciEMuvBIoZjyAojyiJYTfPNq9Av/ZPXIBZAYGluujHNVoc9z8fuEUcJWRGsHTEzfXX
         hk8+b/bOcWd+7vwY+MjskqumSYWbByCpdex5ZfyOYRvp2VdehmWIPwvN8tN0ITBEFgDI
         teCast5fceriI9FjELhBrPuOqv0BPFOZTJqFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711154179; x=1711758979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNrld7J3rRC7RvH2KCmmyzFGDmF8jJ8gCeKdRT3S6xQ=;
        b=rZwdZNVcsPs+iCjL699HgcV8MNnF7JoBoYn689HWp1zmG01TOUnoZeQ1uCI+F8MBZ2
         0zyDtmFfLI/APIiRVlU1QzJlzrv+379K52I49E/bsKv4o1SsRrYkteHuyj1nmSDxdhrV
         MSDgcU6J8wbToqPXL9RHkQxZx4ielduiLn8xmM5iWeDhCB1eZKbsyamCu13lHyN+lfsu
         kor72hk5/0RNaxUfawVPBXUkoMXursrf29O2T2e6GNVAjOqzKiC0MzmbakssAk3UMNyE
         iZYJyYtGptw2ZBnfW49yg6OLam7TQlUhot1Kd0ZtpmqQfSjSZOQLIV7zicOzVC8nDgSH
         TsFw==
X-Forwarded-Encrypted: i=1; AJvYcCXkWnvI6F9U0In/4qWzTrSElnfscGya1utBhHnqiU4uim/wQlgcAly5GEELT6G0Kysncjt6Vziv41f5EzsW815dpX6aD9l8loZTlQ==
X-Gm-Message-State: AOJu0YxmhB1usArBwr3Mfv6JIJhIafPr6Wge4rln1m64XoDv7y37DFv3
	cO/QzSAReQRFHO2/F6Jci5+oUe2uqyotopOLyVpLAb/IFZp08kk2gkJwuVLdWMRG0kAQAG8v4FF
	9YUKFiA==
X-Google-Smtp-Source: AGHT+IFi6POVxKA6KRPHOx6ouJJN7tHdM26Ec1v9ReAHF6zmGpVIoy7ujcqyA+dbOCBRHNMhh33HWg==
X-Received: by 2002:a2e:b0f0:0:b0:2d3:4b73:7b40 with SMTP id h16-20020a2eb0f0000000b002d34b737b40mr649468ljl.17.1711154179151;
        Fri, 22 Mar 2024 17:36:19 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z20-20020a2eb534000000b002d6b47725casm359697ljm.6.2024.03.22.17.36.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:36:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5159f9de7fbso383510e87.1
        for <linux-arch@vger.kernel.org>; Fri, 22 Mar 2024 17:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4PK1YyPyoz1SGjfda3gtf8lZrBcPiOhh1Q2JSLrGIbBLIy3XRlz/SzkZ1YavPDzbRkDPXK6JLg1pSpu1a9xhFZudaiUvpiWoGzA==
X-Received: by 2002:a19:f806:0:b0:515:9d4a:d580 with SMTP id
 a6-20020a19f806000000b005159d4ad580mr604299lff.26.1711154177346; Fri, 22 Mar
 2024 17:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com> <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
In-Reply-To: <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 17:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Message-ID: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Fri, 22 Mar 2024 at 17:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Besides that there's cross arch support to think about - it's hard to
> imagine us ever ditching our own atomics.

Well, that's one of the advantages of using compiler builtins -
projects that do want cross-architecture support, but that aren't
actually maintaining their _own_ architecture support.

So I very much see the lure of compiler support for that kind of
situation - to write portable code without having to know or care
about architecture details.

This is one reason I think the kernel is kind of odd and special -
because in the kernel, we obviously very fundamentally have to care
about the architecture details _anyway_, so then having the
architecture also define things like atomics is just a pretty small
(and relatively straightforward) detail.

The same argument goes for compiler builtins vs inline asm. In the
kernel, we have to have people who are intimately familiar with the
architecture _anyway_, so inline asms and architecture-specific header
files aren't some big pain-point: they'd be needed _anyway_.

But in some random user level program, where all you want is an
efficient way to do "find first bit"? Then using a compiler intrinsic
makes a lot more sense.

> I was thinking about something more incremental - just an optional mode
> where our atomics were C atomics underneath. It'd probably give the
> compiler people a much more effective way to test their stuff than
> anything they have now.

I suspect it might be painful, and some compiler people would throw
their hands up in horror, because the C++ atomics model is based
fairly solidly on atomic types, and the kernel memory model is much
more fluid.

Boqun already mentioned the "mixing access sizes", which is actually
quite fundamental in the kernel, where we play lots of games with that
(typically around locking, where you find patterns line unlock writing
a zero to a single byte, even though the whole lock data structure is
a word). And sometimes the access size games are very explicit (eg
lib/lockref.c).

But it actually goes deeper than that. While we do have "atomic_t" etc
for arithmetic atomics, and that probably would map fairly well to C++
atomics, in other cases we simply base our atomics not on _types_, but
on code.

IOW, we do things like "cmpxchg()", and the target of that atomic
access is just a regular data structure field.

It's kind of like our "volatile" usage. If you read the C (and C++)
standards, you'll find that you should use "volatile" on data types.
That's almost *never* what the kernel does. The kernel uses "volatile"
in _code_ (ie READ_ONCE() etc), and uses it by casting etc.

Compiler people don't tend to really like those kinds of things.

            Linus

