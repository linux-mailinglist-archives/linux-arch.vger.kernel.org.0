Return-Path: <linux-arch+bounces-12664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF98B01DCA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0755E1CC08FD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FE3A1CD;
	Fri, 11 Jul 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkHEEI+Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDE298997;
	Fri, 11 Jul 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240900; cv=none; b=G2T26ZLsfDZR5CEuuEGLHrcboMhwGer18SIQJ/0+sBzRAmWNNy2SWDcyZtnDbo6525WJhbnooZDDeRWCkflSEnurGfhdkVMy+atoizanT56rjsxaMVTC0jqq10p5XgDAJzKu7dXQLpmMg568GThERvDTWREHku8ou/JHgAirjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240900; c=relaxed/simple;
	bh=W1eSNvE6RoFcjXOe8d9knnF4KP1s1kX/QKTAsJ6mLp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r5K04DQnXjtjvibEzajo7BeT8v7qcjINPm0ojYdM3g/HzZHyW/GUEZnb+N7pk6nQRrIpDIJQCWyrN4Hi1PurzoAnVp2qy17wSkxTq3xP90h4ayMRRr3ijSeo6UJs38iUtOntCK01xxevMryGUw5co19eP5VTbACq2oaV/ooy0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkHEEI+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A96C4CEED;
	Fri, 11 Jul 2025 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752240899;
	bh=W1eSNvE6RoFcjXOe8d9knnF4KP1s1kX/QKTAsJ6mLp0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AkHEEI+YGznfm1eRU0RzYVRZQSoUwYV4cTCUDc2ixsxdo5eb4LTL3iaG7/Xz1ZqnE
	 fSASFeExYuPi2+qEDtB5DMr1x4YYsnwpvlQxtiSHICBN1OfazCT+Pb+dbMPfe6hKdj
	 TKT5pF2vs6Wuxe0I8m4EBzALxTLLJqNHxI988+2arFa2hFwCkcWwzV0kOAtyDJasqw
	 JoIzTf47ZXEDeHwqmSLy7vAxyyUnFGCGhZjbelYogc1mqSOSp7mr0oLWGbaa9MqKay
	 VtVpZHaIYtl/PgR2eiqOOlQDLAAxZ6sd7vVWv3vafJJbN6xcJY+ywhU1vLsB44bfaj
	 FaSZfl68Rzchg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 15:34:47 +0200
Message-Id: <DB99JZ3XMHZS.3N0GLG94JJSA9@kernel.org>
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
In-Reply-To: <aHEQKBT68xvqIIjW@Mac.home>

On Fri Jul 11, 2025 at 3:22 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
> [...]
>> > +
>> > +    /// Returns a pointer to the underlying atomic variable.
>> > +    ///
>> > +    /// Extra safety requirement on using the return pointer: the ope=
rations done via the pointer
>> > +    /// cannot cause data races defined by [`LKMM`].
>>=20
>> I don't think this is correct. I could create an atomic and then share
>> it with the C side via this function, since I have exclusive access, the
>> writes to this pointer don't need to be atomic.
>>=20
>
> that's why it says "the operations done via the pointer cannot cause
> data races .." instead of saying "it must be atomic".

Ah right I misread... But then the safety requirement is redundant? Data
races are already UB...

>> We also don't document additional postconditions like this... If you
>
> Please see how Rust std document their `as_ptr()`:
>
> 	https://doc.rust-lang.org/std/sync/atomic/struct.AtomicI32.html#method.a=
s_ptr
>
> It mentions that "Doing non-atomic reads and writes on the resulting
> integer can be a data race." (although the document is a bit out of
> date, since non-atomic read and atomic read are no longer data race now,
> see [1])

That's very different from the comment you wrote though. It's not an
additional safety requirement, but rather a note to users of the API
that they should be careful with the returned pointer.

> I think we can use the similar document structure here: providing more
> safety requirement on the returning pointers, and...
>
>> really would have to do it like this (which you shouldn't given the
>> example above), you would have to make this function `unsafe`, otherwise
>> there is no way to ensure that people adhere to it (since it isn't part
>> of the safety docs).
>>=20
>
> ...since dereferencing pointers is always `unsafe`, users need to avoid
> data races anyway, hence this is just additional information that helps
> reasoning.

I disagree.

As mentioned above, data races are already forbidden for raw pointers.
We should indeed add a note that says that non-atomic operations might
result in data races. But that's very different from adding an
additional safety requirement for using the pointer.

And I don't think that we can add additional safety requirements to
dereferencing a raw pointer without an additional `unsafe` block.

---
Cheers,
Benno

