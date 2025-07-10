Return-Path: <linux-arch+bounces-12633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF7B0011D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C4B40301
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977B24DCEB;
	Thu, 10 Jul 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6nv30q1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDF1EA73;
	Thu, 10 Jul 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148868; cv=none; b=QPG5v3ytJ9NipvDZTl8gdXOfgUlKPHkhIR33spNGVG697elbjzT6dO4GqJVXqluy4B+ioh4DnIgsOVeG6sjmpwEzw2STUr/tKB9xdGuPAHmdGYCxobdfdi3u0Bik1q6tG2oXgbFjXKbkVtFwMD4tQXfrLYcBrn/U1UUs4tcfMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148868; c=relaxed/simple;
	bh=xlOKUHxAG5+wDJb2IC+FgPeerBVxfJ6Ohz+JMX7/gpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o0uka/Oac72rZ+w8isqfg8Ske7cTdS5g4L2C2fqNhfKWawq1aCZea8NK8Lv4G3ZbZq6NXLA9lGmK2TbqYRYxYq0m9qHD0dGrzujrmTwtntgdQg8B2/mZ0H5VHlojaB32BsdWbwbrlSADVAiOdZPj4pKk5efFqBnYFGTLsuBtnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6nv30q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E000C4CEE3;
	Thu, 10 Jul 2025 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148867;
	bh=xlOKUHxAG5+wDJb2IC+FgPeerBVxfJ6Ohz+JMX7/gpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W6nv30q18H8QhIFXyBVNo5oXW0gI/m+DesNOelLmRsQkbSUQMuruGa9bvwZn1hblG
	 olZk7orPdkztCj9aZy46xyY9ZOYIqwpHjrCpm7xGNnfqfYp+yFNuyFr5DOcENbVxSj
	 AZJJ9tq0uh3A2taBqFaJWTC3cmTQxKa1XWm8525tRxQbSrX7LENZeF18+wTwywg49r
	 pGMhGk9Siao5Pw4JOivaoF6B7rHRm4vmo0IhZ/1DUUSlaRlXpm77kQzuWnFmjpUYkv
	 Z+IJ3Tu94t+POIiPdkl6CJXLtH2ibipoWm0zC/EyyeDxO46i99Hd4CGoVx2BG0dmsk
	 smk2Tb9A6tQNw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <lkmm@lists.linux.dev>,
  <linux-arch@vger.kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  "Alice Ryhl"
 <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,  "Peter
 Zijlstra" <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,
  "Wedson Almeida Filho" <wedsonaf@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  "Lyude Paul" <lyude@redhat.com>,  "Ingo
 Molnar" <mingo@kernel.org>,  "Mitchell Levy" <levymitchell0@gmail.com>,
  "Paul E. McKenney" <paulmck@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>,
  "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation types
In-Reply-To: <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org> (Benno Lossin's message
	of "Thu, 10 Jul 2025 13:08:19 +0200")
References: <20250710060052.11955-1-boqun.feng@gmail.com>
	<20250710060052.11955-4-boqun.feng@gmail.com>
	<4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid>
	<DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 10 Jul 2025 14:00:59 +0200
Message-ID: <87v7o0i7b8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>> Preparation for atomic primitives. Instead of a suffix like _acquire, a
>> method parameter along with the corresponding generic parameter will be
>> used to specify the ordering of an atomic operations. For example,
>> atomic load() can be defined as:
>>
>> 	impl<T: ...> Atomic<T> {
>> 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
>> 	}
>>
>> and acquire users would do:
>>
>> 	let r = x.load(Acquire);
>>
>> relaxed users:
>>
>> 	let r = x.load(Relaxed);
>>
>> doing the following:
>>
>> 	let r = x.load(Release);
>>
>> will cause a compiler error.
>>
>> Compared to suffixes, it's easier to tell what ordering variants an
>> operation has, and it also make it easier to unify the implementation of
>> all ordering variants in one method via generic. The `TYPE` associate
>> const is for generic function to pick up the particular implementation
>> specified by an ordering annotation.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>
> One naming comment below, with that fixed:
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
>
>> ---
>>  rust/kernel/sync/atomic.rs          |  3 +
>>  rust/kernel/sync/atomic/ordering.rs | 97 +++++++++++++++++++++++++++++
>>  2 files changed, 100 insertions(+)
>>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
>
>> +/// The trait bound for annotating operations that support any ordering.
>> +pub trait Any: internal::Sealed {
>
> I don't like the name `Any`, how about `AnyOrdering`? Otherwise we
> should require people to write `ordering::Any` because otherwise it's
> pretty confusing.

I agree with this observation.


Best regards,
Andreas Hindborg




