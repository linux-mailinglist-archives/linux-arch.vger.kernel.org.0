Return-Path: <linux-arch+bounces-12309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1FDAD3132
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 11:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A9B1727C6
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897927A93B;
	Tue, 10 Jun 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se/+7llQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B61A8401;
	Tue, 10 Jun 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546443; cv=none; b=rr0wTi8Faswhbc9H/uHHpSMU1/ixq4TI44LH10aeL32nTEOGdDdSuWAQ53048ycLonzee71106EdSnDXjtoIQhdWjbT/vvB3O75wTm5YdpBb8Dgx7z3K/eSqrdstI1t7akvy/1IVLiO/sWv0iU/UDBggQ1B8vSCyayG9PBUolwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546443; c=relaxed/simple;
	bh=ZM+zxGI1u4LejkqbNmMVUbYQhbNCdSBHsu5mm84RMCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gNHd2VrUF3S+2w/yGGPS03fl1zJDVMUy8kk1Juf6nefpjqW7/AulSN19ZmyLLg0gHsYHq8DQVWevqsp9Lnt/d6M3wRZVXZVAD/CU10+3trYayMvSY+jcBo5/YeZXkMBF4WOXD2Le81nkyIkPTZOQMY968It5EfaIDhekj4WLLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se/+7llQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE6FC4CEED;
	Tue, 10 Jun 2025 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749546442;
	bh=ZM+zxGI1u4LejkqbNmMVUbYQhbNCdSBHsu5mm84RMCc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Se/+7llQ0ATlcHDQPW8Un4LmPpQBtOpj/S+vklbEe9q30T1FRfq1kbOAC+s/Yw0+o
	 3O2Cx+K36+7wH3bXy9JJEjMR4Dom12fJqucj6ZiNldNtTC6w3rutuj56gu6jAlvPyi
	 NNFvrcqM24SVa2Ti/i8yEn4yaUUdWXBTH7N1iZjDwkQr2nCym9uGJOqEFjrYIXx1/z
	 EfULQVfL+KBj2WNz1VEz+5+K+McvIRcMafcJvGJlhsx8Gu7tejk7f0Zno/eTm7j/7o
	 j3bPt3hx90SNqy1U2Q/FdAob7qn0pf2LEfoYJZjE02MXKDJ1IrVQhIH1tmYKk3C6jb
	 kHML1rWytJzDg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 11:07:16 +0200
Message-Id: <DAIQG9ALK4QC.2P2C2MC4U9YVX@kernel.org>
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
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v4 03/10] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250609224615.27061-1-boqun.feng@gmail.com>
 <20250609224615.27061-4-boqun.feng@gmail.com>
In-Reply-To: <20250609224615.27061-4-boqun.feng@gmail.com>

On Tue Jun 10, 2025 at 12:46 AM CEST, Boqun Feng wrote:
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
> all ordering variants in one method via generic. The `IS_RELAXED` and
> `ORDER` associate consts are for generic function to pick up the
> particular implementation specified by an ordering annotation.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Looks good, I got a few comments on the details below.

> ---
>  rust/kernel/sync/atomic.rs          |  3 +
>  rust/kernel/sync/atomic/ordering.rs | 94 +++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
>
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 65e41dba97b7..9fe5d81fc2a9 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -17,3 +17,6 @@
>  //! [`LKMM`]: srctree/tools/memory-mode/
> =20
>  pub mod ops;
> +pub mod ordering;
> +
> +pub use ordering::{Acquire, Full, Relaxed, Release};
> diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomi=
c/ordering.rs
> new file mode 100644
> index 000000000000..14cda8c5d1b1
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/ordering.rs
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory orderings.
> +//!
> +//! The semantics of these orderings follows the [`LKMM`] definitions an=
d rules.
> +//!
> +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Ru=
st memory model.
> +//! - [`Full`] means "fully-ordered", that is:
> +//!   - It provides ordering between all the preceding memory accesses a=
nd the annotated operation.
> +//!   - It provides ordering between the annotated operation and all the=
 following memory accesses.
> +//!   - It provides ordering between all the preceding memory accesses a=
nd all the fllowing memory
> +//!     accesses.
> +//!   - All the orderings are the same strong as a full memory barrier (=
i.e. `smp_mb()`).

s/strong/strength/ ?

> +//! - [`Relaxed`] is similar to the counterpart in Rust memory model, ex=
cept that dependency
> +//!   orderings are also honored in [`LKMM`]. Dependency orderings are d=
escribed in "DEPENDENCY
> +//!   RELATIONS" in [`LKMM`]'s [`explanation`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanatio=
n.txt
> +
> +/// The annotation type for relaxed memory ordering.
> +pub struct Relaxed;
> +
> +/// The annotation type for acquire memory ordering.
> +pub struct Acquire;
> +
> +/// The annotation type for release memory ordering.
> +pub struct Release;
> +
> +/// The annotation type for fully-order memory ordering.
> +pub struct Full;

Is this ordering only ever used in combination with itself? (Since you
don't have a `FullOrAcquire` trait)

> +
> +/// The trait bound for operations that only support relaxed ordering.
> +pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + All {}
> +
> +impl RelaxedOnly for Relaxed {}
> +
> +/// The trait bound for operations that only support acquire or relaxed =
ordering.
> +pub trait AcquireOrRelaxed: All {
> +    /// Describes whether an ordering is relaxed or not.
> +    const IS_RELAXED: bool =3D false;
> +}
> +
> +impl AcquireOrRelaxed for Acquire {}
> +
> +impl AcquireOrRelaxed for Relaxed {
> +    const IS_RELAXED: bool =3D true;
> +}
> +
> +/// The trait bound for operations that only support release or relaxed =
ordering.
> +pub trait ReleaseOrRelaxed: All {
> +    /// Describes whether an ordering is relaxed or not.
> +    const IS_RELAXED: bool =3D false;
> +}
> +
> +impl ReleaseOrRelaxed for Release {}
> +
> +impl ReleaseOrRelaxed for Relaxed {
> +    const IS_RELAXED: bool =3D true;
> +}
> +
> +/// Describes the exact memory ordering of an `impl` [`All`].
> +pub enum OrderingDesc {

Why not name this `Ordering`?

> +    /// Relaxed ordering.
> +    Relaxed,
> +    /// Acquire ordering.
> +    Acquire,
> +    /// Release ordering.
> +    Release,
> +    /// Fully-ordered.
> +    Full,
> +}
> +
> +/// The trait bound for annotating operations that should support all or=
derings.
> +pub trait All {
> +    /// Describes the exact memory ordering.
> +    const ORDER: OrderingDesc;

And then here: `ORDERING`.

---
Cheers,
Benno

> +}
> +
> +impl All for Relaxed {
> +    const ORDER: OrderingDesc =3D OrderingDesc::Relaxed;
> +}
> +
> +impl All for Acquire {
> +    const ORDER: OrderingDesc =3D OrderingDesc::Acquire;
> +}
> +
> +impl All for Release {
> +    const ORDER: OrderingDesc =3D OrderingDesc::Release;
> +}
> +
> +impl All for Full {
> +    const ORDER: OrderingDesc =3D OrderingDesc::Full;
> +}


