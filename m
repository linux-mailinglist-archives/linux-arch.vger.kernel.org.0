Return-Path: <linux-arch+bounces-12485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1AAEB963
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0FE7ACB4B
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCB176242;
	Fri, 27 Jun 2025 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8qXtVOw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656E2D9EC1;
	Fri, 27 Jun 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032816; cv=none; b=ZRQBb/kVppioDNGMa9bdzI6WYdX4RWdhkarWZQy4mLTtcvXu2rYf4fp/v1oVS5J6xJqYl3RWaMbIs1blwcAttp6sSdlgSJmqCUPVPSGUwpJYTky/EHz5blr9YS4uMlGf0565VrbojRq8lWtHb/dqj/ygbsYRhxfeX+LoEG6SjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032816; c=relaxed/simple;
	bh=MCDW2CnFKAr1DkxQeT4e0c8U1UD9qjT0HJQAEVVIstA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFgQBen62khT9HbB06M3c1FuR1m+1Gy7+dW5wWF5WSDALKwr7DKNid/9aBI+jRt/TNRHYKfOlwc5kt+UZ94AiiCfh4bupZVRSE0Ai9MvzoCVNTLkHx7hf67b2ARjKwtE4/GJFrBLF+SKHJ9al0am2G8lUP3PGwPTf8GQst2sbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8qXtVOw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a589b7dd5fso41429231cf.0;
        Fri, 27 Jun 2025 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751032812; x=1751637612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHVmGFnuGCc8DLnIxYjeOgCVrpk/B79KTLrditxxX5M=;
        b=e8qXtVOwa32eHv5a3l9eLZMbpiLreKgu7man5Eb0GitJKYSKRmefyRWOlRzlilntCA
         zxNFOEvAQ0RDQmjtaE4Bwh0Z8uiOuO9dJRpXaC+lmGYFf6+YhamnhP3tIkWrAirHKyWa
         Aj3x5KAIWBAut3YHtkYVnSAaugdElFXQLI9oiqpYv4i6QNdlua9aHdZNP8fp039+Mmb1
         hAD1cK6gbYuI/Wm+JOKjrgg6z6Ccb4yk0jtDQspAfcJDXVBdZqigP791YDCuMC47Gwhl
         w5zN5EmNUROrANzX9g4ZT+5tUxwFtnVV5JYnVuUHJRcUJ6lI3s/ZJa1xOFvdqO+N+tpS
         wk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751032812; x=1751637612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHVmGFnuGCc8DLnIxYjeOgCVrpk/B79KTLrditxxX5M=;
        b=Wfop763TKJpE3gqv5epVUlIjHsGjdt/EJXV2TcB5leOit6gQTNVLglxiZXPS97RM8j
         Q90tJAMAPPrpTsuREDwBL52SOX1MVa7Zy3Kw18QnmwLkeix/z+8bnBWNjuvXDm4zr7om
         o1KQSqSNR2Xq09rA/uPb1RzE9iW7heo9nAx3i6sMqv11SP2a6hB97TMwHWZISYIhRB6s
         pTK/SfsABm78fPeJxoRfmat9WuPzVwhC3C0CkL5Mh+G3PM3Jna07zSdWCb5tK0gX4Osh
         FgxUNDLNcZFjZe0xO7FpPuS04TYpGrCswtQGSybuHk7kBqgvZ6n5a0srlfMSA+kOrYI1
         JZJg==
X-Forwarded-Encrypted: i=1; AJvYcCUId/5K77BwYEPdE9NpLr6n7e7zwTSKlL/ceQT7gH4LOhybEA27Aj5KtGi9X0zYDgXm7FhPLtgzKtgxfErxwDA=@vger.kernel.org, AJvYcCWTsPYXzsH2Avy9+YFy/UQrZrMgpCllvYEJbsJcUKbL0bHke8QHVK3Iru6KPZIu5CssXlK/2eoSKXgn@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLlt7ocnO2N6hrb/Lv+Q/91Ze4+uYPLQeR6jiafUowphwQZQP
	QnSeMpXWWM08tkk8FXr7sTAeH2yR5oUYAZdCZHldNTkrwMYnbpBz36By
