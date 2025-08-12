Return-Path: <linux-arch+bounces-13124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37612B21FDE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D5684E4932
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332332D4817;
	Tue, 12 Aug 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmXMYz8D"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBF2C3265;
	Tue, 12 Aug 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985129; cv=none; b=Ke3PY3H2uOIExh16/HuoJ/YOk+Wok7Bz11Tkvgpm5MoydMNFHyP0ICRgIghkC90A4dFllX2DdGUJehSQX19Zn386N9drdfxv7Xp62tlQ/MurPQddHFUY7+E81Fb5dXqlNN/pqFqpCnCVmumIeEwrLuy861PBSpIZgAy0dvsXsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985129; c=relaxed/simple;
	bh=qgQAoR+vutUrtVmv5wZSsH+LMxvRPCpEfXZhDCBOfQA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YS75CPZE/X1Fw5I4abIlfrkwjsLyYVSuSwBVIVyKehAxwTjADG/YZeJpd5oBfHFinqqeAPNK92UAWgl8jz3KTk3zTurELtaowDf1VAlA9amGa5SCxOyDCajYwACUKjEkVg0z+uMgc90vDWDjTgOWc10VJhBTpPvoMK9BTVsokdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmXMYz8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A974CC4CEF0;
	Tue, 12 Aug 2025 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754985128;
	bh=qgQAoR+vutUrtVmv5wZSsH+LMxvRPCpEfXZhDCBOfQA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZmXMYz8DAHXC2ZensZbqZXo4k9FGbqI12Brc4z3yBpiIMRXkQpF3+0munXj2HXx75
	 2Hfsq4BTAr1dByt59L++ZXBspVKcLa1QLW2AmQWlnFpOc+STs4u9tsKbaK4ez0qN+G
	 4OKeC/PjjWPfmOcDy+a4XEcfRQ+vLBMLkPF5Q/EzNe7Gl5Z4OdasP1HS5nKLntLEF3
	 qmit20+Y/seoFA7mgYoXwJdZXYUNOuo48XAcqKb+1HJAOR4WcLSb0TD8qoEV0Gvv2K
	 CAKoRa3zxzmsV7ui6p8v4IVch1oBJirDqhsRldH6p0z0fhIQnCg+LKoHxejCwV+R8X
	 cT+1qfQD3UbaA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 09:52:02 +0200
Message-Id: <DC0AAYXV7UEP.IAFKSR5OURDP@kernel.org>
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
Subject: Re: [PATCH v8 3/9] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-4-boqun.feng@gmail.com>
In-Reply-To: <20250719030827.61357-4-boqun.feng@gmail.com>

On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
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

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/atomic.rs          |   2 +
>  rust/kernel/sync/atomic/ordering.rs | 104 ++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs

