Return-Path: <linux-arch+bounces-9019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F79C48A6
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 22:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6A6B2630A
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11C166F32;
	Mon, 11 Nov 2024 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgG39R/K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C316DC3C;
	Mon, 11 Nov 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361467; cv=none; b=ee+VANL4jr8QZdsCk9Cd1VFyA5Cpcjyn8bazj54B1e7WIYCmTk3UmRaBpwKL6iZH02yAMaLcTm/hCJm1YTi85t+qKmCur4qWvVRbMwl1skN1U78Ykd9Adpg/ynwdRhXhMw203rk+9hip0KEI/PvO49X8rHMpuCaWA3jJqpEFV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361467; c=relaxed/simple;
	bh=hr28Jzb4t27J6dZ45ZmNnAwUhS5FlHHu4qHutaG4GVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjlql0yHjuFEEja3b2HpLJGoUrFWwItMmX3uMYCXYSnSHt9wyFr8H2mVVXyMJ7aUtuwFmfJaSaEADNYkxug6y7brjZcPybbr195LCfJk+TgMxhJN3oq6mxvUZSuZPVf1p9ofAaCTqdifiFu744zrNR2b1CTvsN+l8JHee8PdLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgG39R/K; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460ace055d8so37369771cf.1;
        Mon, 11 Nov 2024 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731361464; x=1731966264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itkjvb9I+aBKuWOCo7K0Xg8I/MkZ4NMqhq67SD9l5UM=;
        b=PgG39R/Kf9ps4/Dianv4xwBn1M9kqi/RiG4w6aSiXmsIVlsGDiZmNjws+b8fBUGj00
         0qLe1u3P5qeXdCiMmR7x/wBZUYc8t0NE0oIYSQ1HKZYslVOMwp/4XNGSSc7FxJSUxa1L
         PbNlSXPH/zRrZ/ivVasHoCS5yA3WSVgCN1Wg08d1MH6YrKYhrmjPcXV+8hW90PpjFJqq
         +FcAiVHBjJIOehyX2bkpW8iVOhdVRKThrFlzsKwuMeCQWPGrD8KMSvwmXWbikx6F5NaI
         aEMHJWK90SD+ZQEiMWGvATjmyngO2BC4m7KufzqmhzrF1MLfJPYE5bgRqSf8kSyryVar
         u06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731361464; x=1731966264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itkjvb9I+aBKuWOCo7K0Xg8I/MkZ4NMqhq67SD9l5UM=;
        b=gnYYhdEJYUawZDKO0G0QiJgrD0keATFKS/NzeHI4HcVaezH/RAnUeJO6SeY0sAhDSv
         RJ0/kYe+DFyumyN+VdgsrOF2RV6MNxMG8s4gpkwgeyHOrhMI6cC7UHDyoODRKumswpCF
         UOgd6Dbou79RzKKwk5qCKemXFj6Gg8I2zEt4WouY375zOHOQks5XlIyvi0PeI1fXKycc
         k4E8VJeX5YCT6NsPuOhqn46F2b9X2EcVoRQyyOeAbqZ9346XlbfeIkwUCQxpV7xQwtmg
         adHa1kj6m1VPQusTM7p+9oKD5kPWsmHhvjTlBHIcMTigLpbiTJn45O+NT8BdFTpI6uBt
         pSMg==
X-Forwarded-Encrypted: i=1; AJvYcCWmBYtUVrDxjd8UU8WCMU2MmS/r+Ao6fhOkkLYoRfPe0i11ipncwQtuIRnxG5gQatD92kzR+Sy70hAa@vger.kernel.org, AJvYcCWqcJoXG+HmvjMzpIV6hbNRbtf8QbWClXzAjr9XhQ07cZ+rA9XG4LQGHG+CGCrlyjKGPG+tW0OqJUn7MpzK@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3XOVgXEU2QbTNPKgBnDNjtj7kqf6+54lYC/GpptpJH+A8bXE
	fj7sZfPUeJ/S41PhErdDgR1wllXgD+Z8gnvFbbmBnq1MBZgEwIpj
X-Google-Smtp-Source: AGHT+IGGQw9xSO9K/8sKheTnSqCCrMGLDs/3H9lx42LPWQzzQrl0qeQ/9F1j4zfJWVeXoYWW3Q53Rg==
X-Received: by 2002:a05:622a:610a:b0:460:af80:ceb9 with SMTP id d75a77b69052e-4630931929dmr154291581cf.4.1731361464452;
        Mon, 11 Nov 2024 13:44:24 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df35fsm67597831cf.13.2024.11.11.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:44:23 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 62C241200078;
	Mon, 11 Nov 2024 16:44:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 16:44:23 -0500
