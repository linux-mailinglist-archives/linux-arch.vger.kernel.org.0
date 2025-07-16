Return-Path: <linux-arch+bounces-12826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7D4B07E41
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 21:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DDB1C43055
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE152BCF5C;
	Wed, 16 Jul 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="ylVMaZtV"
X-Original-To: linux-arch@vger.kernel.org
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FD286D46;
	Wed, 16 Jul 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694955; cv=none; b=fAy2f/OD3Wu9s92Kz4bXFKjmazFqGSB9j89z+xY15VQd/Ga66oe5aw/0LG9GTMLlYh1CX9IliG5AOTegXPkX7ihYHqwJqQeFk8NaK++4PTYivnDo85vwej9Nyf8NEDd5BYQl6MuouwL0+8Fsxg6isYPVq3a4OXGKz00emS24am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694955; c=relaxed/simple;
	bh=Pw1fBsv5/TECiWrU0V6LsQwsUBawWDhGo6/SS9Wf7zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfxUdUarQsbEf2FnIccjYqddC6rc+qEj7CifX63hAOzfeSDlTWqNuinOFm3wYgaKvql5RXTmq8tH8XuqBpiuzHsOgd3z7TSSTbAfLeEJ9rrCtENOXhd92NmW4Cmiv3rZyo15HhJfK5f2hJkzdIf8dWgWOhr/YEuVcCqUWnzbTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=ylVMaZtV; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1752694946; bh=Pw1fBsv5/TECiWrU0V6LsQwsUBawWDhGo6/SS9Wf7zo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ylVMaZtVIVVxtiHibKwBdHuJo51ETftah3+pTgLa5GYZznGt01W6s1+Nuv8au7AjZ
	 Z5gl7LuPDtR7FNNBiOF6E8xVYUYkXKgJS4Uqz0BA2815O2t9gx5Wh2fajPpVp0biES
	 7uvth2RvhoqRIM+aeIAuBb8QLQBK0SoznmiuuwIk=
Received: from [192.168.178.20] (53.206.40.145.ftth.as8758.net [145.40.206.53])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id EE21020513AF;
	Wed, 16 Jul 2025 21:42:25 +0200 (CEST)
Message-ID: <5ac8d7e3-d778-4ef8-a7d7-1296ffda5dae@ralfj.de>
Date: Wed, 16 Jul 2025 21:42:25 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
 linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
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
 <4d373b56-0f36-4f8a-9052-cee38b90f59b@ralfj.de> <aHZyC4xr7jgN6Mgv@Mac.home>
 <371882d2-3c31-4c5f-a12f-22945027ee33@ralfj.de> <aHZ6Rp4qdCXUoIZy@Mac.home>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <aHZ6Rp4qdCXUoIZy@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Boqun,

