Return-Path: <linux-arch+bounces-9972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9826A25ABE
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C01F164D77
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF7204598;
	Mon,  3 Feb 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5TJwG5W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C235CDF1;
	Mon,  3 Feb 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589001; cv=none; b=H3CPGp9FBHHUTaCdzTmAXAoM3YRCxIzSJEXyA53K2mxFkSS9lvAjvuSxKlFd8E1V9fdhGCg8bbzeMYAue3tP8zW24paldESWZojunaqDghefpe0bU2/UMOo+T2L2/KYx1UdJJQtAp217bn8hhGoH+suT/mib4zojiS2wulJ7CX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589001; c=relaxed/simple;
	bh=fkYTSQqB6fjrJ9fwcE9r7/08qWTH3rH5ygz2q5/JYpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm2TR6z2F8flUZ+ZlxpZzjOLzwuUwijbfYUDWgTAgLTxBJUpuoV5vXoLYmG6XSQH3AbK7CsItXeUKnYscjSwx1yA0reS6eV1iCDzckXA8SNUrWVBkhfwKjLkhwkc1FYpX51esUUN6MTbjRFaK+/Th4CWcQ/0MSHNqCjOPkITm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5TJwG5W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738589000; x=1770125000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fkYTSQqB6fjrJ9fwcE9r7/08qWTH3rH5ygz2q5/JYpg=;
  b=D5TJwG5WxEMSsoIWlwuaZI6jGav0wBtDX3ksHPZDBYn2gbyrcO98IE5m
   knhCuyIveJ8QJ922Qt/PLjv79DbI7B8KxedOxtTyrKcFl2bPBsOeF6u8S
   FJ8dgj92N+2/iVg+Oki1AXkfsrvnF2wlNRwzzTFum+9yTEDxctsZ31EqH
   YiNelsSJI/d+Uhthk5j4eRkYXRZN8QRIfAQ8wFpxqHCijlvbYBOso/gP4
   LAgOnjPj5GrhUoTuqedD25s9xp3Qr9sAymrjxIeNjaBXNrcQCcWkvCfZW
   2Eqy0Hj3w8bA7LP9wyY5Kkzg37uRkRtT+cBEAMJOLdgK+4EJpDs6GuEQx
   A==;
X-CSE-ConnectionGUID: pG/UwcEFTouAeH4wxkteMw==
X-CSE-MsgGUID: 8XLnQsZWSwK/U5Y8HDlFtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="41912806"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="41912806"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 05:23:19 -0800
X-CSE-ConnectionGUID: VyMDYgAOQu2q8wgORkWCLg==
X-CSE-MsgGUID: HkuKmXNjQe6O+gyP8+q6uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110848719"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 05:23:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tewPy-00000007q9k-35WH;
	Mon, 03 Feb 2025 15:23:14 +0200
Date: Mon, 3 Feb 2025 15:23:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Message-ID: <Z6DDQlhmzvNj-B7o@smile.fi.intel.com>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
 <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
 <Z6Cxan9WE38_x41e@smile.fi.intel.com>
 <96829b49-62a9-435b-9e35-fe3ef01d1c67@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96829b49-62a9-435b-9e35-fe3ef01d1c67@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 02:08:35PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 3, 2025, at 13:07, Andy Shevchenko wrote:
> > On Mon, Feb 03, 2025 at 12:43:01PM +0100, Arnd Bergmann wrote:
> >> In addition, these seem to be timer registers that may overrun
> >> from the lo into the hi field between the two accesses, so
> >> technically a 32-bit host needs to do an extra read to
> >> check for overflow and possibly repeat the access.
> >
> > Yes, precisely why hi_lo is used to minimize the error when it races like this.
> >
> > But IIRC *_pch drivers are for 32-bit platform, the code, if so, was made
> > to be compiled on 64-bit but never used IRL, just for test coverage.
> >
> > (I believe the PCH stands for EG20 PCH, I have [32-bit] boards with it.)
> 
> Ok, so we don't even know how that hardware block would read to
> a 64-bit bus transaction, it might give a race-free result, might
> have the same race as 32-bit or might just cause data corruption
> (e.g. ignoring half the bits).
> 
> I think the usual way to access a timestamp in two registers works
> like this
> 
> u64 read_double_reg(u32 __iomem *reg)
> {
>        u32 hi, lo;
> 
>        /* check for overflow race by re-reading upper bits */
>        do {
>                hi = readl(reg + 1);
>                lo = readl(reg);
>        } while (hi != readl(reg + 1);
> 
>        return (u64)hi << 32 | lo;
> }
> 
> void write_double_reg(u32 __iomem *reg, u64 val)
> {
>        /* ensure the low bits don't overflow right now, assumes
>           low word is ticking up */
>        writel(reg, 0);
> 
>        writel(reg + 1, upper_32_bits(val));
>        writel(reg,     lower_32_bits(val));
> }
> 
> [If there might be concurrent read/write accesses, it gets
> much more complicated than this.]
> 
> Do you know why the driver doesn't do it like that?

No idea.

> > I like the lib/* and include/* cleanup but PTP probably should stay as is.
> > OTOH WWAN case most likely had been tested on 64-bit platforms only and
> > proves that readq()/writeq() works there, so it's okay to unify.
> 
> Ok, I'll try to split it up into sensible patches then. For ptp
> (both ixp46x and pch), these are the options I see:

> - leave it unchanged since nobody cares any more
> - add some comments about being racy and possibly broken on 64-bit

Any combination of these two I would prefer.

> - revert your pch patch d09adf61002f/8664d49a815e3 to make it have 32-
>   bit accesses again and fix the theoretical 64-bit issue but not the
>   race

Definitely not this. I assume that _hi_lo and _lo_hi semantics of IO
APIs implies non-atomicity access and hence always splits the IO in
64-bit case. These helpers make code much less verbose and actually
(due to naming) clearer about the sequence of the reads or writes.
I prefer to have them stay (in the drivers).

> - use helper functions like the ones I showed above and test it
>   properly

If so, these helper functions should be available to wider audience.
But I think it will be a premature effort.

> I also added Richard Cochran to cc, as he wrote the original
> ixp46x driver and may know of other ptp drivers that have

I also suggest to ping Linus W. He seems to have an IXP4xx hardware,

> this issue. One potential candidate I see is
> https://elixir.bootlin.com/linux/v6.13.1/source/drivers/ptp/ptp_dfl_tod.c#L226
> and other functions in that file.

-- 
With Best Regards,
Andy Shevchenko



