Return-Path: <linux-arch+bounces-12578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97FAFA220
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 23:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FC07B4C8B
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B425B680;
	Sat,  5 Jul 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCAKay3Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19E217709;
	Sat,  5 Jul 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751805; cv=none; b=BBFGL4RGDhq2pm4CrlySY6DJnO2UayEDlo+lm+o4zs3aPFHwAwSPCNprINDeL/oZUeoUvnnrQ8NvBHycBz7trisQ+aEBU58RLXFSMtgX791qpfYNOJVODzoz9vQfdpMc+NZ0Z0YFEcVfJ1ii1rLY2UtfLEZov6v9msnCNEovGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751805; c=relaxed/simple;
	bh=8JEvEGM9sNm9zynsk/02xiiJGM43gFUDp52vEHIyfyo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=K5s8HG9fHgal+FHxOCDWGwgw/Sa4N4/YJtpnEMaqWAsWkwdJlbFIcumbcdAKm63pU4E5HJyAdF/JN82aSxN4d8T8YA6vDAZ31LNgqxK4qTZbZ4iq5N3dyWDWjSLaM4eRvm3UAPbuEKuDw/z2Hc4G78dWnh2tKT1ScCL9QN5cuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCAKay3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AEAC4CEE7;
	Sat,  5 Jul 2025 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751805;
	bh=8JEvEGM9sNm9zynsk/02xiiJGM43gFUDp52vEHIyfyo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ZCAKay3ZSzt2NQCOhXdlOV5I+U5DxCLFKGodf/OXmgCuZAZioawqIau4IXWSAlLji
	 amgn1Pr7KDHCA4+PTCpF8wmYGD57Be0vsHYViKLAzZ0oAeaOCIj7vt4ZQllomBy84/
	 46Igzn8mg8VF6dMxxF/HyWYX6NBnzT0Y6dBGxXHjr4Wvx+DUyEgZrjTUxq4DSAh0Ld
	 VVbKr7/eqfYBpcnt04K5aAgKeAok8u6lwgF6mf0WTuFxrOR2T7hN041mn4mbUWREgh
	 WsqmhiPXipA+nmaW0LaK93107Ivoj16UafqLv+ApbQhf3OJwRSSN1wBQKO4+UVHAdH
	 lUp+PNAs9mBxg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 23:43:18 +0200
Message-Id: <DB4G6QHBZIQ2.BFT3RFRRHYB0@kernel.org>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Gary Guo" <gary@garyguo.net>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
X-Mailer: aerc 0.20.1
References: <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home> <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local> <aGg4sIORQiG02IoD@Mac.home>
 <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org> <aGhFAlpOZJaLNekS@Mac.home>
 <DB3MQ54N1FLA.3RTNYKTJFDNYY@kernel.org> <aGhiEZ4uNzEs4nah@Mac.home>
 <DB3YRHR9RN8Z.29926G08T7KZ0@kernel.org> <aGlHBqoqTA2PCXbJ@Mac.home>
In-Reply-To: <aGlHBqoqTA2PCXbJ@Mac.home>

