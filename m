Return-Path: <linux-arch+bounces-13609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B49B57281
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 10:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16E73BE3EB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF682EA14E;
	Mon, 15 Sep 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TwOVV/99"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15B2135B8;
	Mon, 15 Sep 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923569; cv=none; b=CAlPGeWYL9YwS8S28V4Va9uZiqlHNXPiym8QUVkyj6Pc795Ic3c+JFpZpwwVLgRi5WiHRMNCem6USRMlnJO2f4oM2yF7t1cbMbQLQjUjZUC8UmKJxUbpyrJdhcm/oWCjcx/basHsFSxREenqV6WWwoRdh272BVmRgjAqKmmpSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923569; c=relaxed/simple;
	bh=oFrTDktTFiktI9UAz3zYiN0lhC3FtY+9Cn6H/VJQIDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej2R8k9H+5SPZ8w3cfKeVu0UKUjiWtzxPwpbeiMjJpHd5kECVqp/P56SgfuT2pik6HUvmSL2d+9z6pfsevigJyK8yIxQ0yCIJwT3uvmSKLl8EUNiE6Z/Pn32APUiYzImkeEclxgBMcV+bWs0XcMeQDQAHgwv6OkDKcDBjFUYixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TwOVV/99; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IcptKrOCeXeq0uLG6WubqPVUYs4JHED1EQfTxtwMDaA=; b=TwOVV/99YHwxkZfPcHuonE8esM
	l+CDZgx3bkl5IxGCAuhzmtNLFqLiBdJYjKNNkIBlY5u7Z6ZNs7I1KMerMEd5o+DvcYRVYV6mfMJju
	yyX0VcC4WeKkqCLxyIgsuq8ANqvozvkU1oJS+nSHN+hTLLsHsCTgHUgX+fgBngDfzpcZmCbpzEnhX
	YUtjpP3qqYd6G0Xrx/UzUAhRkVYJXEMYqjUA+ZVcTWd4wvO4YT5bwPtAHexIpyGUZkd4N4v/hkATG
	JYFRE2FS1WDQ2S3urA4GVZn3VML2Dfazk2GtpQ3yzVVz3o9XcDTrJEpFIe7g67Oh6FBckict7cmz1
	aUIwpd3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4Dp-00000006ttQ-35K2;
	Mon, 15 Sep 2025 08:06:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5E8E302E03; Mon, 15 Sep 2025 10:06:00 +0200 (CEST)
Date: Mon, 15 Sep 2025 10:06:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@linux-m68k.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
Message-ID: <20250915080600.GT3419281@noisy.programming.kicks-ass.net>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <f1f95870-9ef1-42e8-bb74-b7120820028e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f95870-9ef1-42e8-bb74-b7120820028e@app.fastmail.com>

On Mon, Sep 15, 2025 at 09:35:08AM +0200, Arnd Bergmann wrote:
> On Sun, Sep 14, 2025, at 02:45, Finn Thain wrote:
> > index 100d24b02e52..7ae82ac17645 100644
> > --- a/include/asm-generic/atomic64.h
> > +++ b/include/asm-generic/atomic64.h
> > @@ -10,7 +10,7 @@
> >  #include <linux/types.h>
> > 
> >  typedef struct {
> > -	s64 counter;
> > +	s64 counter __aligned(sizeof(long));
> >  } atomic64_t;
> 
> Why is this not aligned to 8 bytes? 

Yeah, please use natural alignment for all atomic types.

> I checked all supported architectures
> and found that arc, csky, m68k, microblaze, openrisc, sh and x86-32
> use a smaller alignment by default, but arc and x86-32 override it
> to 8 bytes already. x86 changed it back in 2009 with commit
> bbf2a330d92c ("x86: atomic64: The atomic64_t data type should be 8
> bytes aligned on 32-bit too"), and arc uses the same one.

Right, so x86 as a whole will accept unaligned data for its atomics, but
at terrible overhead. Modern x86 grew (optional) trap on unaligned, and
we've made sure the kernel is 'clean'.

With that, the i586 cmpxchg8b instruction very much wants 8 byte alignment.
Similarly, the x86_64 cmpxchg16b instruction wants 16 bytes alignment.


