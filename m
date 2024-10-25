Return-Path: <linux-arch+bounces-8537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E39AFE7B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740551C21010
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E91DAC96;
	Fri, 25 Oct 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozS2LGo/"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC51D9A65;
	Fri, 25 Oct 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849277; cv=none; b=XwEfpu3OY0DyxkB+0Dsqqwt2m33aRDGnA6dY5ZXus45qx3F45CBGMBVqLovXmmLF+b7Sto8nKf0w2gLPFXdbQHu9Lg1Y+ezqSUKZ8ht4YtvA18aQEjw8g9wlyAsUb7zPV77ksp8qySl5H5N4yoJMHQ0ia2DAe8uqMhmX5vXqUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849277; c=relaxed/simple;
	bh=DZw/imHsx/+zw2O5vHUtcjCd/KJqLJnG7G7NqmKDhxM=;
	h=Message-Id:Date:From:To:Cc:Subject; b=BHcwugmYwXqczbFQS9AaKQkNjnT4sJglfR3E9E7kFZMz8yI86q8O8OFwLwEQijMe/Y1oGBQmT0ECH31XVLlvpPfXiSwRvtBa5+MBhUNZHeLt7jpXjCAlhrq5hilY0HvQVyaEDsvx7E6TSO2+Z8Ca4nz6dcreS/WdBbeLleHLDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozS2LGo/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DZw/imHsx/+zw2O5vHUtcjCd/KJqLJnG7G7NqmKDhxM=; b=ozS2LGo/VkM5p19EjH/wzUt9SE
	W2EZfqQEbHY20SuZnp0mX1cEKlOr3rq0dBKCdWqgn0trz+MPkfyxA3l4eiCdk2HzShq2Pi3TgB7El
	D+vcOykYfmBOPb1fuI2s+tG4EwTOqLZc5pWzNLHW6iORlwRRSeOlyKC8ByPPDR24nQlvGJaj4mUm1
	/6ZHQd0yR3/4TvJDn+2rWKlAmfICMEbrL8bRNGL6zv+AKJPlTFqVGteRb3faI0lMdTBokd93Noina
	WTR/G4hmM7sNyHjVoZKaA0A8NmHN9/Vbgq0I/40CdZd2j5Sl2qvoADJv6dzawmbrS3ECLfRdHjCq1
	wMQ1qtnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GoU-00000008sa7-1mPP;
	Fri, 25 Oct 2024 09:40:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CBC1630083E; Fri, 25 Oct 2024 11:40:57 +0200 (CEST)
Message-Id: <20241025090347.244183920@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 25 Oct 2024 11:03:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 dvhart@infradead.org,
 dave@stgolabs.net,
 andrealmeid@igalia.com,
 Andrew Morton <akpm@linux-foundation.org>,
 urezki@gmail.com,
 hch@infradead.org,
 lstoakes@gmail.com,
 Arnd Bergmann <arnd@arndb.de>,
 linux-api@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arch@vger.kernel.org,
 malteskarupke@web.de,
 cl@linux.com,
 llong@redhat.com
Subject: [PATCH 0/6] futex: The remaining futex2 bits
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Hi!

By popular demand a repost of the remaining futex2 bits.

Notably this is the FUTEX2_NUMA and FUTEX2_{8,16} 'small' futex support.

I'm not sure how much demand there actually is, since back-channels and
whispers don't really count. So for those of you out there on the big wide
interweb, if you want this, respond with Tested-by tags.

I know Christoph wants the NUMA bits, so I suppose that is at least one user
for this new interface, and that might see it through, but more interested
parties would be better and certainly move things along faster.

Same goes for the small futex bits, if nobody replies, they're going to get
left behind -- again!


