Return-Path: <linux-arch+bounces-4147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487A8BA227
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94BEB20630
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656D17BB07;
	Thu,  2 May 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEhoY/q3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA401DDC5;
	Thu,  2 May 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684813; cv=none; b=ZgQNbn68ViFOR0HBqHF8TYvnin/r23r6hyDFOsXuUf88dcf2zMyI2+PK3JuwVn8DlZA8G7IecdY5bEecWOExYjeQn/X4fp64PFX4D0axWYvc83GHHvR55D+VE1Xh+hDnzM7kekFfRzoeyZWDAd1UQmVOQVjIoLvWAAfX9kSi9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684813; c=relaxed/simple;
	bh=kqPxr7jd2zlR9K+vT1S62jN9uvOh5oTWDdwk6p3Ox5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txC4j9kW+RzuNFfZl8CZLNI/J1VJVS1M/CeVZPXYxeY/WEdeXsVfTZeXtPk2a6SCRjL3f+9bYnZEYAcNcE3DYWT3RGfP5bfwmo20X6EjGdWdizT4jMJe1Mv4ZIOJn14rqR9LyQpPiH4UOdjsIcD3k6HPa599rEYq8eku6kxLjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEhoY/q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE4C113CC;
	Thu,  2 May 2024 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714684812;
	bh=kqPxr7jd2zlR9K+vT1S62jN9uvOh5oTWDdwk6p3Ox5g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MEhoY/q37/RNJYYx/wBmaoNl95SBtSF6LPknRPitNZ9UfTkslBZCV1ikyJw4OpaC9
	 X9Z7crr3N6pbX1PD+VkFohvv3PTLuny3lD6letApF2CVqSwYcBlyfYWhh6vNJX+LgC
	 1vOSgH5xhxi8Z9dF1RTMo1HNVjcmqSY5mT4ZHWDyXTDaiY9qBphJc88RbR1bq62df/
	 +02yQz4ncI8qFz11lMKt42D34NjPQhMru2LGwRVjyLYdbSYeD9THTmA4LzSBq83cXI
	 /MpU0OXxU/mhD/3aiLZNFOn2HJj6iLlPqeuVQBMhRDeCmLjRSVmkPFRsBYtsbqLn4m
	 OD0yorIQOp7Wg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6BF1ACE0962; Thu,  2 May 2024 14:20:12 -0700 (PDT)
Date: Thu, 2 May 2024 14:20:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 cmpxchg 0/8] Provide emulation for one--byte cmpxchg()
Message-ID: <4a941e33-c7e0-4018-bd1d-41f49e4bed8f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240502200153.GJ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502200153.GJ2118490@ZenIV>

On Thu, May 02, 2024 at 09:01:53PM +0100, Al Viro wrote:
> On Wed, May 01, 2024 at 03:58:14PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This v2 series provides emulation functions for one-byte cmpxchg,
>        ^^
> ...
> 
> > Changes since v2:

Good catch, and I clearly wasn't paying attention.  It should be
"Changes since v1" and then "Changes since RFC".

Again, apologies for my confusion!

							Thanx, Paul

