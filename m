Return-Path: <linux-arch+bounces-13662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B1B7D4A6
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CA617E3CF
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F529A9E9;
	Tue, 16 Sep 2025 22:12:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from cynthia.allandria.com (cynthia.allandria.com [50.242.82.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA1283680;
	Tue, 16 Sep 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.242.82.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060761; cv=none; b=KJf1iliYjPaXwUqf74Y/w4NvHG8++3ddqiOiksgfU7N/s5ibP2TaJbRen570/huLgrdjkh021wMWtxzHhFc1+8FmDvTOdaIdIQf2evsSRbrAh1PEbH/GWL02iX+qdRyXPjK2l1M5NRLGjEEG+xstxf+gYVPIwG1YaO2D7rcdT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060761; c=relaxed/simple;
	bh=K20w/tR4L5Hr+p3kQf9+3/eXO3aQKHRleh4af8OXvXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnDW4SJMB7O6H/Wn2f98SGJO1a+R0vdABpZXfxgJ7Bq9vstqZSIhR5DfUJ8ahhnpP7XtDjXxecx38GaGx5LBHYnDyLi8THg6ehGkQ2EsF9Q074DDgU6TObcAFA5Tnoqr8yO598/80f/mFeXKnfkRIOf15nVDLziEVlgDcx7+MfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allandria.com; spf=none smtp.mailfrom=allandria.com; arc=none smtp.client-ip=50.242.82.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allandria.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=allandria.com
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
	(envelope-from <flar@allandria.com>)
	id 1uydO6-0003P1-CD; Tue, 16 Sep 2025 14:38:58 -0700
Date: Tue, 16 Sep 2025 14:38:58 -0700
From: Brad Boyer <flar@allandria.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
Message-ID: <20250916213858.GA12681@allandria.com>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
 <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
 <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
 <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
 <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)

On Tue, Sep 16, 2025 at 02:37:21PM +0200, Arnd Bergmann wrote:
> arch/m68k selects CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS for anything
> other than Dragonball, so I would not expect much performance difference
> at all, unless CASL on unaligned data ends up causing alignment traps
> as it does on most architectures.

I believe it depends on the exact CPU. The 68060 user manual has a
section called "Emulating CAS2 and CAS Misaligned" discussing the
handling of such instances through software emulation. The 68040
user manual doesn't have any similar section. I haven't looked at
the exception handlers in the kernel to see if such cases are being
handled. The documentation says it results in an unimplemented
integer exception, and the handler has to manually lock the bus
while performing normal memory operations.

	Brad Boyer
	flar@allandria.com