On Sat Jul 5, 2025 at 5:38 PM CEST, Boqun Feng wrote:
> On Sat, Jul 05, 2025 at 10:04:04AM +0200, Benno Lossin wrote:
> [...]
>> >> >
>> >> > Basically, what I'm trying to prove is that we can have a provenanc=
e-
>> >> > preserved Atomic<*mut T> implementation based on the C atomics. Eit=
her
>> >> > that is true, or we should write our own atomic pointer implementat=
ion.
>> >>=20
>> >> That much I remembered :) But since you were going into the specifics
>> >> above, I think we should try to be correct. But maybe natural languag=
e
>> >> is the wrong medium for that, just write the rust code and we'll see.=
..
>> >>=20
>> >
>> > I don't thinking writing rust code can help us here other than duplica=
te
>> > my reasoning above, so like:
>> >
>> >     ipml *mut() {
>> >         pub fn xchg(ptr: *mut *mut (), new: *mut ()) -> *mut () {
>> > 	    // SAFTEY: ..
>
> Note: provenance preserving is not about the safety of Atomic<*mut T>
> implementation, even if we don't preserve the provenance, calling
> `Atomic<*mut T>` function won't cause UB, it's just that any pointer you
> get from `Atomic<*mut T>` is a pointer without provenance.
>
> So what I meant in this example is all the safey comment is above and=20
> the rest is not a safe comment.

Yeah it's not a safety requirement, but a guarantee.

> Hope it's clear.
>
>> > 	    // `atomic_long_xchg()` is implemented as asm(), so it can
>> > 	    // be treated as a normal pointer swap() hence preserve the
>> > 	    // provenance.
>>=20
>> Oh I think Gary was talking specifically about Rust's `asm!`. I don't
>> know if C asm is going to play the same way... (inside LLVM they
>> probably are the same thing, but in the abstract machine?)
>>=20
>
> You need to understand why Rust abstract machine model `asm!()` in
> that way: Rust abstract machine cannot see through `asm!()`, so it has
> to assume that `asm!() block can do anything that some equivalent Rust
> code does. Further more, this "can do anything that some equivalent Rust
> code does" is only one way to reason, the core part about this is Rust
> will be very conservative when using the `asm!()` result for
> optimization.

Yes that makes sense.

> It should apply to C asm!() as well because LLVM cannot know see through
> the asm block either. And based on the spirit, it might apply to any C
> code as well, because it's outside Rust abstract machine. But if you
> don't agree the reasoning, then we just cannot implement Atomic<*mut T>
> with the existing C API.

We probably should run this by t-opsem on the Rust zulip or ask about
this in the next Meeting with the Rust folks.

>> > 	    unsafe { atomic_long_xchg(ptr.cast::<atomic_long_t>(), new as ffi=
:c_long) }
>> > 	}
>> >
>> >         pub fn cmpxchg(ptr: *mut *mut (), old: *mut (), new: *mut ()) =
-> *mut () {
>> > 	    // SAFTEY: ..
>> > 	    // `atomic_long_xchg()` is implemented as asm(), so it can
>> > 	    // be treated as a normal pointer compare_exchange() hence preser=
ve the
>> > 	    // provenance.
>> > 	    unsafe { atomic_long_cmpxchg(ptr.cast::<atomic_long_t>(), old as =
ffi::c_long, new as ffi:c_long) }
>> > 	}
>> >
>> > 	<do it for a lot of functions>
>> >     }
>> >
>> > So I don't think that approach is worth doing. Again the provenance
>> > preserving is a global property, either we have it as whole or we don'=
t
>> > have it, and adding precise comment of each function call won't change
>> > the result. I don't see much difference between reasoning about a set =
of
>> > functions vs. reasoning one function by one function with the same
>> > reasoning.
>> >
>> > If we have a reason to believe that C atomic doesn't support this we
>> > just need to move to our own implementation. I know you (and probably
>> > Gary) may feel the reasoning about provenance preserving a bit handwav=
y,
>>=20
>> YES :)
>>=20
>> > but this is probably the best we can get, and it's technically better
>>=20
>> I think we can at improve the safety docs situation.
>>=20
>
> Once again, it's not about the safety of Atomic<*mut T> implementation.

"Safety docs" to me means all of these:
* `SAFETY` comments & `# Safety` sections,
* `INVARIANT` comments & `# Invariants` sections,
* `GUARANTEE` comments & `# Guarantees` sections.

Maybe there is a better name...

>> > than using Rust native atomics, because that's just UB and no one woul=
d
>> > help you.
>>=20
>> I'm not arguing using those :)
>>=20
>> > (I made a copy-pasta on purpose above, just to make another point why
>> > writing each function out is not worth)
>>=20
>> Yeah that's true, but at the moment that safety comment is on the `impl`
>> block? I don't think that's the right place...
>>=20
>
> Feel free to send any patch that improves this in your opinion ;-)

I'd prefer we do it right away. But we should just have one big comment
explaining it on the impl and then in the functions refer to it from a
`GUARANTEE` comment?

---
Cheers,
Benno