On 15.07.25 17:56, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 05:35:47PM +0200, Ralf Jung wrote:
>> Hi all,
>>
>> On 15.07.25 17:21, Boqun Feng wrote:
>>> On Mon, Jul 14, 2025 at 05:42:39PM +0200, Ralf Jung wrote:
>>>> Hi all,
>>>>
>>>> On 11.07.25 20:20, Boqun Feng wrote:
>>>>> On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
>>>>>> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>>>>>>> diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..df4015221503
>>>>>>> --- /dev/null
>>>>>>> +++ b/rust/kernel/sync/barrier.rs
>>>>>>> @@ -0,0 +1,65 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>> +
>>>>>>> +//! Memory barriers.
>>>>>>> +//!
>>>>>>> +//! These primitives have the same semantics as their C counterparts: and the precise definitions
>>>>>>> +//! of semantics can be found at [`LKMM`].
>>>>>>> +//!
>>>>>>> +//! [`LKMM`]: srctree/tools/memory-model/
>>>>>>> +
>>>>>>> +/// A compiler barrier.
>>>>>>> +///
>>>>>>> +/// A barrier that prevents compiler from reordering memory accesses across the barrier.
>>>>>>> +pub(crate) fn barrier() {
>>>>>>> +    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
>>>>>>> +    // it suffices as a compiler barrier.
>>>>>>
>>>>>> I don't know about this, but it also isn't my area of expertise... I
>>>>>> think I heard Ralf talk about this at Rust Week, but I don't remember...
>>>>>>
>>>>>
>>>>> Easy, let's Cc Ralf ;-)
>>>>>
>>>>> Ralf, I believe the question here is:
>>>>>
>>>>> In kernel C, we define a compiler barrier (barrier()), which is
>>>>> implemented as:
>>>>>
>>>>> # define barrier() __asm__ __volatile__("": : :"memory")
>>>>>
>>>>> Now we want to have a Rust version, and I think an empty `asm!()` should
>>>>> be enough as an equivalent as a barrier() in C, because an empty
>>>>> `asm!()` in Rust implies "memory" as the clobber:
>>>>>
>>>>> 	https://godbolt.org/z/3z3fnWYjs
>>>>>
>>>>> ?
>>>>>
>>>>> I know you have some opinions on C++ compiler_fence() [1]. But in LKMM,
>>>>> barrier() and other barriers work for all memory accesses not just
>>>>> atomics, so the problem "So, if your program contains no atomic
>>>>> accesses, but some atomic fences, those fences do nothing." doesn't
>>>>> exist for us. And our barrier() is strictly weaker than other barriers.
>>>>>
>>>>> And based on my understanding of the consensus on Rust vs LKMM, "do
>>>>> whatever kernel C does and rely on whatever kernel C relies" is the
>>>>> general suggestion, so I think an empty `asm!()` works here. Of course
>>>>> if in practice, we find an issue, I'm happy to look for solutions ;-)
>>>>>
>>>>> Thoughts?
>>>>>
>>>>> [1]: https://github.com/rust-lang/unsafe-code-guidelines/issues/347
>>>>
>>>> If I understood correctly, this is about using "compiler barriers" to order
>>>> volatile accesses that the LKMM uses in lieu of atomic accesses?
>>>> I can't give a principled answer here, unfortunately -- as you know, the
>>>> mapping of LKMM through the compiler isn't really in a state where we can
>>>> make principled formal statements. And making principled formal statements
>>>> is my main expertise so I am a bit out of my depth here. ;)
>>>>
>>>
>>> Understood ;-)
>>>
>>>> So I agree with your 2nd paragraph: I would say just like the fact that you
>>>> are using volatile accesses in the first place, this falls under "do
>>>> whatever the C code does, it shouldn't be any more broken in Rust than it is
>>>> in C".
>>>>
>>>> However, saying that it in general "prevents reordering all memory accesses"
>>>> is unlikely to be fully correct -- if the compiler can prove that the inline
>>>> asm block could not possibly have access to a local variable (e.g. because
>>>> it never had its address taken), its accesses can still be reordered. This
>>>> applies both to C compilers and Rust compilers. Extra annotations such as
>>>> `noalias` (or `restrict` in C) can also give rise to reorderings around
>>>> arbitrary code, including such barriers. This is not a problem for
>>>> concurrent code since it would anyway be wrong to claim that some pointer
>>>> doesn't have aliases when it is accessed by multiple threads, but it shows
>>>
>>> Right, it shouldn't be a problem for most of the concurrent code, and
>>> thank you for bringing this up. I believe we can rely on the barrier
>>> behavior if the memory accesses on both sides are done via aliased
>>> references/pointers, which should be the same as C code relies on.
>>>
>>> One thing though is we don't use much of `restrict` in kernel C, so I
>>> wonder the compiler's behavior in the following code:
>>>
>>>       let mut x = KBox::new_uninit(GFP_KERNEL)?;
>>>       // ^ KBox is our own Box implementation based on kmalloc(), and it
>>>       // accepts a flag in new*() functions for different allocation
>>>       // behavior (can sleep or not, etc), of course we want it to behave
>>>       // like an std Box in term of aliasing.
>>>
>>>       let x = KBox::write(x, foo); // A
>>>
>>>       smp_mb():
>>>         // using Rust asm!() for explanation, it's really implemented in
>>>         // C.
>>>         asm!("mfence");
>>>
>>>       let a: &Atomic<*mut Foo> = ...; // `a` was null initially.
>>>
>>>       a.store(KBox::into_raw(x), Relaxed); // B
>>>
>>> Now we obviously want A and B to be ordered, because smp_mb() is
>>> supposed to be stronger than Release ordering. So if another thread does
>>> an Acquire read or uses address dependency:
>>>
>>>       let a: &Atomic<*mut Foo> = ...;
>>>       let foo_ptr = a.load(Acquire); // or load(Relaxed);
>>>
>>>       if !foo_ptr.is_null() {
>>>           let y: KBox<Foo> = unsafe { KBox::from_raw(foo_ptr) };
>>> 	// ^ this should be safe.
>>>       }
>>>
>>> Is it something Rust AM could guarantee?
>>
>> If we pretend these are normal Rust atomics, and we look at the acquire
>> read, then yeah that should work -- the asm block can act like a release
>> fence. With the LKMM, it's not a "guarantee" in the same sense any more
>> since it lacks the formal foundations, but "it shouldn't be worse than in
>> C".
> 
>>
>> The Rust/C/C++ memory models do not allow that last example with a relaxed
>> load and an address dependency. In C/C++ this requires "consume", which Rust
> 
> Sorry I wasn't clear, of course I wasn't going to start a discussion
> about address dependency and formal guarantee about it ;-)
> 
> What I meant was the "prevent reordering A and B because of the asm!()"
> at the release side, because normally we won't use a restrict pointer to
> a kmalloc() result, so I'm curious whether Box make the behavior
> different:
> 
>      let mut b = Box::new_uninit(...);
>      let b = Box::write(b, ...); // <- this is a write done via noalias
>      asm!(...);
>      a.store(Box::from_raw(b), Relaxed);
> 
> But looks like we can just model the asm() as a Rust release fence, so
> it should work. Thanks!

Yeah... this is actually a subtle case and there are some adjacent compiler bugs 
(when doing the same with local variables, not Box), but those are bugs (and 
they affect both C and Rust).

Kind regards,
Ralf


