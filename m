Return-Path: <linux-arch+bounces-1983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D6845F6E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 19:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B0E1F29F98
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5B12882C;
	Thu,  1 Feb 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JefXNSrB"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AD128809;
	Thu,  1 Feb 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810735; cv=none; b=ptR0Xv+OOh95qYcKz+VkiUcWinZsZGWVbVR8t1JMsVgMj54WfJuKG79nwe96pES6WdKwDmTeuhMLczrEpUl08jnXKFaz2QOcbvm8c0RwbiG7lJXYnnwkriGmviNoZtGksxPmq9jnPtlAtlCJxe57qHLTIhdt49y/liawHcXyStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810735; c=relaxed/simple;
	bh=JfeVxZ9QXBYGCIGLV8XksPrBTz+Oq09ud0x6s4kFSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOQO3hAZxqUKa4PrWAH9j543QO3JFxXJw+vL1KUWutHB23zmcFHeneYpNhKEThSZcAg5KOpHXBUjUKtFv73btdpIFzhuOvSCAfi5R6DyXNm+0rfCS4XhGXdz2D1xjPyAnzzOTMEM5mtUxZxkBpNreeouyv8WnwKz7J3Yu3e/i18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JefXNSrB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBzBIT+OwKc/KgOM6TRSOd+0Koav1Y3FPhSbpX2zBBg=; b=JefXNSrBtf/VmcM3GreDAPNGfS
	K1DwjzfgCb+iQPR3znjOL0WinjE8Rr7KAHTy3kuRFuIdjibhuHw/+nVi5/vVwpmhcHoUri/L7KtsN
	GO/Zl9jhfzeg58LLL+J/pFPmpuWrca/gnfzqfMkuKaBQ84IivqGOB75oEf9WjG2MJsMfDFAAIYRlq
	PNhh1dkTlfI8CuusZwQBlc7pQqdy1kOf0DwdtSdfJUNQg9XZyEz8OmbBSU2go+WULGNlGcDV2EORM
	KMPvQnaEftMyW6EZlHC0Y6tp+4z3a3AVl22ZXBjzIaYA3R/VAPdo1nmau6Vthn0PG3y7UWwoK+PL2
	xM4+qJ9A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVbRN-00000008vr4-1mff;
	Thu, 01 Feb 2024 18:05:33 +0000
Date: Thu, 1 Feb 2024 10:05:33 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org, deller@gmx.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] modules: few of alignment fixes
Message-ID: <ZbvdbdxOKZ9FUQuC@bombadil.infradead.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
 <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrFoKUJQ8MIdzXD@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jan 31, 2024 at 02:11:44PM -0800, Luis Chamberlain wrote:
> On Mon, Jan 29, 2024 at 11:26:39AM -0800, Luis Chamberlain wrote:
> > Masahiro, if there no issues feel free to take this or I can take them in
> > too via the modules-next tree. Lemme know!
> 
> I've queued this onto modules-testing to get winder testing [0]

I've moved it to modules-next as I've found no issues.

  Luis

