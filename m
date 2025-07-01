Return-Path: <linux-arch+bounces-12527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CEAEF1E8
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8351899D42
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DC22488B;
	Tue,  1 Jul 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XanD8PGh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479122259D;
	Tue,  1 Jul 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360061; cv=none; b=lnnCjKJZbHT4BuvrhKR3cDywyCfFT1+koYViEv7cQi+CRZrtezCVttrheZsImzl2k2XwaHowQcztwY21Si69JXA9aj0TWPZsGLs05Wsu4pawiaGv0sdOI4vs+DwyZGdlJ0iE6d9KqjA+kdJYK8Crpz3BV+c8uoSPZZfkNIWYlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360061; c=relaxed/simple;
	bh=Of/4Ddg4QIiyWclus1L5TZgKqEq9vPKIUPcZ8Gmo9Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gh3iP8qgeVfydwd9bcM7Tubuv1oQ230vf+2QbK6EwMRINXTXxGYlWuJu6GCa3suLkp/oN8GrO9u163t4zOZTtnJ4FuFLiJPE9noRyf3gsj8uy2+MqAj9L1fRVSW7oewLkCPruH5I8bBftdcMkZJmDVHxI4D4+1tjQJnsOo+I7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XanD8PGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C4C4CEEB;
	Tue,  1 Jul 2025 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360061;
	bh=Of/4Ddg4QIiyWclus1L5TZgKqEq9vPKIUPcZ8Gmo9Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XanD8PGhrgq8EDkq5uz9JGplQXsgEYGCgSA153V++XcSjO5W3Ud7qs5v2Ioffqs2T
	 q2fcw1Vt5vJob3XKmMKf91HJ7JaIWCPemvA4/iMcWPwRplRo+CSsjtsIoK4tew1CKi
	 pEDuJLhhbgllBfaRTExbAfulgBM04tVJBy5XE1i5L8Nq8r0lwP2opgkzEG2Y0MDKt1
	 xkPKdDXLQI7VcEWyokW2mId7lJt9ogEbnx5VREL8h15S75AN8YtJtRmGUMBsicMVsm
	 LmWzGBgchJw4pxS4t4KC0P79C8KDEwsTAlp8UmK3X6U/9iFzGkiIIhgdvvbaHx7d/I
	 JBQQa2na59YxA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <lkmm@lists.linux.dev>,
  <linux-arch@vger.kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin" <lossin@kernel.org>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Mark Rutland"
 <mark.rutland@arm.com>,  "Wedson Almeida Filho" <wedsonaf@gmail.com>,
  "Viresh Kumar" <viresh.kumar@linaro.org>,  "Lyude Paul"
 <lyude@redhat.com>,  "Ingo Molnar" <mingo@kernel.org>,  "Mitchell Levy"
 <levymitchell0@gmail.com>,  "Paul E. McKenney" <paulmck@kernel.org>,
  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
In-Reply-To: <7eea6ee3-4a9e-4eb5-b412-2ece02b33c6c@rowland.harvard.edu> (Alan
	Stern's message of "Mon, 30 Jun 2025 10:44:41 -0400")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<8ISRnKRw28Na4so9GDfdv0gd40nmTGOwD7hFx507xGgJ64p9s8qECsOkboryQH02IQJ4ObvqAwcLUZCKt1QwZQ==@protonmail.internalid>
	<20250618164934.19817-5-boqun.feng@gmail.com> <8734bm1yxk.fsf@kernel.org>
	<jJqJwkURyr0NjkFdJaF6oYbPGY4LEzZs_sfY9jlmqoK1B9iE8VjqbfINHilEHxKfmpc9co7DmsS142ZWsBQ8tw==@protonmail.internalid>
	<aF6yRIixTPx5YZbA@Mac.home> <87jz4tzhcs.fsf@kernel.org>
	<Xfm2JGPb6LBj7GAjuEFddz5UvwY_vFr3r-253ujBCBa4galferuILoEDKNSQcfOL-lFi65L-rTnBWAxxCE4cyg==@protonmail.internalid>
	<7eea6ee3-4a9e-4eb5-b412-2ece02b33c6c@rowland.harvard.edu>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 01 Jul 2025 10:54:09 +0200
Message-ID: <875xgcxpe6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alan Stern" <stern@rowland.harvard.edu> writes:

> On Mon, Jun 30, 2025 at 11:52:35AM +0200, Andreas Hindborg wrote:
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
>> > Well, a non-atomic read vs an atomic read is not a data race (for both
>> > Rust memory model and LKMM), so your proposal is overly restricted.
>>
>> OK, my mistake then. I thought mixing marked and plain accesses would be
>> considered a race. I got hat from
>> `tools/memory-model/Documentation/explanation.txt`:
>>
>>     A "data race"
>>     occurs when there are two memory accesses such that:
>>
>>     1.	they access the same location,
>>
>>     2.	at least one of them is a store,
>>
>>     3.	at least one of them is plain,
>>
>>     4.	they occur on different CPUs (or in different threads on the
>>       same CPU), and
>>
>>     5.	they execute concurrently.
>>
>> I did not study all that documentation, so I might be missing a point or
>> two.
>
> You missed point 2 above: at least one of the accesses has to be a
> store.  When you're looking at a non-atomic read vs. an atomic read,
> both of them are loads and so it isn't a data race.

Ah, right. I was missing the entire point made by Boqun. Thanks for
clarifying.

Since what constitutes a race might not be immediately clear to users
(like me), can we include the section above in the safety comment,
rather than deferring to LKMM docs?


Best regards,
Andreas Hindborg



