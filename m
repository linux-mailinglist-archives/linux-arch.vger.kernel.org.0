Return-Path: <linux-arch+bounces-12676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60DB023D1
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 20:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FBDA80C13
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7F2F3629;
	Fri, 11 Jul 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feIkAqcH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49C2E92D9;
	Fri, 11 Jul 2025 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258932; cv=none; b=bWhLyzP0iDlSITiuzvQEP0GHct2cLprXMSdVheJKWMjkWGiekiHP26WbJZGhUGIc0A7lMWT/yzvyiWCesib2RLv3liIjJla9wrekgCqBB5IQolM65qPa5eruD2IsHO1sKoETptA9A0ObPu2orXDYtPLbpyuGdGtBHd/84rYwcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258932; c=relaxed/simple;
	bh=fkK5mrBlQnRoJ2IhD+uQlyziIqN01tapyYfzf2qJJnM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JrdI81o3h44JXmKY9CuH6DxRtkA4FtlNsefEPLKTVc3kT5LhoJ3O4gtuL7ktNrHbEuZxdE/FcKOimiXUbdYRyZ4FG65l35qGPVSPJUtLjuOQUSgz0kQzlS68yN/N2uyFp347RwZi+Reo7Bn5Ig3TiyF7I/46vlZaol9G0rGmZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feIkAqcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E2FC4CEED;
	Fri, 11 Jul 2025 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752258932;
	bh=fkK5mrBlQnRoJ2IhD+uQlyziIqN01tapyYfzf2qJJnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feIkAqcHhWZyEVDLlRU1khjIgmSxKdHspSi+vck2tF/LN12wYuT7DUD8FGi83/DTt
	 vvz7/zbg4DcbkXGmmx/rCotrLMLWIMklLMywPFuSWJo0CbUYrovqMQDhAQ52Gn55lx
	 WzN07CKoLJPNm/uoWUNVvRBXZKvGGO0Y8Xtg7+3GGrcXDlM+7OztoW1NW291SB/dec
	 UPvXf2w8dYRpSG0HANRxaPeQoEpTmqpBHOe0FQxU7hfuGiS2LJmtsNon2YfiHxvfro
	 pNqQQR/sUggBkviDGcfd/QfzsOQlpF81MpP36bJ4Bt9JIFg7XqOD9Za0pZ4ViKBngX
	 8ntkFAEQ49QeQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 20:35:25 +0200
Message-Id: <DB9FY5IYEKIH.3KRD160QZ8C54@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude Paul" <lyude@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org> <aHEYkg5K7koUohRo@Mac.home>
In-Reply-To: <aHEYkg5K7koUohRo@Mac.home>

On Fri Jul 11, 2025 at 3:58 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>> > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/ato=
mic/generic.rs
>> > new file mode 100644
>> > index 000000000000..e044fe21b128
>> > --- /dev/null
>> > +++ b/rust/kernel/sync/atomic/generic.rs
>> > @@ -0,0 +1,289 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +//! Generic atomic primitives.
>> > +
>> > +use super::ops::*;
>> > +use super::ordering::*;
>> > +use crate::build_error;
>> > +use core::cell::UnsafeCell;
>> > +
>> > +/// A generic atomic variable.
> [...]
>>=20
>> > +///
>> > +/// # Guarantees
>> > +///
>> > +/// Doing an atomic operation while holding a reference of [`Self`] w=
on't cause a data race,
>> > +/// this is guaranteed by the safety requirement of [`Self::from_ptr(=
)`] and the extra safety
>> > +/// requirement of the usage on pointers returned by [`Self::as_ptr()=
`].
>>=20
>> I'd rather think we turn this into an invariant that says any operations
>> on `self.0` through a shared reference is atomic.
>>=20
> [...]
>> > +/// unit-only enums:
>>=20
>> What are "unit-only" enums? Do you mean enums that don't have associated
>> data?
>>=20
>
> Yes, I used the term mentioned at:
>
> 	https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum=
.unit-only

Ahhh, never saw that before :)

>> > +///
>> > +/// ```
>> > +/// #[repr(i32)]
>> > +/// enum State { Init =3D 0, Working =3D 1, Done =3D 2, }
>> > +/// ```
>> > +///
>> > +/// # Safety
>> > +///
>> > +/// - [`Self`] must have the same size and alignment as [`Self::Repr`=
].
>> > +/// - [`Self`] and [`Self::Repr`] must have the [round-trip transmuta=
bility].
> [...]
>> > +        let a =3D self.as_ptr().cast::<T::Repr>();
>> > +
>> > +        // SAFETY:
>> > +        // - For calling the atomic_read*() function:
>> > +        //   - `a` is a valid pointer for the function per the CAST j=
ustification above.
>> > +        //   - Per the type guarantees, the following atomic operatio=
n won't cause data races.
>>=20
>> Which type guarantees? `Self`?
>>=20
>
> The above "# Guarantees" of `Atomic<T>`, but yeah I think it should be
> "# Invariants".

Yeah and if we use invariants/guarantees always mention the type that
they are of and don't assume the reader will "know" :)

---
Cheers,
Benno

