Return-Path: <linux-arch+bounces-9028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616A9C4B78
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 02:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626ECB2D189
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41A1F7564;
	Tue, 12 Nov 2024 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcJ4pegL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708C2AF06;
	Tue, 12 Nov 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373360; cv=none; b=S3KrIK4/PTyMxFLxRzTyPkVULosv59u4NEg5Xo5rlArVGEUBtpd/wGqw+biIhLUsAVoEI6PY0lIY139KH4S+QlHLOXDpWtH4UibVfxPuRNxQ/CwQNFyycXZpBIJSNt/sNB5Ij8xJVp/6cVQriWmvpH2oCnHCFGtkQO/pkszgkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373360; c=relaxed/simple;
	bh=fyy2IM9XG9szxI/PWCnUonVVBEE2MInbTFU3884NMY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phee6Sl2CJudIWfS8V2LgpSWnY57uELY54fNqbE7ybDr+PBLmtoocqqG5+x1IziN2s++jjtq1aNUUPOwwifEIvW7HNHLdHk2uha1Jl4F6ONyd8jf8qKui/gI5c/u0s8Gm1rGZ+301aOFKfde0V7Ycnnwjy6gJyaRXCStY06Bg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcJ4pegL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1418058bbso343983685a.3;
        Mon, 11 Nov 2024 17:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731373358; x=1731978158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vGvxjMuzZiaW48tpjOWF97MsJFZ160bBlUK8dTgJsd4=;
        b=lcJ4pegL1jHxRqkvoBmb98IXOPsXBdMcyItmxHMlDa19qBQQmA7d7n3etHyyXVWaUX
         MKsM5ws7VFA9kBxT/fH0gAMFkzrTnsE+oAM1GMvy4VXCL4bu9sQYXf3QbKolSgpYe5eU
         NSmPnfRZrq4dyUb+2kBqvQ15CG9PmxXqV/f+EBw/yjun/jcbv4Fszk2TerVko92hS50S
         vTztvHsZQocTCFuzPmh0VknLUzPaKGGrp+eFPeVAKlX98AmrKHXWYfZqYZXv7IcmUhV4
         vz8NgSN8toK6ozhTtdMcRodtLWrE811KjSWW73cmv66QdI4ujWbidUx5K0GKYw5KZEi8
         kZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731373358; x=1731978158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGvxjMuzZiaW48tpjOWF97MsJFZ160bBlUK8dTgJsd4=;
        b=QAoUamQ7x4ELvLMiR5yxgjjdaxFu08haLFbzRuiagvEcJkKqQAvzHHdhv7pR3JllKA
         gtl7HSM2KyejEV0y/ZS01QK65vgxxDiylI8Hq9JNHtbGPqX9IwVf9DaVGfhy/0WYmh7W
         zWyRLvT188GxUZDKV9YinPidopmOBj+ri3JWyMfFjC/+pmir7WpwTiIW3SliGuvegixZ
         7ZgEGTINKZioLF971dg3A4yffcVqilop2UhLxQsPIa2IQwzX1DSTgMU1xs45UnUo+SP4
         3AC8AALCUmkCC403+6as0BPJZvR2E8TFi25AQdy4fg+jhimx6ONpyrQvFrybuuL2J+gb
         wmSg==
X-Forwarded-Encrypted: i=1; AJvYcCUjyWHFtcF1zR38ahK/ktkrxGBxAPR7IJkXitd4kB3yDNlVQfZY4eIoomGk9EwUqoiaKHVsn63j5hHv@vger.kernel.org, AJvYcCXUhUYsX3O36Tj2f9CniuvDkSb40PMR4N0I5SPkx7fPPjkVXWxWKzxAePhLJvNd8Km0ZKyiZcwTuZoWliEh@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtpJ0iqBpyWU/QUn/PQREYhnedD9pgQyopcphFc2hBmcC5kBS
	Kw8svr8T8SMnmo1YR43s2qML0QevRydXzAnMkO+CtD3aLpc57ERI
X-Google-Smtp-Source: AGHT+IHbawZVmkJAnbWWrDKnn13ZvXKyOgmM/LS2hzHpfFeXjCEgw97KH2J2rTKMuPJ1LvMlrPoi7g==
X-Received: by 2002:a05:6214:570e:b0:6d1:8ebd:d181 with SMTP id 6a1803df08f44-6d39e117fc4mr201095716d6.20.1731373357729;
        Mon, 11 Nov 2024 17:02:37 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ef085sm65595486d6.48.2024.11.11.17.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 17:02:37 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id A8AD61200043;
	Mon, 11 Nov 2024 20:02:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 20:02:36 -0500
X-ME-Sender: <xms:LKkyZxyUp2Y65uiTMstbSJUqJQCgOwMR3rcaEvFVBFuc2Eos-5bxeQ>
    <xme:LKkyZxRUMV6hyxhhaW1j1QRlKCgGytIEWT6D52Wn4IYUiEKZ8PZaHxUxwRumlNsJJ
    MHbDh86ZbEykGuM5w>
