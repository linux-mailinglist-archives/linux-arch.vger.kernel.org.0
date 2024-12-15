Return-Path: <linux-arch+bounces-9387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3FE9F0F25
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE8D1884E96
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE291E1A08;
	Fri, 13 Dec 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3+g0qIz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC761E0DB5
	for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100384; cv=none; b=bjeznehzZo0WuR4qS6ozhCWlXkXYEEU0KXJoQEJxQoYvi8Wqr5g8iNpu9Ccsa1evrl6lueqpli4yKaZkW3/afaZrCcsgaEB5/3ueOMe/N972mCJfYFICxH9QDei7dWQaXAXKoO4QgmUUDVQ8Rud71mIJndxV+QDKOPTv9wWS4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100384; c=relaxed/simple;
	bh=EuJufx1aFMmSDDvNPI6DU4SHOlqB0i/fifV9p+FF0lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9P5nQa2ZV3BWZDiZ3vW+N66ez0kiAzqyD8iiRbkuNYsrIpf600DoLbPjA6qWkb+I2mnpDwde2fQBlvDzdH4AS+qfaFzSIQ5aKpYjaU4BP+KQCJ6sincMwzs1K/HZpShbiBsCXBI6fPQYL5ff4sygK6ecrBN4zPWDfkrEwJOr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3+g0qIz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso12729205e9.3
        for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2024 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734100381; x=1734705181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS9LGudJur7kGbLspdnTQuWDC+hZFSTpArars9lBeLQ=;
        b=F3+g0qIz6g2WVi4c4BYQ3Jf/lMTVkukAyhHWqRCsKwlrIwR7vNKvprOJWrbob9UXsy
         7gaT8nGk93GuvfLctjKTMEd5N23oCuAxYCHh9bAZEe7OQTnl0QdEExFJ50e0tVKR9fit
         fVpKi0P78zCTPAPMXPLS6ULTkfJbchVZrbZRDNehNG4Vn2k16bLugou0GLYeFSYDeBxA
         C62UQwbpRrf3PYMAWpx3pEvduNZ2YcnySy/UmRVTFQLJ76RDIX3N92iPZ2nNyQh4q+j2
         Ew9Q6RsSLTLq9lFU7prhz02Ej9yfDVS5jAYKTA4cl7lvlVdYbxHiRmInQFjXKwToH82v
         eZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100381; x=1734705181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS9LGudJur7kGbLspdnTQuWDC+hZFSTpArars9lBeLQ=;
        b=jEtEIZWNW7h9/Kt9vS2wVBzKF7bCVDTMjEvUDa9YuQO19BphggG3gFWgq7onOHTvbj
         9x8It1RLeHc8PyQQC7R9xtulNMrfhg79Uu4felQcqLWTLC0cqkirSPSkko1dm+Uy89aA
         8PYcGV7WVg/nh21jqOHbyteXMvAwIXFrvTVdIR54ShWAtWXQx8spXx4dp6IgMnevZwUw
         PEcRa5g2VEH2ibZ44D3+Ng+S67qh+sPpyIjSNKOyho5Dgm6rohj5+08nEP0HCZO0vehu
         BW6wzOXpOFix4JExx7YRDtaOVp/twzsvfUCKqju0b0KjIM/1PlYi24R0kN7R1Q+6wkoz
         yKJA==
X-Forwarded-Encrypted: i=1; AJvYcCWFkSySloLIuE6A+/vYx7qAVnLELNGkPkqiTUVKthNtXMG/RjKUuqlj55ouu+vLwUxQWYDwDfO9Uq5/@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3UbJKk2Iml/f6aiS7+Ic8ywTftl58pWWvqyInsVfExZ5AinU
	3ZNwPmw4YFeLR/DEmzdQdejuGaL7wYHInMb/Q4j8ynLD9ZzoQBpYUvHp185INNfQwE+LXxdRiLn
	rP5bOB0bBL1nlq8UAzHZimsAhJMtjViNP/6nW
X-Gm-Gg: ASbGncsS84uCyPDR3EBD3m5RzbgBElb1nJ4iBTq4XqOsRHCeoCaISQUHA4v2vGVgFq1
	e27FecCYbgNWnC+nW6mDF5oC71AMnX2P5rMiOXss=
