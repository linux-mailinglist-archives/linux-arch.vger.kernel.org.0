Return-Path: <linux-arch+bounces-3485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3C89CA32
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A941287AF7
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928463CB;
	Mon,  8 Apr 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EGRWk23h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E101422C9
	for <linux-arch@vger.kernel.org>; Mon,  8 Apr 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595715; cv=none; b=Bzkbim/J16hqyQNBiAVGPfrs21R7hy2Ur9VEUHXK9Y5zeuNYhXxgTtCrBMm0RWNdmuT5jFjpSbCHh0vVo6bfQDBFOCx+pSLMkEum8JRHcCHfmjSWHsN6qMMETdaLuR1fkuXecLwNPuQretV3sJeZOvH9vqM99/JZne7tp2NBuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595715; c=relaxed/simple;
	bh=R1X/55Ass4+5QaXX6Nqf8js8X6058F+DL+6kNlzxcrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGIbLXuSXUaePm7zADQlo6ItFIPg/a6KwGJjaXnLVf1ukReXGNsqi82Dgj3qGv+KQIisvQ5rrzmZfyV3LncLhFbLVtQNW3vUlGRNwFAxesMYeia6xlyMVpAzZcPmKZ72xT7O17vyzeRXblh/+pGm6vUu7G5W+xSQIK+kODbNhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EGRWk23h; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso3044580a12.3
        for <linux-arch@vger.kernel.org>; Mon, 08 Apr 2024 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712595711; x=1713200511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwMXPeVIx6bxobFvIepci0DieuFBhkBMzMB9NgGCo/g=;
        b=EGRWk23hCB+CbCUNGOMSRJW9ZGvFWDj3jGm23LM6x0VERLWRzHzLm45D0xKVgYUkLW
         1cm+LDAu3Mir8A4aYfexnB5eBoBSjhbRjC9XxW2wGw9OgECtQT0Cvs/aaSXnH3mt3MH9
         J95Xs84xqodg05yKmRwqnmvRK+O8TV01yf/8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712595711; x=1713200511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwMXPeVIx6bxobFvIepci0DieuFBhkBMzMB9NgGCo/g=;
        b=ZnNzv4nBHFE+PIIj5JMFrqVvOQPaOZQ4Tvssy83kV3SlfiD+TLhD2+NzyqWEAUV3Hl
         dfg8wXYAlzW0tCZon+AYgrjxtl4PtYSiqXqFSE4YVXzo+H1/rbEwJUR14iaeeL+baovH
         J92itDsX8VXaLHj40yi79HNQKDL8VGf33vOEkdCSImUioZEQsMbh87+8iPSgFjrvpXQw
         thjxc702fv1wNmQ6rbJfUqAgPvZ5weH7xiHGmNpgUBz1T3IHrRRRkj2VwgnR6oBNbilW
         oYzq70/Iq0bN3n/gnfi7qO+SkRooCMMyHmpng+bvypdspflvHyEZHbgrkWAvbdYkGR7W
         VoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+M0W3qr9+3+1My64Kiyyspd1xiih+aKtV9XCH0QA0S7A944gOQ1llYnXtCicu4ZITXSme5MyJFFfh/28wTfysHNRnPLS/nz0Rfw==
X-Gm-Message-State: AOJu0YythibTIbBkdJo1em4gUToWstgJ+Or3zLdfRIoihCRF5UvZrR8c
	IERltiWkcuJnWk9VVyGz6DVwZzb1BZSm3xmfWOqLkzP6XR2bx/30CkJAx9Au6yJ3diJ9Z8CF9wW
	TEdc=
X-Google-Smtp-Source: AGHT+IFMmJjroe6yt+sXA2X5Zjs/aJr0Bw4Y9YgHKbxGrMMivbuBTjqGDQ/GAft703MtQM5WM38TgA==
X-Received: by 2002:a50:bae3:0:b0:56e:238e:372c with SMTP id x90-20020a50bae3000000b0056e238e372cmr6889580ede.26.1712595711628;
        Mon, 08 Apr 2024 10:01:51 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id b13-20020a0564021f0d00b0056e6c477230sm346073edb.16.2024.04.08.10.01.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 10:01:50 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4702457ccbso614915166b.3
        for <linux-arch@vger.kernel.org>; Mon, 08 Apr 2024 10:01:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2NjqFVOcKMBAhLiBjbfvfToFLtN1ihjxHEMnUSpx/dCW53LX7Vu3WK9lkQ+rrrIqDg9CXbXoi3QuxxpwiqAtya6uAktcq2hLokA==
X-Received: by 2002:a17:906:1d05:b0:a51:913c:1c83 with SMTP id
 n5-20020a1709061d0500b00a51913c1c83mr6230911ejh.58.1712595709884; Mon, 08 Apr
 2024 10:01:49 -0700 (PDT)
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
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com> <ZhQVHZnU3beOhEGU@casper.infradead.org>
In-Reply-To: <ZhQVHZnU3beOhEGU@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 10:01:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
Message-ID: <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Matthew Wilcox <willy@infradead.org>
Cc: Philipp Stanner <pstanner@redhat.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
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

