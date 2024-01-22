Return-Path: <linux-arch+bounces-1418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D5836E27
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D593DB2748B
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A724EB52;
	Mon, 22 Jan 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ieCSjXXY"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DD4EB27;
	Mon, 22 Jan 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939835; cv=none; b=EtXPGB+0Y4mqFEG78HtwVz/Z63eUmUwwRR+d/kp0PpOz23GKN5J9Ie5zG+Zf2EgUWzAZkn8LeIne7bi4HiaPLFRz+WhD/uUM0RgWQVY/8GEpnzC3cgfrTzYO6q+I+DGDhO0qC0A647N6sqme6qw062QhFAOu3utDG5MLqOZeLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939835; c=relaxed/simple;
	bh=ZGt+C8kuxGgVLMYmXGUjNl+mzXfyON8bvg5n6vThnh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+k0+RFYk+aPQyXlt9HTfzaBpKFRUb1sspyg7oYxBiUcNYhzrHRqhnxFkUMPArPtMPO/Wc1JZOj+smV+NUZhKSLZP4jUUn4nR7tcOgnJF1kBEC8RDenkUGchMG48+0b3dqwuQ7BKMDKdpHXUWKk7O/fO+0Q6mOB2HLRxvH/9Oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ieCSjXXY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IUlnu8wi62rcUhXVGusVj8nsgov/bqx6G7ayEgbR6Do=; b=ieCSjXXY7jvvGh6xwiGqNI73/W
	qe1GyjCUPL4h2XSKuCnHBWT7h7KFV1aC7kF5e8OcTFz3Lsrxj2GCxwmd1uAB9RjaGqZGP9BxkyASl
	CGOm2v09k5Fsq3jm5LkT5FgkPfhgbYAuN0DzhNMzBdVu+GAlM5uSZTEYXlnsv4bNNSkgw6J6RUZm8
	QpdMUZa2k5NlnEorqHIg0eCicVFoDRTYvfY/IV3S7kqCL4uzpbZlsuzmTFHZW9WRp0nTUoqE7UUyK
	VqlwnD4v3vNR3bjQ+41+pQNCO5AwAzySLfQozEP9/YpnG/tepI71cUEC5DxPCkScK8xTrET7wz76p
	BOnCeoOg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwsZ-00Cstp-1Q;
	Mon, 22 Jan 2024 16:10:31 +0000
Date: Mon, 22 Jan 2024 08:10:31 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_*
 sections
Message-ID: <Za6Td6cx3JbTfnCZ@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-3-deller@kernel.org>
 <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
 <1b73bc5a-1948-4e67-9ec5-b238723b3a48@gmx.de>
 <ZYXtPL7Ds1SUKPLT@bombadil.infradead.org>
 <59bc81b5-820e-40ff-9159-c03e429af9a6@gmx.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59bc81b5-820e-40ff-9159-c03e429af9a6@gmx.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Dec 30, 2023 at 08:33:24AM +0100, Helge Deller wrote:
> Your selftest code is based on perf.
> AFAICS we don't have perf on parisc/hppa, 

I see!

> so I can't test your selftest code
> on that architecture.
> I assume you tested on x86, where the CPU will transparently take care of
> unaligned accesses. This is probably why the results are within
> the noise.
> But on some platforms the CPU raises an exception on unaligned accesses
> and jumps into special exception handler assembler code inside the kernel.
> This is much more expensive than on x86, which is why we track on parisc
> in /proc/cpuinfo counters on how often this exception handler is called:
> IRQ:       CPU0       CPU1
>   3:       1332          0         SuperIO  ttyS0
>   7:    1270013          0         SuperIO  pata_ns87415
>  64:  320023012  320021431             CPU  timer
>  65:   17080507   20624423             CPU  IPI
> UAH:   10948640      58104   Unaligned access handler traps
> 
> This "UAH" field could theoretically be used to extend your selftest.

Nice!

> But is it really worth it? The outcome is very much architecture and CPU
> specific, maybe it's just within the noise as you measured.

It's within the noise for x86_64, but given what you suggest
for parisc where it is much more expensive, we should see a non-noise
delta. Even just time on loading the module should likely result in
a considerable delta than on x86_64. You may just need to play a bit
with the default values at build time.

> IMHO we should always try to natively align structures, and if we see
> we got it wrong in kernel code, we should fix it.

This was all motivated by the first review criteria of these patches
as if they were stable worthy or not. Even if we don't consider them
stable material, given the test is now written and easily extended to
test on parisc with just timing information and UAH I think it would
be nice to have this data for a few larger default factor values so we
can compare against x86_64 while we're at it.

If you don't feel like doing that test that's fine too, we can just
ignore that. I'll still apply the patches but, I figured I'd ask to
collect information while the test was already written and it should
now be easy to compare / contrast differences.

  Luis

