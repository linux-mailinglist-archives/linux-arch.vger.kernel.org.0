Return-Path: <linux-arch+bounces-9015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD19C481C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 22:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D282B230E9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592F1AB6E6;
	Mon, 11 Nov 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq2/IJlZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0701A9B3E;
	Mon, 11 Nov 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360227; cv=none; b=C+7s51LE084edW44XNHBoTr0XNl8BLNM52YfJnP+T+9faEc0nav9EsvrhfQz4Sz4rIZoE1YMtjN/x6JTliO4rxtP/vcF4h2KrZbq7ihGm8C+WBaQDXyzw+QP1Cl8I1ki670+dSdMwFiYQ7wAepXgssBr649sblp6ZvRRU25KngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360227; c=relaxed/simple;
	bh=tR3ugVURNPnUdfAc/inSHkYJXIyC4Timb6Eya1tPMGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM7xeZOle7u+5HibtIrQpuSmxaC31W8wISUo8Zo4fK8twIcfDOmWIZcBCBzomYRUzrCTHW0HhHkYnFCOfOG42N0sXOk1TMi8dBuXKTVgQG2rdD4L2ncvTjylmHmWfR3/dEXXFFBBVKgqVBcmcFDv2MPc+gmhreFiOR+YucQt+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq2/IJlZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d18dff41cdso29167276d6.0;
        Mon, 11 Nov 2024 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360224; x=1731965024; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7WTh3etYHVX1kIAwWYPPB2h07KISjB/VnFThtU8FCdY=;
        b=Dq2/IJlZKG56YBFFbkEzJkHOL4CCwJNXa9PE6GLbAdmorpwfwWKphZCQk3U0+/C7J/
         kVbKbsHpL3a15KHNpVUcgca6vJe9XL48eFUZaLm//lMXEYIKgZSCs4eFz9ni1szwjExy
         54XbnXiZaFOT476/mE326BdvzywSzxWtCV/HLJmy8H2tNtZBLLSFcfbVxEGjDOtteO9s
         XvwVduNj/AYflW3MamJ71ZEFnedqIj1HfqSiJJL5YiD/QFid1WtvGqh3vB4G9QUGEkbK
         nxg3eIZVVUj1S79OSOPHvijOws1C7Q157W/tU8PTTEcJTXG5jI/LtgGxKQLrc6ttOWD8
         YR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360224; x=1731965024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WTh3etYHVX1kIAwWYPPB2h07KISjB/VnFThtU8FCdY=;
        b=WYoqHBJF+SLW/+9vFMmo/nXnF65/4cz4XBfJJN+rZ7VZ6MWSO6dkzjQm2cri9qGGlw
         iOyZ88dmjrLb9d1awlVFDwYXYwiWHIMYSac+96AMROJvQ9hKRI5aoec90AMDu/N8RAGv
         JS7i/Hcsd2DSmeiyu8ftyqvXociNiAT/vmGDGgM2eIXVCw8l5wH2g8UaAEQ/rWKUDN2k
         5k3c58SIRlIdq8+qbJdF23ASeLaVY0pv8M1q4jOOFs2TpOGSHFE7UeQMhVPtDkYkipl6
         nnYQwoiio6pKylFCFvYeZsZjBdTso73lw+zme0FPghhP1+Fh9nGdzEO/fJdMq/tcLDJY
         oqLw==
X-Forwarded-Encrypted: i=1; AJvYcCUAy53JGaYZ1BX2M6/yJHSfD7kZqUKnryo0crKtNPhlF4vsQSa5FXmza7kA46+h25eA317bfbD5z3Fi@vger.kernel.org, AJvYcCXCrCWsu5pNVa/m/v1ynWJ6JerdZKZjTPiWgrXi6JYHdWTMijyf8KOAKvp1mciOhoocEDZIXfUVdDqBhqKz@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbFVfecLuCrNP7bOIFqxe8VjELCG/EwDN10EAfG0Pc9rsMzuS
	TiAu25eHhKxnAgUsqJBYxl6NcVKK1aqpySUQKJ849mvUfMfHyiQm
X-Google-Smtp-Source: AGHT+IEEG6aLyjaDYPw6dRe3Uxi4XpCjGXKAS4XeWN7/G/xShQ3mQ8cTCqI0wW7xz6MD1JLqdRHbZg==
X-Received: by 2002:a05:6214:5c4a:b0:6d3:5ca6:b3f6 with SMTP id 6a1803df08f44-6d39e1f1f5fmr174864526d6.45.1731360224071;
        Mon, 11 Nov 2024 13:23:44 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961f5940sm64033516d6.49.2024.11.11.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:23:43 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1D2021200043;
	Mon, 11 Nov 2024 16:23:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 16:23:43 -0500
