Return-Path: <linux-arch+bounces-12467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D04AE9DC7
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAC83A447C
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E402E1C55;
	Thu, 26 Jun 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCYAn8rg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E932E1729;
	Thu, 26 Jun 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942072; cv=none; b=DBh5Ygcybs8Mqvh6Oh3JrCInQd9AUWWJRtoMy8JkNhkHQiVVijT0GhdkzBYSvP7BbyE9GyFCqeqNZn0w2gElfT8uHIZ4Cys83AS9W12wto/rgFGiEKAkukoVvwQYF5tAcTtqH9MO+FEzUt3/TynhswRjud4V6ywJHrNGB/p8O9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942072; c=relaxed/simple;
	bh=XL7Aux9kgahrJU3dpfYeGvcKLSpUw6RBF4v4g6HOzzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TI8fMzI8I517P2tFiWRb9/HcTHvDNk/bF6kaIwis9VA7e/iCxnNfqQLOUqEq5rvA950rw80pcnJuTPXHJd9TFgA/XsySPWvEOZPrLaCYd2l3nk5A4LJ0ixbKaWQyTJHsT3c90UzPQugCOemUx0b5WHk9jBRpftlfUwh/fNg1reE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCYAn8rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4A3C4CEEB;
	Thu, 26 Jun 2025 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942072;
	bh=XL7Aux9kgahrJU3dpfYeGvcKLSpUw6RBF4v4g6HOzzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BCYAn8rgXzQ2N7HFq15gTuZqkSQabKj/Feu1oeOTCYB2rvyiBM9/w5vt/0dGpK/rn
	 MOF4E175qyYKeFWMnL6lMaoFwD/AIckF6BSpB9pAeESjf/p70YtIZfWe1g8XFZ/2Ik
	 c+YdjXewkM3RYfh7yPLj97VWw84IRAFMjhFMEOVPOVIR6wgKk/QuwXaXOi0js+xRn9
	 ASku/mGanEgy0+F3M2pz3XkzD60r8cS5AgFcY6pPL8ICFd3LtAcHAh8JRSFQDmSIhH
	 bKp19DShxczCvoiFfeCXiGbEIW5zA1QCBgckGIYmdPd2eDq4LKih2eH2AC4pHH+/z5
	 7TZKKdwktQG9A==
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
Subject: Re: [PATCH v5 07/10] rust: sync: atomic: Add Atomic<u{32,64}>
In-Reply-To: <20250618164934.19817-8-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:31 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<NipooAeL4iGcyj1mFm4IgmsOxRMn1dmQSeyQhU5piJonKEvKbj_tFKnDuN0I2NV3V_sfoOb3iLfVWaa2q7qYXA==@protonmail.internalid>
	<20250618164934.19817-8-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 14:47:39 +0200
Message-ID: <87ldpezn2s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> Add generic atomic support for basic unsigned types that have an
> `AtomicImpl` with the same size and alignment.
>
> Unit tests are added including Atomic<i32> and Atomic<i64>.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



