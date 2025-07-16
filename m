Return-Path: <linux-arch+bounces-12822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC310B07BDB
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 19:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1247A85F2
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2E2F547C;
	Wed, 16 Jul 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA/Ii8Gr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACB2798EA;
	Wed, 16 Jul 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686169; cv=none; b=Mf3NKJbbRxO6WQ/bpzqtjqvgwCmPUa3jIFKM1HaQ9FSW38/0yAJ0N2mZsvEFO1D7McfWKC3Q4BvmOw1Boh65sxK/tKWIYviv9AM/pAH2L/ScvAFSA4JB7G9CId7jnsGbnZkaI2GJ1JGjvbtee+CE0hlvMc8yaqvAV8jBfuwbq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686169; c=relaxed/simple;
	bh=WjN4ZftabKpQLXbiJ4dykt/E4neOL6d8HDXxD+KsYsg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=gz89g86y6qeZ0WGWR5atkn1xMcAU0/zTqBNNfEmD4nVBEU4gFKrIz+wrL5avAvG0cgM5OxSX0abojQf2ZoOTRZ120IH7umiuu1j1qYRGN5yjvU120pHkLcVSf6Bd0PoqPQ/+Vc2qFW8WsEDJBGbxj4e/P6AsEN7b9bGNeP/YOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA/Ii8Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51355C4CEE7;
	Wed, 16 Jul 2025 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752686169;
	bh=WjN4ZftabKpQLXbiJ4dykt/E4neOL6d8HDXxD+KsYsg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=IA/Ii8Gr1Za8zAw0xmiaujSA2tjTH3ppWsobaRIC5xDJ4lz7/LrX4Z/YNh6SuUInl
	 PMK4HGV001yLzrsg2LbYEhx9By4cRSW+CzwnX91J7W3NENGjWiRfqTaL/ohM7opau7
	 jWxomSpQgWYJvxuWslffSJNpagRcv8Z2zgIQ7HgBWJaqnYyKHICkrih+m3reZPVlQF
	 Q6ZuEnAtWuShSi9+SRKHv7M1Dq+4VcA8IFTAE04YpsK5gFXu7Xr0uOO4MM/wdH1BZY
	 q7y+vcAjXZ+usJdExDd5IE80beP7X6xVLW8Skoknj8UAHGek0ZL9YrFIqOMBf8v9XS
	 2WPgTnoMYEImg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 19:16:02 +0200
Message-Id: <DBDNE3CNUOZP.1H168Z8BD6ZKK@kernel.org>
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
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org> <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org> <aHZ-HP1ErzlERfpI@Mac.home>
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org> <aHa2he81nBDgvA5u@tardis-2.local>
 <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org> <aHezbbzk0FyBW9jS@Mac.home>
 <DBDL9KI7VNO2.1QZBWS222KQGP@kernel.org> <aHfJx5_kMcULUd7t@Mac.home>
In-Reply-To: <aHfJx5_kMcULUd7t@Mac.home>

On Wed Jul 16, 2025 at 5:48 PM CEST, Boqun Feng wrote:
> On Wed, Jul 16, 2025 at 05:36:05PM +0200, Benno Lossin wrote:
> [..]
>> >
>> > I have a better solution:
>> >
>> > in ops.rs
>> >
>> >     pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>)
>> >
>> >     impl AtomicArithmeticOps for i32 {
>> >         // a *safe* function
>> >         fn atomic_add(a: &AtomicRepr, v: i32) {
>> > 	    ...
>> > 	}
>> >     }
>> >
>> > in generic.rs
>> >
>> >     pub struct Atomic<T>(AtoimcRepr<T::Repr>);
>> >
>> >     impl<T: AtomicAdd> Atomic<T> {
>> >         fn add(&self, v: .., ...) {
>> > 	    T::Repr::atomic_add(&self.0, ...);
>> > 	}
>> >     }
>> >
>> > see:
>> >
>> > 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?=
h=3Drust-atomic-impl
>>=20
>> Hmm what does the additional indirection give you?
>>=20
>
> What additional indirection you mean? You cannot make atomic_add() safe
> with only `UnsafeCell<T::Repr>`.

What is the advantage of making it safe? It just moves the safety
comments into `ops.rs` which makes it harder to read due to the macros.

---
Cheers,
Benno

