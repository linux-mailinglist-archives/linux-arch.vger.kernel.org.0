Return-Path: <linux-arch+bounces-12518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F4AEE30F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604BD3BEBA8
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014128DF48;
	Mon, 30 Jun 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5WXWCDO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96B282FA;
	Mon, 30 Jun 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298632; cv=none; b=tAZZj2fOqXOP5965E1rHOEl41IDbvN8P6+8n8gbixtq6qyGMNjVt6QiHt7z3g+gN61XqV2HJVwLeD8t2q4zKqDAeJoFFGSDj6gXAM2Ng9ZU7RJTbw119ELFs8shu6SY1R/hGmBRm9733YJ58Ym0Qsu7Eupe2P0yLHgttoWO0DTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298632; c=relaxed/simple;
	bh=CSJUGiOUWxP2VkzX3WWdpnoHSgKS/uHYmWqXozPe0A0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mvWJEY9f8mjCRm4VZQfZ5Zt1yej4AgaJjCZLeeWSqYwJKR55oHLeocLhmU6VUxh2bD2IIS5TAiUnuFzpVIBiUIMZiJbsCCpQxI1m6q6N9I2O1CZsiFr21C9GpJUIsiOMGDHWiSR8kt0PPtEoUWZPyf+zWPC1ToPPnatlqfWFQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5WXWCDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249C5C4CEEF;
	Mon, 30 Jun 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751298631;
	bh=CSJUGiOUWxP2VkzX3WWdpnoHSgKS/uHYmWqXozPe0A0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=O5WXWCDOFT9xSP7EWEdwiqrP7Z9E9l7zGxZxfrkYT5GuEWMZPY0D7Ldowf8OJqyIb
	 pee1VEGR+F7Yl8GfOU5CLvIK+oyEz1snVp2S7fYvF8jcGwWh+8Hsh5ESbwzvyTjJr6
	 6pw91zZp2zLnTb+y46ZGqVFt5zyKefQIFBSAkkmE/bLwgse+N83rMhCFGmfWsYXVL+
	 QOqRftCDjuhmLkSDpEHipp32Qez57uoD1gw5m4DJMagYFWrrMqaUrzkqHYoKfcbmpb
	 YNyPglDh9s1heE/I37Z3h3k4d2gghSx9mKKb+JDiVJSpGueo33Z/JgCOfZJt70ZNxx
	 dfvIogoTSVm5Q==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jun 2025 17:50:25 +0200
Message-Id: <DAZZJTOR5N3G.1ZC2DWWPP2YM5@kernel.org>
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
 <DAY0AZXDTCD3.OAWZ91IQJT2Q@kernel.org> <aGKsHZ0saC-XkQlA@tardis-2.local>
In-Reply-To: <aGKsHZ0saC-XkQlA@tardis-2.local>

On Mon Jun 30, 2025 at 5:24 PM CEST, Boqun Feng wrote:
> On Sat, Jun 28, 2025 at 10:00:34AM +0200, Benno Lossin wrote:
>> On Sat Jun 28, 2025 at 9:31 AM CEST, Boqun Feng wrote:
>> > On Sat, Jun 28, 2025 at 08:12:42AM +0200, Benno Lossin wrote:
>> >> On Fri Jun 27, 2025 at 3:53 PM CEST, Boqun Feng wrote:
>> >> > As for naming, the reason I choose xchg() and cmpxchg() is because =
they
>> >> > are the name LKMM uses for a long time, to use another name, we hav=
e to
>> >> > have a very good reason to do so and I don't see a good reason
>> >> > that the other names are better, especially, in our memory model, w=
e use
>> >> > xchg() and cmpxchg() a lot, and they are different than Rust versio=
n
>> >> > where you can specify orderings separately. Naming LKMM xchg()/cmpx=
chg()
>> >> > would cause more confusion I believe.
>> >>=20
>> >> I'm just not used to the name shortening from the kernel... I think i=
t's
>> >
>> > I guess it's a bit curse of knowledge from my side...
>> >
>> >> fine to use them especially since the ordering parameters differ from
>> >> std's atomics.
>> >>=20
>> >> Can you add aliases for the Rust names?
>> >>=20
>> >
>> > I can, but I also want to see a real user request ;-) As a bi-model us=
er
>> > myself, I generally don't mind the name, as you can see C++ and Rust u=
se
>> > different names as well, what I usually do is just "tell me what's the
>> > name of the function if I need to do this" ;-)
>>=20
>> I think learning Rust in the kernel is different from learning a new
>> language. Yes you're learning a specific dialect of Rust, but that's
>> what every project does.
>>=20
>> You also added aliases for the C versions, so let's also add the Rust
>> ones :)
>>=20
>
> Make senses, so added:
>
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -310,7 +310,7 @@ impl<T: AllowAtomic> Atomic<T>
>      /// assert_eq!(42, x.xchg(52, Acquire));
>      /// assert_eq!(52, x.load(Relaxed));
>      /// ```
> -    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> +    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
>      #[inline(always)]
>      pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
>          let v =3D T::into_repr(v);
> @@ -382,6 +382,7 @@ pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) =
-> T {
>          "atomic64_cmpxchg",
>          "atomic_try_cmpxchg",
>          "atomic64_try_cmpxchg"
> +        "compare_exchange"
>      ))]
>      #[inline(always)]
>      pub fn cmpxchg<Ordering: Any>(&self, mut old: T, new: T, o: Ordering=
) -> Result<T, T> {
>
> Seems good?

Yeah, thanks!

---
Cheers,
Benno