X-Google-Smtp-Source: AGHT+IGvvc8SEIVkqPspUBW11+fwBIw/V0dhqL0RuVU+1lBeUhFdbOVUzhj6j5lBdtbpP2FKdq6ekBfVUhokO3//J1Y=
X-Received: by 2002:a05:6000:2ad:b0:385:ee59:44eb with SMTP id
 ffacd0b85a97d-3888e0bd28amr2583040f8f.33.1734100380695; Fri, 13 Dec 2024
 06:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <20241101060237.1185533-5-boqun.feng@gmail.com> <CAH5fLgjhQouU=kqVx7LET2yeWt6sKt-VO5PR5SnQ8doaG4ihuQ@mail.gmail.com>
 <Z1seogLmy5H8-hXn@boqun-archlinux>
In-Reply-To: <Z1seogLmy5H8-hXn@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 15:32:47 +0100
Message-ID: <CAH5fLgjGg8_s8imOkmPb0yLAMwD1sF1aoBZWkAy-YLNh41zCuw@mail.gmail.com>
Subject: Re: [RFC v2 04/13] rust: sync: atomic: Add generic atomics
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, lkmm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:34=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Dec 12, 2024 at 11:57:07AM +0100, Alice Ryhl wrote:
> [...]
> > > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/at=
omic/generic.rs
> > > new file mode 100644
> > > index 000000000000..204da38e2691
> > > --- /dev/null
> > > +++ b/rust/kernel/sync/atomic/generic.rs
> > > @@ -0,0 +1,253 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Generic atomic primitives.
> > > +
> > > +use super::ops::*;
> > > +use super::ordering::*;
> > > +use crate::types::Opaque;
> > > +
> > > +/// A generic atomic variable.
> > > +///
> > > +/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to=
 be chosen.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// Doing an atomic operation while holding a reference of [`Self`] =
won't cause a data race, this
> > > +/// is guaranteed by the safety requirement of [`Self::from_ptr`] an=
d the extra safety requirement
> > > +/// of the usage on pointers returned by [`Self::as_ptr`].
> > > +#[repr(transparent)]
> > > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);
> > > +
> > > +// SAFETY: `Atomic<T>` is safe to share among execution contexts bec=
ause all accesses are atomic.
> > > +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
> >
> > Surely it should also be Send?
> >
>
> It's `Send` here because `Opaque<T>` is `Send` when `T` is `Send`. And
> in patch #9, I changed the definition of `AllowAtomic`, which is not a
> subtrait of `Send` anymore, and an `impl Send` block was added there.
>
> > > +/// Atomics that support basic atomic operations.
> > > +///
> > > +/// TODO: Unless the `impl` is a `#[repr(transparet)]` new type of a=
n existing [`AllowAtomic`], the
> > > +/// impl block should be only done in atomic mod. And currently only=
 basic integer types can
> > > +/// implement this trait in atomic mod.
> >
> > What's up with this TODO? Can't you just write an appropriate safety
> > requirement?
> >
>
> Because the limited scope of types that allows atomic is an artificial
> choice, i.e. we want to start with a limited number of types and make
> forward progress, and the types that we don't want to support atomics
> for now are not because of safety reasons, but more of a lack of
> users/motivations. So I don't think this is something we should use
> safety requirement to describe.

I found the wording very confusing. Could you reword it to say
something about future possibilities?

> > > +/// # Safety
> > > +///
> > > +/// [`Self`] must have the same size and alignment as [`Self::Repr`]=
.
> > > +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> > > +    /// The backing atomic implementation type.
> > > +    type Repr: AtomicImpl;
> > > +
> > > +    /// Converts into a [`Self::Repr`].
> > > +    fn into_repr(self) -> Self::Repr;
> > > +
> > > +    /// Converts from a [`Self::Repr`].
> > > +    fn from_repr(repr: Self::Repr) -> Self;
> >
> > What do you need these methods for?
> >
>
> Converting a `AtomicImpl` value (currently only `i32` and `i64`) to a
> `AllowAtomic` value without using transmute in `impl` block of
> `Atomic<T>`. Any better idea?

You could use transmute?

Alice

