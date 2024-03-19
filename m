Return-Path: <linux-arch+bounces-3038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA53880460
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2FB1C221C7
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1E2B9D2;
	Tue, 19 Mar 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8+wG0uo"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49251208C1;
	Tue, 19 Mar 2024 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871726; cv=none; b=oZRqaY04rhLypEXew5IStVVK8LiOGjzurn/1yiMiQ0Dr8mImYL4X3ObzVRmaUTTMCgtCAz9GktFZxjGKOuU7ra+9EeDlHTUapXnBKlaIGqGN/f0ifS/Eg5iRPJyK3BX03oBXwomOgIKDcry6D00cz2rIgAUj2UJvat3euzOxBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871726; c=relaxed/simple;
	bh=/TLTNjLRNuhiV0mSLNL2wHkFZhyXdWLHNCfTEJYuONs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nhs4wt6szdz8gjuqRaEXdU9V430OuzUDsLS918IVYpU7qHeZzSrzdNnGcydCHXN5aFpge1/QLqSqKXPnRMOmy4MMbck1M5x4VxTTDPuEzgnAqG6GOaEj3tf2zu2HS05lo3ZVO1jLcSvrQXL8h6wR0EZb4fQVApPsSRB0OcrhhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p8+wG0uo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xgQvZBrHztRTAZp16CLgbseSLdtWf7Q9SsKAjuSvgJI=; b=p8+wG0uomF7unG72AzIrt36aSJ
	BYw0KiYaxuAzk0130AC7NRgxOFgbF1lOguMjoN7QhozQa/Clk2e5rGFgjPuB1FrrgacJexHlXYV4C
	yxHbBxRf3OYrLuI6WRiBjiXpzNkpiGDM2dSePR5KqCrGubYkqPIlg3tUEf/Voy4ux8DBaJraMJjEq
	i8wiZLYx8XH5FCioMIeMIohRBC+ewn2hIsz8LU5QwnBlK/suikfwVzd4pWIjn1kih+eQmHiYtecIW
	eCVd5DPvWPnEJYNL5yne6nCtZMXm861+a6KLunxMlHp3LTeyiKOnFY3VbQgcsShLTQmV5/PWm3xEj
	nrGgB6iw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmdt9-00000002Ss5-1TtK;
	Tue, 19 Mar 2024 18:08:39 +0000
Date: Tue, 19 Mar 2024 18:08:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, ying.huang@intel.com,
	dan.j.williams@intel.com, honggyu.kim@sk.com, corbet@lwn.net,
	arnd@arndb.de, luto@kernel.org, akpm@linux-foundation.org,
	shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <ZfnUp7OAr6PFGAq_@casper.infradead.org>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnQ7n_7cZvk9BkC@casper.infradead.org>

On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > Implement simple ktest that looks up the physical address via
> > /proc/self/pagemap and migrates the page based on that information.
> 
> What?  LOL.  No.

Also, how is this v3 and the first one to land on linux-mm?

https://lore.kernel.org/linux-mm/?q=move_phys_pages

Also, where is the syscall itself?  The only thing here is the ktest.

