Return-Path: <linux-arch+bounces-13985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71CBC79A4
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D74A44F0C4D
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAC276038;
	Thu,  9 Oct 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBaT4VqF"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803581F151C;
	Thu,  9 Oct 2025 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993341; cv=none; b=Q8io+y6kMXTXmE6Yl5eEdgT4rTiBxESyhVai0/pS8HPBSwYU7uhO4FezmeFr6yEaJfaV8Uzp2q3rbQqxEg9a8AAPywlyEphe8wnjY7SM+bo4bH/INuASv0y5O1GmjlcnujufipjJ/blbzgh+Oo0PiIc8beBfL15lwebFH2aDYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993341; c=relaxed/simple;
	bh=tvYLvDIBb3D303eQ6KXixRkOCxS6SBhi1y+E7dgsZjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/jPxCKm9nYWaWGGvVWgEl/W+DFFzI2ye4rkMtQAtf2ZH83FgLtV3ju1IWdqUtDf7kmd/sKN0uAHyMYJumAsKvWrEtxuMJwbwsGciBdjPtXWHm+KcrOjwUQtDxXTPXXGmVGcIXSmLj9qmoUaWZyAcIOffMsKW4ufEJmW1gqmvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WBaT4VqF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tvYLvDIBb3D303eQ6KXixRkOCxS6SBhi1y+E7dgsZjU=; b=WBaT4VqF0KMSU3YMU58QP5Bn3z
	xQ6JqzyO427EMlxrPHeLN/qRgrc/vKL7a87trCT4g+wIEHDF63CKcdFqUfzqXbp6VWXeQrwvRVrNE
	DnvMtI6VKv0wJcxOa6ZCEH7O5xooDmgLJELxgAqtW+Ho2DQMxDGvp2agPelh47rpjCObmTizjwgfe
	2nQSt0M3tEl/IHn23qcJ+TJ0ZsJECPM812nZp6VxdNlL0Dj/YrIFCImqWqw+gEUaSo9Jy1uhZAw7y
	IitWIVIzrbz35f0V6hzS7NWZeFru5L9ZJ0DyUFWi0p1PC0oDzMr1+6H/q726fWBse42Oto5j3pHyL
	grv+IQXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6kf8-00000002ykY-0j1O;
	Thu, 09 Oct 2025 07:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 612A3300400; Thu, 09 Oct 2025 09:02:06 +0200 (CEST)
Date: Thu, 9 Oct 2025 09:02:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Finn Thain <fthain@linux-m68k.org>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
Message-ID: <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
References: <cover.1759875560.git.fthain@linux-m68k.org>
 <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
 <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>

On Wed, Oct 08, 2025 at 07:10:13PM -0700, Alexei Starovoitov wrote:

> Are you saying 'int' on m68k is not 4 byte aligned by default,
> so you have to force 4 byte align?

This; m68k has u16 alignment, just to keep life interesting I suppose
:-)

