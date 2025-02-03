Return-Path: <linux-arch+bounces-9968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A32A258FC
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7A63A19C3
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 12:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD8A20408E;
	Mon,  3 Feb 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5P47O8r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59A204090;
	Mon,  3 Feb 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584433; cv=none; b=uWBuCxbufHUoq0g0fE7llaheVUdKeP9GV8ZJfO8WgsQ9udhpqCIz+PKBf1s61xArBxqhzp7tOQ1LwgLnquP+VCUFl/wuvR6lW5aid+NSyfPAgg3nbQ1sURRDXHT+iGZEETwgL21QgXCPKdBCtsQxdQKGWt9ZhWfcnzDjYmGsN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584433; c=relaxed/simple;
	bh=QpfyurEd8E5cwwV8WNfOjpdwcXEjHkqbkJYSxPJNKok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXSFqCm+JqKEUuBFC1oCzgNiHa7kx7d5Ww2iyKOCfVOFbkrdGJXIqAiZqh9mHKnnC1ih6dVGvmqGsMqVqovLDMpKU3CklpjlktEPpx3ywVlzCy+2v3Cdgo4+LoD6nopW6sFRk4E5ORZEsxmV7uIgPvN16xOpcyEDlr5JjHOYkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5P47O8r; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738584432; x=1770120432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QpfyurEd8E5cwwV8WNfOjpdwcXEjHkqbkJYSxPJNKok=;
  b=P5P47O8rNXH8RVZcVxofVdiuhEOGZthrztKFcSZgXi8io+QuA6gBEQt/
   +XIJfU/aRU1Hst4/APBgL97rHT60SrJA1+HgLZA3hdu/Yj5ljjzm1K+Hg
   kVG5Y8NnrsxTi+8/HmIKoJgcxV/fPyrOjl2NA/kvRuVWzgyzNCMSi72b9
   T7MtgtzS9hnapmHzBkCTFqN6Yyz/6dE9PAQu6ikC3jYODFiGB2ep9lQKI
   /NBoJj+BWJTRwKizfzYAbtWH97IK9iO9e1myKo9zOSRQWoJLlRkH0HbGY
   cgVQidIftuKLGnFZGmEHng+OgBiIS2WaB/KfzU1GsfxwtZiuuwTvRSs1+
   w==;
X-CSE-ConnectionGUID: ETq6nTXQQGS/yFKkXYpIIA==
X-CSE-MsgGUID: ayrkcj+SQ6WBPzbs07xAPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39337841"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="39337841"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 04:07:11 -0800
X-CSE-ConnectionGUID: mz8anxNETNG3b0vz+QKfZQ==
X-CSE-MsgGUID: y4Z/cwMwThG/H0Z/hn+OJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114896022"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 04:07:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tevEI-00000007oyK-2sLQ;
	Mon, 03 Feb 2025 14:07:06 +0200
Date: Mon, 3 Feb 2025 14:07:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Message-ID: <Z6Cxan9WE38_x41e@smile.fi.intel.com>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
 <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 12:43:01PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 3, 2025, at 09:25, Thomas Weißschuh wrote:
> > On Mon, Feb 03, 2025 at 09:18:33AM +0100, Arnd Bergmann wrote:
> >> I have not tried it yet, but I suspect this is not the correct
> >> fix here. Unfortunately the indirect header inclusions in this
> >> file are way too complicated with corner cases in various
> >> architectures. How much testing have you given your patch
> >> across other targets? I think the last time we tried to address
> >> it, we broke mips or parisc.
> >
> > It was build-tested on 0day.
> > I also gave it some light boot testing on kunit/qemu.
> > (Neither on mips or parisc)
> 
> Ok, I see. I checked the usage of these functions again and
> now remembered the reason we didn't fix it last time, which is
> that the semantics are inconsistent across architectures
> and I think this should be addressed first, so we can untangle
> the definitions:
> 
> There is one driver that is specific to ARM processors
> (drivers/firmware/arm_scmi) using  ioread64_hi_lo/iowrite64_hi_lo
> and this uses the documented semantics from
> Documentation/driver-api/device-io.rst, which says that the
> helpers always do separate 32-bit accesses (even on 64-bit
> machines), but that it's possible to just call
> ioread64()/iowrite64() after including linux/io-64-nonatomic-hi-lo.h
> in order to always get 64-bit accesses on 64-bit architectures
> but get 32-bit accesses on 32-bit architectures. There are
> another dozen or so drivers that do this.
> 
> There are two other drivers that were written for x86 that
> use other semantics (drivers/net/wwan/t7xx/ and
> drivers/ptp/ptp_pch.c): Here, the definition from lib/iomap.c
> means that even on 64-bit architectures calling
> ioread64_hi_lo/iowrite64_hi_lo on an MMIO space always
> results in a 64-bit access,

Interesting... I believe both cases mentioned in this paragraph
were written with only the include/linux/io-64*.h in mind.

> and only the PIO version is split
> up. On 32-bit architectures, this part is not provided, so
> it should fall back to split access (I think this is where
> we had bugs in the past).
> 
> Another complication is that alpha, parisc and sh (not mips
> any more) explicitly include asm-generic/iomap.h but don't
> select CONFIG_GENERIC_IOMAP. At this time, GENERIC_IOMAP
> is selected at least in some configurations on m68k, mips,
> powerpc, sh, um and x86, but most of these should not do that
> (mips, m68k and sh have no PIO instructions, powerpc had
> a hack that I think was just removed but needs more cleanup).
> 
> I'm testing with the patch below now, which separates the
> CONFIG_GENERIC_IOMAP implementation (with the 32-bit PIO
> access) from the normal version, and picks an appropriate
> one in linux/io-64-nonatomic-*.h based on the architecture
> to avoid some of the more confusing nested 
> "#ifdef ioread64" etc checks.
> 
> I checked that none of the three drivers ever actually uses
> PIO registers instead of MMIO, and since none of them use the
> big-endian accessors, this all turns into readq/writeq
> in practice anyway.
> 
> The ptp_pch.c driver still needs more work as I noticed two
> issues there: the driver has a mix of lo_hi and hi_lo
> variants, but it is unclear whether is is actually required
> on 32-bit or if the hardware works the same either way.

PTP is special, some registers are related to a read timestamp IIRC and
hence hi_lo is a must there.

> In addition, these seem to be timer registers that may overrun
> from the lo into the hi field between the two accesses, so
> technically a 32-bit host needs to do an extra read to
> check for overflow and possibly repeat the access.

Yes, precisely why hi_lo is used to minimize the error when it races like this.

But IIRC *_pch drivers are for 32-bit platform, the code, if so, was made
to be compiled on 64-bit but never used IRL, just for test coverage.

(I believe the PCH stands for EG20 PCH, I have [32-bit] boards with it.)

...

I like the lib/* and include/* cleanup but PTP probably should stay as is.
OTOH WWAN case most likely had been tested on 64-bit platforms only and
proves that readq()/writeq() works there, so it's okay to unify.

-- 
With Best Regards,
Andy Shevchenko



