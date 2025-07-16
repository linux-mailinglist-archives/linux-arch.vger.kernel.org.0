Return-Path: <linux-arch+bounces-12819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2610B07A56
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 17:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB87188F417
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4EA2F7CE8;
	Wed, 16 Jul 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFEe5QQS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE152F4A03;
	Wed, 16 Jul 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680909; cv=none; b=tzHKub+GQPNBYXYqrC2MhuZmpkrKtyBq1V9HEAPViUe5RzZZiQ1zHxFEYfw4Wz6WvogjY7b5nAszKHUOLQss6dPtmKobqEP9RIVMRJ2WPh7DwYDVRrtMpVwXlnN+11jimohSlV8RPsqZp09LxV5sLZsVyzUQBuC0oMQUuO8w0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680909; c=relaxed/simple;
	bh=9QObaE15aA2HF9A4bZEW1whQFC6WEn59Tf4pkxZV2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAaogjIHeSWRnlov3imTDHTJGm78WdPNuFVcHwFodadayo8Tnl75L0b0Sv4d2oFE8NQy5PIk0HRVjsaa1pFODU5CcMutuS+UUyCJtTaHwf2BDIflmdHTQ8u5q1sbKcFIwDpTd8J7YEf2ZxV82IHtMbxFLbe/ETLOZWIzANqNLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFEe5QQS; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab60e97cf8so592201cf.0;
        Wed, 16 Jul 2025 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680906; x=1753285706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HO8xWa8N6E+EadbzyVIIdblu5LfP5/dbhHokIsV+v4=;
        b=QFEe5QQS/i6SUMRjJAgWQ4CvdQ7GOv0iDnIv5dsIxP6AwwsInLuM1MHr6vPnFc9cH9
         WsKJsxG8ppfycjYHb5hG8s96im19b6ZCGqERGKG2r55oOp2qjph9zimSG+UQnwqqW248
         bsT1r5A6YfKWM21zce/YaeK1+HgRX4p/ziNIHnzcZYxU4dFNLiiOr08Xw49if6vEZlYo
         hWYEbxWFR/Depk8ueulin8332GPU6//Ah/d9HuQoJ/4AjCw03io1MPfQi7OgLZYI3PyK
         6PxLb071hZmYKE7UaFTRHlKQfbTOQFuiuFXVKjAvLJ9HdwgTDb7Gal1nIgPFtucqbE7q
         ELSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680906; x=1753285706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HO8xWa8N6E+EadbzyVIIdblu5LfP5/dbhHokIsV+v4=;
        b=ERqALl3li0jZcSZQn8roVOvAg7saX2dkZulHcGuelH9c01nt5ZYF4iqsA06sV1TYWc
         8e/KMyf4xYUkEvnbiv28KhSMic5YiM+VdP4ldJrq9L/IJtlA8qE063CmrKe+dAtkPitd
         D52Po5hFZzR4L8uATrsXuuHbWZf0X5KUAoKv945CM8OZsIe5pV7DXUFrb+FB2saEsX6F
         q1fGtlfsM4yajA3gk2y83gQt8sUqyvKVnj9US5bAmkOeZaOObvOT/E8BemeMYuC9Xt+I
         r62eHZPU7qkmCcsden1dBudAvvJJ8Qw+hw/0GR7odCZa8n4RAun2lmXzlO2FBPR0eYNP
         uB8w==
X-Forwarded-Encrypted: i=1; AJvYcCUSotnEoMcHrmcpSbQLq7uEot/ju3svikO/3bfY3WDImPaUd3qPZwYIheJm+Uh8MBNM8jXptBULBotDxQh3UtQ=@vger.kernel.org, AJvYcCWO/ifqHZTpYYUvvZ/r3OjlKt3AXzdVrHKjAPKsJ4HFCPZ5G9hLUsfsLpP4ymCagUdr6Lnipxqrolbm@vger.kernel.org
X-Gm-Message-State: AOJu0YwpntWNK5xmPqDxZA0MvtpGRgIhv8U4ow7ML2ukuzh5etxXr5JJ
	lxBjiwFe+zwEgJJlQhnsXyKb+HSxm3zdmJknw0jKo0lxElvTJ5j7st9d
