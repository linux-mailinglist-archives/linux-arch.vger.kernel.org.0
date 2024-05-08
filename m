Return-Path: <linux-arch+bounces-4258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452F8BF3F4
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0CE28549E
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9338C09;
	Wed,  8 May 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMHiMyAQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFE79EA;
	Wed,  8 May 2024 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131044; cv=none; b=l8CdXPkXy2qo2O/HNB4yHHK1XP479PRowOh1H83qUN7l3My2WgwoDdVCpNc3i92ghwmk1o8Xz6dyQkiplK6snKNgWpqRKs1AAAobKxbj6eS+OA/aaaWsKgUIanBxNWT2jeS5Iytk2o7B5FBekyQUkX8FDnnwZaPs5LpQLfwbyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131044; c=relaxed/simple;
	bh=q+flXFjjckrLPgiVDLB1Ixl+QXYQc/Y230a9unJhNo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwHJSHBzIX1u7VeA2F9+/YFpEAHUM9gFsNdKAI3cj8rzp4vN/VVPSSYRl4ONSrQN3SsyecCqb085wIai8siBv9qUAhZEvKWWcVW/aZ3eNyDImf5WnNlOg/9eVJceeg8UvPJDECwhtlqgUUgoK/b/s2143ZcgBime5JdRV5OClEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMHiMyAQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a934ad50so868303466b.1;
        Tue, 07 May 2024 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715131041; x=1715735841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxC2TtexmcaRDAYZCHXgg+btsYEd2qPKlrWiDWoUjPA=;
        b=DMHiMyAQhQamuaF4h/sDHDnN11CD5xGPoH3M/VGzgf86Yl2qmj+RedWQPlctV7VfMF
         JrQ9xC3r1XLikW6QE80G8AXQd8TT+EkCWvSMDlOhCt1hbGc5Q1+yO6FS1uaL2nUm84u0
         ymonqRRAT32Qy5YT0VptxUjr6ZBRJKl0pTu8LgxayIUtNxSjJXX4LVXEZXJrTLYkx5zt
         xAC7h8YgwCeIoCmXRd1bpjvnzs1KkF2SNbb0ut3/0+bicuC6qo5a67ecNzC1jXjploqp
         nGlbTh9A8D5Z/bEznfQ56mk/UptlTadPz70ZjqwjUGR5HvFi4cWtdl0kLblYl/CsPmyR
         fSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715131041; x=1715735841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxC2TtexmcaRDAYZCHXgg+btsYEd2qPKlrWiDWoUjPA=;
        b=WHM9KQR0TUQK8wIIdQbmQqZXcxwg7i7RoOwxvxEJiAbpMbc6uHkfMXtlASji54JJUu
         zUAOIzaTDkUSStLhpTjpi2GUMzJ6YCpJTZuon34xbmPZLr499bENEYpXC12TOKyMD7X8
         dn68Kl24O9TnIpGGhMpsomdHmMujVm4vCZoeCi1xzfIne5eL/Nd42Y30h3jHK2fw6/7w
         R/r+n8Z+QGRSMB0JsjJK6amny12trhFqnsqRI6ijLRfAiwVlF/IxAHi7BE7RvRMS4B1l
         6uzrxfU8+JTLk194FUXS9OVHlRQfS9hKelpl+MHZmHwIS73+9Z2D9qKBJE3VSEVrtBn7
         9QYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBuTR/pWliqyAq2QIuF9ZulUFbOwKX5D3oeULqm/61HrxtK1XWqZKealwi1Qed+wXrJkgIzPZH9I1ab6K5WICuhh3NGziEU4O788KT0F838AHAvN3H1THWuNQ+6GY9Tv1cO3D6+L0T0cnBk83ynecJHX85h1lpwNXZkSyv8gNiKQLQAA==
X-Gm-Message-State: AOJu0YyY/QVOlZad1VOOkPe28a3tquvxGPNM1LrCYLUOx2XQQ0O3Xrxf
	OYn1twlca8IlymuoY9M6DDBbpcOOOv8wU84JyKN960hm5EOCt3jQ
