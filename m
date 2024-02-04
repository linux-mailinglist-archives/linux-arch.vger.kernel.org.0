Return-Path: <linux-arch+bounces-2082-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22B848FFB
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682501F2310D
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A924A1D;
	Sun,  4 Feb 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EO/BA6k6"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2966249FA;
	Sun,  4 Feb 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707072855; cv=none; b=Qmc1PwJTe3Cmf0aUEfBoe1O8l/qgSddHilddPbsv3lpzFFE823FyRlxhZQjKdOFckV3+SOvBEu3bCRtPASE2aZsm6nvrtwY9GL5aBXcvVK2unbTfMXl44LiR0lzG3vzkblMWt7vuP0lraERil9jCwZQqOC3aEVN1ntCCoKWfNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707072855; c=relaxed/simple;
	bh=IJAzeDQLc2l4aENFMXWZuKCnfgjMkL1wsmTB76NTmUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAgkcyWBtkBTdviZYx/+w6i4DlalUP35C7yp83w17+wC4o6QkkYbdrRtWjLcHAAEN1UsfiJRNYfJONl0hNAHXGlfj4zBm+3xd2/gqHpjSA8IWiJFGBjCLvWREE7QSypaqsC5DzFY9Cj6kdmsaRhzUyKYMRhCKqdhqnUuZPrLXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EO/BA6k6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XXrjFlXGwGKdyrGaQ+qk99Wr2RMFYX1C0OGJy7bKAAw=; b=EO/BA6k6hMbO7NUbSRSR5ZNvIW
	JvJ0pW5JNr+Ne6AU9edFWfO+G9cnmWETdhiazQA/fd2n6EkVNjVGEbFczv9qmxawMD/I2/mKizTKs
	s/e5iatw2Gmna5ErsmkyJ6M+NnE9Hh8hxsOeTUZ8bmsS6fKCGSqc7eJr3JBnMSAud/jWlNGBaRTnO
	y1Eemis9HWQWB1mzDrcWwX31HJKvwRUWl8OxKjCfq5CErc6LF8r9xi7qc9KntHjmAhIr4MQkH1rX8
	aDffoUWcBSVUKC24FkUhEki7iXambEBeXIq2O5aVSnQqC2PC5HzWBaogZMLSTiknCi0GNUTNXvG0R
	AksWKU5A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWhd1-00000007KOd-2yaf;
	Sun, 04 Feb 2024 18:54:07 +0000
Date: Sun, 4 Feb 2024 18:54:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: pgtable: remove unnecessary split ptlock for
 kernel PMD page
Message-ID: <Zb_dT43-oPsRplhi@casper.infradead.org>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>

On Thu, Feb 01, 2024 at 04:05:41PM +0800, Qi Zheng wrote:
> For kernel PMD entry, we use init_mm.page_table_lock to protect it, so
> there is no need to allocate and initialize the split ptlock for kernel
> PMD page.

I don't think this is a great idea.  Maybe there's no need to initialise
it, but keeping things the same between kernel & user page tables is a
usually better.  We don't normally allocate memory for the spinlock,
it's only in debugging scenarios like LOCKDEP.  I would drop this unless
you have a really compelling argument to make.

