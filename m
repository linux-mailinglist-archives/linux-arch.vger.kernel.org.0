Return-Path: <linux-arch+bounces-4508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854538CD87E
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403C2282583
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742E20DC3;
	Thu, 23 May 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH/o6owE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E41CD06;
	Thu, 23 May 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482160; cv=none; b=IYCAUUbkKd/8jcv03NHS0/QaooRAWmZjWIfyveeS1hJuCAWlFoiVczcTS345aEfYr+7+xsN5fZ9W3k5v5x/hCdG0w7rgANshbDp1gGo6Ycq/nlubUj08ylanzwJzPMA76SGq74959BL7hrSEM3AmBva1xud73XIt5rrOiJm/HOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482160; c=relaxed/simple;
	bh=C11k79vWQz4vx2r1YSg1a1AtrNnhflomtLuwMR0xY4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQJ+4PEHlAelhsOrZ39Lkd+F36RXQUbn+HZFDgFE+0h/DH8zi7vAdktSAabwbbYVIyjbanTfwEFjkMk8ISJSsDedcMtfM1/ZiA88ExaIVLiFFsZ382Lfgk0X+A88OG4Jdwfgx6Isrbfx7bWnvnmpOf/hleN87Pnar8H/k8YrB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH/o6owE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a620a28e95cso423085566b.3;
        Thu, 23 May 2024 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716482157; x=1717086957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buNOyAtDa0tUMT5k2NuVW/hvMfR9ISBuznEnORaVzAE=;
        b=UH/o6owEHZsc8FqpzgbSMnLFLqZV8g+UHQL72S7DRU0TKBI8YmHbD7TbEjatMmoBdC
         Ddchz4ZSmIGCystSrfDMc2ATufI6yaiFU9LtHJIeIKVigLBHRutFfccD7fzyU0pU0O5Y
         2rGVAEUHAOWIbhHCcbmdGMHWjJir/f/Z+P8Xa2C5G8A1MtZPZKpbLrHOPr8+SO2B1C2s
         cAwQT9A71CG/h3bILNkMuipjogycO2L2PK+DaiqbUttgdi91h/9NN+OusmvPorJREwHl
         H569NEjCZnMmkEPMeXEZBHo3EHT0NAUiXbJh8ngwgHSbPv4nfcMLnhUPD3u7lhHGb0Ih
         8SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482157; x=1717086957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buNOyAtDa0tUMT5k2NuVW/hvMfR9ISBuznEnORaVzAE=;
        b=Aeh6Ax0yzWtqQSl1w3fFnNcYTBQYk5i0vULh8ouCKdbevZerXujAvtCHzKEdAzuYow
         f5ZYXZEv16hqUDRvH59e4u/2gcfwF5XjHYshewC2+YK39FobUameun6DJJfLxR8rlA7Z
         3bBUdMdgiWafv4y3oWyBYdWaq8bSTDRXNnHQsSF5FoRrjM8uAMRTwuUtkyoBnoH/RRTK
         9HuADC4iceL5DLyNNssxsUO5WXXbqhW/+F3waRy5kuecKDZKZ8UO2nzMC2ceDZ6lAsXR
         Qo0XzLRi/TPWRJJDBBFUrUvekxUpSz6bzGM2yF0yp1Gm1a4VJx5Hmm4bGuoFZ6wD96JF
         GWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/VvnIx48Eyb/MhtbCR2Mfqeh/gRmZF8AnHPYVRRUEScL74lnWsRc9Y5TssMDnGWfRjLaSj+sUS3lex5OHj8WRyi49j9HFqO+jklQKjWz9m+CsJU5EzrFIo4/egXT6PegvDvHAEZTjQ==
X-Gm-Message-State: AOJu0YxSYsqzluS9R4rPIl5GELIJ8tXPl11JD+eT9WnUNng+HqMnn/VH
	zBeF3z2KH8rLzyEmSbZA5oun2zKMerF3oUJBi+Ud3Pdeyfalmuxv
X-Google-Smtp-Source: AGHT+IEA4zIBkzXJDNkUG3VRj3PjR4eYNIcWnrhcU7oXFRL036aL9uHCSQjRcdJf3PS7CHipWlSRNw==
X-Received: by 2002:a17:906:682:b0:a62:2cae:c02 with SMTP id a640c23a62f3a-a622cae0d6emr341693066b.61.1716482157128;
        Thu, 23 May 2024 09:35:57 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a621b339b6asm363814366b.72.2024.05.23.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:35:56 -0700 (PDT)
Date: Thu, 23 May 2024 18:35:52 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, boqun.feng@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <Zk9waJNBwifS/Ops@andrea>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <Zk4jQe7Vq3N2Vip0@andrea>
 <73e08b17-cb2a-4e14-a94f-7144c5738684@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e08b17-cb2a-4e14-a94f-7144c5738684@huaweicloud.com>

> I would phrase it more extreme: I want to get rid of the unnecessary
> non-standard parts of the herd representation.

Please indulge the thought that what might appear to be "non-standard"
to one or one's community might appear differently to others.

Continuing with the example above, I'm pretty sure your "standard" and
simple idea of mb-reads and mb-writes, or even "unsuccessful" mb-reads
will turn up the nose of many kernel developers...  The current repre-
sentation for xchg() was described in the ASPLOS'18 work and it's been
used (& tested) upstream since the LKMM was first merged ~6 years ago.

But that's not the point, "standards" can change and certainly kernels
and tools do.  My remark was more to point out that you're not getting
rid of anything..., you're simply proposing a different representation
(asking kernel developers & maintainers to "deal with it"): here's why
I was and I am looking forward to something more than "because we can".

  Andrea

