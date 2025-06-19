Return-Path: <linux-arch+bounces-12405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B8AE0A08
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EB916B285
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7603215F53;
	Thu, 19 Jun 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvI9xjt3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B73085D3;
	Thu, 19 Jun 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346147; cv=none; b=ljIV5DAjD+cssciQeYBBlt9jr/R2toZmlRkcgs4xKnV7YC/Z7ZHoFhSCqpJ8fTW/SV+/FLIKA7mkBs06Im4V+F8P0rrDeOtreH/NEWFiyg4W3/gsQCBOBA8AyqN3tYdC3J8cB+TbQA/1pMSamlwg67K6dnD9tSOZRRjPGTTbFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346147; c=relaxed/simple;
	bh=zHZPU0pQVvtvELT/A0DnUl36QCSDJghMFFVkTWTaZUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6M14oh442YbHgRRu/UEZbODUGUFkdv16enoeYd9NdLcbnM4GbOquqlDBCMdWLrGwDfJuUU0h+EvF4fjw+rly/0wdB6ziXYHGrIFAviRtS77kr80YueauNXc7ZL8vYcuEWSZSm+y60i3LWOTuGoPuBYr/OFKGUWD2p9O/ZtqibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvI9xjt3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a58ebece05so7711201cf.1;
        Thu, 19 Jun 2025 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750346145; x=1750950945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB6NBWoWO017Q/yotmTxC8XiQqyoYl9JmICEhhvlvHU=;
        b=gvI9xjt3Wp9ZPsDuHkv7IN2Kd0nM98jn+OKmyvsMR6UUjK1bvGRcnVIw65d9G72Mgl
         9CvSpBQ5oVJcMusJcHl54HRkfN0pgK8JJk0kwDGO3mc/owizMzvBO+nVhKEeCnkhxcvn
         HeNfRaO7lTG//GOqr29N/aYMIY2PjDirUg1brTWnUHSASCgNgWQW0/3+rsYRDC+3gMKf
         6iZmc2SyZoj/1Eu3TnBfXLhqKmFGCYD2Ub3+PmZ2rm+8zOdvVFvus+J1+5Us6VK8mFPC
         QdKV/F8l7QZj/WSXur7tBmA9WEJ5OAU1BBT/iJj8Yd6rmfsHtROlLo1NcTx9/W0TXWrT
         LFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750346145; x=1750950945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB6NBWoWO017Q/yotmTxC8XiQqyoYl9JmICEhhvlvHU=;
        b=Dn8PscKQ3+8NRAgPAeA8Ew6PE/eFYYjkUKX3Dq38RvYuxJ5kR+8k1JYb8QyvhNJsbi
         JvUkE0YQLXxarVu/7UNr1RTQaxZ94dd7upR42yClTlROMBvYZw8sgqkLAsyFZSh+7elP
         0+nC40lYnXs0usQMTx2qwNDsMrO96/DESMx0oAfWNoUMn5BqFOitYeiDld2aV6GK5aPq
         5eoTYT2QOC6iVjhTTVRK4vYmd3F3POXpjR9ltjPl3hvf9JnYnBlcJivrBJsG/t8qjKh+
         AOKun8MkbQjmueAuuCVZciIl4FKT1V4TaJR8eZbtp5W1M0hqqOEeeLIF2gT70oAR7CYr
         1MTA==
X-Forwarded-Encrypted: i=1; AJvYcCUZSV8pHchLnAC4np4VQrwi2L5Zi4Mvd//yy+kja1UuPtgXk7QF6QQkR/ZRcj9z18eMqvQ1dWC7Fjr+7EyG/Tw=@vger.kernel.org, AJvYcCUlcF5+qzNbAbkrCV+RN066+q44rFSIEgAVUh9WwwMe2zgEpsEvz+RUDyYliXuk+60pRnNsM6EpynxT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CXI/m1v7TiyJPhi7+UgRmgCmCm8rrdxpmdw6QZBXkdrUMK2L
	IP8+BT3nBxk2xsTfL6KRARjiG7wkf21OaxIo2C8wSRSoN86UcdD07PoG
X-Gm-Gg: ASbGnctw1OPCqSAkLsJoGCgKC2DwGmhkKwc577ET+UHrP6a63MufcVy6YQTI2m+QzUi
	Vy6j9RZF6Msrq9vqQs4vHdtUeze3ue4JIiXTQKNjZdIa7tlEi8De4j7NUi0WPlMKCkeCOmIueI9
	wVuFFg0V/pkVBM80zgmYYfvMWJaiNQ5YBnAs8+9MYvo6+0SHlIZYFAr12inyyQzt35bj4FUDFI5
	hHqfXhHDiaeLHHIg7zK7kfZz3DUf3gEb86xcqzAbwY5dBtOEojMEOHnFIgifusvW13Lz6RYHiJ7
	lLDm39ZB5NtLyPUGBTBCASyC3kLXlfIwMJOKAJjpM7DN/QwKHhgU7CKiFZeG1xA9vYchZeut/OD
	WxGS12Lty6FJbS1b54wzTwtGeAKOOez1xHPeYLx51gS3/OQTdzNQX
