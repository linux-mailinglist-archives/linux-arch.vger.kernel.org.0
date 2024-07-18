Return-Path: <linux-arch+bounces-5492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E59349D1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 10:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA48AB21377
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86E1EA8F;
	Thu, 18 Jul 2024 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xg+7pShL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C07A15C
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291014; cv=none; b=I95AFXKe47zLkIcCdFxdSiIZjRoKkHgvbex2jlq5zZ+qWc11sWwwIr0LB8PScBBDW1uUPGAHvb6e1BFD726sLCWyGTC4mMoDySborudcdxBri1XRWJVD1NsbUbx5EvOlH9aY+00ciqbaSFB7r/bmqOCcNjAIFMNpbBRxbR0auIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291014; c=relaxed/simple;
	bh=0y8AhGu2nWWxQy923GG8cGe+VNq4xXxcn6y0LVxjNxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lloytM63sXPyuCdMu0VjXJFmfcSdlXNVoBBLwltpVTG5cWhKtfj8A1P2V/0vL5xNVONngYF8cGnEo1GgjSkWXNvF4FqphG5k7vKnes1fD2EL+9A2VmS8+vm4DTf7fVA6wWW1Y4LtIpz51u4H5tM3uG/7yztTD/D6s3zPnCWNQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xg+7pShL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721291013; x=1752827013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0y8AhGu2nWWxQy923GG8cGe+VNq4xXxcn6y0LVxjNxQ=;
  b=Xg+7pShLPu+JKyBCMHGRfJD5NIQIgKY+BEWAzabzKj/U9lkhmYT1j2sW
   Wh7RClBpEY3dXc5fckB5kJ8dw6X6LWFQwvwHUkk82QCaTMpASwJm4CGxw
   HRQcTcMtrEcD/1VWys5Frqi0qA7Mouut8Oa446fDcy0Wsb7B4GyaSSpJL
   TpytdW6IM3aZnt5PuiVZmUq4uiVkp26oAs9Y+HI8yAF4qNxwo1byqhdL7
   a7mVCZpS+0I60zoGW91K+ZRLn46kOxlTmSQec3mvPNEMCoD8hLrJ0PsME
   UegqW8S2Dm0vUzHjWU337h2wr6ur7uzC7gajDzfCfGHktC+KhSyiKRh7Q
   Q==;
X-CSE-ConnectionGUID: QLLYOy4xSEGrb3P+31l2Qg==
X-CSE-MsgGUID: jg/o5YdnQSCYV4S5tO+sCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="30226019"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="30226019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:23:32 -0700
X-CSE-ConnectionGUID: pQ2rLVzLTw28GJMprXC6NA==
X-CSE-MsgGUID: f5KhluQETte6b/bOSEWl4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="51295207"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jul 2024 01:23:31 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUMQC-000h5m-1p;
	Thu, 18 Jul 2024 08:23:28 +0000
Date: Thu, 18 Jul 2024 16:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 81/98] powerpc-linux-ld:
 arch/powerpc/kernel/systbl.o:undefined reference to
 `__powerpc_sys_fadvise64_64_2'
Message-ID: <202407181648.IsTOYT9n-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   9a99991d90521113a738c2a4761a4147fe4b31ca
commit: 895267a916ccea4816ebf852ee2fd278a705a18e [81/98] powerpc: use non-conflicting syscall function names
config: powerpc-randconfig-003-20240718 (https://download.01.org/0day-ci/archive/20240718/202407181648.IsTOYT9n-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407181648.IsTOYT9n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407181648.IsTOYT9n-lkp@intel.com/

All errors (new ones prefixed by >>):

>> powerpc-linux-ld: arch/powerpc/kernel/systbl.o:(.rodata+0x3f8): undefined reference to `__powerpc_sys_fadvise64_64_2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