X-Gm-Gg: ASbGncu7Yg0mVvviSZJRl9RJTqSXMUfpkHF6kIsPUxTjJ3dST89KKdBZWd7reD1v4fd
	FOgvrLbyFac6I6mWivh5m4kssPqva569rbtrKWDDEMAb/tCFnaasam5Q6uaBRP4wUAvEXvPU/w9
	Q9/mudzJqxrhkl/pxyl3+MtTPXZyAMrWJgnGU5ZOTyBivI/RVkGcd4DOUpwDMtjM7GdYYSWv0qo
	pv6V49rUP8yGr3Dp8cHfwON6UZRYZMnUuyJwOz8ZQ1avKMczuwBrY1CPdUKm1vr1tptTzU85nDN
	fBKDAOw2OOJ30ueK0k6Sg3K+yvIbJnFiCr0ewCtv3BfvmV8fyHdZ54EHkrqVaFkTqVwXVr0XMAS
	Ihjz2TIuFijGA8MlF6kFnK5U6rJJ8AXFbys/j1wKBQexPcgKuVKPMUmx9xxXgYOeYZFDcfgQEhl
	xkZkBEjSpRy1x5
X-Google-Smtp-Source: AGHT+IHBnCkbkHcfWeZMyZZz/YOPnOdee30pCHkZOcxDxSemJI0bQD9ig/IPq89o8eZkA2Xn9bn7Ew==
X-Received: by 2002:a05:622a:5591:b0:4aa:df14:983f with SMTP id d75a77b69052e-4ab93df38bbmr41572161cf.51.1752680906378;
        Wed, 16 Jul 2025 08:48:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab5b9a1949sm43793561cf.55.2025.07.16.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:48:26 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 50CBBF40066;
	Wed, 16 Jul 2025 11:48:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 11:48:25 -0400
X-ME-Sender: <xms:ycl3aOD1J4fjv5aIUx2IPox0q1oe7YiNy7M5hfMqhZlITw4n69kISA>
    <xme:ycl3aKBZPKfWsPSs-xAmeuEUsU4YDO8pOGedMKo-7dQ_HPxfWuFDIKvxSgpdLpXrY
    gXlPQRA1mhob3lXag>
X-ME-Received: <xmr:ycl3aGJIxxAt1ztjrTEeSLAoswXBPsFjluzSfmJiRyt-hRkPGzXgyps3Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:ycl3aMSHK4pnfJZA2eRBtaw6SDJ44Pqw9ItMoXndaEiS5eYcvmTJNw>
    <xmx:ycl3aBQ-KsnX3u3tR70z8V2gZ-ZnkdimOlnZWkHrBQQTK46PUO_gJA>
    <xmx:ycl3aP581rbjIAC1WVX49CvoU9FPX_PX-c2B0lCJ9ueP5_x-PO7DMg>
    <xmx:ycl3aOF1eFtbg7claoiZP746xzSYGjCTQq7CuoLE-yTnb4QKx6qDqg>
    <xmx:ycl3aAk4TPOJzM59lpdV-8GfFKwUCmibcTxfstvyT5RabH4QYFRim3gn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:48:24 -0400 (EDT)
Date: Wed, 16 Jul 2025 08:48:23 -0700
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
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aHfJx5_kMcULUd7t@Mac.home>
References: <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>
 <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>
 <aHZ-HP1ErzlERfpI@Mac.home>
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org>
 <aHa2he81nBDgvA5u@tardis-2.local>
 <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org>
 <aHezbbzk0FyBW9jS@Mac.home>
 <DBDL9KI7VNO2.1QZBWS222KQGP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBDL9KI7VNO2.1QZBWS222KQGP@kernel.org>

On Wed, Jul 16, 2025 at 05:36:05PM +0200, Benno Lossin wrote:
[..]
> >
> > I have a better solution:
> >
> > in ops.rs
> >
> >     pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>)
> >
> >     impl AtomicArithmeticOps for i32 {
> >         // a *safe* function
> >         fn atomic_add(a: &AtomicRepr, v: i32) {
> > 	    ...
> > 	}
> >     }
> >
> > in generic.rs
> >
> >     pub struct Atomic<T>(AtoimcRepr<T::Repr>);
> >
> >     impl<T: AtomicAdd> Atomic<T> {
> >         fn add(&self, v: .., ...) {
> > 	    T::Repr::atomic_add(&self.0, ...);
> > 	}
> >     }
> >
> > see:
> >
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-atomic-impl
> 
> Hmm what does the additional indirection give you?
> 

What additional indirection you mean? You cannot make atomic_add() safe
with only `UnsafeCell<T::Repr>`.

Regards,
Boqun

> Otherwise this looks like the `T::Repr` approach that I detailed above,
> so I like it :)
> 
> ---
> Cheers,
> Benno

