Return-Path: <linux-arch+bounces-8661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE59B38D6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31B42841CA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A4C185B54;
	Mon, 28 Oct 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6brVQkC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551141DFD86
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139140; cv=none; b=ObXD3ctsjfu349Fo47BcQ9lgIiWEtuZdNiZBJEspUFjgqH2/u7EQ+aVlGFM5MoejRtAsd3/XxLibfO8q7zJuD6jzCCfj9yKDmYYgs+uGWF8otbOa+NZerCrM/sqL7XpaxnxQORzkvPAUVKilt6+zRPxVYOwOSQqrFhDVOQHfbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139140; c=relaxed/simple;
	bh=lHqhkRJvaClYrhbd7ijTWcLFj4PWYpnMwlDD2B9VDVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MM6yV+rtzwc9zu5tF+jm/5ndrZILJViLvVWCpj7QI0225vNeu1eY26aDdsGcHl6vEgg/Pz08H8/LQG+miyejJ6GUPpaJIqRFo9BIrdNRa2+XSsjD1sBmHhayq0mb1CqywrrEPl9YCQzpWJHPRfJ4682bbd6B3tEzttSjsSvV/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6brVQkC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730139139; x=1761675139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lHqhkRJvaClYrhbd7ijTWcLFj4PWYpnMwlDD2B9VDVs=;
  b=M6brVQkCAeHE3ALioo2ImGJPU1euFCtax6+Err/aJgGTWjlzdUNXaeWB
   udtsPQ9WoqKUHNN/rb/1+LajwY2AIqpg0SG9yfvAMtgUgXfUFboSOCKjW
   qVkiUDS0zHbJOrEk7Iltcum4Pum9pglv3t2BJbJG8Gw13OYwkepUmD6CB
   6CxQ1IW+5K6X+/q41PbnZueFp0MXZqiwX9EaatJqBSWrP1P9MtJsJlWhA
   r6X1uXQvb28+QtvsatmBYmEpB/8bt6m3ZJgiS86x0pBnJjC8jtMhtPLzX
   HRVSudIPePpMzheWAPvHOCfNlntAIFeoJpj68q3LsLhKyGd/tCc3Ybne/
   g==;
X-CSE-ConnectionGUID: xk/JtjQJTFOv/KBjuNaY1w==
X-CSE-MsgGUID: IbewrNCUSRS74eXLUM4rHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29958634"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29958634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:12:18 -0700
X-CSE-ConnectionGUID: p/8cXsLBSh+8xgJ21ekQaA==
X-CSE-MsgGUID: 8/e4H6YcTJGSx6TpBroNCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86311493"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Oct 2024 11:12:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5UDu-000cik-0r;
	Mon, 28 Oct 2024 18:12:14 +0000
Date: Tue, 29 Oct 2024 02:11:46 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Yann Sionneau <ysionneau@kalrayinc.com>
Subject: [arnd-asm-generic:master 14/17] lib/iomem_copy.c:10:10: fatal error:
 linux/unaligned.h: No such file or directory
Message-ID: <202410290234.4lGXVTw1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   e6a5255d009d8427b6609b25c729048f894e9d60
commit: 4030decf42ca0da176fc1d5c556fc3f0035df6c9 [14/17] New implementation for IO memcpy and IO memset
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20241029/202410290234.4lGXVTw1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290234.4lGXVTw1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290234.4lGXVTw1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/iomem_copy.c:10:10: fatal error: linux/unaligned.h: No such file or directory
      10 | #include <linux/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +10 lib/iomem_copy.c

  > 10	#include <linux/unaligned.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