X-ME-Sender: <xms:33UyZ71UU9wIOqEuY-HNOOzFk9ykYa8FwjEX-nSm9ecULG0vGMOPpQ>
    <xme:33UyZ6H-zvmbPKw2ORdcFGSzSCIBrjb5CFMWND0-ty-Ax0O-22CNX9vY1pcBTGg-M
    dKVkTH57NuEXjtI2g>
X-ME-Received: <xmr:33UyZ75os6fe3azB0c3haRL1MB6TZJOmPb79Gm7i7GG8je4msMZOTiURm0gsSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcuhfgvnhhguceo
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtud
    euffeiheeltdefjedtgeejgeefteffjeeglefguefgueffueehueekfedtleenucffohhm
    rghinheprghpphhlvgdrtghomhdpmhhitghrohhsohhfthdrtghomhdphihouhhtuhgsvg
    drtghomhdpfhhrvggvuggvshhkthhophdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeeh
    heehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmh
    gvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    vghghihsiigvrhgvghihsehfrhgvvghmrghilhdrhhhupdhrtghpthhtohepphgruhhlmh
    gtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdr
    hhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehprghrrhhirdgrnhgurhgvrgesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhpihhggh
    hinhesghhmrghilhdrtghomhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepjhdrrghlghhlrghvvgesuhgtlhdrrggtrdhukh
X-ME-Proxy: <xmx:33UyZw25iS9Ci228xSQ1hqdIQxkcdS9U6hABUByefbW5mhhz5SHWng>
    <xmx:33UyZ-E8JRTEQ4eYoH0YAW78vkWlrHiPk82WedTunpE1c_phq-FJiw>
    <xmx:33UyZx-u38aucXHFOQ8Tu8asUs1nrXGJIXqfkhFnsy3Fcg7bY36gtQ>
    <xmx:33UyZ7mO3nybiHPE2q5QEjQdE1gyDNaSIAMc-9t6vopo8LX7prpGLA>
    <xmx:33UyZ6HHOSgA9v76EY0NyU6FA8xmA5HW4au5CN_vO-6NK05kgsCGh8jd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 16:23:42 -0500 (EST)
Date: Mon, 11 Nov 2024 13:23:41 -0800
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
Message-ID: <ZzJ13eM2SNNB3fl7@tardis.local>
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>

