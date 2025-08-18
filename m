Return-Path: <linux-arch+bounces-13193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3FDB2B436
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 00:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B0B582945
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E02185BC;
	Mon, 18 Aug 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVHeeeAt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F91B4247;
	Mon, 18 Aug 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557369; cv=none; b=uKX8smAZwpfdzgUL5l3fU9CtLxCmafEYPGhiUxpAOqHDG6XsJ/2k5YpWLqiITy+woNVG41EPtcjtwKOuoskvrzo09gahM+zuQMJZItXk/BUeL2gth1Mekhp+tRCpsG/JqFgH6Z5JJqCwfBt2Nnlht1j60QDZfJFzT12//Wc6IIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557369; c=relaxed/simple;
	bh=e8raUYSx+kB5duYi2EeS2q/qnA85lKxEqn2nshSlYrs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xy4AO//IZm1vj/kRpBAFr4CbqOTP6VC4mjE9p4284LKSQxW1sM4J/+1Mzkrf8sTyjC9AKZTRyXBOlwoBjpxcqoHdGkVPe1j5zY8wtg7HWmwZZ5L24fmGRNhRfigRg1+Gvlb3NeSq3evfI2bse2FQUY/JxPdvkuNqGtyIWRslCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVHeeeAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC1C4CEEB;
	Mon, 18 Aug 2025 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755557368;
	bh=e8raUYSx+kB5duYi2EeS2q/qnA85lKxEqn2nshSlYrs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kVHeeeAtKZTMPzraDJRX8+GreH31xIDktiuKOIY+U6VzjLxjw7jQHtCZI4C/8YEyk
	 3PlBVC0jcUzIm0BJdmYHjhZROeq9wYH2qf832/pqjyDg/VdOqxLpncoeCAuPxXPA4L
	 DmLNLp37EnKwcxGr1lkg14cGnJGUOxgT3Kt5IVYyh3h7y5VBBKbryWG7rB827fT9iQ
	 RufMvrNznuNqoI8kB4nsc5gv/+WNHLbC4jPJ9kpvjRL0N1iNiJIePhmzViMWIkFzri
	 sXgkzbjnZ2aLlH7qLRmzJnLNvvNTqddHrhfbsh1rqz714Wco60qxaSTEH/86Sh/hgn
	 gDrQ3wCAzMChw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:49:22 +0200
Message-Id: <DC5X5AJHD5XZ.1QNTV43HZ2F9L@kernel.org>
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
Subject: Re: [PATCH v8 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-7-boqun.feng@gmail.com>
 <DC0AKAL1LW84.MR2RFTMX1H61@kernel.org> <aKCtbSDuJNrtdLNp@tardis-2.local>
 <DC43RPUDBY6M.1TGSQKJV9BKSF@kernel.org> <aKFGtzQnUdH4zUGD@tardis-2.local>
In-Reply-To: <aKFGtzQnUdH4zUGD@tardis-2.local>

On Sun Aug 17, 2025 at 5:04 AM CEST, Boqun Feng wrote:
> On Sat, Aug 16, 2025 at 09:35:26PM +0200, Benno Lossin wrote:
>> On Sat Aug 16, 2025 at 6:10 PM CEST, Boqun Feng wrote:
>> > On Tue, Aug 12, 2025 at 10:04:12AM +0200, Benno Lossin wrote:
>> >> On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
>> >> > +/// Types that support atomic add operations.
>> >> > +///
>> >> > +/// # Safety
>> >> > +///
>> >> > +/// `wrapping_add` any value of type `Self::Repr::Delta` obtained =
by [`Self::rhs_into_delta()`] to
>> >>=20
>> >> Can you add a normal comment TODO here:
>> >>=20
>> >>     // TODO: properly define `wrapping_add` in this context.
>> >
>> > Yeah, this sounds good to me. How do you propose we arrange the normal
>> > comment with the doc comment, somthing like:
>> >
>> >     // TODO: properly define `wrapping_add` in this context.
>> >    =20
>> >     /// Types that support atomic add operations.
>> >     ///
>> >     /// # Safety
>> >     ///
>> >     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained =
by [`Self::rhs_into_delta()`] to
>> >     ...
>> >     pub unsafe trait AtomicAdd<...> {
>> >         ...
>> >     }
>>=20
>>=20
>> Inline maybe?
>>=20
>>     /// Types that support atomic add operations.
>>     ///
>>     /// # Safety
>>     ///
>>     // TODO: properly define `wrapping_add` in this context:
>
> The colon looks a bit weird to me. I would replace that with a period,
> i.e.
>
>      // TODO: properly define `wrapping_add` in the following comment.
>      /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by=
 [`Self::rhs_into_delta()`] to
>
> Thoughts?

Also works for me :)

---
Cheers,
Benno

