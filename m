Return-Path: <linux-arch+bounces-12653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2CB015BA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82CC3B62AC
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE419233714;
	Fri, 11 Jul 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaT0U+td"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9811A5B99;
	Fri, 11 Jul 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221724; cv=none; b=Xt76YNvXt+V38PvHBFdlZo/vvMjbLDkvkRk3Twk4sHaT9L1Xh4qcS5aFcmuerYUMC0Pf3vPvxP9home2Gi4qmm2jcW3GVxNcfk27Qz9REoyCLOAmJu07RS70eZAZNN3zcsWqnhwGYIg+rnOB9xG4IYqs+N7hWNQZ8J0LwcPhQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221724; c=relaxed/simple;
	bh=MdlvamzqR242whEfiL7qVmBGWnd92BiQRP9xljkyRVM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GZbG++adxwrpVDSSB/02O1qpPGK1C87QLA7/YCFK3suVY5KoKqNOV87eEDCG5ODZ+DejDk8SJ9aqR2oeGnDt32VQqEd27MCuBp99NlowsAxkUk6xye9E6UBa1u1nYcwH3l3/xLuwFLvuOwSYCc2a+iGlq0JuFwd0IuNSRnxmRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaT0U+td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE862C4CEED;
	Fri, 11 Jul 2025 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752221724;
	bh=MdlvamzqR242whEfiL7qVmBGWnd92BiQRP9xljkyRVM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=EaT0U+tdfBpDCGPtDKQKdvVxcnrOIpjzTJm6UEmUMwxPR2XaFzGbkho3DtsJiyVTE
	 cGaqFt/OK9b6VCrYwDdnDP3zkp7gwJ1bX+EjCR2O2CXzyWOTep5jxW5VsIFtJtxXke
	 cH6y6yNVvN7mI2i9p9LlBn2/oHL4NAcw7iqZeSpG7LkgaPI56GCumaWaXAp+oigRe1
	 AZMcI4sfIKLIdgIaKgt9QacVKuswGoRHEp8q+mPB5nccOmV3wtMn8xZCk9tS4xo4lp
	 ioW572vK21Ju30YwMY7mFXKhDvlb4noC7g47iYREbargre8QWKEvxZfz0d/cTnlXjm
	 OaJAX7i6xWXhQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:15:17 +0200
Message-Id: <DB92RCJX0C6E.352SUWSV7VBE9@kernel.org>
Subject: Re: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping
 framework
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
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
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-3-boqun.feng@gmail.com>
 <DB8BQGJNFDAY.BGQ8CZSFFOLH@kernel.org> <aG_Yah5FFHcA3IZy@Mac.home>
 <DB8HQLY48DFX.3PBBUTQLV14PC@kernel.org> <aG_nT3H8J-h2qwr5@Mac.home>
 <DB8MAQC4V57F.1GGYO1PNPOV2X@kernel.org> <aHAiqhPe5OwVioUe@tardis-2.local>
In-Reply-To: <aHAiqhPe5OwVioUe@tardis-2.local>

On Thu Jul 10, 2025 at 10:29 PM CEST, Boqun Feng wrote:
> On Thu, Jul 10, 2025 at 09:21:17PM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 6:16 PM CEST, Boqun Feng wrote:
>> > At least the rustdoc has safety section for each function. ;-)
>>=20
>> I don't usually use rustdoc to read function safety sections. Instead I
>> jump to their definition and read the code.
>>=20
>
> Understood. It's probalby the first time we use macros to generate a few
> unsafe functions, so this is something new.
>
> But let me ask you a question, as a programmer yourself, when you run
> into a code base, and see something repeat in a similar pattern for 10+
> times, what's your instinct? You would try to combine the them together,
> right? That's why duplication seems not compelling to me. But surely, we
> don't need to draw conclusion right now, however that's my opinion.

It all depends, if the definition never changes for a long time, I don't
mind the duplication. It's probably more effort to write macros to then
have less overall code.

It also makes it harder to read especially wrt safety docs. So if you
think you will have to make constant tweaks & additions to these, then
we should go a macro-heavy route. But if not, then I think making it
more readable is the way to go.

---
Cheers,
Benno

