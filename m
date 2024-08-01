Return-Path: <linux-arch+bounces-5888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7D944DBB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92760B21792
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396A1A4884;
	Thu,  1 Aug 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qONyCuTM"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED01A3BA6;
	Thu,  1 Aug 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521746; cv=none; b=aoHfJp/Ud5vGlclW/m3qXRk1jEJCsUrKo4ml7xS08zUdZPh95wHBD6wu8SjCqjdpjIaWFEnyn1Hwr+FEGOTpOnJIfZSO9xAw9mMoM4091cty8eMkOjSlkFMMXrxMDUQfKquecoZQf9MDf36JTd6DAfb6x0D0nEVLg/eEMOtVF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521746; c=relaxed/simple;
	bh=3X46hSaAqW+SybLGb1T+P0kPLPBtb/OEq9Ct18C9TEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K68JTjHMmZDFy/wmgB2KZVtvdN+7feMGU3pgWmCfOlAODXZbJhRzwZSSElC8B2KhTKI3UYiIOJiNg6q+Fbd1f7G1I8wEtkPCcY7Opvsp5GEMwunU4dpy/yDqizcZ1O+OBCTtLsdE7x3x3TZpyUEje4eN/0wpXZqQoBoaxcBJZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qONyCuTM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Llj0thCWyHmdMwfKQPKFIkXT0ex9mx5ak8YGqPuRtZY=; b=qONyCuTMCjAFZ000cEy8VYPRNB
	GhlhW4q9o4PfSktxhNYSJ7wcfDwKFoHORTL5sQTq7E6qu+caZHzNsq8gmCb/5bHEE+Bwxy6Gd7zsI
	DjXjBNXcSoN4YKyGMlt302CsDdb2rD6mMDwZ9RAB3ZCuFIddmGbXGRXJyFreX1WQ2XCTgm7rdnggx
	FH7PgO2ifz7lQYRE0ERA9a78qmFXbm/BwykiKm2OIflHtWUoLuBNNmgmCVmSjgScm6DDJmgf5w0Dd
	Uvn/+U4kc+nd5ioP3s+7kUS9vlk3hoBB+XctgJiAjTtveRmYL2eFgluNgNlUhR8UR939YJLdBs9S4
	X+HZxLjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZWae-0000000HXXJ-26b8;
	Thu, 01 Aug 2024 14:15:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1266B30074E; Thu,  1 Aug 2024 16:15:36 +0200 (CEST)
Date: Thu, 1 Aug 2024 16:15:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 00/13] Zacas/Zabha support and qspinlocks
Message-ID: <20240801141535.GC39708@noisy.programming.kicks-ass.net>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:52AM +0200, Alexandre Ghiti wrote:
> Guo Ren (2):
>   asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
>   asm-generic: ticket-lock: Add separate ticket-lock.h

>  include/asm-generic/qspinlock.h               |   2 +
>  include/asm-generic/spinlock.h                |  87 +-----
>  include/asm-generic/spinlock_types.h          |  12 +-
>  include/asm-generic/ticket_spinlock.h         | 105 +++++++

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

