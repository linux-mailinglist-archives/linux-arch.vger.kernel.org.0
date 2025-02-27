Return-Path: <linux-arch+bounces-10426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66592A482C2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B313B4C74
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34026AAA9;
	Thu, 27 Feb 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBrcjuJV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466024DFF8;
	Thu, 27 Feb 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669621; cv=none; b=muQkLVjHls69FDtvkRdSgsQ8IrrS9ewBzmENk/jocjoIClKSebG2y6vab5/Gk7+VFn3Cwg+TXV6eyRbA0GUwQQkuhlZWRRR3rgbS2MP/MO+GbB7gxblCmKBCWWw7BVFMY6ZUaOMDVxiZ1ymVWkyj/hOl4TY/f7DjKL1Yb7fwUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669621; c=relaxed/simple;
	bh=xbybQy58/b9cxOIPGCsqR+WM6Yqy4lCzOUwQ/Rvr3Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRltDQ0+Q32EDuAs1jvOcKXpLjRLg3GjlVm48UtVoNCpO8D83aQHYcBHSXzt1avCR7EG/G8hbL1cmee3gsVbdgxeH5KxUIuzN9QMPVdd9Hgz0gsdussTiX1apy4EVPr9StZuj5LDu9MwJqmfcd1NQbGAi7JFsFPwVoXazemPJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBrcjuJV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669620; x=1772205620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xbybQy58/b9cxOIPGCsqR+WM6Yqy4lCzOUwQ/Rvr3Ww=;
  b=kBrcjuJVtBtM0u615xSA3pwdbvfizjoLw/jTt1CaEVbo34FwUW5YN4Jx
   spDheWQGv8r/bViKO5Fvd3Kap1CnNBYiWXZERNl2CCwcnED3uUxTguOX4
   y+j8uWKUS/ZcdElU24Dm7EkpXT8K1Q7PnJeS1z7AxEwQRbmQXU43quhAk
   pb5c+7n8EeKFyxIpLqfk6/2AutqfSBS7aym268PNm8Hsrasehk2U0fVnN
   VIZU97z1v/WPwJYXtPfhWuriPTQQD9mvPy6wrUkppB1zEDBvdrYEnSouM
   ITj/tbdT++E7qysv0kIQ9oB3SjJDgW1n4SIN6sqyu/5MLxiDj+qBONYas
   g==;
X-CSE-ConnectionGUID: 8qP6V1+vQkOfTCAvo+bX0Q==
X-CSE-MsgGUID: fOgMdmsbT+CTa57ssuqtpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52205832"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52205832"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:20:19 -0800
X-CSE-ConnectionGUID: //sydfZnSqWjo0BZQbncpw==
X-CSE-MsgGUID: VE+oI+AfQS2qiv7pLBNW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="121999934"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:20:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnfgM-0000000FdBP-2W3l;
	Thu, 27 Feb 2025 17:20:14 +0200
Date: Thu, 27 Feb 2025 17:20:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic/io.h: rework split ioread64/iowrite64 helpers
Message-ID: <Z8CCrqzCfwzIpJ-3@smile.fi.intel.com>
References: <20250227141910.3819351-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227141910.3819351-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 03:19:01PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are two incompatible sets of definitions of these eight functions:
> On 64-bit architectures setting CONFIG_HAS_IOPORT, they turn into
> either pair of 32-bit PIO (inl/outl) accesses or a single 64-bit MMIO
> (readq/writeq). On other 64-bit architectures, they are always split
> into 32-bit accesses.
> 
> Depending on which header gets included in a driver, there are
> additionally definitions for ioread64()/iowrite64() that are
> expected to produce a 64-bit register MMIO access on all 64-bit
> architectures.
> 
> To separate the conflicting definitions, make the version in
> include/linux/io-64-nonatomic-*.h visible on all architectures
> but pick the one from lib/iomap.c on architectures that set
> CONFIG_GENERIC_IOMAP in place of the default fallback.

Thanks, this is good to go in my opinion,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



