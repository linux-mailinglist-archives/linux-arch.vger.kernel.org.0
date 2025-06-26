Return-Path: <linux-arch+bounces-12468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F8AE9DCE
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446B169353
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0C2E11BF;
	Thu, 26 Jun 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxkmt1d+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAF2E06DC;
	Thu, 26 Jun 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942189; cv=none; b=FuXPaYMYgEuPAEEfrBGHaVs+TMsGgsffhkUGE0rgqMl6ZG8Gnid1SR6MBAHxR7pD5n24qFxNTMXU38hWlXuIxlFy+AJRJh80iV6jwKA9jZGn7r6bc6poLSQPocQNIkABo6rPjHNFZZSSQZdgv9LuT8E8HoPk61EM1Pdn24ZZn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942189; c=relaxed/simple;
	bh=kL4J8BTLyYzlWo6RRBwU61vvtNNhnrQbzVS7EarMxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGLxHJ0gcVotAeJii8DYrJVGmzt+n7wuWfgrVGMYCrJrGT9Uq6JMd8h/n9y8OVDM64waION3O/Dtry+I6fi7Y3GjoQD7ak4dYEdcqAxKm7kPsl4cS5OqO6di78CsNYVtgqrlILWCZ8LkWK2NitV3faIuxaeUXnTflSgjON6g4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxkmt1d+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6706C4CEEB;
	Thu, 26 Jun 2025 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942189;
	bh=kL4J8BTLyYzlWo6RRBwU61vvtNNhnrQbzVS7EarMxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oxkmt1d+FqxkPZCKCgFovSEQWDOheBvQC7RFTrKLNcQR1zOXU4wZuezSDWM/fD6Vm
	 ZwS5ac6UPUXG/UGMoaPdLAnzTV8NJwFYxki8rhs/AO/k/SWHR5KWlyazHRrzM5L+kG
	 U66spCZqvQlxHBL8j+j4lsUwUeE5GDo/D3V3t+JnhhDpI312ft/dCFBhklOu0nNzcn
	 NWRN9vap2WtP36RNIxD2UagGPpob0VG2lBe1r1WQxHF/nVhiHwUU7eg2gmWQx92ytS
	 SZJkQ7xlmc3tJmIaF1k4maNZGLr7kb1czE6663fthbJKByt98WjQHH36/NgvSwDyhj
	 YHb311YfXL1lg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <lkmm@lists.linux.dev>,  <linux-arch@vger.kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  "Lyude Paul" <lyude@redhat.com>,  "Ingo
 Molnar" <mingo@kernel.org>,  "Mitchell Levy" <levymitchell0@gmail.com>,
  "Paul E. McKenney" <paulmck@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 08/10] rust: sync: atomic: Add Atomic<{usize,isize}>
In-Reply-To: <20250618164934.19817-9-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:32 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<ltC0BkXC4k2mWM8ivSmhZxpTx7Nivj7YBJGffVg8XahVfEdyUa04pCWPY9r8s7L5j8e9QkmioBhT3oFIs7cL1w==@protonmail.internalid>
	<20250618164934.19817-9-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 14:49:39 +0200
Message-ID: <87frfmzmzg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> Add generic atomic support for `usize` and `isize`. Note that instead of
> mapping directly to `atomic_long_t`, the represention type
> (`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
> the necessarity of creating `atomic_long_*` helpers, which could save
> the binary size of kernel if inline helpers are not available.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