X-Google-Smtp-Source: AGHT+IF8vYUaxN9IXHpKW7pA/QJMa955Hnx3mIGzGHZgpjKqaBXYX9dt9SNO06zJEdxRolqCx+PzwA==
X-Received: by 2002:ac8:58ce:0:b0:4a4:2d64:a7e4 with SMTP id d75a77b69052e-4a73c608616mr347986811cf.35.1750346144930;
        Thu, 19 Jun 2025 08:15:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7784ce4d1sm443131cf.27.2025.06.19.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:15:42 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BA82F1200069;
	Thu, 19 Jun 2025 11:15:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Jun 2025 11:15:41 -0400
X-ME-Sender: <xms:nSlUaIskrN58R8pfL5HcUXbdEiumOwJqeuesDalCGA3HVarVvmyARA>
    <xme:nSlUaFeNOvpNck2jrzCPWg4LTetKM-aQVMaK8C29bgMk9ofYorlSYilskBbtliwyw
    3Gmn_LeOdbJVgUfcA>
X-ME-Received: <xmr:nSlUaDywfts9qXJkAqSPEMQoe1SVaa1E4BW_p8tiC1i2t22isfspKuYbeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefgledvudfhudfhhedugeegheekhfeileelteffgfekleegjeetueefieetudehueen
    ucffohhmrghinheprhgvlhgvrghsvgdrshhonecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:nSlUaLNdegtaf3xa6TtwhaE9QVx0LOLdxrxkjQsJumnZV9M82BoMFw>
    <xmx:nSlUaI97kKqOW3Jz1ZTEl1t1OU9zu2-JXHQ7WwsMcfFCSFGvg1MkrA>
    <xmx:nSlUaDWyQdmWn8GXYlEn-B9jFQd6bol3p47FB5jr87ZtyMi-7Vjw5g>
    <xmx:nSlUaBcQjjgb1RuxLQIQq9W7jb-vnzoQorE84AInrV4M6SHYASavZg>
    <xmx:nSlUaKdQ1obqpDC4h0bIwoMZVevMyR3SsKD7oaRo9lMngoUJv_RfiWfS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 11:15:41 -0400 (EDT)
Date: Thu, 19 Jun 2025 08:15:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aFQpnBGrOrd3rtbF@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
 <aFQQuf44uovVNFCV@Mac.home>
 <20250619143214.GJ1613376@noisy.programming.kicks-ass.net>
 <aFQmDoRSEmUuPIQG@Mac.home>
 <20250619151050.GN1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619151050.GN1613376@noisy.programming.kicks-ass.net>

On Thu, Jun 19, 2025 at 05:10:50PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 19, 2025 at 08:00:30AM -0700, Boqun Feng wrote:
> 
> > > So given we build locks from atomics, this has to come from somewhere.
> > > 
> > > The simplest lock -- TAS -- is: rmw.acquire + store.release.
> > > 
> > > So while plain store.release + load.acquire might not make TSO (although
> > > IIRC ARM added variants that do just that in an effort to aid x86
> > > emulation); store.release + rmw.acquire must, otherwise we cannot
> > > satisfy that unlock+lock.
> > 
> > Make sense, so something like this in the model should work:
> > 
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index d7e7bf13c831..90cb6db6e335 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -27,7 +27,7 @@ include "lock.cat"
> >  (* Release Acquire *)
> >  let acq-po = [Acquire] ; po ; [M]
> >  let po-rel = [M] ; po ; [Release]
> > -let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
> > +let po-unlock-lock-po = po ; (([UL] ; (po|rf) ; [LKR]) | ([Release]; (po;rf); [Acquire & RMW])) ; po
> > 
> >  (* Fences *)
> >  let R4rmb = R \ Noreturn       (* Reads for which rmb works *)
> > 
> 
> I am forever struggling with cats, but that does look about right :-)
> 

;-) ;-) ;-)

> > although I'm not sure whether there will be actual users that use this
> > ordering.
> 
> include/asm-generic/ticket_spinlock.h comes to mind, as I thing would
> kernel/locking/qspinlock.*, no?
> 

Ah, right. Although I thought users outside lock implementation would be
nice, but you're right, we do have users. Previously our reasoning for
correctness of this particular locking ordering kinda depends on
per-architecture memory model reasoning, so modeling this does make
sense.

Regards,
Boqun

> 