X-ME-Sender: <xms:t3oyZ15xjU9DUDwOp_DiqtIv9vKgm9e3DSlPFpfuR5GhIbOvUufpww>
    <xme:t3oyZy7VsUEOgzZDybzoh_sdyZ6bRN-oF4dFD4C4AeX1c3Owkk5tB8s_ZVSweVMwL
    0_fEStMUJQPU3lFWg>
X-ME-Received: <xmr:t3oyZ8dwByCYCo405nSqIW6zlVsGHjhVycS7RIwat4h2-f_6ydE2Xj3jCoq16w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddunecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepveehte
    ffvdffteekueduuedukedtgfehtddugfehvdfgtdegudffhfduudfhjeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghg
    hihsiigvrhgvghihsehfrhgvvghmrghilhdrhhhupdhrtghpthhtohepphgruhhlmhgtkh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgr
    rhhvrghrugdrvgguuhdprhgtphhtthhopehprghrrhhirdgrnhgurhgvrgesghhmrghilh
    drtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhpihhgghhinh
    esghhmrghilhdrtghomhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepjhdrrghlghhlrghvvgesuhgtlhdrrggtrdhukh
X-ME-Proxy: <xmx:t3oyZ-I61SD9KdNwIrq7IS0mn9GxjXdKd_af53m8gTMnaab25cU8-Q>
    <xmx:t3oyZ5LiTA6zCjpTbAEZvVG8HMWctoSDJYOfu4o2yGos2aJgIQJ0cQ>
    <xmx:t3oyZ3xAyiWWY-iFfdayu9MATUzEa2b-3i2-NOSaa-kMEx6FDgFUCw>
    <xmx:t3oyZ1Ju-jlA2Qqb7KRfcY2PyXn3-DJvRNmeym162R0bi2sstBaErw>
    <xmx:t3oyZ8ZxB4fp2x5qhkbALSYYP4i5zVACDr0vYEGzduG4A42foncExZwp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 16:44:22 -0500 (EST)
Date: Mon, 11 Nov 2024 13:44:21 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: =?iso-8859-1?Q?Sz=22oke?= Benjamin <egyszeregy@freemail.hu>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <ZzJ6tWbbdi-zlxS3@tardis.local>
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <ZzJ13eM2SNNB3fl7@tardis.local>
 <10ffb1e1-163d-4e30-9be3-0f229f3b7492@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <10ffb1e1-163d-4e30-9be3-0f229f3b7492@freemail.hu>

On Mon, Nov 11, 2024 at 10:39:07PM +0100, Sz"oke Benjamin wrote:
[...]
> > > 
> > > There is a technical issue in the Linux kernel source tree's file
> > > naming/styles in git clone command on case-insensitive filesystem.
> > > 
> > > 
> > > warning: the following paths have collided (e.g. case-sensitive paths
> > > on a case-insensitive filesystem) and only one from the same
> > > colliding group is in the working tree:
> > > 
> > >    'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
> > >    'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'
> > > 
> > > 
> > > As you a maintainer, what is your suggestion to fix it in the source code of
> > > the Linux kernel? Please send a real technical suggestion not just how could
> > > it be done in an other way (which is out of the scope now).
> > > 
> > > Is my renaming patch correct to solve it? Question is what is the most
> > 
> > No, because once you do a checkout to a commit that previous to your
> > changes, things are going to break again. The real "issue" is git use
> > case-sensitive file names, so unless you can rewrite the whole history,
> > your "solution" goes nowhere.
> > 
> > Regards,
> > Boqun
> > 
> > > effective and proper fix/solution which can be commited into the Linux
> > > kernel repo to fix it.
> 
> 
> My renaming solution can not fix the old history line, but after this patch
> in latest master branch there are no any issue anymore, in git cloning. This
> the bare minimum solution which can fix its "cloning" issue for the future.

You asked for a technical issue for doing the renaming, and I gave you
one: simply renaming doesn't solve the issue you want to resolve,
develop Linux kernel on a case-insensitive filesystem. Do you admit that
the original issue won't get fixed with your patch? Then technically,
the best way to "work around" it is to use a case-sensitive filesystem,
right?

Regards,
Boqun

