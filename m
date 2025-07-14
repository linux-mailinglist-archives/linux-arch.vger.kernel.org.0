Return-Path: <linux-arch+bounces-12746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739A9B04273
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51CC188726B
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC38925BF1B;
	Mon, 14 Jul 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwsLD6pf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36C257448;
	Mon, 14 Jul 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505264; cv=none; b=EpVRENszCmiWVauKuleV31NSq/xTunefkTV8+yJiV4bRUk0hSnS6fxf54GGUbGRCzLtV0dPExJPMR9aKqeAoFvqZJguOVmhFrWJZXWKaZm44vIoK1sk7mL4TTVLqgLZHBBo4Sdb2cJQ2C0UcfTrkt3SIVOhocA6/PqQ+/rVZqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505264; c=relaxed/simple;
	bh=qlPgUQU/gaN/1eOKsYk2wqbQmVMaMdbCfXW0TEFe5So=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J95n5vSIbec8LzATFnA1gSDOxB7JuytT55QZrUpBAUI5WTn7R+rNi8XDpix7yp7ngZisV6MsogAZ4wjH5Dlr6B5RTHiixUDzkrtRNYsM5aWZOrruFSlBXp+997V69xV+xFyNR9lTJwl2cr7IDs1Ga3og46wN5y7c3q7XFV1uGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwsLD6pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF0C4CEED;
	Mon, 14 Jul 2025 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505264;
	bh=qlPgUQU/gaN/1eOKsYk2wqbQmVMaMdbCfXW0TEFe5So=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DwsLD6pfMNv6iSpp5bwEirf2B3wAn4wDyj/KxDP8QEgCYPrKvmkYD3uE08iKwsZvs
	 xRahWKq3KPO8UVrdBtjZkn26b0Bq5qcApQ5I6XlmOQHDl+g5eOuPfxdkegi7q4Hm9g
	 cr36clIKsrR+5hX03rNgVXMj05uqNoL6zknNS+xEHJ1LK2UkKhiTJaYIsumHSkAypf
	 SuhqYNewp7UOdPRngqYDccz3WakbIG8nGOTWqqhL9oCR7yQpSAUiGcowoXb7V78FJ5
	 kaIYXO3YREcwa8Eu/6FnkjU0a2PUilHgtrxA4rzgh3aztJsSMBWOmoiWrmNL9GraCU
	 XjT9XrrjxNDUg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 17:00:56 +0200
Message-Id: <DBBV9KHTEM3E.3T10KY9JN754X@kernel.org>
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
Subject: Re: [PATCH v7 2/9] rust: sync: Add basic atomic operation mapping
 framework
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-3-boqun.feng@gmail.com>
 <DBBOXLF23VVA.2T3U6GBOZ3Y20@kernel.org> <aHUJYTv4_wsatAw5@Mac.home>
In-Reply-To: <aHUJYTv4_wsatAw5@Mac.home>

On Mon Jul 14, 2025 at 3:42 PM CEST, Boqun Feng wrote:
> On Mon, Jul 14, 2025 at 12:03:11PM +0200, Benno Lossin wrote:
> [...]
>> > +declare_and_impl_atomic_methods!(
>> > +    /// Basic atomic operations
>> > +    pub trait AtomicHasBasicOps {
>>=20
>> I think we should drop the `Has` from the names. So this one can just be
>> `AtomicBasicOps`. Or how about `BasicAtomic`, or `AtomicBase`?
>>=20
>
> Actually, given your feedback to `ordering::Any` vs `core::any::Any`,
> I think it makes more sense to keep the current names ;-) These are only
> trait names to describe what operations do an `AtomicImpl` has, and they
> should be used only in atomic mod, so naming them a bit longer is not a
> problem. And by doing so, we free the better names `BasicAtomic` or
> `AtomicBase` for other future usages.
>
> Best I could do is `AtomicBasicOps` or `HasAtomicBasicOps`.

But you are already in the `ops` namespace, so by your argument you
could just use `ops::BasicAtomic` :)

I'm fine with `AtomicBasicOps`.

>> > +declare_and_impl_atomic_methods!(
>> > +    /// Atomic arithmetic operations
>> > +    pub trait AtomicHasArithmeticOps {
>>=20
>> Forgot to rename this one to `Add`? I think `AtomicAdd` sounds best for
>
> No, because at the `AtomicImpl` level, it's easy to know whether a type
> has all the arithmetic operations or none (also the `Delta` type should
> be known). But I don't have opinions on renaming it to `AtomicAddOps` or
> `HasAtomicAddOps`.

Ahh right yeah this makes sense. So let's use `AtomicArithmeticOps` if
you insist on the `Ops` part.

---
Cheers,
Benno

