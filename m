Return-Path: <linux-arch+bounces-13125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76077B2201C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 10:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D12161D85
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 07:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA42DF3F8;
	Tue, 12 Aug 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRwgGS3J"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028C2DF3D1;
	Tue, 12 Aug 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985588; cv=none; b=YIG7wa1tcr9gmx4lkbeSvyGT53fe1nvsyJpQtaqMwccDL4Q/JqVa3JH+dpTtx11e8/FX8KExsIoMclc1jl1TIoNBE/pqC1xPJJSxDOcMD/eqDs1REw4jXIjFTF6OZC0KuSvjkTDYdsXD88i/kHOTqNny30FkbPzi3pT0O0eHSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985588; c=relaxed/simple;
	bh=ymkjN9ZtuK+LQ/wrsa9QbECgUoYFiNmqiBmrVh6GFiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QZsCD5GzUDgU6Chs6sWvsBJ9dpzN0d7onqinW0K2DfoeNksbTTeZKJRPAEfJEqc7J886b6B+Oop1EgkS+nYxICLy/AZAVMPrSZFgTaNc++POcr6AWTEvGbCetuNmR+PxF/wwNMr7V909ds/tWMf3NES2i7O9Vdh8nX6OZPEZrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRwgGS3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A7EC4CEF4;
	Tue, 12 Aug 2025 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754985586;
	bh=ymkjN9ZtuK+LQ/wrsa9QbECgUoYFiNmqiBmrVh6GFiI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fRwgGS3J9wup10Ei3nMlgDK3Tgvf2t+7imPsLvpkb5ZtD3/A32Q9Y5YZ5rDtvuFeG
	 hgC9a+csI9kC5FHQB+hi1j1FL5QjxD3eB1SDVi75cYA4RRIipRwpJ8VodLcyGEByR5
	 AgRKIsddUGMTWK+WCRy6MxiXY7thfZd4O5/ev5lx2bB9lRNeH72EBIfU4zOrS8y6cg
	 V9HqLh8P9FxVJm8e+Lmwfy6MaleB+KrcCgVLrXyi0NFRb6athaI0U2wAPotxGnf/dJ
	 FNbJ2YIQyLCUydSq8zAH/u+QYRqSMiTf2+PTY8EJO7L9vHP5rGSH2UekZXj8RCc5Zt
	 ClJPbUKj9iUgg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 09:59:39 +0200
Message-Id: <DC0AGT8F3JH1.2PZIXKX9AQBWD@kernel.org>
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
Subject: Re: [PATCH v8 4/9] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-5-boqun.feng@gmail.com>
In-Reply-To: <20250719030827.61357-5-boqun.feng@gmail.com>

On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
> To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> added, currently `T` needs to be Send + Copy because these are the
> straightforward usages and all basic types support this.
>
> Implement `AtomicType` for `i32` and `i64`, and so far only basic
> operations load() and store() are introduced.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/sync/atomic.rs           | 274 +++++++++++++++++++++++++++
>  rust/kernel/sync/atomic/predefine.rs |  15 ++
>  2 files changed, 289 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/predefine.rs

> +/// # Limitations
> +///
> +/// Because C primitives are used to implement the atomic operations, an=
d a C function requires a
> +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hen=
ce at the Rust <-> C
> +/// surface, only types with all the bits initialized can be passed. As =
a result, types like `(u8,
> +/// u16)` (padding bytes are uninitialized) are currently not supported.=
 Note that technically
> +/// these types can be supported if some APIs are removed for them and t=
he inner implementation is
> +/// tweaked, but the justification of support such a type is not strong =
enough at the moment. This
> +/// should be resolved if there is an implementation for `MaybeUninit<i3=
2>` as `AtomicImpl`.

I'd remove the last sentence, as it makes it sound like one only would
have to add that impl and be finished.

---
Cheers,
Benno

