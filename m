Return-Path: <linux-arch+bounces-13174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CEDB28F5B
	for <lists+linux-arch@lfdr.de>; Sat, 16 Aug 2025 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133DB1C255AB
	for <lists+linux-arch@lfdr.de>; Sat, 16 Aug 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04A28D8CD;
	Sat, 16 Aug 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrMLgx0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855881C862D;
	Sat, 16 Aug 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360715; cv=none; b=XoTucrPKNAwz7YGKWb1QvgvS9/7ezYb7mjS+3Q4Pn0+xHR8G9poO6MRY3iDvehD68U9EtogEHsVgfSOXXiIJ8BLMuIsFUP55A412sf0giqvV2e7xxR7cGwUhnKnugTrENVWP+qnPBdXgRN+11CKhlRXOGJyurxRUr/lYTWFxFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360715; c=relaxed/simple;
	bh=EtMfV6kWwY7RpKSzy6jCkyzXpqZ6kO6pRgQEXOPNW1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2M6TooMaZaKPJC7OtZ3QnqcCk1iSkptQwtQevdO3QXYXoo5ezX+Cjd2NCGZVCC/V1O+HVvDBLzTHx1qEstpxtN7MUXEMYZPRv5IouxAXMrknU9rXFMm0V0WoY8QyP6+PnJHmHbLoB+gJoj0Cy0mceUy0L6dNGN0HH9cGncMXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrMLgx0a; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e87055e1b6so402454085a.1;
        Sat, 16 Aug 2025 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755360712; x=1755965512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQSAsVXNS1069qI55AjAFU4SUhFAdBWLay5Yhtg6JU0=;
        b=XrMLgx0akiHospUNvBP0Bj2Z0J+dRHUrYwmtfjQOXKqZrOA41J/PgkAH4fK7gbo9nv
         mAiCrktKn6svGT4KvWd8/bW3+qbSnhHG4ZuqaAOyYbSRlI0G39DzGWiUUQEVYDrjAKHs
         hEJxLdZCT9taZCz8TP2xZkbjBaTohTvFSAwzwA295CIzBLdxHwG2dzBl1c9Zzm/b15ZI
         DOr63J99ZqFGS/Xtigg1XgdAwXFIxWG+h/BGhJOUt5S423SJMa54/CQ7co5DncEQSUGp
         /zSUwFyXiZlAp6KncE3UhpTX0O4sXlTpHW6oLu0hGrj9A8/xuMr5TBk4XJ6QBnWont5x
         7glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755360712; x=1755965512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQSAsVXNS1069qI55AjAFU4SUhFAdBWLay5Yhtg6JU0=;
        b=hmjT1p2Rr8HTpyUpFfuJiGpXzdrX4hK7MQALRp3jrTXS+g5Xm0d6nbUTEr9osUUiCp
         mNUTm8pi/GntnitNqXVLxcTxr73LzyvCzl66aWlU1MZsd0MVrqHPgSQahzDNzle1rnXx
         E6D9636DOppbKaOpEJJdozx51rfliE2qzlleFSJZSAx7vP/aFzUb3eiFYaTT2EBTa6ZP
         qIpHVECIXnPOb7wdIinu9pu1B1Rk1EW7MlcSf7QStbn/vnBfPm/2md2FKpGRUcIRpi+e
         YALgggctqx1CBsrxQeN1ghWcm9dEpRKcFu0LENyv7/ciPxZGqINtEVA9w+LZyxm7Ljzv
         wALw==
X-Forwarded-Encrypted: i=1; AJvYcCVsc4Xip8g3bywGX8vSqiHh4gc7sguHV/MBLdTRe1FGsduo7Lm6+GaJDuuwt0AhIaScLd662Zsv+rm5dKJu9II=@vger.kernel.org, AJvYcCWouO2dOZKqY3nrUuB+g4UvzFwTGHAeEDsLL4FurRVkzYRQiI5o+4pbn/zlPVWFczl/9A7iLRUnuj+e@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6UYGDrTGZw6j5JernR9HqHyBsDZqK/AWauGJUQDHldiQqK8Q
	cnYCYZPAkFePCLMfI1A5FbbYL6oG8wbK3T8yykfNYkXQNbBAaXDlUz8V
