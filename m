Return-Path: <linux-arch+bounces-4531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8748CE84E
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 17:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA52AB20BDF
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCB12E1CA;
	Fri, 24 May 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSo9KmLY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01B126F04;
	Fri, 24 May 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566129; cv=none; b=tqSsbXmpht9oEZOW5MVkygQTdleh+03rhj+b9xvQP1uv/c81G/AFMgA3J9kFrBn0HWLYeJe202JUzsDRWNZ8q1P1dQ8PuWWfzfUuC7dB5TMtode+gYTm3uTg8CanUSvcfxTg7DU4cagwLQih1rSOvAyN4TWvb0ehPny65fkw9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566129; c=relaxed/simple;
	bh=xS5Cb4oU68zPCtUxfTuRzeBZiDu8VHCvZRRao9Wn4OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr4+hd0T0nA+ugHRHlfo0j2pJBMAD6xsG3xBF27yumDy8IbaqUv/K2VKuSdUtymEnJiW1A9cPP2/gVCS/T/2ZVa1nV1wkM3lgGVMwhf/AfxN1BgIbCnhmJ1xQpuGzZJwtvypnQBWzZPj8CEL9Dad41bznR0iWl0mh/MeSLt1BSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSo9KmLY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35507de9853so587079f8f.0;
        Fri, 24 May 2024 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716566126; x=1717170926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//KD1Ad6RRaTW94yeORLrlBuaIevXtri2sWaywu2r1w=;
        b=iSo9KmLYdnM9CdcRxSy6fKoYsfFCnJrBgqA184WuoxjNiE+edVoZXC9mwI/G/4VQiH
         f3iBI2hGsAcU/5ShRyxv8qkko4gRe+hDVCu936f6H65zoZ7nv3Tv10zFDPJiMirNVdOO
         iSlEjJBd3HLqJYtk5oeKRZU2bS6C0/qkT1oAHGjzVO6Pr3KoBCret//dWvt8fTgmJtmb
         Y1Sm804XsdSvtjzTqZVo+9L0gffaQQn3njRYCsTC7BoI1goGElUoP1UXaw6UfIYGNwGI
         WRkaaWY8vcpWZMqcfCkhHZ0mQOjgIi1SqBaRAshP5fdRVPPoB24yO48PSDyyU4hteRZo
         Wbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716566126; x=1717170926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//KD1Ad6RRaTW94yeORLrlBuaIevXtri2sWaywu2r1w=;
        b=uUGSMffX80YSw1Ph8sx9CCBRTYPYl1edsRdZ+ij44dZSk7wvh1ErvH+k6HEv+EEyDD
         9GZSzi3cldFsL2Jzc85CVS50f6M/PmgE0qLqmwxqJyXOz1OYmPtFQPa5QzQu4APTV0CU
         s0rJWFgHGnHVIAZxTtGZFsBMucfe6Ui2nFcyoL+LRkZ+Wk+pZgpgO1pfGw0WmIduFHL/
         xFdAd4i7uv776D9TsqH5xinECjzXOc0toTjz3n4XnY1xC8MKPHXd/RvwPN8YyIow6PI4
         N/fd04UcDJ2HccnKzdGhga6C91SavfGQcmTKVbG6C0F0G2GBJf67bkQEHot0XW8X8QeU
         n6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVT6BxZD5Wnal4vHsqQA7ZY2rirLF4N2hkNs1EysIKLXzmvlE+oM051TE2oJ052EJuy+uLvJNQCce5jHeCz2b/QmEWogaxxg56H+Nbwo6iUtr100wIidcgCPMRiX0M7NMDFN98nDXyS8w==
X-Gm-Message-State: AOJu0YzObSTXFpYUJnl5y8XKwo3IzpF+oi7fHVzupSHvBF8AFNA3hcMt
	atRBC2xpqzmzMelQF0/pedRONNOxYXc6uKVa1aKvDP6cmNGJZJPc
X-Google-Smtp-Source: AGHT+IGvjRiaA8GlfSDW7h+Ok/W23XLgkVoUl4OzjYq5we7GcVfeiytWRtbZHIoF1/0S4q9ZqlUhig==
X-Received: by 2002:a5d:5242:0:b0:34c:77bd:2508 with SMTP id ffacd0b85a97d-35506d48543mr2704271f8f.11.1716566125620;
        Fri, 24 May 2024 08:55:25 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf06dcsm1901645f8f.106.2024.05.24.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:55:25 -0700 (PDT)
Date: Fri, 24 May 2024 17:55:20 +0200
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
Message-ID: <ZlC4aFfAx4u8cjDb@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
 <bd6426c0-f439-4b15-9ab4-12768aa8557a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6426c0-f439-4b15-9ab4-12768aa8557a@rowland.harvard.edu>

> > $ cat T.litmus 
> > C T
> > 
> > {}
> > 
> > P0(spinlock_t *x)
> > {
> > 	int r0;
> > 
> > 	spin_lock(x);
> > 	spin_unlock(x);
> > 	r0 = spin_is_locked(x);
> > }
> 
> No "exists" clause?  Maybe that's your problem.

Nope, that doesn't seem to be it.  (Same result after adding one.)

  Andrea

