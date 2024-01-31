Return-Path: <linux-arch+bounces-1945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C98445D2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DCF1C21372
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B312CDA4;
	Wed, 31 Jan 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rsl8t/33"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BE374D4;
	Wed, 31 Jan 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721436; cv=none; b=mbjcVjll6+ouA0Iop1vmjeQyW8sTz4x76JsiNNXn0eXMKy3tSsl9Phzgo3BEnQX2iQXxI8Y/R3uUnwnG9+AirL+a2EX0dxvNi1PACX05K7tN8yRn7VPxJMrSfnej+K0VhOfMnBmoOEYvB28YrXhOWc5Kqfc1BUTPe8q/8PWN9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721436; c=relaxed/simple;
	bh=U5JVlzMHnikLTbflOiwB0cOegF5Lvb4lezm32PuIfRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkXPKAxaAj/Qhvk4meP8/9HoK/cKqs91B5/A7eOkkX349ILhv7Y9ATOzW1AupARu03mjZ7IiE/J9XjwABlSpo/YMxZFuf6MaFYKKtsqem+s5VOS86J/eEGx0x9osh5yLHvdqInY9id7Uf/c80aK+F3wxh/P6Te7XgYant9Wkdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rsl8t/33; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w1jT7gCr/nu7sGcbwL+LF2kX9U7qRsSCTeyoHJy/WoQ=; b=Rsl8t/339Yi08Mvz6SuF7kZN9I
	CnN3y5DZzKI3qBcG10yO78L9AswhfcfGda6buppIVmKYQ9rLKArcacUl6PzWQKPv+4Dp3W3XbHTPE
	uR3N0EolP0wZTTYSNI7cBEp+leg0S4wWEK+goRXqzwEqpGjAmDIJZjf/xSYhM/M6zgIEsneIh3U8u
	+pt0ncx9X6NMNHS9RFoUOhBzFwp2TK9GLbQT2+GNezMOfKRSEjDKbr5ek0Dc6zikgjUsYdddqp8Sd
	+MR3RJ7gAhCxPKgDb/DR6F/DjccFH/pDiX2BjiZS0ns77g3HyhidMuWY+DeEGolOioj7UEUcIcNvC
	m4xIsg3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVED1-00000004nCR-20Ex;
	Wed, 31 Jan 2024 17:17:11 +0000
Date: Wed, 31 Jan 2024 09:17:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [RFC PATCH v3 3/4] Introduce cpu_dcache_is_aliasing() across all
 architectures
Message-ID: <ZbqAl3gerwe2o6jy@infradead.org>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131162533.247710-4-mathieu.desnoyers@efficios.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

So this is the third iteration and you still keep only sending patch
3 to the list.  How is anyone supposed to review it if you don't send
them all the pieces?


