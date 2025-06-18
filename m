Return-Path: <linux-arch+bounces-12365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F6ADEB80
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 14:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B03AD7CD
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50302DBF45;
	Wed, 18 Jun 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mam5EdNC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578A2BD022
	for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248626; cv=none; b=hK7ud46wQVuPkqgYsDGlL5vT2pI/G6y/v9CdKg0dy9PFeXDvw9o6102jiWDf5WtKq3tF+nsjvH5ItQkLH0/eLk32Cn44Tj205DYLDfEO333fygCUju/0ASAvcYD/oImBLJswNY1iMAX3sZJeKP+EpiBtGqUhN1JvlK7i1pZGI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248626; c=relaxed/simple;
	bh=f3GIbyVHrxISNrimyhIFZSo9QvqnBsjZXMzvJuU6h4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWGtnQ8vOot++wwerUPq1AHNK4kEImmzsbc4SDZKXltrdEbYcGKsaKR5bOw5BM2jvXUXnqmcqwM4Unzvi2ze+0fePbHnmr2XWzFUAKlUeEylzlsJUe8UiWIP4v3oL/Ks9+IyaohXap5zZ3tC9wEWORtiDJX5u7/HYhnfCWFCkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mam5EdNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EF3C4CEE7;
	Wed, 18 Jun 2025 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750248626;
	bh=f3GIbyVHrxISNrimyhIFZSo9QvqnBsjZXMzvJuU6h4M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Mam5EdNCmTGtbVUk5ZadbMmPcvKMhmy6c7uiIovu1ER837ZYVwNhxsCMDTmqXJteY
	 53t4Jn4aqLtYlFz79x921Pz7QEQSIC1L5Q6mP6s9GUbRQ2Ov4osQbDXZRYJCeFgr8T
	 Vogpvstik8wTMhgtVBfEtpG9AT64+x2XmTIkDTM5yUu6xJZK+DxuDTcAwQ7Lqz4CgJ
	 d3+ePwWYzyRMXKuiVjnaASYGsAIRAsS7pLISN+zZcqQbu/z7jHECKofR/+2bw25b2x
	 YTWiRzEHhzm2Ws9snneFp/QnJvkQyhdUkrDtGMaEF0OPdeXYKJydPg4HdwKgzwV5aR
	 JhvVa1o6Mc3HA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3D447CE0C98; Wed, 18 Jun 2025 05:10:23 -0700 (PDT)
Date: Wed, 18 Jun 2025 05:10:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [Not urgent] Systems unable to do 16-bit stores?
Message-ID: <872b6d94-b6ea-4ad2-b443-5b63780c9994@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e8134255-806e-424a-bb86-68d3d6671536@paulmck-laptop>
 <3b92adce-2fdb-4845-8cf1-a3378ca12217@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b92adce-2fdb-4845-8cf1-a3378ca12217@app.fastmail.com>

On Wed, Jun 18, 2025 at 10:49:34AM +0200, Arnd Bergmann wrote:
> On Wed, Jun 18, 2025, at 09:16, Paul E. McKenney wrote:
> > Hello, Arnd,
> >
> > It has been about a year since the one-byte cmpxchg emulation hit
> > mainline, so I figured that I should check up on two-byte cmpxchg
> > emulation.  The issue that kicked it out of last year's patch series
> > was that there were systems that run Linux that lack 16-bit stores.
> >
> > Not at all urgent, just figured I should ask.  ;-)
> 
> Hi Paul,
> 
> The RiscPC machine is still there, my plan was to remove that
> and some other platforms around this time. I sent a series[1]
> last December, but we never merged the patches.
> 
> I need to send a rebased version. 
> 
>       Arnd
> 
> [1] https://lore.kernel.org/all/20241204102904.1863796-1-arnd@kernel.org/

Thank you!

Not that it will carry any weight, but please feel free to add:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

