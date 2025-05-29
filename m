Return-Path: <linux-arch+bounces-12146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BBAC84DA
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 01:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29B01BC4797
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65422B598;
	Thu, 29 May 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HyH5Ogtv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB921D3D3
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560480; cv=none; b=IgWBt1/YSs2gdYhT/zKnwaY6zji/skwpT2mneeG7J7RyCoOXQcn95FeTftYYlfcL0YphSN5qHgVm6jMoctP5q3tNvgf1hlgeS6z9V72lwDdFPMWqNXoEu0HllGHPeDENcQg28RepL2k1xTyZMoPf+YRgPbyoBqWWyRJIXDfx5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560480; c=relaxed/simple;
	bh=82aH58/OR0lhXutdEGfFFolRSVqVk4YWdp/gYCJthhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geqo4juA8fChaIimykb4NoU4wnA/ExBPnEyh+l979YDThh52i8HCgYtT3kqbEdli8XO32JV4Mz3sW4HxM4oFlECxPUgdnWeVp86mbzz366A6bqvtIqOXtJ3xk6Rh4T3CzdXVvQQrcjaUe3S7aXP9Qf6YyfNFkVxIU236YuxxWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HyH5Ogtv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a43972dcd7so13521951cf.3
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1748560477; x=1749165277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B8M5wTYZuijeurw8QK1WHO/ILS2jrTlhZFmFoRTN/Y=;
        b=HyH5Ogtv/bAKYdeGFzkyKULzvcWBQ61X3a0HjhTxtCLXQX0Bl0xKR9BEh0KGoKMKSj
         otczVuO2br0wmF2rFklkafmoV0hxzHen4tYQB9A/FsAJb8nBmfJlVKYIZg+1sB95cCOq
         Zy9Q9DW18+JYlsFZApL8iyVmqLn1Jgfg9thXFshmBAr1PgBakIgGdh4tymdC91HRIoY5
         sRQtefrELhWmW67eLkro/GffOiRU3/bxcF9wZZqXQeXPPAPmhqIU0f7y54/VnOF5w1o1
         VoZAc+xqNcLdkQ/bGRjCfsPrOKVrRPlmlfBSXQxdoeUUE2Y8Be3oxDifdR42JMvqka5x
         MhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748560477; x=1749165277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B8M5wTYZuijeurw8QK1WHO/ILS2jrTlhZFmFoRTN/Y=;
        b=p6TsFZoFLcLpFSFbn3fTNhTJZ2/vj1HCawMvjRTFVoBfQS+oW2OVaOADnOT0pGGnj7
         QTIYyxHTRlrCOX/Lkt6b3Glm9ENn+KKp5leOIE/xR4iJE//T9qOgTh5pEJ1RP1wECjxL
         +PHT64QuNHD88i1LLXXtnJIW96wg5BZf00MWoGjJ4eV4aZ3jKtAmhPxrEm3BlWpB6BO5
         MZiEBE5KZ3kf3ZRlUpZOp3476kTODiZSBshwei9Fdn50pjJiz42A72YtQ7RRF2v+OxlW
         p697f7LQ4M3NWf4VFx7M/d5C0f/ypheXbRPYbU7UdDcKtMqArjVbhvMFvel2iF6d3S1m
         nOpA==
X-Forwarded-Encrypted: i=1; AJvYcCWWiYfooJN5IfUpVLvfucp75nUjphfhTtunmN5l/K7kC0wHwWhS50p0UY+vMdaXdXh/WobZDTbOGm0w@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuTzJgA4qbhVgBXuCO/4sH+7jioprqg5spnFecjZsiI6LMMH3
	LajXoeoewAJ4lk8FU+ZEHdso9+nAR2QwV8TcFthvnMG40DaySEBV+RlziN0r1yxxXpA=
X-Gm-Gg: ASbGnctY++N48p7n/TMME/3WLKI/9iyF/BrJDgwTJuKY4Uq8Uhe/eydzcBO1lVwGSe5
	3neP3GbiY3BUgFBeQIrHU72f55vySOLo1MgSxbZV09gLAY+1+EY71yd/QWectwF1SVCCE5Nw79V
	kpr+fRzYh5zqbaGw+5tggxy5Hm7lZZEwBsc6nGIvEKKp/RY2LUtnT1aKj9HxsXoLuvjXWky4H3M
	FA746poage2qFdeuAzvsv6anO3vkGPgsnRwUaH7unb1EJdptQBrIsFUY5YKgamTEM0Mfkgtv7DR
	6jMT55r9lfAO2J0pPmUR3p6flcDNS4Z7szK4BQMeidvmIWWWHQ==
X-Google-Smtp-Source: AGHT+IH39k+/aVil5iL6wSfx1rri1NcKXfcLj3pE16Pc8yYjcX2Yvk9Lsla/f5OW48LamZwx8C0WJg==
X-Received: by 2002:a05:622a:608f:b0:4a4:3924:96b9 with SMTP id d75a77b69052e-4a4400e2419mr23361561cf.52.1748560477322;
        Thu, 29 May 2025 16:14:37 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a435a377f1sm12758531cf.61.2025.05.29.16.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:14:36 -0700 (PDT)
Date: Thu, 29 May 2025 19:14:32 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <20250529231432.GB1271329@cmpxchg.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <klrw3rjymes6phs5erz7eqkjji5oe3bg4j4jbqpjv3qzuw4vra@k6ei5pssfany>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <klrw3rjymes6phs5erz7eqkjji5oe3bg4j4jbqpjv3qzuw4vra@k6ei5pssfany>

On Thu, May 29, 2025 at 05:24:23PM -0400, Liam R. Howlett wrote:
> * Johannes Weiner <hannes@cmpxchg.org> [250529 17:14]:
> > On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > > Barry's problem is that we're all nervous about possibly regressing
> > > performance on some unknown workloads.  Just try Barry's proposal, see
> > > if anyone actually compains or if we're just afraid of our own shadows.
> > 
> > I actually explained why I think this is a terrible idea. But okay, I
> > tried the patch anyway.
> > 
> > This is 'git log' on a hot kernel repo after a large IO stream:
> 
> Can you clarify this benchmark please?
>
> Is this running 'git log', then stream IO, then running 'git log' again?

Yes, but it's running git log twice first. On the vanilla kernel this
is the number of references when we usually activate.

You can substitute any sequence of commands that would interact with
the git objects repeatedly before a pause where programmer thinks.

You can probably get similar mmapIO patterns with sqlite, lmdb, etc.

Periodically running executables and scripts are another case. They
tend to be less latency-sensitive I suppose, but would still
unnecessarily eat into the available IO bandwidth.

