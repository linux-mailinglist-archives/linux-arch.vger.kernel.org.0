Return-Path: <linux-arch+bounces-12647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF11B00C13
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978595C45EF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C922E402;
	Thu, 10 Jul 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERL+5YIm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11C72627;
	Thu, 10 Jul 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175152; cv=none; b=hlWCM/blpx9ltXuwqJCfS0dsMvNs0Ky/ZPlTyHZRttUxPv1AvPsrnfpPK4CN5opOZLGZy4vylZ77a+e5PHntbVSy4WqTRZAVgedSbOXNa25ZNKfOwxY9o2UlyOVJHwtTYZIMMIk+PA0k3j/w9/xdQk/gJULhGrTpF8IbEilkHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175152; c=relaxed/simple;
	bh=/VNtHzWlVrFxJTK4M067LDtmq1dxJcucRkdoJjYxRCk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qwxjzvX6ffOkgc6q+BYD+h3wVuEUUyuN2noPTV3nw8RFVH0nE57gG/ySJwy6cibTxobcprfoSMCqZrJSABs1aoYBSf3VeYZ6FjQ0VvjxDbsO15NoEom4RngDJcOFVTQcJCaWFh1VgjYwG7NgVeg3E/OkTUs5DX625AoZGxQDz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERL+5YIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D7C4CEE3;
	Thu, 10 Jul 2025 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752175151;
	bh=/VNtHzWlVrFxJTK4M067LDtmq1dxJcucRkdoJjYxRCk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ERL+5YIm3WTY0Zy50rcfb2NunzB8IZCbwrOyu4jzokTU8g2PLzonM/IZ2MH382fKr
	 PN7umPn5jx+3KbogFUTk7cPLGjDIwhV6tF8KsjLeF5VrPKn+KCZ1OPe0cQGNssiKUe
	 KeVh+PN94mbNcx9V9T4l3XsLLqi3X/eeZ7Fs0r8uNEh3pNpNo8yEacEwWNnrxLVkR5
	 ASUbv5sVAemo3O8WB57d9+/ryc5jASLLJfuLiFFAJh8qN+D/PAWNpH2QzDCKb6jbKj
	 chOs6L0QDpcZf8mIb6dRw4RcPHvgYRglYPhRa9nmWZui+mQkD4xmQyYxEcCWjomTV2
	 Z4lH41NcWaUMQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 21:19:05 +0200
Message-Id: <DB8M91D7KIT4.14W69YK7108ND@kernel.org>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-4-boqun.feng@gmail.com>
 <4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid> <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org> <87v7o0i7b8.fsf@kernel.org> <aG_RcB0tcdnkE_v4@Mac.home> <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org> <aG_i1aQhkBa6k8JZ@Mac.home>
In-Reply-To: <aG_i1aQhkBa6k8JZ@Mac.home>

On Thu Jul 10, 2025 at 5:57 PM CEST, Boqun Feng wrote:
> On Thu, Jul 10, 2025 at 05:05:25PM +0200, Benno Lossin wrote:
>> If it were something private, then sure use `Any`, but since this is
>> public, I don't think `Any` is a good name.
>>=20
>
> This essentially means we keyword `Any` as a public trait name, then we
> should document it somewhere, along with other names we want to keyword.

Then let's restrict `Any`.

---
Cheers,
Benno

