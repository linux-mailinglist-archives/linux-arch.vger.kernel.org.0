Return-Path: <linux-arch+bounces-12505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B1AAED919
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBAB1897052
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1AB24A044;
	Mon, 30 Jun 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE7GnNve"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4F248F71;
	Mon, 30 Jun 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277286; cv=none; b=rphym/U65CbAx7JlqgzVJBbT4M9Gcrw20lArjBNmz7gUinTpl+lE2FMJOBwqER2k28aIm3mFJ/xYNlaU8LPHH3tIuN3ZxuX9bTDa+v8EqgXJEBkpLuhXkWBubo0vZnF7XboOSGug0XzVjNUJ1Xt98siX0DQK2eI1DOlAQbelHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277286; c=relaxed/simple;
	bh=WIDUvS7JkY3GNFQTSjGce34RpeCHS2xzEDHzrQxx0nY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xc7Obp6ELLs4/y6cpCmdh7wts57jvNnXnB2t5Y5GGCYhCy8Hz8uuMFgmu1aeyBK2vSH9uMNM9K9BVhFnR5xIy22bzw7+/JHFPDTNjTh716Bl2AQ/5emNXN2oTqNIQKl/0vGBBrygUKC6ae49undoza8DViwSh2wNNc2V9+l1dYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE7GnNve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D2FC4CEEB;
	Mon, 30 Jun 2025 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751277286;
	bh=WIDUvS7JkY3GNFQTSjGce34RpeCHS2xzEDHzrQxx0nY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hE7GnNveBwjT+D7CEFtAVW3o91xUIPk56n2r99qz7K+QtQ21aLpMTVDvrbAp0wW/o
	 xW8dXbKz8cNkuz9ncs7Y1t3TpcNkh/mYGKjbEvXfgWP9sXZl0Wt0xXZSKodesR0IyI
	 AXYQz54vQ2mAAd18ZrCGx1Z0pLgIMZ00Hr3yx/z/R+UFJ62pMZ9HQ8fZD3wPKlE3zR
	 3V7DLNPxsUs76lI/1UA67LE5wK4Gmirr0SW0trcIcdEUqohzpro7FhfXD83c2S4MEZ
	 TT9O3JTjCYADcpICUsYbGrCXVwq/x/MrHLTy2b0Fn7GcZY+Mov9j9MP8LwzMWWBAeT
	 X4yVDygFcNgQQ==
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
Subject: Re: [PATCH v5 10/10] rust: sync: Add memory barriers
In-Reply-To: <aF9krO0nVjN0yoEC@Mac.home> (Boqun Feng's message of "Fri, 27 Jun
	2025 20:42:36 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<A-SZkzm2EzwbPsG5Vm5qfT1BIGijzoQ7zQI6ExgXZbSXf8ZfIMw6fe-Z7xWgvKnr0BPylikGRuhEfiKfXx5xTw==@protonmail.internalid>
	<20250618164934.19817-11-boqun.feng@gmail.com> <874iw2zkti.fsf@kernel.org>
	<epLSBAaTAfRuG5Eb6xqY9vkhnj_hJxwcYvQZw9WGNvxU3Z861O5w58L0rz3s4fq1u5FEYdFkXywUmLVmkp4gvg==@protonmail.internalid>
	<aF9krO0nVjN0yoEC@Mac.home>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 30 Jun 2025 11:54:37 +0200
Message-ID: <87ecv1zh9e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Thu, Jun 26, 2025 at 03:36:25PM +0200, Andreas Hindborg wrote:
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
> [...]
>> > +//! [`LKMM`]: srctree/tools/memory-mode/
>>
>> Typo in link target.
>>
>> > +
>> > +/// A compiler barrier.
>> > +///
>> > +/// An explicic compiler barrier function that prevents the compiler =
from moving the memory
>> > +/// accesses either side of it to the other side.
>>
>> Typo in "explicit".
>>
>
> Fixed.
>
>> How about:
>>
>>   A compiler barrier. Prevents the compiler from reordering
>>   memory access instructions across the barrier.
>>
>>
>> > +pub(crate) fn barrier() {
>> > +    // By default, Rust inline asms are treated as being able to acce=
ss any memory or flags, hence
>> > +    // it suffices as a compiler barrier.
>> > +    //
>> > +    // SAFETY: An empty asm block should be safe.
>> > +    unsafe {
>> > +        core::arch::asm!("");
>> > +    }
>> > +}
>> > +
>> > +/// A full memory barrier.
>> > +///
>> > +/// A barrier function that prevents both the compiler and the CPU fr=
om moving the memory accesses
>> > +/// either side of it to the other side.
>>
>>
>>   A barrier that prevents compiler and CPU from reordering memory access
>>   instructions across the barrier.
>>
>> > +pub fn smp_mb() {
>> > +    if cfg!(CONFIG_SMP) {
>> > +        // SAFETY: `smp_mb()` is safe to call.
>> > +        unsafe {
>> > +            bindings::smp_mb();
>> > +        }
>> > +    } else {
>> > +        barrier();
>> > +    }
>> > +}
>> > +
>> > +/// A write-write memory barrier.
>> > +///
>> > +/// A barrier function that prevents both the compiler and the CPU fr=
om moving the memory write
>> > +/// accesses either side of it to the other side.
>>
>>   A barrier that prevents compiler and CPU from reordering memory write
>>   instructions across the barrier.
>>
>> > +pub fn smp_wmb() {
>> > +    if cfg!(CONFIG_SMP) {
>> > +        // SAFETY: `smp_wmb()` is safe to call.
>> > +        unsafe {
>> > +            bindings::smp_wmb();
>> > +        }
>> > +    } else {
>> > +        barrier();
>> > +    }
>> > +}
>> > +
>> > +/// A read-read memory barrier.
>> > +///
>> > +/// A barrier function that prevents both the compiler and the CPU fr=
om moving the memory read
>> > +/// accesses either side of it to the other side.
>>
>>   A barrier that prevents compiler and CPU from reordering memory read
>>   instructions across the barrier.
>>
>
> These are good wording, except that I will use "memory (read/write)
> accesses" instead of "memory (read/write) instructions" because:
>
> 1) "instructions" are at lower level than the language, and memory
>    barriers function are provided as synchonization primitives, so I
>    feel we should describe memory barrier effects at language level,
>    i.e. mention how it would interact with objects and accesses to them.
>
> 2) There are instructions can do read and write in one instruction, it
>    might be unclear when we say "prevents reordering an instruction"
>    whether both parts are included, for example:
>
>    r1 =3D atomic_add(x, 1); // <- this can be one instruction.
>    smp_rmb();
>    r2 =3D atomic_read(y);
>
>    people may think because the smp_rmb() prevents read instructions
>    reordering, and atomic_add() is one instruction in this case,
>    smp_rmb() can prevents the write part of that instruction from
>    reordering, but that's not the case.
>
>
> So I will do:
>
>    A barrier that prevents compiler and CPU from reordering memory read
>    accesses across the barrier.

Right, that makes sense =F0=9F=91=8D


Best regards,
Andreas Hindborg




