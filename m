Return-Path: <linux-arch+bounces-12749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55FB0436D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D35D1A67AFD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA4260590;
	Mon, 14 Jul 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6C72BaY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EF1FF1A0;
	Mon, 14 Jul 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506226; cv=none; b=SdseNECWsTcc1V8ZDRWD3RLlKxB4ggNKUefqaSTQ0WH7mvTWIanX0NcOxQ8Fz5B/YBWWtWfnIwh72T0XRuGF6x42LoKFFhvPGbVGew5CBqEZvEXMiGpuOCarUG7DsV8g0p+0Yx85pVQsRGtjk4BmYTgdCieaI2yqcWhEtQ5KUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506226; c=relaxed/simple;
	bh=4igAOpka0ueg8YOxxmkXDIQmMsPUVxUchsQwmhh9DIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VP/zve1mgNdGoDgNCOGnk/xN0OlHHzMHd+krtrhtG01ZwaHZn6D2Qai0nID547Q8WumOxKB+LRimSQwgVAhx3ITIM3B2R5EuXDVLtLfldFbkzlt3abqKdvCTbeooiEetYSrkOllBxYkdNkx269Kq/V4Pe/y6+73MnFxAdrsj+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6C72BaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE900C4CEF0;
	Mon, 14 Jul 2025 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506226;
	bh=4igAOpka0ueg8YOxxmkXDIQmMsPUVxUchsQwmhh9DIQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=K6C72BaY+ln7/Qi4pr0Pvo88sqkcnKsQ+wXyOvOx3IXRAiKTU/jaloK7EtjKwvJV2
	 uHeo6gwRKQj/DB5EqQj+hQhAYIkfBJF9CTX7AOcv7hPCGUlt9dXmUp24VQ+VOn0Tjn
	 9D0Hul+vnRRM8AlBQ1cKz4ZhhdfAKAZrUJ6fM8375VpEOhrhDHgNTT8U5jDplmJCTl
	 aS+k6x+EFv3o/vXBu++qIeW3YEEBZxNfwtVXwXpYSDSafUYMVj1XBttJDC1kT/eH3j
	 u/4kO1yrV8m/p3nLYaJAI9sQnJaA8ghRET6EeZ0JoRpuNRcBvorHf3UlzDF4BI+K1j
	 PFZ0wkWl5G5Iw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 17:16:59 +0200
Message-Id: <DBBVLUSF4TVV.2GCXLLC9JS2II@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
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
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org> <aHUSgXW9A6LzjBIS@Mac.home>
 <CANiq72mFa0bM_DZV2tHViU0SKqNG_tX6AxBWz4AQ=2UmBrt=nQ@mail.gmail.com>
 <aHUZzdbUSkN_4v2G@Mac.home>
In-Reply-To: <aHUZzdbUSkN_4v2G@Mac.home>

On Mon Jul 14, 2025 at 4:53 PM CEST, Boqun Feng wrote:
> On Mon, Jul 14, 2025 at 04:34:39PM +0200, Miguel Ojeda wrote:
>> On Mon, Jul 14, 2025 at 4:22=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>> >
>> > Hmm.. why? This is the further information about what the above
>> > "Examples" section just mentioned?
>>=20
>> I think Benno may be trying to point out is may be confusing what
>> "this" may be referring to, i.e. is it referring to something concrete
>> about the example, or about `from_ptr` as a whole / in all cases?
>>=20
>
> Ok, how about I do this:
>
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic=
/generic.rs
> index 26d9ff3f7c35..e40010394536 100644
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -135,6 +135,9 @@ pub const fn new(v: T) -> Self {
>
>      /// Creates a reference to an atomic `T` from a pointer of `T`.
>      ///
> +    /// This usually is used when when communicating with C side or mani=
pulating a C struct, see
> +    /// examples below.

I don't think it's necessary to mention the examples below, but this is
what I had in mind.

---
Cheers,
Benno

> +    ///
>      /// # Safety
>      ///
>      /// - `ptr` is aligned to `align_of::<T>()`.
> @@ -185,9 +188,6 @@ pub const fn new(v: T) -> Self {
>      /// // no data race.
>      /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
>      /// ```
> -    ///
> -    /// However, this should be only used when communicating with C side=
 or manipulating a C
> -    /// struct.
>      pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
>      where
>          T: Sync,
>
> ?
>
> Regards,
> Boqun
>
>> Cheers,
>> Miguel