X-Gm-Gg: ASbGncvkcFutyk6n8xvB63dLgbdKnNl6ZCJmke/dH/XcjyPl59scjOVAFOi//q/0DrS
	nocoKbIGTSxg3/wQ/8xAbzvlIY68cjIRArm9zttxMXXOQBPGj/xMGgrewvJx5uIAc3KRxezapG8
	WEDyRndLAR+QdDI8PujaqOgVqUhsPrckDU24hiti2X+fLHTGJgvpg7tyIYAZvs5ifDU6Gn+koLB
	UBFKY6Sa30xVXiT71H1w4OTJAPMWusg4Pvo54lZdUK6So6dINgw7l1KslpoIV4DmFrugngXkuoH
	YVZQVJUkCzJ0ah1rNATkj0gUBNMHGTvGMu3fw7qbka6RvAMKYO9jm9PROoeaJyODYQZcoPcYCza
	9byfVoFneZOlVD7rE72r4E75Ye1ojIqAlzHeAZoSdKXvmG8ubIEuJv92SqqxfYoEFwT/6aiAEs5
	GCt5E4vZ/uP+KJ59sEE1e/DMJ5eQMSAqg8xg==
X-Google-Smtp-Source: AGHT+IHr8ZShzqXQ/i14KU3FBbPl6pX+JdsCK1CS7YltUGPOZFM0P9Gl2uACBr6tjF0lbZaga/qmTA==
X-Received: by 2002:a05:620a:bd6:b0:7e8:1dbc:f126 with SMTP id af79cd13be357-7e87e0e1932mr614435285a.32.1755360712255;
        Sat, 16 Aug 2025 09:11:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b120b96b1asm22149831cf.26.2025.08.16.09.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:11:51 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3B79CF40066;
	Sat, 16 Aug 2025 12:11:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 16 Aug 2025 12:11:51 -0400
X-ME-Sender: <xms:x62gaLW9mWg5ENPTFlfeqfHH5q0WK6mX_5b7JlsdaARKZXDPchChjQ>
    <xme:x62gaFPD0cZJLh-8kRVq_kSBxvC5ig41ogZUtIJdUsUGS0TqMrEohkIE3Ji4r6x1o
    GA-k1p65bomAMp4aQ>
X-ME-Received: <xmr:x62gaGFmQsu6P2BjO6iXiU-gI5EUQoR_gbEeQGzyQpC9-0wrvh15AtyePx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushht
    qdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghr
    tghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:x62gaO0UpGqIo3BWdmBJv-9G1755Figkjske1r3fU73qDhGF6MraEQ>
    <xmx:x62gaGPtySw1amOUiigKhB7DjyrTvd-zGv0XXedLc1-rujtD-HP9Xg>
    <xmx:x62gaOIONn5kFOVqAXTBW-otbE-61KKT1IzAsRAYbg2UkUkf15uqBQ>
    <xmx:x62gaHZDaQBaK99vmsMSYh-sFRte8dLeT4_o1ZelA0LXVJt8Yvq_BQ>
    <xmx:x62gaHkQWYEjKOs74b6frLQhBO9o6dsSetGVu5P1hX_jkCobG9JPN9FW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Aug 2025 12:11:50 -0400 (EDT)
Date: Sat, 16 Aug 2025 09:11:49 -0700
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
Subject: Re: [PATCH v8 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aKCtxVSm9kYD8NcK@tardis-2.local>
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-5-boqun.feng@gmail.com>
 <DC0AGT8F3JH1.2PZIXKX9AQBWD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC0AGT8F3JH1.2PZIXKX9AQBWD@kernel.org>

On Tue, Aug 12, 2025 at 09:59:39AM +0200, Benno Lossin wrote:
> On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
> > To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> > added, currently `T` needs to be Send + Copy because these are the
> > straightforward usages and all basic types support this.
> >
> > Implement `AtomicType` for `i32` and `i64`, and so far only basic
> > operations load() and store() are introduced.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> 

Thanks!

> > ---
> >  rust/kernel/sync/atomic.rs           | 274 +++++++++++++++++++++++++++
> >  rust/kernel/sync/atomic/predefine.rs |  15 ++
> >  2 files changed, 289 insertions(+)
> >  create mode 100644 rust/kernel/sync/atomic/predefine.rs
> 
> > +/// # Limitations
> > +///
> > +/// Because C primitives are used to implement the atomic operations, and a C function requires a
> > +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence at the Rust <-> C
> > +/// surface, only types with all the bits initialized can be passed. As a result, types like `(u8,
> > +/// u16)` (padding bytes are uninitialized) are currently not supported. Note that technically
> > +/// these types can be supported if some APIs are removed for them and the inner implementation is
> > +/// tweaked, but the justification of support such a type is not strong enough at the moment. This
> > +/// should be resolved if there is an implementation for `MaybeUninit<i32>` as `AtomicImpl`.
> 
> I'd remove the last sentence, as it makes it sound like one only would
> have to add that impl and be finished.
> 

Yeah, sounds good to me, will remove the last sentence starting with
"Note that technically .."

Regards,
Boqun

> ---
> Cheers,
> Benno
> 

