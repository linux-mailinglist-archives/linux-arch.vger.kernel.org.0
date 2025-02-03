Return-Path: <linux-arch+bounces-9975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA4A25CF0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 15:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842BE16B0B8
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99820B21C;
	Mon,  3 Feb 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN7xefHL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747520B1FF;
	Mon,  3 Feb 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592973; cv=none; b=ukuHh4h8sBJn4fzo+CikjtAx8P0fo3gk2Vgi/fRz8z7ROKmK00jtpr14kVQOHTI04x1P0I2pLHUQ1OC0JHvxm6RcPHnxhBCOORQ4qDDNvOqe/49LhDQXQcC/A1alTYpcAIi5O5OE0pfnd6TWQETTCpS6Jm4Byz+HH++wJ4cdhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592973; c=relaxed/simple;
	bh=NJ3h5WOGTaqTFPG1T6M2d2Y2MZWC9yQaWbsJhTh73Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASB5jTE+Iz1/nEb2rtbwq8R/SgtcYcoOFqlQcxPMUs7mNbA5nO6cgFyfUKp+bWo0wrgXuTq549+9FCoia7/VxyhFhBSRxV3xdbhwLa+W0j9v7naOatMWNMAMKW9mw/Hlap4R0oT5OfAKI++hKDrdEqxoEaWfsyX2jYk2Pi7qdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN7xefHL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738592972; x=1770128972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NJ3h5WOGTaqTFPG1T6M2d2Y2MZWC9yQaWbsJhTh73Gs=;
  b=RN7xefHLcgTgag2jdtegX5T1jYUa7br+8VPTR2LYbFxA+bRZMdrhvsdE
   m6UXuEHJckNj0cv6wRh5jE0oWRE7lunzA+EQPI13HeJTzAEcHRtTWE8n9
   znN1PHWZ9tetoievhOusAZeF0XaIcKfVnuMBfuOPidLBErlnv1shKG+wV
   NZmu80ml67fSUHi0qD5OV/r2uc1WM37jPmvcasELhdlk2F43TIsKkONys
   w6KMZP/AJIiTkbhvvHKRaFmyItfyYUS1CqpMy2yJsgZmPbDEF3w2bIXwA
   afeKLlmnpxz0yQ8cjMnlF1HgY17A9ojCG/Kfygi5A4agSB29HU7npvvwm
   Q==;
X-CSE-ConnectionGUID: m0DT79jWR/62xcBaIXtwtw==
X-CSE-MsgGUID: oKPWgU9YSkiIrgYE9qBvfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39117244"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="39117244"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 06:29:31 -0800
X-CSE-ConnectionGUID: VIck8FrLSJiBpEmdyTOO6Q==
X-CSE-MsgGUID: 5cDhAPQ4S8euVG79jpwpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="110469329"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 06:29:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1texS2-00000007r7P-1T2h;
	Mon, 03 Feb 2025 16:29:26 +0200
Date: Mon, 3 Feb 2025 16:29:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Message-ID: <Z6DSxjSO6hcrt-eL@smile.fi.intel.com>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
 <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
 <Z6Cxan9WE38_x41e@smile.fi.intel.com>
 <96829b49-62a9-435b-9e35-fe3ef01d1c67@app.fastmail.com>
 <Z6DDQlhmzvNj-B7o@smile.fi.intel.com>
 <5f40c879-1430-45e8-aca2-d94706b8671c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f40c879-1430-45e8-aca2-d94706b8671c@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 02:34:11PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 3, 2025, at 14:23, Andy Shevchenko wrote:
> > On Mon, Feb 03, 2025 at 02:08:35PM +0100, Arnd Bergmann wrote:
> >
> >> > I like the lib/* and include/* cleanup but PTP probably should stay as is.
> >> > OTOH WWAN case most likely had been tested on 64-bit platforms only and
> >> > proves that readq()/writeq() works there, so it's okay to unify.
> >> 
> >> Ok, I'll try to split it up into sensible patches then. For ptp
> >> (both ixp46x and pch), these are the options I see:
> 
> Update: While splitting out the wwan patch, I see that this would
> revert 7d5a7dd5a358 ("net: wwan: t7xx: Split 64bit accesses to fix
> alignment issues"), so that driver also needs to keep using the
> split accessors, at least for some of the registers. From what
> I can tell, the problem here is that REG_CLDMA_UL_START_ADDRL_0
> is not a multiple of 8, and arm64 CPUs require MMIO registers
> to be naturally aligned.
> 
> If that is the cause of the problem, this means that on x86-64
> the unaligned readq() is still used but happens to work.
> Once I change linux/io-64-nonatomic-lo-hi.h, it will split
> the access on x86-64 and other using GENERIC_IOMAP as well.
> 
> The accesses to ATR_PCIE_WIN0_T0_TRSL_ADDR and
> ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR can probably use ioread64()
> because they are on aligned addresses, but it should be safe
> to just leave this driver alone and keep all the split
> accesses.

Interesting. I haven't followed the development of that driver, so it seems it
gets some fixes over the time. In previous reply I was under impression that
the code in question was initially written by Intel and hence was assumed to
split (because readq()/writeq() usually works there and no explicit treatment
is needed in the most of the cases).

-- 
With Best Regards,
Andy Shevchenko



