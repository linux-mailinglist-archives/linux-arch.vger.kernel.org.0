Return-Path: <linux-arch+bounces-15692-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42755CFEC92
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 17:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F22C30141FF
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D778357A3E;
	Wed,  7 Jan 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXotIqNN"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52833CEA5;
	Wed,  7 Jan 2026 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797625; cv=none; b=PQ9hMgrwnEk6fuk/JxP2r9eKKV0dRfj2lWryc1jJZw4LCcAgAgL5reHlDzffmy/1Ao78clFdp6ZkG5H/G2jqFjgLNDgFfwv/YOm1IjacTJS5m1sDPK9B9TgBNxv0oeTr6Q2dX0jmRVoYUeA0Jen48ofRg9GKtZz1Yt5/Czu0z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797625; c=relaxed/simple;
	bh=iMvBxsExFQCPGOjEkdRrFfbrKTfT55RAESh2TUTSxcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS0jMV+P1RGfJ3UcYoVTzR1JGghempTOArrJQTQy/5R9m5EmcrBIMYiGI2C6ukWTTrKubqMpghb+Rz3KcfHdoblaFtUlNxEAw9R6R8pZhBXsxThyAWV6upVv5ncvK+k25laVNjucDx47IjxnuT5znImJc8jDVRn9GSEZdICbFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QXotIqNN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N/MSGdm4Pn94QVvbBIPMYP8yHiQacuBfDGzmKsc3hKc=; b=QXotIqNNT/HVDRTm2V+NGY3EYa
	51N5hZPgpuLxtJc/LHnPBxl/SAfQlnN9EiZqwW91lt6SG4oT0y1pbCIloNr9Y/hWsMw7STAAe4npK
	nC2LvHqAbtg6hDCrxDaTYAHkDZLK4GRO/50zGXLPnE+9BbsyXvCqCgEYZTPV3Lm/nmGyQWmgbyn/+
	wvCItMwzoyGbzR3iNGVMOH1bpZ5blzltQHraCRhCaixsvCCqKNYRseljywpUuM+wzffDsMFlc4sX3
	ZPovcnR+N2BzFJ8DaYtE3m6Kck9KyJGh+CK/S0YAP674BfGA919TGhR4KqA1DOo4vUXGW5s1fhG3i
	Wg8XVBtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUur-0000000DVzV-1s2j;
	Wed, 07 Jan 2026 14:53:41 +0000
Date: Wed, 7 Jan 2026 14:53:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/pgtable: remove unddefined
 __HAVE_ARCH_P4D_ALLOC_ONE/__HAVE_ARCH_P4D_FREE
Message-ID: <aV5zdQ2pX9vKM1aj@casper.infradead.org>
References: <20260107063911.15299-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107063911.15299-1-alexs@kernel.org>

On Wed, Jan 07, 2026 at 02:39:10PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> No any archs has ever define __HAVE_ARCH_P4D_ALLOC_ONE/__HAVE_ARCH_P4D_FREE
> So let's remove them.

No, let's not.

