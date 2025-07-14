Return-Path: <linux-arch+bounces-12735-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A4B03BA6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 12:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D451897E6E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C524291A;
	Mon, 14 Jul 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVboV4gP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCA1E5018;
	Mon, 14 Jul 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487854; cv=none; b=ZFaeCpi86Pt2O3JJYlh58WwtkIqyzDSUNl6eiw5DJ/QTL3McKyrwuBi5VtV4nOvzAJvJG2oyTIS4dRqp29zSkO2Jqw+GsRW8FX6vcDi7odQEXWA43F+sNEvyQFBC1d0uY5dhu3z8anqSWagTWbCEual7si2I8TXh/ol2wlW2JsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487854; c=relaxed/simple;
	bh=2FjgHRwrJ1gHWTE/gLdl+Fgz/qFZmAvlrqMcxusjD2I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y5T/VF9PzYLSPgNfjnkayMSOWQv62QaQ156v1haoODE+Cst60wxGruvNprmzMWyuUjOjPlBw5YdIBXNQMhZKsYlPdFqe+T/QgIY7TI8UdAqZFIJc6MxueVmhSTwRWvb3WaLiMnJw6K2uFIB07UbjkzAsDlmw8RZUc69yxNATaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVboV4gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B21C4CEED;
	Mon, 14 Jul 2025 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752487853;
	bh=2FjgHRwrJ1gHWTE/gLdl+Fgz/qFZmAvlrqMcxusjD2I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mVboV4gPob7vdLun6cFtTTjGkfDajuNl+B6Xf+FtDdgm+fsiFi79OdSCpvF8cVkzA
	 m7AIRQVDYwmbRVRXxytFqBXhlLDCyCkDvGdyd36GMtHEIrH7JhGS4HmVSbCC7Y1rAF
	 D9Je7IiK1/Rr9N1CuxUApd9966P7T8FaEjyYYG64bjX7URlP9vLeXa1x727eqgh3x/
	 PGA3vY/E81eHtsitRG2g9vAVCJ3WOcZN1f0ajwlqL5iYPvZcmYly8Js6QWQsXQXGDr
	 yPUGv4JrjspmY+zbWx+DArmxfgQFft8lGHlFsU7m0qvBciSCyRzTITsIQa6oy25RwZ
	 uhCGXMTJUKB6g==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 12:10:46 +0200
Message-Id: <DBBP3E8PZ81U.2O0QHK1GQXKX2@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 3/9] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-4-boqun.feng@gmail.com>
In-Reply-To: <20250714053656.66712-4-boqun.feng@gmail.com>

On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> Preparation for atomic primitives. Instead of a suffix like _acquire, a
> method parameter along with the corresponding generic parameter will be
> used to specify the ordering of an atomic operations. For example,
> atomic load() can be defined as:
>
> 	impl<T: ...> Atomic<T> {
> 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> 	}
>
> and acquire users would do:
>
> 	let r =3D x.load(Acquire);
>
> relaxed users:
>
> 	let r =3D x.load(Relaxed);
>
> doing the following:
>
> 	let r =3D x.load(Release);
>
> will cause a compiler error.
>
> Compared to suffixes, it's easier to tell what ordering variants an
> operation has, and it also make it easier to unify the implementation of
> all ordering variants in one method via generic. The `TYPE` associate
> const is for generic function to pick up the particular implementation
> specified by an ordering annotation.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Benno, please take a good and if you want to provide your Reviewed-by
> for this one. I didn't apply your Reviewed-by because I used
> `ordering::Any` instead of `AnyOrdering`, I think you're Ok with it [1],
> but I could be wrong. Thanks!
>
> [1]: https://lore.kernel.org/rust-for-linux/DB8M91D7KIT4.14W69YK7108ND@ke=
rnel.org/

> +/// The trait bound for annotating operations that support any ordering.
> +pub trait Any: internal::Sealed {

How about we just name this `Ordering`? Because that's what it is :)

That sadly means you can't do

    fn foo<Ordering: Ordering>() {}
           --------  ^^^^^^^^ not a trait
           |
           found this type parameter

But you can still do

    fn foo<O: Ordering>(_: O) {}

If we don't have the ordering module public and instead re-export from
atomic, you could also write:

    fn foo<Ordering: atomic::Ordering>(_: Ordering) {}

If you want it to be extra clear. What do you think?

---
Cheers,
Benno

> +    /// Describes the exact memory ordering.
> +    const TYPE: OrderingType;
> +}

