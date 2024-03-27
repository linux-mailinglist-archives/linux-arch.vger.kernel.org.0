Return-Path: <linux-arch+bounces-3248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B888F073
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDA81C30625
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C61534F6;
	Wed, 27 Mar 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ou0vZTZT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076213049E
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572368; cv=none; b=ukbhtRdkHfdSJf6fTND8iPMzuwdMLXRYTtSbFcYMlZI2MNwcp5mMWJRir9dydHLxOdiGyVlfpj8Nc88ePTiuBzAsXm3PbaXQHas3yteuRUyRg1/nyeweYdE7aTiWAkx/KVFAtSFgg3orKhOuyCAZBodW9GkO2hvjArBYMydpPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572368; c=relaxed/simple;
	bh=RuCWKtbRzqJIEwrREMPn1YstKGaBmUG9LovdmLij8Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li8OF1PMQLnx+g0SBEv7y3WObZZDClwT521JbLBqkgE2wbcierzzSWaObu//utCIxHwcnsecB4SEzqvL98MdjdiaY5E1DrU/JmTXvqnoypxl0WTN9a90/77bdD/k3oq4n2mFfG0Tja/6+jPh0rTFEIAfjwh1rHCeMUtXl0u2lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ou0vZTZT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c36f8f932so2413275a12.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711572365; x=1712177165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MmaskrdbVq30uGRTY87iYuCKuy48OuaJH0qBlabGSIs=;
        b=Ou0vZTZTW9vFLlzd7o1NnmYGxW3i2eJBW+31PNcH/aerZATE0jRdCs5oyvR/BV3hCu
         Ze34ZXyGMlqS+PnxdbTQ7h1z7msIs7V1fNSolfYwE9h3E4h6swj7fHYPmFtGq3xkvwrh
         nIO5HC1UOMhJsv7NXwnPH11S/LQoGargDU2vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711572365; x=1712177165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmaskrdbVq30uGRTY87iYuCKuy48OuaJH0qBlabGSIs=;
        b=B9VqwyzwIUD3eA0jK9iuqhgIbGpqkIkVsb400EVRVJTC9YHaDwsk0kwNtVjxQ8EpG4
         36+4+MqM9FS7lMTdWIYUI9WREUIKk9eJQqwktE8lQtYV7vUSiz/Ysjpz9KLrDv9dFp+K
         CDwu03ul+8F7pZoaghezQyOdmqt6m2w92Ug6pn1Q4Y5ZyrrHlPdOmCQG8OEKXnAsPCES
         eHLmI49TYWAI9CCQNay5u/RPcXben066c79+vmUfv6Ai5FUNbPnAVSih5DR6rs5WNSS1
         DUUBSbEXp086ZvWJUnZfeF3BwUUZd04H0ER19oYplFTewvJEx3j+x8ioOMMvEVUH+4Hc
         NNpg==
X-Forwarded-Encrypted: i=1; AJvYcCWLybA2FebaZ+5NO0KOvMKH0ocTkv6oOjLwvjn0cwVhVdQD6jfwuJ26GMenxmb7dHyrAZ6GzithQ+H97/hJiCAKAaJ7QKUOJyPSug==
X-Gm-Message-State: AOJu0YwLoBNIRaW9f2gngWZkhQTJUijeV5E6Akz8ZG3R3+VVl/inYhSE
	vRq9WB3jZpZFW0ddoNAvI34zaVdYw2nC4fn5h+6g+jtFV9ViTaC1f6+RPTceWsnElkpUyiAwSkc
	i9HRWYQ==
X-Google-Smtp-Source: AGHT+IEwV96FPr8M3g9z4CBsm8giP+E9OfZ81E7+zle9RsaP222RwiG/7SZtytoxhzplu6rHshXNlQ==
X-Received: by 2002:a17:907:9710:b0:a4a:347f:a835 with SMTP id jg16-20020a170907971000b00a4a347fa835mr464854ejc.19.1711572364966;
        Wed, 27 Mar 2024 13:46:04 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906191b00b00a46bd891b5bsm5845623eje.225.2024.03.27.13.46.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:46:04 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46d0a8399aso227289266b.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:46:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtwSxwE+246NrWQnqG6e9RVpsgrEvbovWSqBJA5HOpOnN+0Ff8OSQEdEcyPsrHWprFqZ5PTo19FSd4vwZ7M+2HzH93rPyGixFHAA==
X-Received: by 2002:a17:906:ca59:b0:a45:40e4:8c8 with SMTP id
 jx25-20020a170906ca5900b00a4540e408c8mr355615ejb.16.1711572362918; Wed, 27
 Mar 2024 13:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com> <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
In-Reply-To: <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 13:45:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Message-ID: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 12:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> _But_: the lack of any aliasing guarantees means that writing through
> any pointer can invalidate practically anything, and this is a real
> problem.

It's actually much less of a problem than you make it out to be.

A lot of common aliasing information is statically visible (offsets
off the same struct pointer etc).

The big problems tend to be

 (a) old in-order hardware that really wants the compiler to schedule
memory operations

 (b) vectorization and HPC

and honestly, (a) is irrelevant, and (b) is where 'restrict' and
actual real vector extensions come in. In fact, the type-based
aliasing often doesn't help (because you have arrays of the same FP
types), and so you really just need to tell the compiler that your
arrays are disjoint.

Yes, yes, possible aliasing means that the compiler won't generate
nice-looking code in many situations and will end up reloading values
from memory etc.

AND NONE OF THAT MATTERS IN REALITY.

Performance issues to a close approximation come from cache misses and
branch mispredicts. The aliasing issue just isn't the horrendous issue
people claim it is. It's most *definitely* not worth the absolute
garbage that is C type-based aliasing.

And yes, I do think it might be nice to have a nicer 'restrict' model,
because yes, I look at the generated asm and I see the silly code
generation too. But describing aliasing sanely in general is just hard
(both for humans _and_ for some sane machine interface), and it's very
very seldom worth the pain.

            Linus

