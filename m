Return-Path: <linux-arch+bounces-5603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D976A93ACE4
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 09:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E59B28497D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA695C8FA;
	Wed, 24 Jul 2024 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ucfq2jcw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18661FD4
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804473; cv=none; b=mg85EUtO6P92/jmA6zKicMMBSmzwvDUwCN7lOvjKl9lP4vnfkuKZMVME1hbNs5/cvWUzxFUvGsQmf5486S73CGFKSw4JBbvUaS2gIhNEESg5LY1wFQTZv8+JBiaK+Hbhxlc+EbE2RmN1VdXgJo/SoNcujkKCR8xLKP9kOsV+w10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804473; c=relaxed/simple;
	bh=OO0ZZDTOeR5AUlJcKeXZ+Lb9wklPBMO5SCLpnDfEU8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RH9QXiAQgoMuhIsb8/SNZJKthJCBTGr7E4ws4zcotr/f88IVFmQSlkDpKZT9ct/3VhXw+AjO8BkD9G5EgBBFaHk1LlmB3fxH5eZZD/Tk3a8Qt1LfZBNCziGTOi5VauS5jj06j2N6jRw5yy/xk3fJcYA6BF3gdCqWEPU+Rrz2XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ucfq2jcw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721804471; x=1753340471;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OO0ZZDTOeR5AUlJcKeXZ+Lb9wklPBMO5SCLpnDfEU8M=;
  b=Ucfq2jcwRW8qpFHz8/42bTUJWq8WwztcJyD6Gn2w05Y6Ka+Cbuf8jimZ
   XUMR6NthGcDiKOQI09yMrGotTkOpc5fRbqyVHVRw32mj7O/qOXwdRTXgH
   vALXHSJ1LXlA/7W9jbawonpU+r00de2jZxh/l9Zy2Oq038M3Bq1KA17EE
   PoSzDqdJubZsOV3LnLk2Hp4UcdmqJdwNE380lxbwbLsCGoB9C/Z5yyWqN
   Y/55qZ9kkuCDqzl6wb0uFxeubCshhnPYike6ypY0w8arnuibRLPPBIyef
   f2qIf4LQez1mRQquZ2dkMA17DLpTMjJ8zbkHBbnDDIcvUWvIMGt/TCJra
   g==;
X-CSE-ConnectionGUID: RLnoCPfkRxC8UqhU/55gBg==
X-CSE-MsgGUID: duyNB0D4RjKOznh7MQtbBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19645738"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19645738"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:01:10 -0700
X-CSE-ConnectionGUID: FLzQNpTHTQW/OZlV1BnIbQ==
X-CSE-MsgGUID: WhLuczHhS+WXeALgQHRWew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57008863"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jul 2024 00:01:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWVzn-000mlM-0z;
	Wed, 24 Jul 2024 07:01:07 +0000
Date: Wed, 24 Jul 2024 15:00:42 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 30/80] ld.lld: error: undefined
 symbol: __riscv_sys_fadvise64
Message-ID: <202407241414.kQcjV3vu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   ece1b5ebc0b7064a8a130f64e85a81ec76381c3f
commit: cd87002bd5fb586775035c95e92b262b22a3080a [30/80] syscalls: cleanup fadvise64_64()
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20240724/202407241414.kQcjV3vu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241414.kQcjV3vu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241414.kQcjV3vu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __riscv_sys_fadvise64
   >>> referenced by syscall_table.c
   >>>               arch/riscv/kernel/syscall_table.o:(sys_call_table) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

