Return-Path: <linux-arch+bounces-12737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39859B03CA6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 12:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C20164000
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF551FDA94;
	Mon, 14 Jul 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYorg/Ol"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89F1DD0C7;
	Mon, 14 Jul 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490568; cv=none; b=SznitT6gD7YGwT62vou7T9mp7soSmHMxWBMYtlvN0hMyl+Z3o9hk0Lj/HTun1u5k1b96xVHXeTWk8DgnYcCnw9WqFQL+m9VsKpxtvCOkcc9aiuOW+/MH7MJYfESM4xB3aegc/0J3jYEPle+yfLotxaROeNJpcnrLR3zwIuqlZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490568; c=relaxed/simple;
	bh=4WP0XcVaNLZoGGZ50rlIpOYekaVIX50HRb3NbB+zsac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Y/X40LicmrOZ3tI+uXhM+Sves1A1mihrWRknzgbzOOp541mBAktIXRDgOtO0hkjqI49V62Rc6ia9R9oyMmlV5gqyN/OHVK0Av3mrm3gMD45EscY6/00sFeORZGkU2YbqQcc8arYbZxdQ40RG/0tBAebjGGmo1fz01eVOrgukhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYorg/Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F1EC4CEED;
	Mon, 14 Jul 2025 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752490567;
	bh=4WP0XcVaNLZoGGZ50rlIpOYekaVIX50HRb3NbB+zsac=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IYorg/OlPjqE4WqeUB1T2oNI6bTt3J8SATqFUpSwielod/HIemhg2hI07oa+JMD6S
	 Rma+xKPs43G8TgTnccukbiPSlpol0B4AhxQxEI3TNwy83I6v/u3uZ5NTcFkytrsAgh
	 zWH7+ztNgoeeBGlLUH5zwG1Bl7M1+6SL+d1xaSak7d++PhBKu+D3Ts84EG+CKHq71Y
	 GVkeQ0KF7qc/RrwhwQYA/etjoiu5u8uY37odogAcS/WWRisvvBIpyoVRSjezildkEb
	 Zsb+AnUxDggcAFiE1DgncDKhZybsIF2nfuPPVeX6T0FF1A9e5ZSFibQJ6+RcjwaJd4
	 XY6jpjWGBGVvA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 12:56:01 +0200
Message-Id: <DBBQ21NIC2I5.32X8ZVDIK3J4C@kernel.org>
Subject: Re: [PATCH v7 5/9] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
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
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-6-boqun.feng@gmail.com>
In-Reply-To: <20250714053656.66712-6-boqun.feng@gmail.com>

On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> xchg() and cmpxchg() are basic operations on atomic. Provide these based
> on C APIs.
>
> Note that cmpxchg() use the similar function signature as
> compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
> the operation succeeds and `Err(old)` means the operation fails.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Looks good except for the naming disputes :) So

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/atomic/generic.rs | 181 ++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 1 deletion(-)

