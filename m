Return-Path: <linux-arch+bounces-4720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEE8FD6A1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926AD28A32C
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF21527A0;
	Wed,  5 Jun 2024 19:40:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5410215279C
	for <linux-arch@vger.kernel.org>; Wed,  5 Jun 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616411; cv=none; b=LYVLVJtH1x17Zsx4ODaWAoirt+1lU0N/1BO9MHYMr2kFROvSCPdRJuft2paC2jDoedzeghpOaXrp+M++sT/MPByFRiX5Q1sw0r1l/0HpCC13W3eY8zeZoxExqZG8ulx47rWxRLgrvxxhQVgEYqxrY5AOff2lhM3DELNHVTXyZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616411; c=relaxed/simple;
	bh=WpoWV7Z9ZwENUXOLSPhoajoLQlkmRBnATTnJO5Vt3P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiH1uXzYID2wY8m6OVvnSCTkAUbpsZtyeWPrbQ2jzdY7wcMullK0Vo/E9fCTtQUJ9O2N42CN+klxT5SLS1jhV6hdvU4VkYDyNfs3IUn1B/K597OsQrAIIjjS7KgPs6aTDnnOyTli3E1QIKN9VRyBYC3E1f36fedxbv00Il3M1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 206781 invoked by uid 1000); 5 Jun 2024 15:40:08 -0400
Date: Wed, 5 Jun 2024 15:40:08 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <844b1c86-d3ca-4325-9c2a-ac54d4bef829@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
 <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>
 <ZlQ/Ks3I2BYybykD@andrea>
 <28bdcf4c-6903-4555-8cbc-a93704ec05f9@rowland.harvard.edu>
 <ZmCa6UXON7bBDLwA@andrea>
 <ZmC7z26DmZ5xP8k4@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmC7z26DmZ5xP8k4@andrea>

On Wed, Jun 05, 2024 at 09:26:27PM +0200, Andrea Parri wrote:
> > > Here's a much smaller patch, suitable for the -stable kernels.  It fixes 
> > > the bug without doing the larger code reorganization (which will go into 
> > > a separate patch).  Can you test this one?
> > 
> > Testing in progress..., first results are good.
> 
> Completed and good on the various locking litmus tests in the github
> archive and in-tree.

Okay, thanks.  I'll submit the patches soon.

Alan

