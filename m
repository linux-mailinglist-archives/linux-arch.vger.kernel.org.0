Return-Path: <linux-arch+bounces-3118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4618875F5
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 01:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDB11C20CA1
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A4621;
	Sat, 23 Mar 2024 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q6qapZI1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB679372
	for <linux-arch@vger.kernel.org>; Sat, 23 Mar 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152771; cv=none; b=LIy0djRuIxjL2XEc+6mo6SETmejZE6HgLsF0YTCqunVrN0bTVcelwldU/PxDIR+HwAK4eUGYD9jv0P6sXnOCd+/nMSMoiJS8NeWhlAvNx/0IBT9EHLl17bNDJhDFBUxnfL92nYD++VQCb75nACTCv/lFtiNcJ3+eimfhpzpH4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152771; c=relaxed/simple;
	bh=buaytYj6XnQEMslfX8wQQCXJQT/19Ph5hoNeBiv9PMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqvkkNlKTz2KyPixfl7/jK9yHu97AufDU2mCJ4+rSyR5BU0qU+s+c7fRbawRP+3/DlAYgb3/kz1xOq0B6OulXs8We40q3K2QK+CLzMHmpQQBQiKfKqVoLp0EkpPOdlWBaEGxaDel3UYcQbWMV2JDQSYtTjMEmt0+2AcECfx44zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q6qapZI1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ba938de0so370967966b.3
        for <linux-arch@vger.kernel.org>; Fri, 22 Mar 2024 17:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711152768; x=1711757568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DcKs5LOC+9m7c+sQfRFSymnyXVGhlvaNbRKaUaILEw=;
        b=Q6qapZI1NYRMQNNYtZidytYsBkiU2qaesQdjci/F7s0ZJE1Qj656NZyCKi8Jei6w0/
         za8b07IjJ9Ry5yQLCiWdVLof2zCHQ74ZcG3zM5D7FRqUjFCtCzelfadqnnycszhSt822
         trnFNO87MaVjDHsjBsPFvIHZw6nSBgRRLSvUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152768; x=1711757568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DcKs5LOC+9m7c+sQfRFSymnyXVGhlvaNbRKaUaILEw=;
        b=GG1ZN0j8EEdgWhPbEjhswOHghpI2X3Jbq+re63qE+hA534JwTBOsJyTYk3dWUZ6pya
         PVsNr3iW3xr5D77HxUOi9nU6qCo+WzAUsX5RqL8Gv0JgYjhKm3KzzWdEwtALTjvr2JXC
         RkPDw1pMiEgLQRv4P7t/4zxSPFwxMSO4L59X4QaGcs9+bvr2N2c2rfMn7n2x5yV9ipt8
         NnKS/mebpt/4fhgzlh9MMobdedX6Vc/5tDIcQVijjczROe2fJBgoDjCKVezkjx7Nn5Rk
         M1hNyzGfrRozgn1UZGgdxlR73YQSnC/WhqNi8cTUEHXrBThUREcgbuU/Gj0hGBbqFE0K
         y12g==
X-Forwarded-Encrypted: i=1; AJvYcCUEt9bEB0wKTJbXqn14Dx9bVOgKf2qCY3wZBPgzLp1Lx6ytMkAan2EgTj+jmi6T/7loH14aE88p401gFsC/5TnIopggNUHmUwhYJg==
X-Gm-Message-State: AOJu0YwgWdSsOew8RxLWc9ARB52jX0r6o4bm3a+Lye69rRivjimSTPF0
	bkcEtoOO9dVMm+trxRWJXmI33d8E97rZNdM8GPeC3I5Pw19PTFfBhUOtVYGDscI2z3IpQ/2glxr
	cI6Q=
X-Google-Smtp-Source: AGHT+IFIzvz2u1zps3Xdh5PVeSlJ6GAYnd4NZ2vAI1kAQLAfHBx8PQnA6g2VNGW5QI0ri+jw0+QKkg==
X-Received: by 2002:a17:906:a15a:b0:a47:1c57:5125 with SMTP id bu26-20020a170906a15a00b00a471c575125mr830601ejb.41.1711152768002;
        Fri, 22 Mar 2024 17:12:48 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906195a00b00a46c508d661sm338071eje.176.2024.03.22.17.12.46
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:12:47 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a471f77bf8eso244469266b.2
        for <linux-arch@vger.kernel.org>; Fri, 22 Mar 2024 17:12:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0b2BOPuZQkvGRDgZbXfBMKNPZYfBA2qPq4VJfTatMZQA9xTh6UWoue0ddI/+7dsnvWQvwGaoow0s7PffTI7mFhy0BCFuIRdw4ew==
X-Received: by 2002:a17:906:6b0b:b0:a46:7ee2:f834 with SMTP id
 q11-20020a1709066b0b00b00a467ee2f834mr791117ejr.11.1711152766110; Fri, 22 Mar
 2024 17:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
In-Reply-To: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 17:12:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
Message-ID: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
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

On Fri, 22 Mar 2024 at 16:57, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> I wonder about that. The disadvantage of only supporting LKMM atomics is
> that we'll be incompatible with third party code, and we don't want to
> be rolling all of our own data structures forever.

Honestly, having seen the shit-show that is language standards bodies
and incomplete compiler support, I do not understand why people think
that we wouldn't want to roll our own.

The C++ memory model may be reliable in another decade. And then a
decade after *that*, we can drop support for the pre-reliable
compilers.

People who think that compilers do things right just because they are
automated simply don't know what they are talking about.

It was just a couple of days ago that I was pointed at

    https://github.com/llvm/llvm-project/issues/64188

which is literally the compiler completely missing a C++ memory barrier.

And when the compiler itself is fundamentally buggy, you're kind of
screwed. When you roll your own, you can work around the bugs in
compilers.

And this is all doubly true when it is something that the kernel does,
and very few other projects do. For example, we're often better off
using inline asm over dubious builtins that have "native" compiler
support for them, but little actual real coverage. It really is often
a "ok, this builtin has actually been used for a decade, so it's
hopefully stable now".

We have years of examples of builtins either being completely broken
(as in "immediate crash" broken), or simply generating crap code that
is actively worse than using the inline asm.

The memory ordering isn't going to be at all different. Moving it into
the compiler doesn't solve problems. It creates them.

                 Linus