On Mon, 8 Apr 2024 at 09:02, Matthew Wilcox <willy@infradead.org> wrote:
>
> What annoys me is that 'volatile' accesses have (at least) two distinct
> meanings:
>  - Make this access untorn
>  - Prevent various optimisations (code motion,
>    common-subexpression-elimination, ...)

Oh, I'm not at all trying to say that "volatile" is great.

My argument was that the C (and C++, and Rust) model of attaching
memory ordering to objects is actively bad. and limiting.

Because the whole "the access rules are context-dependent" is really
fundamental. Anybody who designs an atomic model around the object is
simply not doing it right.

Now, the "volatile" rules actually make sense in a historical
"hardware access" context. So I do not think "volatile" is great, but
I also don't think K&R were incompetent. "volatile" makes perfect
sense in the historical setting of "direct hardware access".

It just so happens that there weren't other tools, so then you end up
using "volatile" for cached memory too when you want to get "access
once" semantics, and then it isn't great.

And then you have *too* many tools on the standards bodies, and they
don't understand atomics, and don't understand volatile, and they have
been told that "volatile" isn't great for atomics because it doesn't
have memory ordering semantics, but do not understand the actual
problem space.

So those people - who in some cases spent decades arguing about (and
sometimes against) "volatile" think that despite all the problems, the
solution for atomics is to make the *same* mistake, and tie it to the
data and the type system, not the action.

Which is honestly just plain *stupid*. What made sense for 'volatile'
in a historical setting, absolutely does not make sense for atomics.

> As an example, folio_migrate_flags() (in mm/migrate.c):
>
>         if (folio_test_error(folio))
>                 folio_set_error(newfolio);
>         if (folio_test_referenced(folio))
>                 folio_set_referenced(newfolio);
>         if (folio_test_uptodate(folio))
>                 folio_mark_uptodate(newfolio);
>
> ... which becomes...

[ individual load and store code generation removed ]

> In my ideal world, the compiler would turn this into:
>
>         newfolio->flags |= folio->flags & MIGRATE_MASK;

Well, honestly, we should just write the code that way, and not expect
too much of the compiler.

We don't currently have a "generic atomic or" operation, but we
probably should have one.

For our own historical reasons, while we have a few generic atomic
operations: bit operations, cmpxchg, etc, most of our arithmetic and
logical ops all rely on a special "atomic_t" type (later extended with
"atomic_long_t").

The reason? The garbage that is legacy Sparc atomics.

Sparc historically basically didn't have any atomics outside of the
'test and set byte' one, so if you wanted an atomic counter thing, and
you cared about sparc, you had to play games with "some bits of the
counter are the atomic byte lock".

And we do not care about that Sparc horror any *more*, but we used to.

End result: instead of having "do atomic ops on a normal type" - which
would be a lot more powerful - we have this model of "do atomic ops on
atomic_t".

We could fix that now. Instead of having architectures define

   arch_atomic_or(int i, atomic_t *v)

operations, we could - and should - make the 'arch' atomics be

   arch_atomic_or(int i, unsigned int *v)

and then we'd still keep the "atomic_t" around for type safety
reasons, but code that just wants to act on an "int" (or a "long")
atomically could just do so.

But in your case, I don't think you actually need it:

> Part of that is us being dumb; folio_set_foo() should be __folio_set_foo()
> because this folio is newly allocated and nobody else can be messing
> with its flags word yet.  I failed to spot that at the time I was doing
> the conversion from SetPageFoo to folio_set_foo.

This is part of my "context matters" rant and why I do *not* think
atomics should be tied to the object, but to the operation.

The compiler generally doesn't know the context rules (insert "some
languages do know in some cases" here), which is why we as programmers
should just use different operations when we do.

In this case, since it's a new folio that hasn't been exposed to
anybody, you should just have done exactly that kind of

    newfolio->flags |= folio->flags & MIGRATE_MASK;

which we already do in the page initialization code when we know we
own the flags (set_page_zone, set_page_zone, set_page_section).

We've generally avoided doing this in general, though - even the buddy
allocator seldom does it. The only case of manual "I know I own the
flags" I know if (apart from the initialization itself) is

        ->flags &= ~PAGE_FLAGS_CHECK_AT_FREE;
     ...
        ->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;

kinds of things at free/alloc time.

> But if the compiler people could give us something a little more
> granular than "scary volatile access disable everything", that would
> be nice.  Also hard, because now you have to figure out what this new
> thing interacts with and when is it safe to do what.

I think it would be lovely to have some kind of "atomic access"
operations that the compiler could still combine when it can see that
"this is invisible at a cache access level".

But as things are now, we do have most of those in the kernel, and
what you ask for can either be done today, or could be done (like that
"arch_atomic_or()") with a bit of re-org.

                       Linus