X-Gm-Gg: ASbGncu1RkZghvWHBP0f19F7Sx1kHPcr4UXIFO79ZcNuA692Xyqs3hQppBm2DA45GJQ
	qpjV5VvLVVZNbH1BprrAVf+9NlfRh/luvCmZinimoJxTcOygwX5PtRVFz9QnwCCBmwLkD68MD22
	rxtyx7+wEh3Ux3uOjk0Cq8vPfmVS8UUYNgYWGI8skySjKy6ILfGTK9Gpygi17hyWowMbekA+15C
	WT0PaFtBgiZLX3o7SAIy5g1x8nn0UBlbP2hSQ/VKP30oVPKyhxqyIS7KVdYGVTImR4a/tUJ3d2n
	zERY8YZ9oVfgDAhqx+1xuSxlxq4+yWh0z06upNzmYuNriruxWncGPWWaBHDAx2bfNxeogN2n09Y
	rOgTCf/nQIoRGtKZftGMTWq/lHa6K46him+hmwuG03XgaGGLLI8Il
X-Google-Smtp-Source: AGHT+IEqQS5iM14Z1smx60jxtHPv4QQEOHjWooOFkrzJ0K7uY9/B7eV3dnb2aGlFi721dnAJ0nOyyQ==
X-Received: by 2002:a05:6214:f2a:b0:6e8:f470:2b11 with SMTP id 6a1803df08f44-7000215068dmr67740936d6.23.1751032810419;
        Fri, 27 Jun 2025 07:00:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ff8d8ecf6bsm13042156d6.30.2025.06.27.07.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:00:09 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 19C94F40068;
	Fri, 27 Jun 2025 10:00:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 10:00:09 -0400
X-ME-Sender: <xms:6KNeaLLAjmdIinLC9QilYqN2CBFZmGqZlZo4pKckMRLvDa6jVt1jrA>
    <xme:6KNeaPIT9qAhHicAuAYQeAFqRGiTs8zY56PKXcf055z_fwzdMNdCxA1p86rVpXepI
    FDjsLq9-V-kogO9pA>
X-ME-Received: <xmr:6KNeaDtCKtXWikmfiq_2yE78BiSy8Lq-wboq4YSeGBMpa2WstyOikh6WGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdehtden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6KNeaEahxje0nUSNuIvIqVraIaJrze5xOuiad_ZbKwotnxnISHBHhQ>
    <xmx:6aNeaCZTQ9EPP7RLe96slpJz9Y1YH7jL20YNAsJ3YNw3lNX0QyS0Jw>
    <xmx:6aNeaIAnTbJ5cZWa9GHaZCZpvKHzqZC4EmDXtgWN8Zbqn5m048iiYQ>
    <xmx:6aNeaAZj9Bg0pF94onEbn-Owp5V1JwsgUextTDLq0NA0UZZupf8NWg>
    <xmx:6aNeaGpaPrfh4tw7sAsYDq7FywKZ6lKAxs_hNq0u7WsXyRxFIYx4As9s>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 10:00:08 -0400 (EDT)
Date: Fri, 27 Jun 2025 07:00:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 01/10] rust: Introduce atomic API helpers
Message-ID: <aF6j5158xC_mEAHM@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <Uqju6u2xO_vCzY1ykGKU72OTQDzH6QgCbUFbq2e4ibAiXgKNzQRBv5IMVNEaCg9zFQpebc65KefA6rzhLNQ9xA==@protonmail.internalid>
 <20250618164934.19817-2-boqun.feng@gmail.com>
 <87jz4y28pu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz4y28pu.fsf@kernel.org>

On Thu, Jun 26, 2025 at 10:44:13AM +0200, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
> > In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> > APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> > the same as in C. This could save the maintenance burden of having two
> > similar atomic implementations in asm.
> >
> > Originally-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/helpers/atomic.c                     | 1038 +++++++++++++++++++++
> >  rust/helpers/helpers.c                    |    1 +
> >  scripts/atomic/gen-atomics.sh             |    1 +
> >  scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
> >  4 files changed, 1105 insertions(+)
> >  create mode 100644 rust/helpers/atomic.c
> >  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
> >
> > diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
> > new file mode 100644
> > index 000000000000..00bf10887928
> > --- /dev/null
> > +++ b/rust/helpers/atomic.c
> > @@ -0,0 +1,1038 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> > +// DO NOT MODIFY THIS FILE DIRECTLY
> 
> If this file is generated, why check it in? Can't we run the generator
> at build time?
> 

Greg asked the same question, and it has been answered in v1:

	https://lore.kernel.org/rust-for-linux/ZmrLmnPz_0Q8oXny@J2N7QTR9R3/

I'm simply following what we already do for other version of atomic
APIs.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

