Return-Path: <linux-arch+bounces-6068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E46E949B61
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C18E1F21B75
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7317166E;
	Tue,  6 Aug 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZRMda+aD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5CB77F08;
	Tue,  6 Aug 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983989; cv=none; b=XlO292GKSfUZ9slEBiKLyh7MMsCkzVsxBGhsAy09tZgt+vCTi1Yhq6gOs5TVBS6MyrpS46kt7y1ZccDcXvUVYo+2EqHTWZ8ce0mC+CRXXGots0c/pKZpS9su0s7djIWPZji6evO+b6cpdN6bBt1pF4C06MjLbPUi8RIiCkvjJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983989; c=relaxed/simple;
	bh=jJmEId4R3kd51IiNhFHMyrGgMqYmLtP9jg6gv8iF2/8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XLVTOyT7TcUY28LleTuPLUg6fiV/IBPOdSl6Ce8Q6zncKutpwqYl6JZLXB/JzCwGmmqhmsQH0b2zGhcp2NbFChkNHc+ytQeLd59BcPtK4t3De2uFPlgJREl/Rsf2cJya1ZJNQnYxpWJbOgLoQK6TPMtCZd6LDr460KMOubdHURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZRMda+aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592E3C32786;
	Tue,  6 Aug 2024 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722983989;
	bh=jJmEId4R3kd51IiNhFHMyrGgMqYmLtP9jg6gv8iF2/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZRMda+aDNhZBB7biIqVBaqsKAzmfTdkIf1Yoa2TeLrWVE6ulp7wdRlaFWo7ZRf1Zj
	 VNgrxBVr3tOGrBYX50Qjj5m51QBm5QtwAjWjsjmo6WD918JPcbJK7JK4wc3Lo1xb9o
	 JMFhe1OqgXmwYNJy7gUjEyTsyGADGodHs4iBcnYQ=
Date: Tue, 6 Aug 2024 15:39:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: zhiguojiang <justinjiang@vivo.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann
 <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org, kernel test robot
 <lkp@intel.com>, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
Message-Id: <20240806153947.1af20ffccfb42f1e8d981d6f@linux-foundation.org>
In-Reply-To: <CAGsJ_4x1tLEmRFbnUYcNYtV73SyBYpBtAx_syjfcnjrom-R+4w@mail.gmail.com>
References: <20240731133318.527-1-justinjiang@vivo.com>
	<20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
	<dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
	<20240806133823.5cb3f27ef30c42dad5d0c3e8@linux-foundation.org>
	<CAGsJ_4x1tLEmRFbnUYcNYtV73SyBYpBtAx_syjfcnjrom-R+4w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 04:32:09 +0800 Barry Song <21cnbao@gmail.com> wrote:

> > > their independent mm, rather than parent and child processes share the
> > > same mm. Therefore, when the kernel executes multiple exiting process
> > > simultaneously, they will definitely occupy multiple CPU core resources
> > > to complete it.
> >
> > What I'm asking is why not change those userspace processes so that they
> > fork off a child process which shares the MM (shared mm_struct) and
> > then the original process exits, leaving the asynchronously-running
> > child to clean up the MM resources.
> 
> Not Zhiguo. From my perspective as a phone engineer, this issue isn't related
> to the parent-child process or the wait() function. Phones rely heavily on
> mechanisms similar to the OOM killer to function efficiently. For instance,
> if you're using apps like YouTube, TikTok, and Facebook, and then you
> open the camera app to take a photo, the camera app becomes the foreground
> process and demands a lot of memory. In this scenario, the phone might
> decide to terminate the most memory-consuming and less important apps,
> such as TikTok or YouTube, to free up memory for the camera app. TikTok
> and YouTube become less important because they are no longer occupying
> the phone's screen and have moved to the background. The faster TikTok
> and YouTube can be unmapped, the quicker the camera app can launch,
> enhancing the user experience.

I don't see how this relates to my question.

Userspace can arrange for these resources to be released in an
asynchronous fashion (can't it?).  So why change the kernel to do that?

