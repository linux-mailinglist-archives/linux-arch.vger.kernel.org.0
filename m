Return-Path: <linux-arch+bounces-9039-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39F9C62AD
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 21:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A479AB26FF7
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559420F5D3;
	Tue, 12 Nov 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVetaohb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B852076A8;
	Tue, 12 Nov 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430579; cv=none; b=Bug/RCGDokCjl82XYdvFNgKVgJsRVhIfvrK3MyI8U5g38esp/V/BArlegb3upK0UX+qRBojXbEt5b7PxpzctEHa1/0pcJJL4eznHWow/OoRxC34qk+oMZhKuuC3novIway5MOjzd9Z4rHM4VhWr0ORF4DDY9oGCxouBfNFopCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430579; c=relaxed/simple;
	bh=IQwpH8uQuuscY4QEhqEZuyacLvlTW5N/L1dD9pP1ab4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlVu/dOYmQGsNKMmbrbwht9H54eJsnPCWhR7WZo4Z3w2HRYIhe2cyfQZ+qx8QcuNhhR756BtMNJHx7RbmFZKmDBDObzskLYkZo2Ef+MfpdbmHDbH+nRoC7gK7jZf+s3j0tWEjl03Y0QjtIm6GgLkZTiEtpeIBuwyTLp6unfQmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVetaohb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbe3e99680so31130926d6.3;
        Tue, 12 Nov 2024 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731430576; x=1732035376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NeZLrjWeq51QnuhA5T+MVCmaCq11ny7ORgxj558OpgM=;
        b=NVetaohb0Ts8RRZ2Zypz51u6pqyG9kQ9wceg/7eZTKVW5zIP6Ub8jAy2xKXw7uXAqd
         IqV6AksHXKBVU9Jk4TInp4raulOEOy0qVd8Vdkxkb0Q4DM0N41vP5e3ueE/KvBuSNLJz
         48rn34E4V38IH4K4Pjal1asaWx6lL9FJMG4btJmWtM67MTWTN7ekPbnBT1FVXE1mfydK
         h0B99cu/4CWjK7Ne9mR+S1IOBnpHBY1BFzb2rG9UCVxjOaMM6r8RYHo6Bv/8Q3yBKJGQ
         NvULJP775XJ5CaRRO8xTOIK9Ri00ZqtvHHmV0r3pqAd2en3hEVXb43U5v9RCukaf1YLy
         anyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430576; x=1732035376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeZLrjWeq51QnuhA5T+MVCmaCq11ny7ORgxj558OpgM=;
        b=QcyBi4bCHlpsmJWBJjTfdVoECTT12gpj+MgEkuavifivZx3sSBqHrzjGGF0zJrd5sw
         O/CuKpz1F2JyWsYTnIdPdwGI0kw6aqZ3SBgRE/V91oqMdciTjtYjYwP7R70RU431Mzp7
         9WcCjSPORzsG6j/Y5tffHwNimT2ZAkhdyb6mRZqMtat5T3uPKwVlTpoiK2PkUK60n7zI
         9DvAHS/zYYyheZkd/NAmcsp26DZwv1MYBZ50zZHkb14BBiY0wEq0iYnbFGJZAWdBkBH1
         vx97QATcdlqXa/LuU60iu7OJV618fw/x5q6Nxx2V5rSXgS/fyRjrmQT/DDDeiMh6fhAI
         MVkA==
X-Forwarded-Encrypted: i=1; AJvYcCVh9chBVlvyhCKnQdKljV3/noGY7MzwzzTW7UDH5kSvx270GKaggzzWUcdHdNpUC4iabt84P5JBdgSO@vger.kernel.org, AJvYcCWFzDbcOoG8bThmLHGZo54Bxn17qaJDaNF+eeAXSDJowhTgcdm+yEVXkpfHbEsedphH7R2PviVktqYq3sYo@vger.kernel.org
X-Gm-Message-State: AOJu0Yypp+S1SiugvETNB4UUeguE7NQe8UvSm3x63bk+S6IhniwqrAPP
	DFGIqFWdwxStLhMGjiR6+OKsdr73iIt7cKaZoh3b7etj172GQ+IppCEqLg==
X-Google-Smtp-Source: AGHT+IFZGbq0ye3dEoy5ere2b7GMEeJax9p9EK1+Yh4xMfoJSIs+pmyuSFwwYtcL4aux/hlgxcHK0Q==
X-Received: by 2002:a05:6214:2f82:b0:6d1:727c:2dfc with SMTP id 6a1803df08f44-6d39e166f74mr241139776d6.10.1731430576455;
        Tue, 12 Nov 2024 08:56:16 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df062sm72969696d6.11.2024.11.12.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:56:14 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05FD5120007B;
	Tue, 12 Nov 2024 11:56:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 11:56:14 -0500
X-ME-Sender: <xms:rYgzZ8Nn60B8RwziFyhXlpy6WbS14dZ5yqV3jVNOuW3tAhrmLIiM3Q>
    <xme:rYgzZy98Li3a9qAz2fkhW1UbGEX2gR_WE9YSfxfZ8w8GEA8fFn2Yr1xMi-Gn-bkeZ
    dq2-8x1LslSdBai0w>
