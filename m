Return-Path: <linux-arch+bounces-12753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A92B044B5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9531893204
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6E25A65A;
	Mon, 14 Jul 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="wfCsT+lc"
X-Original-To: linux-arch@vger.kernel.org
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9225C810;
	Mon, 14 Jul 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508182; cv=none; b=RjsEvELnRyylo8qO/6jGVivg9NDwzbocyV4cgZjDRDgrQhliKdceztuH9rhVu8ZGyXQcAdCDIwccCJs7ivydFMQBjEFDCGPytrjNf0STr4ZPBMUC7OCw33elbIfJVBf7Sc+PYArNC33MKJSyyETG/8WtpqCSzI0WJ0ZXhAdoP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508182; c=relaxed/simple;
	bh=MXT6cnk26Vs4zRGiD6Tr/CTODiUVmYGALHN6Q7w7/PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHhbOc8iHwxYq6GowhWb/AvE/ohJL8j1lPbF4TCWmq6dl1/x/df6+P8AWKTCmHYbJG6+JSXA3KGCVRqLKn0/S6TlBR5CbYeTGHEo3kSqQpiMefew9ZhCnZLW3OwepcigdonX4mHPVzvpV9LHp2tki2gwu6qXGRNsTu4c7LBa+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=wfCsT+lc; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1752507760; bh=MXT6cnk26Vs4zRGiD6Tr/CTODiUVmYGALHN6Q7w7/PA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wfCsT+lcyZPpUl8MEw61/eOpSNg7RA8vglToYyFcdK+4AVUgdmCRgU3WQj83idkXh
	 vZ6zQwaoFJwAL8HStTCD5nx82J606trAe6u4oGzWO8EQrqN2FpN2NzChC4VsgMCKk7
	 Rgf+vmh7wrjULp4KeHyBztbWxNEpLvNE1G/C1yws=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 2567B2054EE3;
	Mon, 14 Jul 2025 17:42:40 +0200 (CEST)
Message-ID: <4d373b56-0f36-4f8a-9052-cee38b90f59b@ralfj.de>
Date: Mon, 14 Jul 2025 17:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
To: Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Lyude Paul <lyude@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Mitchell Levy <levymitchell0@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org> <aHFWCsOfcGLSUPAP@tardis-2.local>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <aHFWCsOfcGLSUPAP@tardis-2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 11.07.25 20:20, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>>> diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
>>> new file mode 100644
>>> index 000000000000..df4015221503
>>> --- /dev/null
>>> +++ b/rust/kernel/sync/barrier.rs
>>> @@ -0,0 +1,65 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Memory barriers.
>>> +//!
>>> +//! These primitives have the same semantics as their C counterparts: and the precise definitions
>>> +//! of semantics can be found at [`LKMM`].
>>> +//!
>>> +//! [`LKMM`]: srctree/tools/memory-model/
>>> +
>>> +/// A compiler barrier.
>>> +///
>>> +/// A barrier that prevents compiler from reordering memory accesses across the barrier.
>>> +pub(crate) fn barrier() {
>>> +    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
>>> +    // it suffices as a compiler barrier.
>>
>> I don't know about this, but it also isn't my area of expertise... I
>> think I heard Ralf talk about this at Rust Week, but I don't remember...
>>
> 
> Easy, let's Cc Ralf ;-)
> 
> Ralf, I believe the question here is:
> 
> In kernel C, we define a compiler barrier (barrier()), which is
> implemented as:
> 
> # define barrier() __asm__ __volatile__("": : :"memory")
> 
> Now we want to have a Rust version, and I think an empty `asm!()` should
> be enough as an equivalent as a barrier() in C, because an empty
> `asm!()` in Rust implies "memory" as the clobber:
> 
> 	https://godbolt.org/z/3z3fnWYjs
> 
> ?
> 
> I know you have some opinions on C++ compiler_fence() [1]. But in LKMM,
> barrier() and other barriers work for all memory accesses not just
> atomics, so the problem "So, if your program contains no atomic
> accesses, but some atomic fences, those fences do nothing." doesn't
> exist for us. And our barrier() is strictly weaker than other barriers.
> 
> And based on my understanding of the consensus on Rust vs LKMM, "do
> whatever kernel C does and rely on whatever kernel C relies" is the
> general suggestion, so I think an empty `asm!()` works here. Of course
> if in practice, we find an issue, I'm happy to look for solutions ;-)
> 
> Thoughts?
> 
> [1]: https://github.com/rust-lang/unsafe-code-guidelines/issues/347

If I understood correctly, this is about using "compiler barriers" to order 
volatile accesses that the LKMM uses in lieu of atomic accesses?
I can't give a principled answer here, unfortunately -- as you know, the mapping 
of LKMM through the compiler isn't really in a state where we can make 
principled formal statements. And making principled formal statements is my main 
expertise so I am a bit out of my depth here. ;)

So I agree with your 2nd paragraph: I would say just like the fact that you are 
using volatile accesses in the first place, this falls under "do whatever the C 
code does, it shouldn't be any more broken in Rust than it is in C".

However, saying that it in general "prevents reordering all memory accesses" is 
unlikely to be fully correct -- if the compiler can prove that the inline asm 
block could not possibly have access to a local variable (e.g. because it never 
had its address taken), its accesses can still be reordered. This applies both 
to C compilers and Rust compilers. Extra annotations such as `noalias` (or 
`restrict` in C) can also give rise to reorderings around arbitrary code, 
including such barriers. This is not a problem for concurrent code since it 
would anyway be wrong to claim that some pointer doesn't have aliases when it is 
accessed by multiple threads, but it shows that the framing of barriers in terms 
of preventing reordering of accesses is too imprecise. That's why the C++ memory 
model uses a very different framing, and that's why I can't give a definite 
answer here. :)

Kind regards,
Ralf


