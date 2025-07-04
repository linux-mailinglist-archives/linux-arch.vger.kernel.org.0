Return-Path: <linux-arch+bounces-12572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976AAF9C84
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 00:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F6D1C8331D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CA19E971;
	Fri,  4 Jul 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDVDS+Hd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4672634;
	Fri,  4 Jul 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751668692; cv=none; b=P1Ju6GIoOY875Ly0TLR26WwwW07se1R5568UVI1CvVPcE9WUwv4nfj0EfKK5dDk8NOEbzZAuPismSFSehOkI7qkmqAEal5rZDyld8GR2USbJUNY5RjDewYFoFqfQncuZupdnjPRtKdYg2kVtQntum1+OSBYzyEMi6x+HORdYL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751668692; c=relaxed/simple;
	bh=cYemWxJ+RJFvxGenORwW9qtNJL7Vn2FrKxfLCwZoSDk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UPy53/dA5FeUiEQZ6xtX9PUHtkcvelqZaC5JHWHpGA5KxVI0/EAJxRMjY4pEXmA+wJRMDN9iDoV1L5aek3tb6JTiSa/Y3VKLrDImz2Q9761oPou1dEaxauLYnH2fzRAw0HX0WkuMHfNgG/LYvqKPbxdtylKJR/zcmbgdkhnrZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDVDS+Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E8CC4CEE3;
	Fri,  4 Jul 2025 22:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751668692;
	bh=cYemWxJ+RJFvxGenORwW9qtNJL7Vn2FrKxfLCwZoSDk=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=JDVDS+HdNjAbrtqJ03ndHS6cV+RDunn0QloRxtI8bBra/IudNLF2PFPH3rvRLdaDF
	 DdB3UrqPDUKUvdzzVI8SsL5zPtl++u8F2P1/YuFAgPKALpVy4qa0ZJ2cmdnzlbCLDU
	 cXLWVQukIQdFiNYXAaiYgIEYhSK9qda0rj63FEMkTK6QBrZrdqnG5uje1sjntARG4A
	 49jvvo4s1zyDSTqDk/mvdVtlcNY5Rw/uNvKb9xXIhgZkY/PStvMJtogRsjyBUmAVre
	 IxIGfhJ1d8mXJZWSxlniCUQ02MznZG8NtjORC2hMH9VzAgP6ZW9hN3LJUrmUvkdoQs
	 DhpgPb6SCAidQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 00:38:05 +0200
Message-Id: <DB3MQ54N1FLA.3RTNYKTJFDNYY@kernel.org>
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
 <aGg4sIORQiG02IoD@Mac.home> <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>
 <aGhFAlpOZJaLNekS@Mac.home>
In-Reply-To: <aGhFAlpOZJaLNekS@Mac.home>

On Fri Jul 4, 2025 at 11:17 PM CEST, Boqun Feng wrote:
> On Fri, Jul 04, 2025 at 10:45:48PM +0200, Benno Lossin wrote:
>> On Fri Jul 4, 2025 at 10:25 PM CEST, Boqun Feng wrote:
>> > * transmute()-equivalent from_repr() and into_repr().
>>=20
>> Hmm I don't think this name fits the description below, how about
>> "bit-equivalency of from_repr() and into_repr()"? We don't need to
>> transmute, we only want to ensure that `{from,into}_repr` are just
>> transmutes.
>>=20
>
> Good point!
>
> Btw, do you offer naming service, I will pay! ;-)

:) :)

>> >   (This is not a safety requirement)
>> >
>> >   from_repr() and into_repr(), if exist, should behave like transmute(=
)
>> >   on the bit pattern of the results, in other words, bit patterns of `=
T`
>> >   or `T::Repr` should stay the same before and after these operations.
>> >
>> >   Of course if we remove them and replace with transmute(), same resul=
t.
>> >
>> >   This reflects the fact that customized atomic types should store
>> >   unmodified bit patterns into atomic variables, and this make atomic
>> >   operations don't have weird behavior [1] when combined with new(),
>> >   from_ptr() and get_mut().
>>=20
>> I remember that this was required to support types like `(u8, u16)`? If
>
> My bad, I forgot to put the link to [1]...
>
> [1]: https://lore.kernel.org/rust-for-linux/20250621123212.66fb016b.gary@=
garyguo.net/
>
> Basically, without requiring from_repr() and into_repr() to act as a
> transmute(), you can have weird types in Atomic<T>.

Ah right, I forgot some context... Is this really a problem? I mean it's
weird sure, but if someone needs this, then it's fine?

> `(u8, u16)` (in case it's not clear to other audience, it's tuple with a
> `u8` and a `u16` in it, so there is a 8-bit hole) is not going to
> support until we have something like a `Atomic<MaybeUninit<i32>>`.

Ahh right we also had this issue, could you also include that in your
writeup? :)

>> yes, then it would be good to include a paragraph like the one above for
>> enums :)
>>=20
>> > * Provenance preservation.
>> >
>> >   (This is not a safety requirement for Atomic itself)
>> >
>> >   For a `Atomic<*mut T>`, it should preserve the provenance of the
>> >   pointer that has been stored into it, i.e. the load result from a
>> >   `Atomic<*mut T>` should have the same provenance.
>> >
>> >   Technically, without this, `Atomic<*mut T>` still work without any
>> >   safety issue itself, but the user of it must maintain the provenance
>> >   themselves before store or after load.
>> >
>> >   And it turns out it's not very hard to prove the current
>> >   implementation achieve this:
>> >
>> >   - For a non-atomic operation done on the atomic variable, they are
>> >     already using pointer operation, so the provenance has been
>> >     preserved.
>> >   - For an atomic operation, since they are done via inline asm code, =
in
>> >     Rust's abstract machine, they can be treated as pointer read and
>> >     write:
>> >
>> >     a) A load of the atomic can be treated as a pointer read and then
>> >        exposing the provenance.
>> >     b) A store of the atomic can be treated as a pointer write with a
>> >        value created with the exposed provenance.
>> >
>> >     And our implementation, thanks to no arbitrary type coercion,
>> >     already guarantee that for each a) there is a from_repr() after an=
d
>> >     for each b) there is a into_repr() before. And from_repr() acts as
>> >     a with_exposed_provenance() and into_repr() acts as a
>> >     expose_provenance(). Hence the provenance is preserved.
>>=20
>> I'm not sure this point is correct, but I'm an atomics noob, so maybe
>> Gary should take a look at this :)
>>=20
>
> Basically, what I'm trying to prove is that we can have a provenance-
> preserved Atomic<*mut T> implementation based on the C atomics. Either
> that is true, or we should write our own atomic pointer implementation.

That much I remembered :) But since you were going into the specifics
above, I think we should try to be correct. But maybe natural language
is the wrong medium for that, just write the rust code and we'll see...

>> >   Note this is a global property and it has to proven at `Atomic<T>`
>> >   level.
>>=20
>> Thanks for he awesome writeup, do you want to put this in some comment
>> or at least the commit log?
>>=20
>
> Yes, so the round-trip transmutability will be in the safe requirement
> of `AllowAtomic`. And if we still keep `from_repr()` and `into_repr()`
> (we can give them default implementation using trasnmute()), I will put
> the "bit-equivalency of from_repr() and into_repr()" in the requirement
> of `AllowAtomic` as well.
>
> For the "Provenance preservation", I will put it before `impl
> AllowAtomic for *mut T`. (Remember we recently discover that doc comment
> works for impl block as well? [2])

Yeah that sounds good!

---
Cheers,
Benno

> [2]: https://lore.kernel.org/rust-for-linux/aD4NW2vDc9rKBDPy@tardis.local=
/

