Return-Path: <linux-arch+bounces-12747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8930B0428C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E9D188D77E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F8259CB3;
	Mon, 14 Jul 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/HjJTwg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF32594B4;
	Mon, 14 Jul 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505547; cv=none; b=ZwtG4nmYUChg3Y4oYjCjckPLmVCLCd+uxBF9fJDTq0IUgL+kdoFzBPZ5kfjCT9eyvb4PtysDbYo0KiTUxoYOyFUGRqOIUUsujiyOQ9qhzKQKt2GQsRWRs2KSSyF/SemSDPT+WnW3hgivTsVnPRxkfFsPf2U3lYYEBizOGj3MjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505547; c=relaxed/simple;
	bh=8JHF2oaX32pB33OO8iIS6R4334am5Qgv2ejcIuPp9o0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NrAvd5SjniD3fe0b6WuLLJMMrtRxTv3chWJnRULgt9CHwuwaueaGpVkZQYhWIJ2nvINFY1NyhPNTLGupbYt6phUbK1nlNjhWWUiDNAcas4lUsfhSJcFF8VgKXyMDy+KzzI53V5kQfoMRp0drap7rYxpuHHCp9g41R5gPhhGO4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/HjJTwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A804C4CEF6;
	Mon, 14 Jul 2025 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505547;
	bh=8JHF2oaX32pB33OO8iIS6R4334am5Qgv2ejcIuPp9o0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=J/HjJTwg/JgRiWr8w9WBD8IyNRroWC6BjFDwFoNFoBLaIRBmMtiZWsd8+ayvrRXQA
	 RSYcfZ3dK4UbbyDormP5SPFa1+OC1QNV6/paCERfTD/onVtxorxcS9spSTEU2pWdsH
	 GccNObc6Xrm6CwEu4+1ruB1dV8UxQ8t6yWi5Rp8xSJpEUuosOf95Kw3Js4PZHZkkSO
	 qc5OSt4oGhpskf1Re83u3YwTOzqx56SBDvwVxsnPkO2a7xJPWMERw63/wSyOjWaY6p
	 +fhr8XnC7CnM+LTTXDhH4HfcjseChxnv7FGFEKYX8rW9TAnsK0DNB3+7eh/+GjIOA3
	 WE6nOi4iwt6ng==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 17:05:40 +0200
Message-Id: <DBBVD70MASPW.2LUTJ51Y6SGMI@kernel.org>
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
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
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org> <aHUSgXW9A6LzjBIS@Mac.home>
In-Reply-To: <aHUSgXW9A6LzjBIS@Mac.home>

On Mon Jul 14, 2025 at 4:21 PM CEST, Boqun Feng wrote:
> On Mon, Jul 14, 2025 at 12:30:12PM +0200, Benno Lossin wrote:
>> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
>> > To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
>> > added, currently `T` needs to be Send + Copy because these are the
>> > straightforward usages and all basic types support this.
>> >
>> > Implement `AllowAtomic` for `i32` and `i64`, and so far only basic
>> > operations load() and store() are introduced.
>> >
>> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> > ---
>> >  rust/kernel/sync/atomic.rs         |  14 ++
>> >  rust/kernel/sync/atomic/generic.rs | 285 ++++++++++++++++++++++++++++=
+
>> >  2 files changed, 299 insertions(+)
>> >  create mode 100644 rust/kernel/sync/atomic/generic.rs
>> >
>> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> > index e80ac049f36b..c5193c1c90fe 100644
>> > --- a/rust/kernel/sync/atomic.rs
>> > +++ b/rust/kernel/sync/atomic.rs
>> > @@ -16,7 +16,21 @@
>> >  //!
>> >  //! [`LKMM`]: srctree/tools/memory-model/
>> > =20
>> > +pub mod generic;
>>=20
>> Hmm, maybe just re-export the stuff? I don't think there's an advantage
>> to having the generic module be public.
>>=20
>
> If `generic` is not public, then in the kernel::sync::atomic page, it
> won't should up, and there is no mentioning of struct `Atomic` either.
>
> If I made it public and also re-export the `Atomic`, there would be a
> "Re-export" section mentioning all the re-exports, so I will keep
> `generic` unless you have some tricks that I don't know.

Just use `#[doc(inline)]` :)

    https://doc.rust-lang.org/rustdoc/write-documentation/the-doc-attribute=
.html#inline-and-no_inline

> Also I feel it's a bit naturally that `AllowAtomic` and `AllowAtomicAdd`
> stay under `generic` (instead of re-export them at `atomic` mod level)
> because they are about the generic part of `Atomic`, right?

Why is that more natural? It only adds an extra path layer in any import
for atomics.

Unless you at some point want to add `concrete::Atomic<T>` etc, I would
just re-export them.

>> > +/// The atomic operations are implemented in a way that is fully comp=
atible with the [Linux Kernel
>> > +/// Memory (Consistency) Model][LKMM], hence they should be modeled a=
s the corresponding
>> > +/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from=
_ptr()`] and
>> > +/// [`Atomic::as_ptr()`], this provides a way to interact with [C-sid=
e atomic operations]
>> > +/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`,=
 `WRITE_ONCE()`,
>> > +/// `smp_load_acquire()` and `smp_store_release()`).
>> > +///
>> > +/// [LKMM]: srctree/tools/memory-model/
>> > +/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
>>=20
>> Did you check that these links looks good in rustdoc?
>>=20
>
> Yep.

Nice :)

>> > +/// over unit-only enums, see [Examples].
>> > +///
>> > +/// # Limitations
>> > +///
>> > +/// Because C primitives are used to implement the atomic operations,=
 and a C function requires a
>> > +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), =
hence at the Rust <-> C
>> > +/// surface, only types with no uninitialized bits can be passed. As =
a result, types like `(u8,
>>=20
>> s/no uninitialized/initialized/
>>=20
>
> hmm.. "with initialized bits" seems to me saying "it's OK as long as
> some bits are initialized", how about "with all the bits initialized"?

Sounds good. The double negation sounded a bit weird to me.

>> > +    /// However, this should be only used when communicating with C s=
ide or manipulating a C
>> > +    /// struct.
>>=20
>> This sentence should be above the `Safety` section.
>>=20
>
> Hmm.. why? This is the further information about what the above
> "Examples" section just mentioned?

I thought "this" is referring to "this function", if not then please be
more concrete :)

---
Cheers,
Benno