X-ME-Received: <xmr:LKkyZ7UcWz4H79d5k0WWP5Zw7tywzff_Pg0ZOYsRDYxMDX2i3MpjgBuPci6WsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleekieei
    feegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvghihshiivghrvghghiesfhhrvggvmhgrih
    hlrdhhuhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphht
    thhopehprghrrhhirdgrnhgurhgvrgesghhmrghilhdrtghomhdprhgtphhtthhopeifih
    hllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtph
    htthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:LKkyZzhDVRoBB0apoaj_cWef-CFidf91cMnCjxL8GOKrsKaZBs4RRA>
    <xmx:LKkyZzCzlZR8tMOlnTJjb_UOKu6HKF-rjhiSUVE9Fx3OJc03pEOFOA>
    <xmx:LKkyZ8IH4RNJKhNNPHV-L5xI3UBgoaeCRJZezR1upBs3FMnRdZgElg>
    <xmx:LKkyZyArPnnYfr3ohpwsmc1UkO16Ou09sb0sHwc8izzFym_zrYMY6Q>
    <xmx:LKkyZ3zpZwT_vxFgAbdMd8IfZMfCX4LdC8wPsoU3ykecMupYt1cGDsEu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 20:02:36 -0500 (EST)
Date: Mon, 11 Nov 2024 17:02:35 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: =?iso-8859-1?Q?Sz=22oke?= Benjamin <egyszeregy@freemail.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <ZzKpK_9nxh4Qg6mW@tardis.local>
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
 <705daf58-dd30-4935-9864-6489b9b90a35@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <705daf58-dd30-4935-9864-6489b9b90a35@freemail.hu>

On Tue, Nov 12, 2024 at 12:21:51AM +0100, Sz"oke Benjamin wrote:
> 2024. 11. 11. 23:00 keltezéssel, Linus Torvalds írta:
> > On Mon, 11 Nov 2024 at 13:15, Sz"oke Benjamin <egyszeregy@freemail.hu> wrote:
> > > 
> > > There is a technical issue in the Linux kernel source tree's file naming/styles
> > > in git clone command on case-insensitive filesystem.
> > 
> > No.
> > 
> > This is entirely your problem.
> > 
> > The kernel build does not work, and is not intended to work on broken setups.
> > 
> > If you have a case-insensitive filesystem, you get to keep both broken parts.
> > 
> > I actively hate case-insensitive filesystems. It's a broken model in
> > so many ways. I will not lift a finger to try to help that
> > braindamaged setup.
> > 
> > "Here's a nickel, Kid. Go buy yourself a real computer"
> > 
> >               Linus
> 
> 
> In this patch my goal is to improve Linux kernel codebase to able to
> edit/coding in any platform, in an IDE which has a modern GUI.
> 
> Chillout, i am not so stupid to compile kernel on this "braindamaged setup",
> I just like to edit the code and manage it by git commands.
> 

Then you just need to create a case-sensitive partition, no? What's the
*technical* issue of doing that? And that cannot be more challenging
than testing your kernel changes, right? So it won't raise the bar of a
potential serious kernel contributer.

> So, this is a tipical Braindamaged setup in 2024 for Generation of a half of
> Y (like me), Z and Alpha developers.
> 
> Windows or MacOS system
> - Visual Studio Code for coding
>     - Git for manage kernel source
>     - IntelliSense in coding
>     - Live coding with other developers
> 
> Linux remote server
> - Visual Studio Code remote SSH extension/connection for Linux server
>     - Sync kernel workdir with remote Ubuntu/Debian/RHEL Linux server
>     - Remote SSH compile for X86_64, ARM64 etc ...
>     - Download the build result
> 

How do you know it's "typical"? I just googled it and confirmed I'm a
Gen Y ;-) and I'm not using vscode or any IDE, a lot of Gen Y, Z and
Alpha developers I know either use Linux on their desktop/laptop or they
don't use IDEs. May my experience suffice to say it's not typical? Or is
it the case where I thought me and my friends are the whole world? ;-)

> Instead of Visual Studio Code it can be possible to use JetBrains, Eclipse
> and so on any other modern IDE. The actual limitation is only, that there is
> a filename issue in the Linux kernel source with
> "Z6.0+pooncelock+poonceLock+pombonce.litmus", why git clone is failed to
> work well in this case-insensitive OSs.

They are not "case-insensitive" OSes, they support case-sensitive
filesystems, and they support them for a reason, so just use them. With
your changes, it may be OK at clone time, but as soon as you do some
serious development involving `git bisect`, you might be very frustated
that your setup doesn't work.

So your solution is incompleted (not handling the git history), and your
goal is a bit personalized: it's only useful to people who want to
read/edit Linux code without running it and don't want to use a
case-sensitive filesystem, and that's not very persuasive. I don't think
we can accept the solution or commit to that goal.

Regards,
Boqun

