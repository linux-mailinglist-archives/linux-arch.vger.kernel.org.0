Return-Path: <linux-arch+bounces-12430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D51AE3EA9
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 13:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D633B9A42
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96F23E359;
	Mon, 23 Jun 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEzDE9rD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F53188CC9;
	Mon, 23 Jun 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679685; cv=none; b=K08NK6NB7a8bPbJnL7JbOBRnstiDMuOSz8s0/rAiLdUqdLOHCoVX67SPQSgslJi5VwB48cfTmExEOOpLHLab1JEepFIecuCydXk0zXXQ4FuwPwO/AxeiMdLSv3UeDBO+LrE5Eu+CXh7Mh7pkuRlFYqb8WUEXxmR8DiF3ZKbs0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679685; c=relaxed/simple;
	bh=/uT155bZSbLCiM0qCfhRE3uZEOZiDrXtCzPyDSsBQ6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eDZl8iAwZP3UBMR8wyfnsLqs1CNTRu4zzOqvZA8afNYQdkKvQ3Iz7SQB+s3no63e26Bl3pXTk3K6FtmUp6TEZkLl8UI0Dtiph7ijWTCf1iZaXSJNN0eN1eaHuqGK4Zoc13XSbZ2k4SPPhqFo6KyqW7xt5cbHrCKSaY+iKAhXJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEzDE9rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404CDC4CEEA;
	Mon, 23 Jun 2025 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750679684;
	bh=/uT155bZSbLCiM0qCfhRE3uZEOZiDrXtCzPyDSsBQ6g=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aEzDE9rDNoQg8vhz8itfbNQn/JbKJiELUhuRe09vzbthtQZb3ucyMox6uuRQ/wWHi
	 T6BWQO9R2OwZNdK8dgzpcaFVSe+2qh3j/wbVTApYKh/eMzYLMbybohZTl/J6inh1Kc
	 tnYVFSJnCh8s0ttfeNbS8Pr0quCoJajAMqQ+7USFsKTzgBGnwa7cE+80+iWrVQpwv/
	 HUvv/Sm9CHs1KB7hanR1AEUfrHCM6KrQg1RpW1xOWfJDpT5/zwCkyRtMaJHe0GQHa8
	 P7nPVhPxIKUpJ8H/thzrn4HaLVE8rp+beSgYIUf6NQ2GQwE4j+wkWs/WCaSzS66SO6
	 hj6aYJIGvVbLw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 13:54:38 +0200
Message-Id: <DATW5HJ259PB.1289VEJEUBT2Z@kernel.org>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
In-Reply-To: <aFjj8AV668pl9jLN@Mac.home>

On Mon Jun 23, 2025 at 7:19 AM CEST, Boqun Feng wrote:
> On Sat, Jun 21, 2025 at 12:32:12PM +0100, Gary Guo wrote:
>> Note tha the transparent new types restriction on `AllowAtomic` is not
>> sufficient for this, as I can define
>>=20
>
> Nice catch! I do agree we should disallow `MyWeirdI32`, and I also agree
> that we should put transmutability as safety requirement for
> `AllowAtomic`. However, I would suggest we still keep
> `into_repr`/`from_repr`, and require the implementation to make them
> provide the same results as transmute(), as a correctness precondition
> (instead of a safety precondition), in other words, you can still write
> a `MyWeirdI32`, and it won't cause safety issues, but it'll be
> incorrect.

Hmm I don't like keeping the function when we add the transmute
requirement.

> The reason why I think we should keep `into_repr`/`from_repr` but add
> a correctness precondition is that they are easily to implement as safe
> code for basic types, so it'll be better than a transmute() call. Also
> considering `Atomic<*mut T>`, would transmuting between integers and
> pointers act the same as expose_provenance() and
> from_exposed_provenance()?

Hmmm, this is indeed a problem for pointers. I guess we do need the
functions...

But this also prevents us from adding the transmute requirement, as it
doesn't hold for pointers. Maybe we need to add the requirement that
`into_repr`/`from_repr` preserve the binary representation?

---
Cheers,
Benno

