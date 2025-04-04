Return-Path: <linux-arch+bounces-11281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17491A7C096
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E173F179D09
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01F145B0B;
	Fri,  4 Apr 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDw2ypPf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637201DF962;
	Fri,  4 Apr 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780761; cv=none; b=H0L61N/XF8/flNV3x/GkYZaDW3IWwz5I9D0uxz1pA3Xs40AUBHUa1twaaQLuRqxdcA907fk4JfRMDymmaTYuedxaX8fUDv7CPyd0CeXNdb6HzqyAXihy8LGyvBXCTc8qqfyW2FwcbC4fFnvaETCCeOMvUCpgeL7t83R0+5h68fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780761; c=relaxed/simple;
	bh=l4NfQuaRg7vF8YLzLFVfCX0eGTmkIJQDbug+xp/8Ur0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgMwHI3Mxf23J9KN8lPSlcWfAewT3jSbX9mxfZ9MOyTVo9MacaAeOLcEoXFMMGNauoo5Bz6DMZRfs6htYzop9OD3Euo5UoAFkWSiye850T7jQQRTpC49rTBudWC1rCgb27pd9gdSBy5LgU3y6WeCg5SehwzlcJU1ZRt/PkF32Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDw2ypPf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743780758; x=1775316758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l4NfQuaRg7vF8YLzLFVfCX0eGTmkIJQDbug+xp/8Ur0=;
  b=MDw2ypPf38I3kIjEqPbEoaHVYkChGf5DpeCftS4YQ0BRauyuNb3qNH3B
   7GeBzROBs4ZVFiFL7pODN6TtivYk0YvtXv2dlfFSaeQkjlZxro9bWSj2B
   Flq+/RL8OFkmkHYCj/WEtp9aSv0fyfRjVKaO8/k1ow8jeC/EZcZlxudo2
   wdfzzrD4K8WUqBb/kVWAP2iayiGzBgETnXnUJrgI9dK3d6ckodRlPqV8a
   MAxVvAPp9HrJ4Ip2jGsJytHtb5veO57oVAig5Z16AYpTEItGMynBbjnxS
   OFf3Y02W1JktgdyT38PLMY6q2QkdfFlQCqTyLDYk7Jn2a7B810sZmBGod
   w==;
X-CSE-ConnectionGUID: dxy+pEgMSNGoUgErKrxFgg==
X-CSE-MsgGUID: N4AV3c7/RCi4yC6cgSXIOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="32827369"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="32827369"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 08:32:37 -0700
X-CSE-ConnectionGUID: w6x4comGQQOj+pL4mRXMsQ==
X-CSE-MsgGUID: uqelw8/ZSUC6OlaT1ChzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132460543"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2025 08:32:34 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0j20-0001Kz-1i;
	Fri, 04 Apr 2025 15:32:32 +0000
Date: Fri, 4 Apr 2025 23:31:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ignacio Encinas <ignacio@iencinas.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, Eric Biggers <ebiggers@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH v3 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
Message-ID: <202504042300.it9RcOSt-lkp@intel.com>
References: <20250403-riscv-swab-v3-1-3bf705d80e33@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403-riscv-swab-v3-1-3bf705d80e33@iencinas.com>

Hi Ignacio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47]

url:    https://github.com/intel-lab-lkp/linux/commits/Ignacio-Encinas/include-uapi-linux-swab-h-move-default-implementation-for-swab-macros-into-asm-generic/20250404-051744
base:   a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
patch link:    https://lore.kernel.org/r/20250403-riscv-swab-v3-1-3bf705d80e33%40iencinas.com
patch subject: [PATCH v3 1/2] include/uapi/linux/swab.h: move default implementation for swab macros into asm-generic
config: i386-buildonly-randconfig-004-20250404 (https://download.01.org/0day-ci/archive/20250404/202504042300.it9RcOSt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250404/202504042300.it9RcOSt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504042300.it9RcOSt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> usr/include/asm-generic/swab.h:21: found __[us]{8,16,32,64} type without #include <linux/types.h>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

