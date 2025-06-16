Return-Path: <linux-arch+bounces-12349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92493ADA823
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jun 2025 08:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72F83A5B86
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jun 2025 06:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E61D5AC0;
	Mon, 16 Jun 2025 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZb9yk5t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085819DF8D;
	Mon, 16 Jun 2025 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054919; cv=none; b=tEiCSyvB4gdGgHAS2d3iqi2FUT+tEQlWjDusfRyM2yRCr8jZEFmlKfPiAFCRfjkMece+Fhvu518MdF0FKxwHsQq36qNHEXK9cI8RbVUo1teyoA0dldECVSEz+RlqRBLW+UaYFTwVPLG2s7UFzaz2+BUPj9d4HZnLliDcQWqvPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054919; c=relaxed/simple;
	bh=icqJHukmdflxT9C8ejGfp7Xtqb9ufi/MGmKigZ6xWyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLAd8SjonkVy9zso3Ee+RBm7mLQQyhZ32699L2O1GKM1Lbh8MvBGWDt/RkSdd3TYGVBtsQteYXpC7RJC3BNREKy6d+bL+qB8pjXqt8fao2gc8k+a+CIzDw8pY2W5WYL8c6tEUY3DTKv5mKcsg1G2th1HlDOOTa4Fm+bTu913ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZb9yk5t; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45347d6cba3so1192795e9.0;
        Sun, 15 Jun 2025 23:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750054916; x=1750659716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9ZPORgpv1nblhxKmsdSf/LKYwc5iD3Bg9h5qXnwBPI=;
        b=YZb9yk5tB60zlW0YbKVCj1DLwhcq4slc8AmIxQuH1cxQlj0DLrqQd3oaMNFX9p/RAc
         aDJ3QJ4EaXjP8bCKpg/Qs6BY+/f0tSjvQx/3E9ayYo6/el6oprQXrdRBryTMk/k80aA6
         wqL3B0xc7a/iTl2aUvEgbwbHEkKg/j38t2H3h//ofRPLmthDTwdriXH3u+AMQq+BPkyS
         OAnypJ5IKGw1ZEuFhCBN879oSpzpoZR7stTMkL3A1BufFM1nOTr3I+h7uoCuKtotwC6r
         Tt3RkthIQMJJD8UJPnS0Y2DHGBQYI7UU22cjfN9FQmX1lpdQp7n4vvev2txpgfa9T3O/
         n8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750054916; x=1750659716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9ZPORgpv1nblhxKmsdSf/LKYwc5iD3Bg9h5qXnwBPI=;
        b=LB1wjaXj7nox1ks9+svLiA3XcOvGXX7n4JdsBWJDuAVeBl2+sbof8L3zxnWBGbNdPJ
         3kMx+1LU0TJb8LFia46CQMq61Sns2DvdXp3EnXyeoQ6AdIOo8/5yj4zfhBzldE0UwMuO
         ngfcLI4U9UgsjgSkYN+gAOAWuA5uu7yYt2OBU1D+tjugWi8J9xZwBUUyS8TDfs7Dy9LK
         /u9SsMKRelQj9GKAWcM/gw9s0n9JDH71KnB1ao6S5qee2QINyL1NHu5NFNgKwgQgVeao
         prA6VBAIMESFlX28z8Xa5SRvaxZO+yZH7gFAD46i7LxvIb0W72FLqbV8BAG8HX/BeKQn
         XZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVqPDAX2X1ARGoDHNRsa3JDAa0KnQ1muMiMrdIBLSaCWacsi966aRNujcDZ64dF4UK7kHhhjwZQj5X3jotj@vger.kernel.org, AJvYcCW4XhOw9RbehACxUb4lwKjFupalkcNSmMY0BppFgViRNh7nMuDsouS7qJ5cu5Yqi3TsaoMAlmvPJdmQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yypo/wwY4AZ8Es6b3rjzjkQJ6e5v5Kkrjitwm+D+Lve4KHtq9G0
	krMZYrp5bnkJg6QetrVMR6/ULwaQzpgXFSrPKUmUK1FJ9wuqdukOwA1j
X-Gm-Gg: ASbGncv5RZ9f78gDZkOo4bwNUi61x3TSwNNJ8yK1dmmwNkqk67eOtkcBv2UGk31LwkG
	RsexMTPL21NCd1MRsbh+We6zqZwfDSsnwWJlaYQV8M9/ofay9V45WoInam2xMM6NBtjlmhEuY8X
	PsqK07+GJZsBi/N0PN/FwJxpSu1oU+rj1fiDiMi4FHVytfZWlHMoSFvbGzm2b3yMrjPh3yrZzO1
	iA/Qyx03H9cOOlqeIaKoQQcbR4XMSDtX2jANLiethUOwo1VKkR4pWY0aVqtiVnQU0/Zg0OmPYgC
	P6MDnv+dPHUKdiH3ad0O8C4Cgb9K/i8szgriGRP19n9q5K/g1fbjK9Zy
X-Google-Smtp-Source: AGHT+IG9ZWTEgCidrMuLIT5G1uCdLIAIbic32LoaPu3oR82xk4/LzfXaXAvhVp87oo7HGLOl9B4xxQ==
X-Received: by 2002:a05:600c:8b02:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-4533cadf85dmr74581845e9.4.1750054916136;
        Sun, 15 Jun 2025 23:21:56 -0700 (PDT)
Received: from andrea ([31.189.73.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4533fc6578csm65401625e9.19.2025.06.15.23.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 23:21:55 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:21:50 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Thomas Haas <t.haas@tu-bs.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <aE-3_mJPjea62anv@andrea>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea>
 <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>

> Thanks for the praise. I expected more questioning/discussion and less
> immediate acceptance :)

Well, the discussion isn't closed yet.  ;-)


> Maybe one should also take into consideration a hypothetical extension of
> LKMM to MSA.
> I think LKMM (and also C11) do not preserve REL->ACQ ordering because this
> would disallow their implementation as simple stores/loads on TSO.
> That being said, maybe preserving  "rmw;[REL];po;[ACQ]" on the
> language-level would be fine and sufficient for qspinlock.

On PPC say, the expression can translate to a sequence "lwsync ; lwarx ;
stwcx. ; ... ; lwz ; lwsync", in which the order of the two loads is not
necessarily preserved.

MSAs have been on the LKMM TODO list for quite some time.  I'm confident
this thread will help to make some progress or at least to reinforce the
interest in the topic.

  Andrea

