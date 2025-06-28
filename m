Return-Path: <linux-arch+bounces-12496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D80AEC5B7
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560644A0752
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B81E0DCB;
	Sat, 28 Jun 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAF4n3AX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49B23A9;
	Sat, 28 Jun 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751097641; cv=none; b=BEv2qRKBVkSKtDoTCI6KnjM55PuKhxh7ysvc/frVSAPpkBo96XO5458SWaTejxJEioicNyFzzDJGJkof+dRQv8mE/fBoP6sZQN3/eB1fHF/AusE7zdIVLlJ6alx86v/uZDmJGoc6HvkZv4i1kXM1+51cGgg/Nz8+0UX0CL+eMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751097641; c=relaxed/simple;
	bh=XHtWMoAtS1LGv/FF36seqsY50O+Rw+GG7ZY39xJfB7g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MpAm/KoWHGk6IcO2T4OYskYpRdrDOn10FOHZRUEJobepyPY5SrTxESp3bBCpSEiZ/fut9Zlpp6DJjW2x73+oVVLh1AOtgNFWzeyKd8/idjfwRMmKgMGn59Vomsn/x28Q5ASwLI8oXLxCaTNhVeSiV2qma2WFw2BJB3Oy7bpNvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAF4n3AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876C0C4CEEA;
	Sat, 28 Jun 2025 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751097641;
	bh=XHtWMoAtS1LGv/FF36seqsY50O+Rw+GG7ZY39xJfB7g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iAF4n3AXF0Hxsf06MUC2Zzswq+cT3e/t1KK7xxrMOufjcx1DJH+/e+znhQ7+Mqz1c
	 wNwiGWs9MTAau8bxX2XCK0uk8pyfL2/ut8HLBfeLLriasA1YzrLJYfqLhRKnPk1dMW
	 DUfCx4YXJFpKBcp2YskrrIUgPCN5tyCLKvjCn/UN+NeUfbncoIJh2n+BfFlukermBd
	 bJjDDvS78buDsd9MC2v0oZHYph1JcneuFfXml9dC87+6uNXjKCE+n9Zdy9+/gglWHe
	 mxU4BAJY5m4dSe54sKTwVil4J06QdRvCfTX8/Rfntr4TAWuQZJnctX4kaxz78AAM1t
	 QYE1/jIxliQhw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 10:00:34 +0200
Message-Id: <DAY0AZXDTCD3.OAWZ91IQJT2Q@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude Paul" <lyude@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org> <aF6iXB6wiHcpAKIU@Mac.home>
 <DAXY0EJHHDWM.1KRSSJLOTCZ8F@kernel.org> <aF-aS5FLX7QIiiPa@Mac.home>
In-Reply-To: <aF-aS5FLX7QIiiPa@Mac.home>

On Sat Jun 28, 2025 at 9:31 AM CEST, Boqun Feng wrote:
> On Sat, Jun 28, 2025 at 08:12:42AM +0200, Benno Lossin wrote:
>> On Fri Jun 27, 2025 at 3:53 PM CEST, Boqun Feng wrote:
>> > As for naming, the reason I choose xchg() and cmpxchg() is because the=
y
>> > are the name LKMM uses for a long time, to use another name, we have t=
o
>> > have a very good reason to do so and I don't see a good reason
>> > that the other names are better, especially, in our memory model, we u=
se
>> > xchg() and cmpxchg() a lot, and they are different than Rust version
>> > where you can specify orderings separately. Naming LKMM xchg()/cmpxchg=
()
>> > would cause more confusion I believe.
>>=20
>> I'm just not used to the name shortening from the kernel... I think it's
>
> I guess it's a bit curse of knowledge from my side...
>
>> fine to use them especially since the ordering parameters differ from
>> std's atomics.
>>=20
>> Can you add aliases for the Rust names?
>>=20
>
> I can, but I also want to see a real user request ;-) As a bi-model user
> myself, I generally don't mind the name, as you can see C++ and Rust use
> different names as well, what I usually do is just "tell me what's the
> name of the function if I need to do this" ;-)

I think learning Rust in the kernel is different from learning a new
language. Yes you're learning a specific dialect of Rust, but that's
what every project does.

You also added aliases for the C versions, so let's also add the Rust
ones :)

>> >> Don't I need `Acquire` semantics on the read in order for
>> >> `compare_exchange` to give me the correct behavior in this example:
>> >>=20
>> >>     pub struct Foo {
>> >>         data: Atomic<u64>,
>> >>         new: Atomic<bool>,
>> >>         ready: Atomic<bool>,
>> >>     }
>> >>=20
>> >>     impl Foo {
>> >>         pub fn new() -> Self {
>> >>             Self {
>> >>                 data: Atomic::new(0),
>> >>                 new: Atomic::new(false),
>> >>                 ready: Atomic::new(false),
>> >>             }
>> >>         }
>> >>=20
>> >>         pub fn get(&self) -> Option<u64> {
>> >>             if self.new.compare_exchange(true, false, Release).is_ok(=
) {
>> >
>> > You should use `Full` if you want AcqRel-like behavior when succeed.
>>=20
>> I think it would be pretty valuable to document this. Also any other
>> "direct" translations from the Rust memory model are useful. For example
>
> I don't disagree. But I'm afraid it'll still a learning process for
> everyone. Usually as a kernel developer, when working on concurrent
> code, the thought process is not 1) "write it in Rust/C++ memory model"
> and then 2) "translate to LKMM atomics", it's usually just write
> directly because already learned patterns from kernel code.

That's fair. Maybe just me clinging to the only straw that I have :)

(it also isn't a good straw, I barely know my way around the atomics in
std :)

> So while I'm confident that I can answer any translation question you
> come up with, but I don't have a full list yet.
>
> Also I don't know whether it's worth doing, because of the thought
> process thing I mentioned above.

Yeah makes sense.

> My sincere suggestion to anyone who wants to do concurrent programming
> in kernel is just "learn the LKMM" (or "use a lock" ;-)). There are good
> learning materials in LWN, also you can check out the
> tools/memory-model/ for the model, documentation and tools.

I'm luckily not in the position of having to use atomics for anything :)

> Either you are familiar with a few concepts in memory model areas, or
> you have learned the LKMM, otherwise I'm afraid there's no short-cut for
> one to pick up LKMM atomics correctly and precisely with a few
> translation rules from Rust native atomics.
>
> The other thing to note is that there could be multiple "translations",
> for example for this particular case, we can also do:
>
>     pub fn get(&self) -> Option<u64> {
> 	if self.new.cmpxchg(true, false, Release).is_ok() {
> 	    smp_mb(); // Ordering the load part of cmpxchg() with the
> 	              // following memory accesses, i.e. providing at
> 		      // least the Acquire ordering.
> 	    let val =3D self.data.load(Acquire);
> 	    self.ready.store(false, Release);
> 	} else {
> 	    None
> 	}
>     }
>
> So whatever the document is, it might not be accurate/complete, and
> might be misleading.

Yeah.

>> is `SeqCst` "equivalent" to `Full`?
>
> No ;-) How many hours do you have? (It's a figurative question, I
> probably need to go to sleep now ;-)) For example, `SeqCst` on atomic
> read-modify-write operations maps to acquire+release atomics on ARM64 I
> believe, but a `Full` atomic is acquire+release plus a full memory
> barrier on ARM64. Also a `Full` atomic implies a full memory barrier
> (smp_mb()), but a `SeqCst` atomic is not a `SeqCst` fence.

Thanks for the quick explanation, I would have been satisfied with "No"
:)

---
Cheers,
Benno

