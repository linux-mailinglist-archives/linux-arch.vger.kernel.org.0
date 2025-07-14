Return-Path: <linux-arch+bounces-12738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3919B03CDA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3FF167F32
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD7245014;
	Mon, 14 Jul 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJriUBTi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65071DDC2B;
	Mon, 14 Jul 2025 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491176; cv=none; b=XtxzrP5MAeBXDLk4XRgwp/tIXmqXPiI8ebnY8IlJ3nKbLZzWh2L9T6/WVbspbiGIhKPg6983yLmn+9KuWOb9TCCp5/YY124TljgbIBmkkSiFLotEDvhpRTCRLIXrsCO+RbajE9IXyg6FG61uLQeqv4+Pg8DWRudJRj0vELFWKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491176; c=relaxed/simple;
	bh=08FQX5jjC0fHpNbdzJ7L8aJDB8Exeg72PrRUtVL5D0I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rQvd3Fb8ma9ekSM06UxduxN86dTsany4ZqNXkANoPLQ+9cpzO7SnvyEAbLapF8WQ1IPgXvKPXfXNQLzAulHj4krxLSPFgEVfRJiWqF8Iwt1GA8oDlAG/epoOMkVaNwwf8sFDJJwROpsuDTwcz8SLtW72VRnOBjwHE53s1FDao8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJriUBTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E8C4CEED;
	Mon, 14 Jul 2025 11:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491175;
	bh=08FQX5jjC0fHpNbdzJ7L8aJDB8Exeg72PrRUtVL5D0I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NJriUBTieWUexKIrlILdx706I/ji3z01trEEwQbRcD0TqNLohg26/MZlnnID+2qV6
	 9nYfK4H+KpMzISa+MUz0LyMyI2xztT+RHq8uTAo6V1SN+rU/1t0frisNEwiR31pm4W
	 At5KG0KgW9kmv5lMHyr+GENu3ll6AV5JfeJxmMH4dqxo+vs/hcf68EE+vOcNZsqXLN
	 /VWHnsQ9C7vXMhqUumm1ZCM+7sVczrhIsRipT1/HlkTnlkvkuD+K0oUipZLEgkM76M
	 RQjH/9z555MqDIrWT8FsmfYcKdC0jD1XvBupPJo5YooZCeoIzW/NeRFVQ+AdxFjGH/
	 7HWAxzO5VTeOg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:06:08 +0200
Message-Id: <DBBQ9SLMWA2K.33BWRE1ME65MG@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
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
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-10-boqun.feng@gmail.com>
In-Reply-To: <20250714053656.66712-10-boqun.feng@gmail.com>

On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> +// Defines an internal type that always maps to the integer type which h=
as the same size alignment
> +// as `isize` and `usize`, and `isize` and `usize` are always bi-directi=
onal transmutable to
> +// `isize_atomic_repr`, which also always implements `AtomicImpl`.
> +#[allow(non_camel_case_types)]
> +#[cfg(not(CONFIG_64BIT))]
> +type isize_atomic_repr =3D i32;
> +#[allow(non_camel_case_types)]
> +#[cfg(CONFIG_64BIT)]
> +type isize_atomic_repr =3D i64;
> +
> +// Ensure size and alignment requirements are checked.
> +crate::static_assert!(core::mem::size_of::<isize>() =3D=3D core::mem::si=
ze_of::<isize_atomic_repr>());
> +crate::static_assert!(core::mem::align_of::<isize>() =3D=3D core::mem::a=
lign_of::<isize_atomic_repr>());
> +crate::static_assert!(core::mem::size_of::<usize>() =3D=3D core::mem::si=
ze_of::<isize_atomic_repr>());
> +crate::static_assert!(core::mem::align_of::<usize>() =3D=3D core::mem::a=
lign_of::<isize_atomic_repr>());

This is fine for now, but I would prefer for this to go into an
`assumptions` module like Miguel proposed some time ago.

---
Cheers,
Benno

