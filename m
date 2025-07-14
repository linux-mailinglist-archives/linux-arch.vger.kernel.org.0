Return-Path: <linux-arch+bounces-12742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA1B041AC
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2491176D18
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B114A60F;
	Mon, 14 Jul 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLVa3aKN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948F1922F4;
	Mon, 14 Jul 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503438; cv=none; b=hufubiH3FCAiVNKSpJR+mNZ8p9sVCm3peW7xYsWaLzEieP+z8eZ+PsisCF9Zik+5cmmIxazy7fJuE2Td1fwwdSadHaDdzg7LpONrDGOIVz5xOY5Ya0LRXW0geBgnX5+XdDa7/pMwy0oht7J3rl0T6p2dys48UzTOMV0X681gcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503438; c=relaxed/simple;
	bh=sFtKmdPe3yM1e81VjhNJm4orvucz96RczzN9REg2yBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu+CLHgAzvRSWSC+sAHT0OOTIO+3MACT4sCEKE7jEeMLQTwVUBODnjek38jgDn2SYcO7qLQN6vrWtVrl6eEo/FRblpar4zQ+jobiTXObfr9MhRwFd88rCRCcF0XUJYFifodt5MROIQ3uWqiIuQJ5w2o8OQYLNvkSdMakzRSsaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLVa3aKN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7df981428abso467078985a.1;
        Mon, 14 Jul 2025 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752503435; x=1753108235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rc1Y+pmzpiPQHIuTeXg8gdbq5HQwcIQr312n6KM6r8=;
        b=PLVa3aKNHGiLyiCCE9WK9mzXBYBDy/L3fYyyZKnZJqVIdBwejX7wkUdsnQbKRBvs8h
         opGFMzD5yQ6CGbkPgFauDr82vkPT0/02JX//av32fteLqwekB71O9EYRWMuUxvIBw/vz
         jnmFwCQkqFuL7F4cKwi9FS7vH+sod3H5ndu+e1LO7+F5Ma/CpTEN7Qh5HGSmstT9P2hD
         vUD0M7sBOMoT9D9BwPDBWDX84vBGMa0P0Evrq06V9m2jkMcwmDWtXoVR5wgAB3BffiI3
         W6iKQngfPkeBfUJXeWZ3eD3TZgtGMfTpyjZ4hWKjItnILal/5uGtndUsCzMMLZ7lyxVc
         wQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503435; x=1753108235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rc1Y+pmzpiPQHIuTeXg8gdbq5HQwcIQr312n6KM6r8=;
        b=tYIhobUpTdS77n2aYvqWK0eXARZxLcp9u6kuooEFg/oZJPxdv7p6p1x0A+1+0zPdH2
         RevXajPXvZMVSZY/ghlI76/RyPJpCi4/qJLQaMuoh9sXjkkEx6RVVhLb/ixs96eZvVvN
         IzVriLv0StuHPOwKjA/6Vhy8Ru+Y6nK8faWHbgkGER2iRuXeH4GBEEtTO+/NttkAwAXE
         CxDAsw8LKgeF6SxI+Taz34HxMI996L4iOpVpEzwoaTQ0sicd9A4PIP0Y2R1pJTwpPErx
         age6EJira7M311ANXJkEyw8fSwdTi5MJIrOvlFM2dXqsPkzedlJeEXAThFctRPNhfleX
         GJuw==
X-Forwarded-Encrypted: i=1; AJvYcCUrWV6PulPDNMQ2X/BdIFVSAVchGXCkG24vvDxf/DoXuOnM2pioiP14GecLvdXJzN1oEUrlOsDdbUIhx1oqvXU=@vger.kernel.org, AJvYcCX5hQY8QQ1PJJ5mUAPmLZPIcrkQhn/NasTVjQvAg0Znu6tv0YT1sMU/zxNqMNqsIgSJndxcjiygC00R@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzTiVFLwHi9F2V33iCqMt9xjfoL27i1uZJQUMx/FA7gAlowi2
	gXOnkHbshO3wEuLyZokyjzWu1pG4AvAHmTWh1fGTx7PA2MINjc/mUZbv
X-Gm-Gg: ASbGncvUw3WABa9Gp99pqEtCT2NjoJTC51lMKP+sG/ack0Fw3bbYs3wws2tabiVUrVj
	P/fhPnnQbsByasMa1djPufjvz4CIsEDzs+pruAVVTRaYmWnRlQ9z4UEDM9mboynbzFykBEVJ7nr
	8xN7H+jNZ3yPg3PQuXtRZWzA+JmI/bwy7d++BlNrPxMBUz1JUv2GzksQVYaslFMbTu/vithamd5
	ruM/lAIWhxYwOjsU+dZ6lRekJsDu3S0X/kEBCkmFd5DpiA876ihVMIyz8cKRx1Sk70ja0WiPNsm
	GWMNyIRhYT2O5znmPZMm94dCaLM3nzSqAJMql2QqmiJSGj1P4/zEsqn8unPRT7rT5cRJspkjAnq
	zLB55I1zwDoO3hJJG9W3/fW1EHDjROj2ZCME0eulnY6+WIUPkT56tfgwhwbF6fhxEj8+m7ID7Xe
	veK069dYdCsPkT
