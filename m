Return-Path: <linux-arch+bounces-14667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0717C52A5F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 15:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54EE4341CEB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C932848A1;
	Wed, 12 Nov 2025 14:17:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832DB27EFF1;
	Wed, 12 Nov 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957078; cv=none; b=mr3C7dhz+1b5scruRqI5mbQzaA6xA2ZKEyV0e5J1Nb/H62/AiiYVbsOXrtqBOn9YISj1ptxTUaQd8RaJqt4EUsmTCqtBn0WvWxJRJINFYXzcvZQ2JUXCcSt2kf1V3B4YV6B6ddy0ma0FJ52rwO8thnTHvkulfiBwQ+9i24KLnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957078; c=relaxed/simple;
	bh=yHCsSRmzIEcc2+pbJTsDiLYepFiqMay3UJUEkTzqLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgB2ik75bVbTosm0EGYPWF1+qG6wVz9l6fzurLVoMxulq8hc7w24E8cLmxr7BXzyJLIp4YVh/tQHbGYs/lhq9MmMb6Yz0AkRfNdBKRYv76aCvhekGz8yL0mRg5X7uI0+IARiThgKbMZjoz4FQbZIjYqS8hEyP50nA7QFE35Xh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B4D1515;
	Wed, 12 Nov 2025 06:17:48 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D563F5A1;
	Wed, 12 Nov 2025 06:17:52 -0800 (PST)
Date: Wed, 12 Nov 2025 14:17:49 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Chenghai Huang <huangchenghai2@huawei.com>, arnd@arndb.de,
	catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, ryan.roberts@arm.com,
	andriy.shevchenko@linux.intel.com, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, fanghao11@huawei.com,
	shenyang39@huawei.com, liulongfang@huawei.com, qianweili@huawei.com
Subject: Re: [PATCH RFC 4/4] arm64/io: Add {__raw_read|__raw_write}128 support
Message-ID: <aRSXDTT44_3iutEg@J2N7QTR9R3>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
 <20251112015846.1842207-5-huangchenghai2@huawei.com>
 <aRR9UesvUCFLdVoW@J2N7QTR9R3>
 <20251112140157.24ff4f2e@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112140157.24ff4f2e@pumpkin>

On Wed, Nov 12, 2025 at 02:01:57PM +0000, David Laight wrote:
> On Wed, 12 Nov 2025 12:28:01 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Wed, Nov 12, 2025 at 09:58:46AM +0800, Chenghai Huang wrote:
> > > From: Weili Qian <qianweili@huawei.com>
> > > 
> > > Starting from ARMv8.4, stp and ldp instructions become atomic.  
> > 
> > That's not true for accesses to Device memory types.
> > 
> > Per ARM DDI 0487, L.b, section B2.2.1.1 ("Changes to single-copy atomicity in
> > Armv8.4"):
> > 
> >   If FEAT_LSE2 is implemented, LDP, LDNP, and STP instructions that load
> >   or store two 64-bit registers are single-copy atomic when all of the
> >   following conditions are true:
> >   • The overall memory access is aligned to 16 bytes.
> >   • Accesses are to Inner Write-Back, Outer Write-Back Normal cacheable memory.
> > 
> > IIUC when used for Device memory types, those can be split, and a part
> > of the access could be replayed multiple times (e.g. due to an
> > intetrupt).
> 
> That can't be right.

For better or worse, the architecture permits this, and I understand
that there are implementations on which this can happen.

> IO accesses can reference hardware FIFO so must only happen once.

This has nothing to do with the endpoint, and so any FIFO in the
endpoint is immaterial.

I agree that we want to ensure that the accesses only happen once, which
is why I have raised that it is unsound to use LDP/LDNP/STP in this way.

> (Or is 'Device memory' something different from 'Device register'?

I specifically said "Device memory type", which is an attribute that the
MMU associates with a VA, and determines how the MMU (and memory system
as a whole) treats accesses to that VA.

You can find the architecture documentation I referenced at:

  https://developer.arm.com/documentation/ddi0487/lb/

> I'm also not sure that the bus cycles could get split by an interrupt,
> that would require a mid-instruction interrupt - very unlikely.

There are various reasons why an implementation might split the accesses
made by a single instruction, and why an interrupt (or other event)
might occur between accesses and cause a replay of some of the
constituent accesses. This has nothing to do with splitting bus cycles.

Mark.

