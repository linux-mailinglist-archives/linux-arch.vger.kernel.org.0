Return-Path: <linux-arch+bounces-12551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66CAF0E20
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A591680A3
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D623184F;
	Wed,  2 Jul 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8+Skwj3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066238F91;
	Wed,  2 Jul 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445219; cv=none; b=cz7G50SLkaCuwSooOGCPzqM06tbD7nyGtcDPs8/5IcWhNV9PA+TnxtREjd5iriomPsvx3nGcsJf58ofNEL5UbeCSAIwat/0SxFKq2Ls7Z71ZpuO61dA/tyBPiaiehS9GXKVYYzWCvq/sonZeVh0DjoWQLdDvVM9X9GZopV0l/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445219; c=relaxed/simple;
	bh=kJ0c2Y+z8vkhvIp9L3wSYqCfON+TxnGqLUp7nQEzxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQocdRZLBeyPKoPL8L6vRBrO1LmEEucKbtFvI7Kc/exK5DFcPYm4YtBWSByHMOGwGc0dH/WMp1fpmpKPRR1PETlK7PlHvdzYwgajtwsyMQK/m0uQd+4BJeLpW/tG/j3CDypafqwumSneTEudCWAWHPA7fbu08p+7ZAys0ilGczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8+Skwj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683ADC4CEED;
	Wed,  2 Jul 2025 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751445219;
	bh=kJ0c2Y+z8vkhvIp9L3wSYqCfON+TxnGqLUp7nQEzxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q8+Skwj3QzyUajp+7zFyee3Jrk9XxY71iydzWBnwzhOU2Eka/4YCsA4zHrsPOLb7F
	 giS3CtoP3N1oKev4+5eKYZS7vrJnPLIJnwWp3beZJ2UNgQSbrrWAdv18YcI1gLJZsx
	 9epXbFSCWR/WfoegWEE5O6RGbm3OoS0mExfqPrPCLNedHrpX1xQ6jrHnKJqqny8IWH
	 H+jQYsy+8dpCp3/+PXIEGzWWy/pMoLdqexYFnnxXJBEIE45g6kpgEYaME+BsGOxFhG
	 PHylNKcGo48d5x3ohuanRsAeSakrq6VNKU3xX6sLWEb/AR7GH7AfJY1UOn3r6tItUf
	 ILjHfS4TISX3A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Alan Stern" <stern@rowland.harvard.edu>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
In-Reply-To: <aGP1qoda9U0q2yss@Mac.home> (Boqun Feng's message of "Tue, 01 Jul
	2025 07:50:18 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<8ISRnKRw28Na4so9GDfdv0gd40nmTGOwD7hFx507xGgJ64p9s8qECsOkboryQH02IQJ4ObvqAwcLUZCKt1QwZQ==@protonmail.internalid>
	<20250618164934.19817-5-boqun.feng@gmail.com> <8734bm1yxk.fsf@kernel.org>
	<jJqJwkURyr0NjkFdJaF6oYbPGY4LEzZs_sfY9jlmqoK1B9iE8VjqbfINHilEHxKfmpc9co7DmsS142ZWsBQ8tw==@protonmail.internalid>
	<aF6yRIixTPx5YZbA@Mac.home> <87jz4tzhcs.fsf@kernel.org>
	<Xfm2JGPb6LBj7GAjuEFddz5UvwY_vFr3r-253ujBCBa4galferuILoEDKNSQcfOL-lFi65L-rTnBWAxxCE4cyg==@protonmail.internalid>
	<7eea6ee3-4a9e-4eb5-b412-2ece02b33c6c@rowland.harvard.edu>
	<875xgcxpe6.fsf@kernel.org>
	<2E_dNXmHJqWTXxnkODAnirCUgwU4iXANoAbNVSze1fnVwr49fbc8TeYMaLvKoIyO4Z8aRLwfwaaOiz7Zht1Leg==@protonmail.internalid>
	<aGP1qoda9U0q2yss@Mac.home>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 02 Jul 2025 10:33:30 +0200
Message-ID: <87a55nvvol.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Tue, Jul 01, 2025 at 10:54:09AM +0200, Andreas Hindborg wrote:
>> "Alan Stern" <stern@rowland.harvard.edu> writes:
>>
>> > On Mon, Jun 30, 2025 at 11:52:35AM +0200, Andreas Hindborg wrote:
>> >> "Boqun Feng" <boqun.feng@gmail.com> writes:
>> >> > Well, a non-atomic read vs an atomic read is not a data race (for both
>> >> > Rust memory model and LKMM), so your proposal is overly restricted.
>> >>
>> >> OK, my mistake then. I thought mixing marked and plain accesses would be
>> >> considered a race. I got hat from
>> >> `tools/memory-model/Documentation/explanation.txt`:
>> >>
>> >>     A "data race"
>> >>     occurs when there are two memory accesses such that:
>> >>
>> >>     1.	they access the same location,
>> >>
>> >>     2.	at least one of them is a store,
>> >>
>> >>     3.	at least one of them is plain,
>> >>
>> >>     4.	they occur on different CPUs (or in different threads on the
>> >>       same CPU), and
>> >>
>> >>     5.	they execute concurrently.
>> >>
>> >> I did not study all that documentation, so I might be missing a point or
>> >> two.
>> >
>> > You missed point 2 above: at least one of the accesses has to be a
>> > store.  When you're looking at a non-atomic read vs. an atomic read,
>> > both of them are loads and so it isn't a data race.
>>
>> Ah, right. I was missing the entire point made by Boqun. Thanks for
>> clarifying.
>>
>> Since what constitutes a race might not be immediately clear to users
>> (like me), can we include the section above in the safety comment,
>> rather than deferring to LKMM docs?
>>
>
> Still, I don't think it's a good idea. For a few reasons:
>
> 1) Maintaining multiple sources of truth is painful and risky, it's
>    going to be further confusing if users feel LKMM and the function
>    safety requirement conflict with each other.

I would agree.

>
> 2) Human language is not the best tool to describe memory model, that's
>    why we use herd to describe and use memory model. Trying to describe
>    the memory model in comments rather than referring to the formal
>    model is a way backwards.

I do not agree with this. I read human language much better than formal logic.

>
> 3) I believed the reason we got our discussion here is because you tried
>    to improve the comment of `from_ptr()`, and I do appreciate that
>    effort. And I think we should continue in that direction instead of
>    pulling the whole "what are data race conditions" into picture.

Yes, absolutely.

> So
>    how about we clearly call out that it'll be safe if other accesses
>    are atomic, which should be the most cases:
>
>    /// - For the duration of `'a`, other accesses to the object cannot cause data races
>    ///   (defined by [`LKMM`]) against atomic operations on the returned reference. Note
>    ///   that if all other accesses are atomic, then this safety requirement is trivially
>    ///   fulfilled.

Sounds good to me, thanks!


Best regards,
Andreas Hindborg




