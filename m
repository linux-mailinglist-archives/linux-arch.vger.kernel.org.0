Return-Path: <linux-arch+bounces-4802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8D902824
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 19:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826461C21377
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E71482F6;
	Mon, 10 Jun 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B6uYFWB3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031014884F
	for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042320; cv=none; b=ozaLjQRWwq93EOLmO3fL/gWIWWo2zMIIlRK5R5o2TIuG2phUn8WrQFVfyd1ic2u6u0j079TV0A+qDEPsZ3Xa8Ws7Zhc5ohLVu9TdDFMqsEUoNv9vh86bpjDOhCxUtpu76hAS7ftqX0kU8Jn0kCWy7opeLEk+MvGljCQiLOlghAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042320; c=relaxed/simple;
	bh=hO6nnDmuhkUErx75fBkprBGAIkEHIr9E1JJw8oC4y1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe/N9W81xl5GR54L6Rwosu2ElfG55Tf2jzWiAm97RIPvCwIyVrGoN+OSBAQ6ZivbZiDQbzrgsXoVoz5H8V0ai5Rkx7Bd7QdqdzIyrlzxx8zIZd9Uk8mLil2OtoIYugAoXaZjngtcxZCOgW3NuRzNSyYyvWfKfbFCGcQdW2iFa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B6uYFWB3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c7440876bso213618a12.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718042316; x=1718647116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bQX4a1uB13mXlhl/FxYuXCoDhG2XSW0BFXyW6YKkaDg=;
        b=B6uYFWB392WDEcYr0HbznBnOc65vMkmbWesae73GUt4mybcRD4siviUw6vNx4qdp1R
         IxO08I+AFOHO51Zu/sdVI03lQhK7O2CB7ePLaD6iMyem/FGvoTN6VssUJiNTEocj9+tw
         ifuTpVtCHbuZhlMkS4/teuJHTrgbfvkhhJxLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042316; x=1718647116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQX4a1uB13mXlhl/FxYuXCoDhG2XSW0BFXyW6YKkaDg=;
        b=IH2I4DyQpbi+cSpixcXJgADeregfW66n+dW5PtpDDWOHQc19Xcnv5xKr6+K3ywqsa1
         T0iEMt2FjYnHcMiozd7rA17S/7RiasaQPfZ4065zYPFouUKDKEDCRLCPn6/tWE3lrhba
         2wZlJGigUhti2WZt1TTZ+NyMuMEjNQ7EdGrbYL+yYMOr6mpfhBynvA2iUC0JdKNoTJJs
         7jV42Ej8LjKiA9xc5t6SQbBE9mGfBqefE+FKPoxOMSU/tH4uCJCHb+oGTRwoD6Afasfg
         mctSk7W3XNbHcQhp4czJ2bfdpQVYAbJ4fWkOOpMoZlhZwXs9+rMqOLsFAh2Tv5pSL4OZ
         Hgiw==
X-Forwarded-Encrypted: i=1; AJvYcCXszFnwUvcZsGJ/tw6ymPTD7+VbUQn3dRLNpDMnqlXfaDigMw8twT/Lil91uZJkR4LJXByMVDc8on3oQEtrwnvNYo6LxP9XNukTCg==
X-Gm-Message-State: AOJu0Ywf3bSjCLJCY6JsRu+3hGTnjtCw+gyL5s6R8NuFSyIX5i+d46E5
	FaYwy0pkIdQTnzgT5MFJM6OAFn0+/PaVInhW8zgqTfm0/p84rpqHu9eFxWoFdbBkQOu2MyJONRB
	ZmEQ=
X-Google-Smtp-Source: AGHT+IFif+bWEOU+v7TvTTnTeCUhwaxG/fR4UEjTJeGOfMEQvOUtdu2mvGjH1TwJxyofsmtaT9lnRw==
X-Received: by 2002:a50:bb03:0:b0:57a:72fc:c515 with SMTP id 4fb4d7f45d1cf-57c50972f4emr8344835a12.29.1718042315696;
        Mon, 10 Jun 2024 10:58:35 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e093sm7718557a12.13.2024.06.10.10.58.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 10:58:34 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f04afcce1so22822366b.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 10:58:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXB17rFX7XyAbniV0sVjG7JcdCuDScRadfY8yKg/cLOxOtLEbpnUy24fX13MtS/YtdF++ZQRAMjVWbSFgvqFfPGqJTT1lZjOMz9dQ==
X-Received: by 2002:a17:906:11ca:b0:a6e:139b:996d with SMTP id
 a640c23a62f3a-a6e139b9d75mr689185666b.32.1718042314389; Mon, 10 Jun 2024
 10:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <29a8ceb4-a699-433b-8a11-be6b3c9fd045@rasmusvillemoes.dk>
In-Reply-To: <29a8ceb4-a699-433b-8a11-be6b3c9fd045@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 10:58:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirUHJ8DWzWjb3ZxatjQaomeTzM4uPjemrkbSjVvYOaGQ@mail.gmail.com>
Message-ID: <CAHk-=wirUHJ8DWzWjb3ZxatjQaomeTzM4uPjemrkbSjVvYOaGQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 02:50, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> Well, I think it lacks a little. I made it so that an arch didn't need
> to implement support for all runtime_const_*() helpers

