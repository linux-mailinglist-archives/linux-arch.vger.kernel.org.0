Return-Path: <linux-arch+bounces-4719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDEE8FD66D
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B52F283A92
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3714E2F6;
	Wed,  5 Jun 2024 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPcoGoHE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDE14D713;
	Wed,  5 Jun 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615596; cv=none; b=jlkB7xSoERHcG08iN3T+YkuQO11imK26tGPpMfiv9UaSZcSfs5kcxB09hpzEwxpbbYl0mmDUSKMpwSSD2asJ08mdwgIyaX4pj4osxldIKQmXYSzROu6SZbPel4OtoXGl3MNj72h77Q/1njaLWf/Psg7mqlwW4ER0oyTuSLhdTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615596; c=relaxed/simple;
	bh=TGeMPpyCZO5b/q1Rebq1IqjfCpKuEFM8wD8tUBsBoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBOO1lksZ9tvMeosSUbN+f0P3NhQXfL4WESJFWqVzt1ERWVQgT6DJNMhuWLVdSBkyc4ORVBGkKzYyiT2Zb+3pnzxIxNiuydkqUYZP7uZUA/mwVAGppe6YWvR+1I1kMQO2uEY4oCvr0YzQzVlSQClKilOJ78PuatJThZ4U6kIDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPcoGoHE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35e0f4e1821so89926f8f.0;
        Wed, 05 Jun 2024 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717615593; x=1718220393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W05x3+sVU6bILbLlHv781110WtHbNpnp+gY6dsPenOg=;
        b=ZPcoGoHEXu/Lymd4PxA95BAMjcv3UW7VBcnDx5iTnmIkJV6pq1VuBHRMPh8+IObhn5
         vSEflwcP5oWvufwr4r10PtYbB5feZT143rbgD4OoNl7dK2ylWrx4jMBHdF5S+OZ4GJSK
         C0ttPzm4TU5bBoDBXYGjRytNA/46k2ckFsaoJdxtKoS6Rpp8pcf6yMoJFhW+FVKCIu+y
         W1dp/7id9rSHslCmqv98RfcEfFqDavb4ytz453tKtwMJylXDpo+ah7xJoH5BbT+fa4ry
         m71h3DTPUIFa12HCNPIedM9E5o9lAe7Gc6YXIahY+2YTcjB+f/ZYqltNBqewkSa2XrVj
         Zndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615593; x=1718220393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W05x3+sVU6bILbLlHv781110WtHbNpnp+gY6dsPenOg=;
        b=FdK4lPGLrO+QikO1tHcTcHpQqUJOxZj6U2KtWeagA4giUjs6xlItrXrWATp9s4eock
         GCA90V/TUINxaNabCFNzZljorfsgGib/wxqCa4oBK1FLm/noEtKQiJyLuFJSL6vUzWlq
         E1FhrwKBIZ8pBhDD/w3I9brp0CQlsZ6ky+SVD3adVi4T/5l6lMc3hdN9Qo5P9zuZPdW0
         QWrCF+EbXWFwQFnIdtOCPxenoPapAqogHxnFOzkWap93vERrsrALVkFvPmNhr8w7+mN7
         WOKWcnydvw5vcrEdRf5iSloOAMmw5kpfc/19Wmpl6QVzgiASYwPgpbDC00jDH0JqQpcP
         4E5w==
X-Forwarded-Encrypted: i=1; AJvYcCUJQjiP9zbcw4uQ5OuWuKY0seR5k0rb/mvQD6Dn0r9lv323LMCNocfwhYUmiOPU5hg12ONHxkV6VPFH1ug81Xovo9t1A1uEQURj2PqrLadsQAu8sJK+wRd3j19+RmW8bmglTIeE2kKjYg==
X-Gm-Message-State: AOJu0YzkqrnNDc2atHE952onXofPQmqOb+FXmo2UgxSm7ghbSJpcY+eU
	gKwfiGtYi4ceK9hvGLiY1XWgHrpds5/78XVLMOeIs4lkLghXlU80
X-Google-Smtp-Source: AGHT+IFO+3N6m7Ih2WOHZ+qasLJwJz7+352/CE7D8ks0I/d1TPQFnypvsJZV+AjEPEiEXjlZWAPN0A==
X-Received: by 2002:a05:6000:114a:b0:357:393d:5006 with SMTP id ffacd0b85a97d-35e8406866emr2729154f8f.7.1717615593349;
        Wed, 05 Jun 2024 12:26:33 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064bbb1sm15440454f8f.101.2024.06.05.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:26:33 -0700 (PDT)
Date: Wed, 5 Jun 2024 21:26:27 +0200
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
Message-ID: <ZmC7z26DmZ5xP8k4@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
 <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>
 <ZlQ/Ks3I2BYybykD@andrea>
 <28bdcf4c-6903-4555-8cbc-a93704ec05f9@rowland.harvard.edu>
 <ZmCa6UXON7bBDLwA@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmCa6UXON7bBDLwA@andrea>

> > Here's a much smaller patch, suitable for the -stable kernels.  It fixes 
> > the bug without doing the larger code reorganization (which will go into 
> > a separate patch).  Can you test this one?
> 
> Testing in progress..., first results are good.

Completed and good on the various locking litmus tests in the github
archive and in-tree.

  Andrea

