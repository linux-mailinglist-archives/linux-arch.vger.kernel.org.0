Return-Path: <linux-arch+bounces-12493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB26CAEC552
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 08:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E176D1BC27DB
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 06:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0CD21E094;
	Sat, 28 Jun 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXSBWnaI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A351A23B5;
	Sat, 28 Jun 2025 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751091169; cv=none; b=IegK7UXJHXMgN5Grbcp5xjSEY5eYwsuTnQlWnsnxIJlNdRI56na/j8XWyMSGzg8FT2RfS5fGauzmxHuKLGGpc6E9S9qo5Y80fyuAZgUYEzEa1SlRl+M9wB/tUdVcKGESS3yWtBQykzfb2xgVT8mxX7snFXVlXSXlgkud9K7vMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751091169; c=relaxed/simple;
	bh=lISQXDWIEw2gFD8C2DEkkUCDzWcx14RFk492z9Yzofg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MBIC9SvEchWAD866JOk6Yp/NX8NCsTtUb7rxy156zRxFv/+xLYt+BpKCWI5kMxRL2BUCFSv7r0clLmwrqktKbilg9Wh30x4T0gLFqXSNEWAHnJ7SI5zRGu40WMDAcEIuDy//ohDRnCWNArLZcD0bjgZyMsS2/oEmu1JFwdDWiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXSBWnaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61C8C4CEEA;
	Sat, 28 Jun 2025 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751091168;
	bh=lISQXDWIEw2gFD8C2DEkkUCDzWcx14RFk492z9Yzofg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FXSBWnaIYW5MZgS2KyU58VoAmcvfIBLngBYZjqFqDm/89rda0VI6+yC1rQr6ajLXh
	 VJwVavPIwvQA3Zmux3gI1oJRRolp4n6qEUdfVoviqJLGK7UY8LN7H43PxUm6e7yfX2
	 EbYJgf2lUSC1VGFOGJeiedrWdIBh26+gcN+cwb9KzJHtHUHLlJLVgNgBLTbczSZAxy
	 nFmXtOvwtlqij4rgQkNvrlGuQoGRqsnyCc9ybzRhU/QArRaWSHcE547bUEl2F0YVXq
	 sibg5akYE5/THI1KyUoz5/rEBo2BAq6j9v1lpd2++BGtAv2vtXTKJIREDhMjeWs85f
	 FImQwi209L8Jg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 08:12:42 +0200
Message-Id: <DAXY0EJHHDWM.1KRSSJLOTCZ8F@kernel.org>
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
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org> <aF6iXB6wiHcpAKIU@Mac.home>
In-Reply-To: <aF6iXB6wiHcpAKIU@Mac.home>

On Fri Jun 27, 2025 at 3:53 PM CEST, Boqun Feng wrote:
> On Fri, Jun 27, 2025 at 10:58:43AM +0200, Benno Lossin wrote:
>> On Wed Jun 18, 2025 at 6:49 PM CEST, Boqun Feng wrote:
>> > +impl<T: AllowAtomic> Atomic<T>
>> > +where
>> > +    T::Repr: AtomicHasXchgOps,
>> > +{
>> > +    /// Atomic exchange.
>> > +    ///
>> > +    /// # Examples
>> > +    ///
>> > +    /// ```rust
>> > +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
>> > +    ///
>> > +    /// let x =3D Atomic::new(42);
>> > +    ///
>> > +    /// assert_eq!(42, x.xchg(52, Acquire));
>> > +    /// assert_eq!(52, x.load(Relaxed));
>> > +    /// ```
>> > +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
>> > +    #[inline(always)]
>> > +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
>>=20
>> Can we name this `exchange`?
>>=20
>
> FYI, in Rust std, this operation is called `swap()`, what's the reason
> of using a name that is neither the Rust convention nor Linux kernel
> convention?

Ah, well then my suggestion would be `swap()` instead :)