X-ME-Received: <xmr:rYgzZzRyETW7vISDXeG22iQRI4wR6xpgS3iW5E2ooxHBZVphnfj-0qtKgms1sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpedtvdeileevgeevjeejkeduiefgffeiteejvdet
    gffgieekudelteefteekheehjeenucffohhmrghinhepsghoohhtlhhinhdrtghomhdpgh
    hithhhuhgsrdgtohhmpdhlihhnuhigrdhnohenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepud
    ekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvghihshiivghrvghghiesfhhrvggvmhgrihhlrdhhuh
    dprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuh
    dprhgtphhtthhopehprghrrhhirdgrnhgurhgvrgesghhmrghilhdrtghomhdprhgtphht
    thhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtgho
    mhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:rYgzZ0vE2-nOUHxuSNfp_-slzc-DjJ9b6BxVVoJK8QQRrPBA4mcN4g>
    <xmx:rYgzZ0e6VUCFcHP8HIN11l9Ib6vAluc7X1iDydcN6Wl6tmzCFIoN8w>
    <xmx:rYgzZ422NjYrXuQXkV28rwFpsGTe7aGonW0No-GkeEiD_oGj387ZJQ>
    <xmx:rYgzZ4_55z-O4PYWR9v5ClUxAQs0kiEA535NlEJiZDSYXc7b3GNvdg>
    <xmx:rYgzZ7-IgLqgA3bwi9DKjzCBUqJJHOYwl_1MNH2G_petBudZ7-dKwGrp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 11:56:13 -0500 (EST)
Date: Tue, 12 Nov 2024 08:56:12 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: =?iso-8859-1?Q?Sz=22oke?= Benjamin <egyszeregy@freemail.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <ZzOIrGpcMUg74Tpq@tardis.local>
References: <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
 <705daf58-dd30-4935-9864-6489b9b90a35@freemail.hu>
 <ZzKpK_9nxh4Qg6mW@tardis.local>
 <9ecdbe98-666b-4467-85f5-7f9bc01788c2@freemail.hu>
 <a9f0858b-6c05-4c7b-8677-8f635a025a05@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9f0858b-6c05-4c7b-8677-8f635a025a05@paulmck-laptop>

On Tue, Nov 12, 2024 at 08:43:31AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 12, 2024 at 11:06:05AM +0100, Sz"oke Benjamin wrote:
> > 2024. 11. 12. 2:02 keltezéssel, Boqun Feng írta:
> > > On Tue, Nov 12, 2024 at 12:21:51AM +0100, Sz"oke Benjamin wrote:
> > > > 2024. 11. 11. 23:00 keltezéssel, Linus Torvalds írta:
> > > > > On Mon, 11 Nov 2024 at 13:15, Sz"oke Benjamin <egyszeregy@freemail.hu> wrote:
> > > > > > 
> > > > > > There is a technical issue in the Linux kernel source tree's file naming/styles
> > > > > > in git clone command on case-insensitive filesystem.
> > > > > 
> > > > > No.
> > > > > 
> > > > > This is entirely your problem.
> > > > > 
> > > > > The kernel build does not work, and is not intended to work on broken setups.
> > > > > 
> > > > > If you have a case-insensitive filesystem, you get to keep both broken parts.
> > > > > 
> > > > > I actively hate case-insensitive filesystems. It's a broken model in
> > > > > so many ways. I will not lift a finger to try to help that
> > > > > braindamaged setup.
> > > > > 
> > > > > "Here's a nickel, Kid. Go buy yourself a real computer"
> > > > > 
> > > > >                Linus
> > > > 
> > > > 
> > > > In this patch my goal is to improve Linux kernel codebase to able to
> > > > edit/coding in any platform, in an IDE which has a modern GUI.
> > > > 
> > > > Chillout, i am not so stupid to compile kernel on this "braindamaged setup",
> > > > I just like to edit the code and manage it by git commands.
> > > > 
> > > 
> > > Then you just need to create a case-sensitive partition, no? What's the
> > > *technical* issue of doing that? And that cannot be more challenging
> > > than testing your kernel changes, right? So it won't raise the bar of a
> > > potential serious kernel contributer.
> > 
> > It is easy to say just need a case-sensitive partition, and sure it can be
> > configurable but for example on Windows, admin rights needed for it, which
> > is not available in 90% for a workstation machine in an universitiy or a
> > general company.
> 
> Or, as Boqun suggested, one of these websites:
> 
> https://elixir.bootlin.com/linux/v6.11/source
> https://github.com/torvalds/linux/tree/master
> https://lxr.linux.no/
> 

I would also suggest using WSL or using GitHub codespaces or similar:

	https://github.com/codespaces

because in 2024, trend is cloud computing. ;-)

Regards,
Boqun

> And quite a few more.  They have at least some of the IDE-provided
> cross-referencing capabilities, though I must confess that I still use
> cscope and vi.  ;-)
> 
> 							Thanx, Paul

