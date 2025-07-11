Return-Path: <linux-arch+bounces-12680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD33B0243D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5580C16BC3C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5702DCF4D;
	Fri, 11 Jul 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxuYiciB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4B1D6DB9;
	Fri, 11 Jul 2025 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260748; cv=none; b=svbf9cpV7VyUP2E/KZq1WFdoV1dVZDibsTyXpZE607oJBes65JaCgMNwvgwdgeRNF6TN656RNUT4fYwBDM/dssnmm6IPZ34OGZ8ujkkfa7Ga1XBeXZlhAFCVYRFeHs3eUWhdunXDQN48yCpgx04aDRw0kIlnkksPbjRBaGW07yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260748; c=relaxed/simple;
	bh=wYw3KntEIjnnKDQic6EnlE/rMhMk+g9BmeUPdvfUmiM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=B0kQIdBmCmi/VG/NOMxOEquYbTPqWTECTwK2Z2Dwc2b9SK/suSYtK6Ud4IOzk02F/MBCZ1Gh9o/ZwvFNF8VB3L+DqCv/4XOvgXC9X51fk9ZKAMm9AF3rUTpSXk9nVebwSq3nzVB9xx9LiFvMSqZKrWkYRs/1ghIBd27e3IiS6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxuYiciB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC4FC4CEED;
	Fri, 11 Jul 2025 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752260747;
	bh=wYw3KntEIjnnKDQic6EnlE/rMhMk+g9BmeUPdvfUmiM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pxuYiciBlNbXGUU1UnglQFG0EVGPy3L8ixx58mRR4MKyZe5faNf4XHRm3KmaEHcOa
	 3Tg2P7EgvUYyPxsoLUCyduE9BkKFaLnWm9Agkc3DIupZoF9udPMKy9wc7gdhGHHGXM
	 r2Yu4Z6dMAgq87gkx8n884mrmmEvGojaT2CeqHmLKH7mK9l4UT0J0BcM3TlDrUJkEC
	 HEOIuirJnN4Nmbn4pcPn3eISUG1pDaduEwiZUx2H5afxJGrhyZml0Lufsc9S0/mLFR
	 Jce5Z0X27K2nwUBVlsYjYGSmuoEJ3rL7+4S9YgaoPZ04arPQGLW68CkrqPtRmpBL1q
	 1kNJ19mBCxcbQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 21:05:34 +0200
Message-Id: <DB9GL8R8BBDJ.2ZDO26DR404JL@kernel.org>
Subject: Re: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>, "Matthew Wilcox"
 <willy@infradead.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-10-boqun.feng@gmail.com>
 <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org>
 <CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUMHFTuuj5ydmqo+OYn60A@mail.gmail.com>
In-Reply-To: <CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUMHFTuuj5ydmqo+OYn60A@mail.gmail.com>

On Fri Jul 11, 2025 at 3:45 PM CEST, Miguel Ojeda wrote:
> On Fri, Jul 11, 2025 at 11:00=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> Do we have a static assert with these cfgs that `isize` has the same
>> size as these?
>>
>> If not, then it would probably make sense to add them now.
>
> Yeah, according to e.g. Matthew et al., we may end up with 128-bit
> pointers in the kernel fairly soon (e.g. a decade):
>
>     https://lwn.net/Articles/908026/
>
> I rescued part of what I wrote in the old `mod assumptions` which I
> never got to send back then -- most of the `static_asserts` are
> redundant now that we define directly the types in the `ffi` crate (I
> mean, we could still assert that `size_of::<c_char>() =3D=3D 1` and so on=
,
> but they are essentially a tautology now), so I adapted the comments.
> Please see below (draft).

Ahhh yes the `mod assumptions` was the thing I remembered! I think it's
still useful as a file where we can put other global assumptions as
well.

---
Cheers,
Benno