> As for naming, the reason I choose xchg() and cmpxchg() is because they
> are the name LKMM uses for a long time, to use another name, we have to
> have a very good reason to do so and I don't see a good reason
> that the other names are better, especially, in our memory model, we use
> xchg() and cmpxchg() a lot, and they are different than Rust version
> where you can specify orderings separately. Naming LKMM xchg()/cmpxchg()
> would cause more confusion I believe.

I'm just not used to the name shortening from the kernel... I think it's
fine to use them especially since the ordering parameters differ from
std's atomics.

Can you add aliases for the Rust names?

> Same answer for compare_exchange() vs cmpxchg().
>
>> > +        let v =3D T::into_repr(v);
>> > +        let a =3D self.as_ptr().cast::<T::Repr>();
>> > +
>> > +        // SAFETY:
>> > +        // - For calling the atomic_xchg*() function:
>> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety=
 requirement of `AllocAtomic`,
>> > +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` i=
s a valid pointer,
>> > +        //   - per the type invariants, the following atomic operatio=
n won't cause data races.
>> > +        // - For extra safety requirement of usage on pointers return=
ed by `self.as_ptr():
>> > +        //   - atomic operations are used here.
>> > +        let ret =3D unsafe {
>> > +            match Ordering::TYPE {
>> > +                OrderingType::Full =3D> T::Repr::atomic_xchg(a, v),
>> > +                OrderingType::Acquire =3D> T::Repr::atomic_xchg_acqui=
re(a, v),
>> > +                OrderingType::Release =3D> T::Repr::atomic_xchg_relea=
se(a, v),
>> > +                OrderingType::Relaxed =3D> T::Repr::atomic_xchg_relax=
ed(a, v),
>> > +            }
>> > +        };
>> > +
>> > +        T::from_repr(ret)
>> > +    }
>> > +
>> > +    /// Atomic compare and exchange.
>> > +    ///
>> > +    /// Compare: The comparison is done via the byte level comparison=
 between the atomic variables
>> > +    /// with the `old` value.
>> > +    ///
>> > +    /// Ordering: When succeeds, provides the corresponding ordering =
as the `Ordering` type
>> > +    /// parameter indicates, and a failed one doesn't provide any ord=
ering, the read part of a
>> > +    /// failed cmpxchg should be treated as a relaxed read.
>>=20
>> This is a bit confusing to me. The operation has a store and a load
>> operation and both can have different orderings (at least in Rust
>> userland) depending on the success/failure of the operation. In
>> userland, I can supply `AcqRel` and `Acquire` to ensure that I always
>> have Acquire semantics on any read and `Release` semantics on any write
>> (which I would think is a common case). How do I do this using your API?
>>=20
>
> Usually in kernel that means in a failure case you need to use a barrier
> afterwards, for example:
>
> 	if (old !=3D cmpxchg(v, old, new)) {
> 		smp_mb();
> 		// ^ following memory operations are ordered against.
> 	}

Do we already have abstractions for those?

>> Don't I need `Acquire` semantics on the read in order for
>> `compare_exchange` to give me the correct behavior in this example:
>>=20
>>     pub struct Foo {
>>         data: Atomic<u64>,
>>         new: Atomic<bool>,
>>         ready: Atomic<bool>,
>>     }
>>=20
>>     impl Foo {
>>         pub fn new() -> Self {
>>             Self {
>>                 data: Atomic::new(0),
>>                 new: Atomic::new(false),
>>                 ready: Atomic::new(false),
>>             }
>>         }
>>=20
>>         pub fn get(&self) -> Option<u64> {
>>             if self.new.compare_exchange(true, false, Release).is_ok() {
>
> You should use `Full` if you want AcqRel-like behavior when succeed.

I think it would be pretty valuable to document this. Also any other
"direct" translations from the Rust memory model are useful. For example
is `SeqCst` "equivalent" to `Full`?

---
Cheers,
Benno

