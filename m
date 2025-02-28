Return-Path: <linux-arch+bounces-10474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A62A4A5F0
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 23:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211A9176EC4
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8291D9A5D;
	Fri, 28 Feb 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHI9W8HF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E723F385
	for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781920; cv=none; b=FGU57icBzcLjeirjvR/xLoQEux+REGb2Jeqo/vnJaM28a+7HOMPJeiutMKvjzTyTPnNlHh6wI8ERpToN3bkYn+KOgjXsUgEfanEBC4KOqxugcLdznXsr7+jXJ29mXTKwhk7lYVGf9EHRr9ZmZLE8mNvZlJ4QdBl+4CI8j4Y7lSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781920; c=relaxed/simple;
	bh=7VdCPxYkfok9dqzeKBzVOHS01KTB1/rxGf2qARYtYx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PuxU4uGpFT+X51j9A6HSBkO6akGaTUrZov7Raj7k4PJ1VjnVIEJa+MgPKg/fBqoC+SNYaLT8aykG1PjcwW06wHnAqBEB5gQxV+XpuUSkB3MVIUoKrKM1RtzIjQvZu90GhXGy+uzO0J6ne2AQFCRKHgAPqyPtGA1AkmVHmj4u+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHI9W8HF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740781919; x=1772317919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7VdCPxYkfok9dqzeKBzVOHS01KTB1/rxGf2qARYtYx0=;
  b=oHI9W8HFrcJULKv1nUrvQzbZI4I5IqqqTyn2jh+PgCXCh36My+AErLAu
   sy3MTYzCgKyUnVIvrpYoTFLnU02vKG3qLrgREnjllVtjsjXjBfTxzOlJ4
   GZddLvuSgCRt5OPg6E3Vy4Hd8fuDcgyKSI10Vl4EHZnzRw3sDGavf8Puy
   g9tStSanfzjqSs070NUm+m56XBcse8P6HEu1T4/FK8MpnkkKVg2QlZqRA
   JHVS9Jr6SWATnFz8v4pMJ7l4JbI1IQACKyeW7VgPAi85aKqYNcqghuWWB
   3ZPXOmX1F6fyVkAT32iIi9hhIJLq12U/uP1pfZK+sI+9KEa2uBWNZRGM4
   A==;
X-CSE-ConnectionGUID: 8UH7rgGgSj+P5mw88K0Ttg==
X-CSE-MsgGUID: VqKX3jxNTY+4+AGQM1TCBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41919146"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41919146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 14:31:58 -0800
X-CSE-ConnectionGUID: PhfWagAzTlK6PCGIMNH//g==
X-CSE-MsgGUID: 9+mDJ/VVT6CmTBhf6EY+SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154634263"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 28 Feb 2025 14:31:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to8te-000FaI-0k;
	Fri, 28 Feb 2025 22:31:54 +0000
Date: Sat, 1 Mar 2025 06:31:09 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:master 1/3] ld.lld: error: undefined symbol:
 __ioread64_lo_hi
Message-ID: <202503010627.d4L934cN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   3a5810be18b2c47e348ca10635500c535e4edd44
commit: 3ec387b24655b02ee623ca554941f33922356f5b [1/3] asm-generic/io.h: rework split ioread64/iowrite64 helpers
config: i386-buildonly-randconfig-006-20250301 (https://download.01.org/0day-ci/archive/20250301/202503010627.d4L934cN-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010627.d4L934cN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010627.d4L934cN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __ioread64_lo_hi
   >>> referenced by ntb_hw_switchtec.c:862 (drivers/ntb/hw/mscc/ntb_hw_switchtec.c:862)
   >>>               drivers/ntb/hw/mscc/ntb_hw_switchtec.o:(switchtec_ntb_add) in archive vmlinux.a
   >>> referenced by ntb_hw_switchtec.c:1103 (drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1103)
   >>>               drivers/ntb/hw/mscc/ntb_hw_switchtec.o:(switchtec_ntb_init_crosslink) in archive vmlinux.a
   >>> referenced by ntb_hw_switchtec.c:1103 (drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1103)
   >>>               drivers/ntb/hw/mscc/ntb_hw_switchtec.o:(switchtec_ntb_init_crosslink) in archive vmlinux.a
   >>> referenced 14 more times
--
>> ld.lld: error: undefined symbol: __iowrite64_lo_hi
   >>> referenced by ntb_hw_switchtec.c:1102 (drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1102)
   >>>               drivers/ntb/hw/mscc/ntb_hw_switchtec.o:(switchtec_ntb_init_crosslink) in archive vmlinux.a
   >>> referenced by ntb_hw_switchtec.c:1102 (drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1102)
   >>>               drivers/ntb/hw/mscc/ntb_hw_switchtec.o:(switchtec_ntb_init_crosslink) in archive vmlinux.a
   >>> referenced by ntb_hw_switchtec.c:1102 (drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1102)
   >>>               drivers/ntb/hw/mscc/ntb_hw_switchtec.o:(switchtec_ntb_init_crosslink) in archive vmlinux.a
   >>> referenced 31 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

