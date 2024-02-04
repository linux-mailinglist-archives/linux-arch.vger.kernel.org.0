Return-Path: <linux-arch+bounces-2081-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DC848FF9
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 19:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AE9281EFA
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C324A0E;
	Sun,  4 Feb 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uUrPYftC"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FF249FA;
	Sun,  4 Feb 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707072674; cv=none; b=lpqQmKVsAGbaVSNjmt3uPLWEA1B9WEHNQEpNvugXuHv2aTeBPtn6fikLGSuhK5wnVg03jAz1Ss0okWK64kjzcLoLWs+0qtuITG6cW08KvwcidftCnumHxRFoMT1kLCXSMc1Jkf/7tCbbS/Z6zhArCsjeBqw0zPvTiCL2gi8Oz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707072674; c=relaxed/simple;
	bh=rZwhviKeGpwY52zfMS1cJH4b/Ftak5t0AXIDWc316yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKUZVDvLCpFGoU2m+d0e2ezS49Oewo6uiCIwJ9GSDhF2eGwLLD1x3iV2OOj8vNJm5A2To7XW1NskaLwZjGA5okh+Bs59Sv+ARJ4oeUEOn2qqgRCOXRoy1rHzsizRcyKK5GWQFr5WY0WhxRBrmdBFi12QakO4UMtum3fODFwPb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uUrPYftC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h8i0ZBrZe7lVtRp0IwzilVeBlhhqzKAVTmt6f/Jrtzs=; b=uUrPYftC8Xnn9WGjYChRzGUuEB
	kaw+oQCk3iBTYwSUrRuGD0t1kfeFVj5/SxpRMcX2BrdG41h/3pqXDsPE48SgECjPyTw+1Yk436lax
	DdRAurDfdvkhwhDeGWztKDk+fqbVuo4RMpwCs7qrqH4Bu+nUtxcsOpmVEz7Z0MphzdZTntNwsSY93
	V4HDIjOXR0VLpjFkcHBJ3NHtF4XyvoQKjtZI9nTg0gD38j2fWyqEH6N0x56S5XWyyyVeYIEDoaejp
	+eBMQ2cpLIEyWcIHSN+aK9CM7+wPZaOT4JjrRE0tuzwg1dl2aO0q4z8HCL6ghOo4WS3kT4YCW0TmN
	l0PjK0IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWha5-00000007KJG-2Fgk;
	Sun, 04 Feb 2024 18:51:05 +0000
Date: Sun, 4 Feb 2024 18:51:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
Message-ID: <Zb_cmZByel4cULDP@casper.infradead.org>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>

On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
> For kernel PTE page, we do not need to allocate and initialize its split
> ptlock, but as a page table page, it's still necessary to add PG_table
> flag and NR_PAGETABLE statistics for it.

No, this is wrong.

We do not account _kernel_ page tables to the _user_.  Just because
the kernel, say, called vmalloc() doesn't mean we should charge the
task for it.  Moreover, one task may call vmalloc() and a different task
would then call vfree().

This is a can of worms you don't want to open.  Why did you want to do
this?

