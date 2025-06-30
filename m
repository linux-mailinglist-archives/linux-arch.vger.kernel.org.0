Return-Path: <linux-arch+bounces-12504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BFEAED912
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 11:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FB71894EAC
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E5247280;
	Mon, 30 Jun 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifkUa/8+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B05242D8A;
	Mon, 30 Jun 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277168; cv=none; b=aVGWmQpyh+Q1PgoB9EiTnYpbjDvpEikDWeiZ2VteqakXm88pvpeOc4BGEPdQcHK0XOkmlhRHnMmI1p4KVc6X09wr4SwHnkVkc6uRaZ86U3eVGiI8KqRorrtzsvjm3jpKFaV57VklNPcCACXf0jXC4u0YpXJgTnW6eEDU7zbsXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277168; c=relaxed/simple;
	bh=/RY3CJryNb/2/aA2kaxisnyFnKYU8V6m8gYEbbdTm8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEVC5JKAr9NLrTKQy/yMk6wOP+iv2/hVGcdtzOQ9OQzpHYrE/ZXdoW65jsYMxf0X9eCj6/5BCbCnVWb0GfetZjMH+bIWAXHT5trKfi+2GHYKhJV+RAX9MMGbH3Wk6PD+rJQ98bx7MD0my8P1fiUdmazR4+rF8qqmN6MI/d9a9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifkUa/8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E33EC4CEEF;
	Mon, 30 Jun 2025 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751277167;
	bh=/RY3CJryNb/2/aA2kaxisnyFnKYU8V6m8gYEbbdTm8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ifkUa/8+ngm3MC14YdOY/Xexd03Sbv+NDlLyYiRmQbMW9qG9Y8/ahRVLDBJabq7sm
	 ejMiYGoKjR4vRNDfthQuOcl3xret15v+rCMRQMaZzVz3r8m9/TlQ6QoxEQpyGLRZl2
	 KWiG/K2kmUVZi0j6AXYZBoglaJannnTxCroN00BN/Ga92rSoQe8ac4uHNrnMb6HwDv
	 crHmZmZU2dSE35P2y8YSUcq4r91eL/e8dyRfgyfQc9xDdlp5kB3CjcTRzpSfH9/V7D
	 7ih0lVOr5dGEou+9uEAmTJiaKQKYbMHwSGivgI+uIxnJx43GRrbcQ6qXFPxzx0zGUo
	 vBbVZislVu93w==
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
In-Reply-To: <aF6yRIixTPx5YZbA@Mac.home> (Boqun Feng's message of "Fri, 27 Jun
	2025 08:01:24 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<8ISRnKRw28Na4so9GDfdv0gd40nmTGOwD7hFx507xGgJ64p9s8qECsOkboryQH02IQJ4ObvqAwcLUZCKt1QwZQ==@protonmail.internalid>
	<20250618164934.19817-5-boqun.feng@gmail.com> <8734bm1yxk.fsf@kernel.org>
	<jJqJwkURyr0NjkFdJaF6oYbPGY4LEzZs_sfY9jlmqoK1B9iE8VjqbfINHilEHxKfmpc9co7DmsS142ZWsBQ8tw==@protonmail.internalid>
	<aF6yRIixTPx5YZbA@Mac.home>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 30 Jun 2025 11:52:35 +0200
Message-ID: <87jz4tzhcs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Thu, Jun 26, 2025 at 02:15:35PM +0200, Andreas Hindborg wrote:
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
>>
>> [...]
>>
>> > +
>> > +impl<T: AllowAtomic> Atomic<T> {
>> > +    /// Creates a new atomic.
>> > +    pub const fn new(v: T) -> Self {
>> > +        Self(Opaque::new(v))
>> > +    }
>> > +
>> > +    /// Creates a reference to [`Self`] from a pointer.
>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// - `ptr` has to be a valid pointer.
>> > +    /// - `ptr` has to be valid for both reads and writes for the whole lifetime `'a`.
>> > +    /// - For the whole lifetime of '`a`, other accesses to the object cannot cause data races
>> > +    ///   (defined by [`LKMM`]) against atomic operations on the returned reference.
>>
>> I feel the wording is a bit tangled here. How about something along the
>> lines of
>>
>>   For the duration of `'a`, all accesses to the object must be atomic.
>>
>
> Well, a non-atomic read vs an atomic read is not a data race (for both
> Rust memory model and LKMM), so your proposal is overly restricted.

OK, my mistake then. I thought mixing marked and plain accesses would be
considered a race. I got hat from
`tools/memory-model/Documentation/explanation.txt`:

    A "data race"
    occurs when there are two memory accesses such that:

    1.	they access the same location,

    2.	at least one of them is a store,

    3.	at least one of them is plain,

    4.	they occur on different CPUs (or in different threads on the
      same CPU), and

    5.	they execute concurrently.

I did not study all that documentation, so I might be missing a point or
two.


Best regards,
Andreas Hindborg