On Mon, Nov 11, 2024 at 10:15:30PM +0100, Sz"oke Benjamin wrote:
> 2024. 11. 11. 21:29 keltezéssel, Paul E. McKenney írta:
> > On Mon, Nov 11, 2024 at 08:56:34PM +0100, Sz"oke Benjamin wrote:
> > > 2024. 11. 11. 20:22 keltezéssel, Paul E. McKenney írta:
> > > > On Mon, Nov 11, 2024 at 07:52:50PM +0100, Sz"oke Benjamin wrote:
> > > > > 2024. 11. 11. 17:54 keltezéssel, Paul E. McKenney írta:
> > > > > > On Mon, Nov 11, 2024 at 05:42:47PM +0100, egyszeregy@freemail.hu wrote:
> > > > > > > From: Benjamin Sz"oke <egyszeregy@freemail.hu>
> > > > > > > 
> > > > > > > The goal is to fix Linux repository for case-insensitive filesystem,
> > > > > > > to able to clone it and editable on any operating systems.
> > > > > > > 
> > > > > > > Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
> > > > > > > "Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".
> > > > > > > 
> > > > > > > Signed-off-by: Benjamin Sz"oke <egyszeregy@freemail.hu>
> > > > > > 
> > > > > > Ummm...  Really?
> > > > > > 
> > > > > > Just out of curiosity, which operating-system/filesystem combination are
> > > > > > you working with?  And why not instead fix that combination to handle
> > > > > > mixed case?
> > > > > > 
> > > > > > 							Thanx, Paul
> > > > > 
> > > > > Windows and also MacOS is not case sensitive by default. My goal is to
> > > > > improve Linux kernel source-tree, to able to develop it in any operating
> > > > > systems for example via Visual Studio Code extensions/IntelliSense feature
> > > > > or any similar IDE which is usable in any OS.
> > > > 
> > > > Why not simply enable case sensitivity on the file tree in which you
> > > > are processing Linux-kernel source code?
> > > > 
> > > > For MacOS:  https://discussions.apple.com/thread/251191099?sortBy=rank
> > > > For Windows:  https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity
> > > > 
> > > > In some cases it might work better to simply run a Linux VM on top of
> > > > Windows or MacOS.
> > > > 
> > > > They tell me that webservers already do this, so why not also for
> > > > Linux-kernel source code?
> > > 
> > > Why we not solve it as simple as it can in the source code of the Linux
> > > kernel with renaming? It would be more robust and more durable to fix this
> > > issue/inconviniant in the source as an overal complete solution. Nobody like
> > > to figth with configuraition hell of Windows and MacOS, or build up a
> > > diskspace consumer Virtual Linux with crappy GUI capapilities for coding big
> > > things.
> > > 
> > > Young developers will never be willing to join and contributing in Linux
> > > kernel in the future if Linux kernel code is not editable in a high-quality,
> > > easy-to-use IDE for, which is usable in any OS.
> > 
> > There are a great number of software projects out there that use mixed
> > case.  Therefore, can an IDE that does not gracefully handle mixed case
> > really be said to be either high quality or easy to use?
> > 
> > In other words, you have the option of making the IDE handle this.
> > 
> > > Need to improve this kind of things and simplify/modernize developing or
> > > never will be solved the following issues:
> > > https://www.youtube.com/watch?v=lJLw94pAcBY
> > 
> > Sorry, but that video does not support your point.  In fact, the presenter
> > clearly states that this sort of tooling issue is not a real problem
> > for the Linux kernel near the middle of that video.
> > 
> > 							Thanx, Paul
> > 
> > > > > There were some accepted patches which aim this same goal.
> > > > > https://gitlab.freedesktop.org/drm/kernel/-/commit/231bb9b4c42398db3114c087ba39ba00c4b7ac2c
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?h=for-curr&id=8bf275d61925cff45568438c73f114e46237ad7e
> > > > 
> > > > Fair enough, as it is the maintainer's choice.  Which means that
> > > > their accepting these case-sensitivity changes does not require other
> > > > maintainers to do so.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > > > ---
> > > > > > >     tools/memory-model/Documentation/locking.txt                    | 2 +-
> > > > > > >     tools/memory-model/Documentation/recipes.txt                    | 2 +-
> > > > > > >     tools/memory-model/litmus-tests/README                          | 2 +-
> > > > > > >     ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
> > > > > > >     4 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > >     rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)
> > > > > > > 
> > > > > > > diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
> > > > > > > index 65c898c64a93..42bc3efe2015 100644
> > > > > > > --- a/tools/memory-model/Documentation/locking.txt
> > > > > > > +++ b/tools/memory-model/Documentation/locking.txt
> > > > > > > @@ -184,7 +184,7 @@ ordering properties.
> > > > > > >     Ordering can be extended to CPUs not holding the lock by careful use
> > > > > > >     of smp_mb__after_spinlock():
> > > > > > > -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> > > > > > > +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
> > > > > > >     	void CPU0(void)
> > > > > > >     	{
> > > > > > >     		spin_lock(&mylock);
> > > > > > > diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> > > > > > > index 03f58b11c252..35996eb1b690 100644
> > > > > > > --- a/tools/memory-model/Documentation/recipes.txt
> > > > > > > +++ b/tools/memory-model/Documentation/recipes.txt
> > > > > > > @@ -159,7 +159,7 @@ lock's ordering properties.
> > > > > > >     Ordering can be extended to CPUs not holding the lock by careful use
> > > > > > >     of smp_mb__after_spinlock():
> > > > > > > -	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> > > > > > > +	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
> > > > > > >     	void CPU0(void)
> > > > > > >     	{
> > > > > > >     		spin_lock(&mylock);
> > > > > > > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > > > > > > index d311a0ff1ae6..e3d451346400 100644
> > > > > > > --- a/tools/memory-model/litmus-tests/README
> > > > > > > +++ b/tools/memory-model/litmus-tests/README
> > > > > > > @@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > > > > >     	spin_lock() sufficient to make ordering apparent to accesses
> > > > > > >     	by a process not holding the lock?
> > > > > > > -Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > > > +Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > > > > >     	As above, but with smp_mb__after_spinlock() immediately
> > > > > > >     	following the spin_lock().
> > > > > > > diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > > > > > similarity index 100%
> > > > > > > rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > > > rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
> > > > > > > -- 
> > > > > > > 2.47.0.windows.2
> > > > > > > 
> > > > > 
> > > 
> 
> There is a technical issue in the Linux kernel source tree's file
> naming/styles in git clone command on case-insensitive filesystem.
> 
> 
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
> 
>   'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
>   'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'
> 
> 
> As you a maintainer, what is your suggestion to fix it in the source code of
> the Linux kernel? Please send a real technical suggestion not just how could
> it be done in an other way (which is out of the scope now).
> 
> Is my renaming patch correct to solve it? Question is what is the most

No, because once you do a checkout to a commit that previous to your
changes, things are going to break again. The real "issue" is git use
case-sensitive file names, so unless you can rewrite the whole history,
your "solution" goes nowhere.

Regards,
Boqun

> effective and proper fix/solution which can be commited into the Linux
> kernel repo to fix it.