X-Google-Smtp-Source: AGHT+IHa3tmWcdaiXdb1wvbTrDNRAA3RlVMxEe8irj/3vOirRww0C4SAaF+FEdUJGS58+x7jb8P9sw==
X-Received: by 2002:a17:906:a449:b0:a59:a0c1:b222 with SMTP id a640c23a62f3a-a59fb95d71dmr55407866b.39.1715131041187;
        Tue, 07 May 2024 18:17:21 -0700 (PDT)
Received: from andrea ([31.189.114.81])
        by smtp.gmail.com with ESMTPSA id gc4-20020a170906c8c400b00a59b2c5003csm4304004ejb.23.2024.05.07.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:17:20 -0700 (PDT)
Date: Wed, 8 May 2024 03:17:15 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
Message-ID: <ZjrSm119+IfIU9eU@andrea>
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
 <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
 <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
 <c168f56f-dfae-4cac-bc61-fc5a93ee3aed@rowland.harvard.edu>
 <fd2369ed-1e84-4e44-ac80-cd316f8e7051@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd2369ed-1e84-4e44-ac80-cd316f8e7051@huaweicloud.com>

> > Don't the annotations in linux-kernel.def and linux-kernel.bell (like
> > "noreturn") already make this explicit?
> 
> Not that I'm aware. All I can see there is that according to .bell RMW don't
> have an mb mode, but according to .def they do.
> 
> How this mb disappears between parsing the code (.def) and interpreting it
> (.bell) is totally implicit. Including how noreturn affects this
> disappeareance.

IIRC, that's more or less implicit  ;-) in the herd macros of the .def file;
for example,


  (noreturn)

  - atomic_add(V,X) { __atomic_op(X,+,V); }

    Generates a pair of R*[noreturn] and W*[once] events


  (w/ return)

  - atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)

    Generates a pair of R*[once] and W*[once] events

  - atomic_add_return_acquire(V,X) __atomic_op_return{acquire}(X,+,V)

    Generates a pair of R*[acquire] and W*[once] events

  - atomic_add_return_release(V,X) __atomic_op_return{acquire}(X,+,V)

    Generates a pair of R*[once] and W*[release] events

  - atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)

    Generates a pair of R*[once] and W*[once] events plus two F[mb] events


  (possibly failing)

  - atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)

    Generates a pair of R*[once] and W*[once] events if successful;
    a single R*[once] event otherwise.

  - atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)

    Generates a pair of R*[acquire] and W*[once] events if successful;
    a single R*[once] event otherwise.

  - atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)

    Generates a pair of R*[once] and W*[release] events if successful;
    a single R*[once] event otherwise.

  - atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)

    Generates a pair of R*[once] and W*[once] events plus two F[mb] events
    if successful; a single R*[once] event otherwise.


The line

  instructions RMW[{'once,'acquire,'release}]

in the .bell file seems to be effectively redundant (perhaps a LISA backward
-compatibility?): consider

  $ cat rmw.litmus
  C rmw
    
  {}
    
  P0(atomic_t *x)
  {
	int r0;

	r0 = atomic_inc_return_release(x);
  }

  exists (x=1)

Some experiments:

  - Upon removing 'release from "(instructions) RMW"

    $ herd7 -conf linux-kernel.cfg rmw.litmus 
    Test rmw Allowed
    States 1
    [x]=1;
    Ok
    Witnesses
    Positive: 1 Negative: 0
    Condition exists ([x]=1)
    Observation rmw Always 1 0
    Time rmw 0.00
    Hash=3a2dd354c250206d993d31f05f3f595c

  - Upon restoring 'release in RMW and removing it from W

    $ herd7 -conf linux-kernel.cfg rmw.litmus 
    Test rmw Allowed
    States 1
    [x]=1;
    Ok
    Witnesses
    Positive: 1 Negative: 0
    Condition exists ([x]=1)
    Observation rmw Always 1 0
    Time rmw 0.00
    Hash=3a2dd354c250206d993d31f05f3f595c

  - Upon removing 'release from both W and RMW

    $ herd7 -conf linux-kernel.cfg rmw.litmus (herd complains... )
    File "./linux-kernel.bell", line 76, characters 32-39: unbound var: Release

But I'd have to defer to Luc/Jade about herd internals and/or recommended style
on this matter.

  Andrea

