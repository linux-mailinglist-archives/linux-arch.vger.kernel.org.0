Return-Path: <linux-arch+bounces-4715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14518FD38E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 19:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27F21C229BD
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C2188CAD;
	Wed,  5 Jun 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ6erTjX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DB3211;
	Wed,  5 Jun 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607153; cv=none; b=aTeHUd7n3ip/h3pA4sdxC22xa5XG2G0y+fAvPVMNnvyKKjW1I9MsPU65rohfn88ISsQM6JnSJ4smhxb8DMaZfSy6z7RW/Wiz9vXbwyebHrUEzU3nl4dfcxdgxybXIayVn7yB4YUQQfqU4MMBpzg402IHZeMRF689uIrnZeLq+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607153; c=relaxed/simple;
	bh=ppfVXkaZDara5XI4iOutK/rvFfYiOX7bKQQ9Goyz6Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3C7Y3oC1JwLpTO1b8gt9r4CTPQWqI8rG2i1JbpnmFsUvuyBpd9mKgGibj+hPqsFgUkw+RmwcaU/lKUTH1WLUL32ZW3HAd17DpYQXTKtXIgZoULfw6TyWQvrXNBuCVqdO/hTcnXVOt1YkW+zWv+lmKsmjNJWWAGYjflDxBk+ftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ6erTjX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42155dfc484so556865e9.1;
        Wed, 05 Jun 2024 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717607150; x=1718211950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKRxRsXITwcKcSFEnZCeS4yIdLc+hSCdiKd4uSyqC6s=;
        b=AJ6erTjXJ3QI7Ykqzssps5LkH24ku0R+GBOgbLjai0gBVTRVyIruQIfURvppZLzXg1
         yP5lp+R+wPaM0PrRlW6s/Oi4RKCVBkpPx/My/wmMSatFFY8SUlyOudT6o3jTwNtGQEqs
         cCcxpl+dcyFMQywGo7n4j4gaioKihe81Tkk89FtBuJID0TCWLYSfsZpPDTaJ5EbR23Ry
         0Q4usK+FREVps4meVbnY7xxs0m391OAgdKVSlLl+27y0frFTKgEVGB3XFvvn8aDPFRdL
         v54QFaRAkPnCbf5ze5HJ5KXInyF+ADy6pu6oPywlNtwiMxxpQ9RqspWoD/z5VVbOutBP
         yMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717607150; x=1718211950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKRxRsXITwcKcSFEnZCeS4yIdLc+hSCdiKd4uSyqC6s=;
        b=Yay4q+UZInyMyk8tvSlYYcSPZxBixkVxJaiNgSZaWM6SRkjvyjzhNMHE5k7XGlRqkv
         lHara3qOpJjgfH6q5atnkq3Z6qTim0hifjXNk8rBlWrdOMB+qFZ6zE8wGPvSOUkUBoe4
         yZowq0Fr8AJfD49csvICBcBcLviP+7XJBZuGCe+WEaOZ+6G3D5eBiJLvsNx/Mq08ZPEb
         zaWoL7klZvTqA9z5PVFLtnD6jtL3Idg0IPt4QJp+mMcnKqNddS/F/07nnuyZMGnkt7Rr
         qgBl/ZbBWnyQDoX3XnFpufOOb49hMk4W3YUE+KrShcm9ZGQPMhqAHn89phK4Z9rVMX3j
         aEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgay/Fn1giF+dOl91icod3imYK0fHY48jtJh5uD6hnfsRzfgv5mskqzpx7vhjog+9WpUuwZN7NJDyRHRpF+FtIz61+q9Y4V/uE9Vc4qFoBCzqjd/vYb990xmVyMSqRjjcJmwYiX6XP6Q==
X-Gm-Message-State: AOJu0Ywr4T0ehKAtk0EtwskKyHDNvBmEdUtO+M2hDGaC1bnWiJzrXwc6
	7930ZisKFklFDANtjGIpG+V3lpPqsy1J852NuBPq10KgYK1UkZJ8
X-Google-Smtp-Source: AGHT+IGPzNbwXlgB9VfrOAPXsykVeDz+8ofDpfOzeWmsF+Bm/cDOtiWDZ5dwMgFYYuCStxlydXFThA==
X-Received: by 2002:a05:600c:5487:b0:420:2cbe:7efd with SMTP id 5b1f17b1804b1-42156338a6bmr28684595e9.31.1717607150174;
        Wed, 05 Jun 2024 10:05:50 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e7d399d15sm5861541f8f.63.2024.06.05.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:05:49 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:05:45 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <ZmCa6UXON7bBDLwA@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
 <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>
 <ZlQ/Ks3I2BYybykD@andrea>
 <28bdcf4c-6903-4555-8cbc-a93704ec05f9@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bdcf4c-6903-4555-8cbc-a93704ec05f9@rowland.harvard.edu>

> > > A patch to fix the problem and reorganize the code a bit for greater 
> > > readability is below.  I'd appreciate it if people could try it out on 
> > > various locking litmus tests in our archives.
> > 
> > Thanks for the quick solution, Alan.  The results from our archives look
> > good.
> 
> Here's a much smaller patch, suitable for the -stable kernels.  It fixes 
> the bug without doing the larger code reorganization (which will go into 
> a separate patch).  Can you test this one?

Testing in progress..., first results are good.

(+1 on splitting the patches)

  Andrea

