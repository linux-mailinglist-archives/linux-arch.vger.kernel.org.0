Return-Path: <linux-arch+bounces-7564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823D98C6E4
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 22:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAAE285B6A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63B1991DF;
	Tue,  1 Oct 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q+UUro4t"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE51CCEE5;
	Tue,  1 Oct 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814894; cv=none; b=Xo0HPYFIFHLJly37GR7SI+xnicXf5fZtYkTgIQXgl8gnCMh7pnY6XU8HbLTdgAu5K/unVOdE3JtmFUtsxB1BRa3TT0fYFIYFcJUFBn/HOTqzBjAdhjD9KjXlaiyuwCXyHFV4d5B8rdnxaBMwX21wn2Wif2lstgZT8u2rqy7epOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814894; c=relaxed/simple;
	bh=S3G2/qIRuRgX6DIlMRbUN7olB2mXOUsAohWQYBWaRRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAwnUn79V/hvSVanJX5B4AlezMxLUNzWkc4imwVWxL5SUTxUWtTbDg1KaODDYzSIsmaF4CTWfz0b5xRfQn+4JsUdSRdTry3jBtqNB+85CKppBK7jrrFtZIedX4ezWq269ZErpXzbJgBfFTIRDOUcufLsAta9tpskrTIETwXBXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q+UUro4t; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=40hpZxJza5B+fK0jnCX+5kmThmw2I4ieWXbZTZp5u1I=; b=q+UUro4tZUBkGINt2b+FFw9hoW
	EE0xlV4PckF4hIvITQ2ldEOiKbCWy8AYBZuO+FqqCPSOZEuHptMatQQvZLEkt2tbN6q010GKO14bu
	s4Z/G4YpfWtB2CyMdaUdSYl0VrkdcYde4HS0/MMTz5rcaiCE3ZattYjspt8IhZBhDASJ07FyFITEo
	uygqoDFbWub6oP024lPugvo4qHFgXHDFp9VnYRD7Erv4KvexCveUJFH+yUeiRbFprcPNL1h6H3j3y
	1q1rIE46yez85BJlwFiTh1Sf/alIZy8SDyPyP4uxmrLtj0MtpsbWaF/RTCmpWdlYRp5n3rAxleqmW
	VmuEvD0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svja5-0000000HN23-31Gf;
	Tue, 01 Oct 2024 20:34:49 +0000
Date: Tue, 1 Oct 2024 21:34:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
Subject: Re: [RFC][PATCHES] asm/unaligned.h removal
Message-ID: <20241001203449.GA4138323@ZenIV>
References: <20241001195107.GA4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001195107.GA4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 01, 2024 at 08:51:07PM +0100, Al Viro wrote:
> 	There are only two instances of asm/unaligned.h in the tree -
> arc and parisc.  Everything else picks it from asm-generic/unaligned.h
> and if not these two, we could just move asm-generic/unaligned.h into
> include/linux/unaligned.h and do a tree-wide search-and-replace that
> would kill the largest class of asm/*.h includes in the entire kernel.

Second largest, actually - asm/io.h has more users (1035 vs. 825).
Top twelve by number of includes:
	1035 asm/io.h
	825 asm/unaligned.h   
	767 asm/page.h
	490 asm/processor.h
	482 asm/irq.h
	475 asm/cacheflush.h
	423 asm/ptrace.h
	402 asm/setup.h
	287 asm/tlbflush.h
	284 asm/sections.h
	237 asm/mmu_context.h
	205 asm/smp.h

Still, asm/io.h has a lot more reasons to be heavily arch-dependent...