Honestly, normally the number of helpers would max out at probably
three or four.

The only helpers you need is for the different constant sizes and the
placement in the instructions. For example, on x86-64, you almost
certainly end up with just three fixup functions (byte, 32-bit and
64-bit) and then *maybe* a couple of "operation" helpers.

Honestly, the only op helpers that are likely to exist are
add/mask/shift. But I didn't add macros for creating these ops,
because I don't actually believe very many exist in the first place.

And yes, x86-64 ends up being fairly simple, because it doesn't have
multiple different ways of encoding immediates in different places of
the instruction. But even that isn't going to make for very many
operations.

In fact, one of the whole design points here was KISS - Keep It Simple
Stupid. Very much *not* trying to handle all operations. This is not
something that will ever be like the atomic ops, where we have a
plethora of them.

To use a runtime constant, the code has to be really *really*
critical. Honestly, I have only ever seen one such function.
__d_lookup_rcu() really has shown up for over a decace as one of the
hottest kernel functions on real and relevant loads.

For example, in your RAI patches six years ago, you did the dentry
cache, and you did the inode_cachep thing.

And honestly, while I've never seen the inode_cachep in a profile. If
you ever look up the value of inode_cachep, it's because you're doing
to allocate or free an inode, and the memory load is the *least* of
your problems.

> name because yes, much better than rai_), but could implement just
> runtime_const_load() and not the _shift_right thing,

Not a single relevant architecture would find that AT ALL useful.

If you have a constant shift, that constant will be encoded in the
shift instruction. Only completely broken and pointless architectures
would ever have to use a special "load constant into register, then
shift by register".

I'm sure such horrors exist - hardware designers sometimes have some
really odd hang-ups - but none of the relevant architectures do that.

> Otherwise, if we want to add some runtime_const_mask32() thing to
> support hash tables where we use that model, one would have to hook up
> support on all architectures at once.

See above: when we're talking about a couple of operations, I think
trying to abstract it is actually *wrong*. It makes the code less
readable, not more.

> Don't you need a cc clobber here?

"cc" clobbers aren't actually needed on x86. All inline asms are
assumed to clobber cc

It's not wrong to add them, but we generally don't.

> And for both, I think asm_inline is appropriate

Yup. Will do.

> I know it's a bit more typing, but the section names should be
> "runtime_const_shift" etc., not merely "runtime_shift".

I actually had that initially. It wasn't the "more typing". It was
"harder to read" because everything became so long and cumbersome.

The noise in the names basically ended up just overwhelming all the
RealCode(tm).

> > +     RUNTIME_CONST(shift, d_hash_shift)
> > +     RUNTIME_CONST(ptr, dentry_hashtable)
> > +
>
> Hm, doesn't this belong in the common linker script?

I actually went back and forth on this and had it both ways. I ended
up worrying that different architectures would want to have these
things in particular locations, closer to the text section etc.

IOW, I ended up putting it in the architecture-specific part because
that's where the altinstructions sections were, and it fit that
pattern.

It could possibly go into the

        INIT_DATA_SECTION

thing in the generic macros, but it has to go *outside* the section
that is called ".init.data" because the section name has to match.

See why I didn't do that?

> I mean, if arm64 were to implement support for this, they'd also have to add this
> boilerplate to their vmlinux.lds.S?

See

    https://lore.kernel.org/all/CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com/

doing arm64 was always the plan - ti was doing perf profiles on arm64
that showed this nasty pattern to me once again (and honestly, showed
it much more: I have 14% of all time in __d_lookup_rcu() because while
this machine has lots of cores, it doesn't have lots of cache, so it's
all very nasty).

Notice how small that patch is. Yes, it adds two lines to the arm64
vmlinux.lds.S file. But everything else is literally just the required
"this is how you modify the instructions".

There is no extra fat there.

> Please keep the #includes together at the top of the file.

Yes, my original plan was to do

    #ifdef CONFIG_RUNTIME_CONST
    #include <asm/runtime-const.h>
    .. do the const version of d_hash() ..
   #else
   .. do the non-const one ..
  #endif

but the asm-generic approach meant that I didn't even need to make it
a CONFIG variable.


> > +static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
>
> Could you spend some words on this signature change? Why should this now
> (on 64BIT) take the full hash_len as argument, only to let the compiler
> (with the (u32) cast) or cpu (in the x86_64 case, via the %k modifier if
> I'm reading things right) only use the lower 32 bits?

I'll separate it out, but it boils down to both x86 and arm64 doing
32-bit shifts that clear the upper 32 bits.

So you do *not* want a separate instruction just to turn a "unsigned
long" into a "u32".

And while arm64 can take a 32-bit input register and output a 64-bit
output, on x86-64 the input and output registers are the same, and you
cannot tell the compiler that the upper 32 bits don't matter on input
to the asm.

End result: you actually want to keep the input to the constant shift
as the native register size.

But I'll separate out the d_hash() interface change from the actual
runtime constant part.

               Linus