X-Google-Smtp-Source: AGHT+IF0pbXsZLq0snH0wnmLL5ls49lFxGDEqoVsSMvAY9S8YD2h69gdmg5fta+/VfYNmQm3T0yudA==
X-Received: by 2002:a05:620a:a10c:b0:7d4:2868:89ea with SMTP id af79cd13be357-7dde9d4b5c7mr2023428385a.4.1752503435233;
        Mon, 14 Jul 2025 07:30:35 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e32b48255esm101836385a.97.2025.07.14.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:30:34 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 060ABF40069;
	Mon, 14 Jul 2025 10:30:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 14 Jul 2025 10:30:34 -0400
X-ME-Sender: <xms:iRR1aOZzmEGMwvq2uJb8XUtPw9mtTqD7Jih499gVA-lzsHxQBqe0CA>
    <xme:iRR1aC5m43tKLj_ZorwYBPEQGrVvjQplpwchY9k8-wTv2nJZOAZzBIuwnkyZI1hL0
    yabrxYWOh97UXnrFw>
X-ME-Received: <xmr:iRR1aNg0F2haNx-8k9GhJ4P7lnCmBqpfo222zAuDHnTKRqydl_352yz57Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefhheeukedtvefhtedtvdetvedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iRR1aAI6bdb5j9SlrqJR1GEBCp-THjl-WOmFtlN8OZsPKc327nareQ>
    <xmx:iRR1aHrWblwNl_cd-hb--sq-LQY2w0Rk_FmoRlSmnMbW-U2xFxADSA>
    <xmx:iRR1aGwE__1ZTP_dHaNsJNJU5-dyAbl9D_7kS7pmwtkHgK3tHc3N7Q>
    <xmx:iRR1aLfzzk5h2QRjAjFW1hCKTvRmAB1sKfgI-foyi6LnL1BXyKKIWQ>
    <xmx:iRR1aCcQdtkXu3U5pqJyjfBCKvgm73QV-IdmlfGmKCh-2qWURALUR-nM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 10:30:33 -0400 (EDT)
Date: Mon, 14 Jul 2025 07:30:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHUUiIHbJaCltawK@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org>
 <aHUSgXW9A6LzjBIS@Mac.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUSgXW9A6LzjBIS@Mac.home>

On Mon, Jul 14, 2025 at 07:21:53AM -0700, Boqun Feng wrote:
> On Mon, Jul 14, 2025 at 12:30:12PM +0200, Benno Lossin wrote:
> > On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> > > To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> > > added, currently `T` needs to be Send + Copy because these are the
> > > straightforward usages and all basic types support this.
> > >
> > > Implement `AllowAtomic` for `i32` and `i64`, and so far only basic
> > > operations load() and store() are introduced.
> > >
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  rust/kernel/sync/atomic.rs         |  14 ++
> > >  rust/kernel/sync/atomic/generic.rs | 285 +++++++++++++++++++++++++++++
> > >  2 files changed, 299 insertions(+)
> > >  create mode 100644 rust/kernel/sync/atomic/generic.rs
> > >
> > > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> > > index e80ac049f36b..c5193c1c90fe 100644
> > > --- a/rust/kernel/sync/atomic.rs
> > > +++ b/rust/kernel/sync/atomic.rs
> > > @@ -16,7 +16,21 @@
> > >  //!
> > >  //! [`LKMM`]: srctree/tools/memory-model/
> > >  
> > > +pub mod generic;
> > 
> > Hmm, maybe just re-export the stuff? I don't think there's an advantage
> > to having the generic module be public.
> > 
> 
> If `generic` is not public, then in the kernel::sync::atomic page, it

I meant the rustdoc of `kernel::sync::atomic` page.

Regards,
Boqun

> won't should up, and there is no mentioning of struct `Atomic` either.
> 
> If I made it public and also re-export the `Atomic`, there would be a
> "Re-export" section mentioning all the re-exports, so I will keep
> `generic` unless you have some tricks that I don't know.
> 
> Also I feel it's a bit naturally that `AllowAtomic` and `AllowAtomicAdd`
> stay under `generic` (instead of re-export them at `atomic` mod level)
> because they are about the generic part of `Atomic`, right?
> 
[...]

