Return-Path: <linux-arch+bounces-12675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F04B023CF
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78B2A81178
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B22F4305;
	Fri, 11 Jul 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsTHyEQh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988C2F3C2D;
	Fri, 11 Jul 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258855; cv=none; b=d87AlS+Q8+ZKc+H4NlqsS1pW7HsvpjydMKq7G6rMRnqNskGpc+tCJkNK98wWKHYRgiN9+02OSK0iPfxVC8qliHKKAMF5D3GaIIzoi195I4ZRoAH4obdSltLK8AQcB3lWx+xDisenWK50LHH0SL1tr0eYS3BmLjbjyUWy7Pa4f34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258855; c=relaxed/simple;
	bh=It/+GohocGAsvEMF/zvsp6BbZBv/a9T1VVszUI+GGqI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nVjs2n6T6nC0WwED+zmHoYHgSxD9TswfPtGu3fJkL2CfuCL0m4PsHftQdMUbhC+6AzW7gaasuYxEYMWw2ME0dFhvFEQMAXXR/gGjiDkMo73xfDCzh9mwBG1udDHxxfPNsRuY2FHg3lOan6vAoZ8iB2wb1Zl386ea9miNDqaWfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsTHyEQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB14C4CEED;
	Fri, 11 Jul 2025 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752258854;
	bh=It/+GohocGAsvEMF/zvsp6BbZBv/a9T1VVszUI+GGqI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JsTHyEQh/g9uryvO7vC85leXnjShJBaLn/c0qEyKXapNFSZBWK28QrPQC+z+/46rw
	 Cb3khfyxlUkHutoIbyWQXkYGuth3r+B449/hAeN0LMIg+Y1aIatDfs5RR482agUMlP
	 33QxFBzc+rn6IuS9t4UiiJ+f2Fq9PF7aEbOqPqrmN8OYm8RzRqvkSi/ZCBFKd9pol9
	 dgvBCQvLeXJT5Noy5QTMwZgCfJEWv0nviuchH5y/eJwtCmOhCdymNeWEHoPfp8d83z
	 JkSnL0xg0G3edjfmscmc13ZeryWltqHfdnIWDd6/V5Te0g2iJAbj8moBLrhtR6HJOp
	 9VEewnApye/Lg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 20:34:07 +0200
Message-Id: <DB9FX5XAK4JJ.3GTCC6Z5EHARV@kernel.org>
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
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org> <aHEQKBT68xvqIIjW@Mac.home>
 <DB99JZ3XMHZS.3N0GLG94JJSA9@kernel.org> <aHEWze8p40qeNBr_@Mac.home>
In-Reply-To: <aHEWze8p40qeNBr_@Mac.home>

On Fri Jul 11, 2025 at 3:51 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 03:34:47PM +0200, Benno Lossin wrote:
>> On Fri Jul 11, 2025 at 3:22 PM CEST, Boqun Feng wrote:
>> > On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
>> > [...]
>> >> > +
>> >> > +    /// Returns a pointer to the underlying atomic variable.
>> >> > +    ///
>> >> > +    /// Extra safety requirement on using the return pointer: the =
operations done via the pointer
>> >> > +    /// cannot cause data races defined by [`LKMM`].
>> >>=20
>> >> I don't think this is correct. I could create an atomic and then shar=
e
>> >> it with the C side via this function, since I have exclusive access, =
the
>> >> writes to this pointer don't need to be atomic.
>> >>=20
>> >
>> > that's why it says "the operations done via the pointer cannot cause
>> > data races .." instead of saying "it must be atomic".
>>=20
>> Ah right I misread... But then the safety requirement is redundant? Data
>> races are already UB...
>>=20
>> >> We also don't document additional postconditions like this... If you
>> >
>> > Please see how Rust std document their `as_ptr()`:
>> >
>> > 	https://doc.rust-lang.org/std/sync/atomic/struct.AtomicI32.html#metho=
d.as_ptr
>> >
>> > It mentions that "Doing non-atomic reads and writes on the resulting
>> > integer can be a data race." (although the document is a bit out of
>> > date, since non-atomic read and atomic read are no longer data race no=
w,
>> > see [1])
>>=20
>> That's very different from the comment you wrote though. It's not an
>> additional safety requirement, but rather a note to users of the API
>> that they should be careful with the returned pointer.
>>=20
>> > I think we can use the similar document structure here: providing more
>> > safety requirement on the returning pointers, and...
>> >
>> >> really would have to do it like this (which you shouldn't given the
>> >> example above), you would have to make this function `unsafe`, otherw=
ise
>> >> there is no way to ensure that people adhere to it (since it isn't pa=
rt
>> >> of the safety docs).
>> >>=20
>> >
>> > ...since dereferencing pointers is always `unsafe`, users need to avoi=
d
>> > data races anyway, hence this is just additional information that help=
s
>> > reasoning.
>>=20
>> I disagree.
>>=20
>> As mentioned above, data races are already forbidden for raw pointers.
>> We should indeed add a note that says that non-atomic operations might
>> result in data races. But that's very different from adding an
>> additional safety requirement for using the pointer.
>>=20
>> And I don't think that we can add additional safety requirements to
>> dereferencing a raw pointer without an additional `unsafe` block.
>>=20
>
> So all your disagreement is about the "extra safety requirement" part?
> How about I drop that:
>
>     /// Returns a pointer to the underlying atomic `T`.
>     pub const fn as_ptr(&self) -> *mut T {
>         self.0.get()
>     }

Yes that's what I had in mind.

> ? I tried to add something additional information:
>
> /// Note that non-atomic reads and writes via the returned pointer may
> /// cause data races if racing with atomic reads and writes per [LKMM].
>
> but that seems redundant, because as you said, data races are UB anyway.

Yeah... I don't think the stdlib docs are too useful on this function:

    Doing non-atomic reads and writes on the resulting integer can be a dat=
a
    race. This method is mostly useful for FFI, where the function signatur=
e
    may use *mut i32 instead of &AtomicI32.
   =20
    Returning an *mut pointer from a shared reference to this atomic is saf=
e
    because the atomic types work with interior mutability. All
    modifications of an atomic change the value through a shared reference,
    and can do so safely as long as they use atomic operations. Any use of
    the returned raw pointer requires an unsafe block and still has to
    uphold the same restriction: operations on it must be atomic.

You can mention the use of this function for FFI. People might then be
discouraged from using it for other things where it doesn't make sense.

---
Cheers,
Benno

