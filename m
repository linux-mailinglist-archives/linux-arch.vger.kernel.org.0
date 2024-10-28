Return-Path: <linux-arch+bounces-8660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F99B378F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 18:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834FF1F2252D
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8C1DE3BF;
	Mon, 28 Oct 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0VNNvFK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09E1DD533
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136079; cv=none; b=JIw2TeE8EL5Gf3Db1odax1mJ9DGJ45oQC93w3KxrHjolZvO5gh0lQg4p+p2w/MewSRWSiwtNu2zT1i29ttteleTa3dvfLV7Bq+vKeJbg0+cAl2LsHLVBBZrn1C45/K9qEPcfiDSLBk0LzNGxfVTxSuAqGbaUVDkFPtaN9ki2sOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136079; c=relaxed/simple;
	bh=Gqd7buX7pAHkc5nP8dtfSh4i6M0BgYz9CcmIUR1vBrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hWSq9j3KfTb3lhhmR9wS1mQoYSadu3HusHUFxrpvWEqvDE0cdSYRi1VDVaQgFOxKFUx023apT0Xt05DYoXgX1gvDhz5flsTWCNA7/AhGguGW+3dJLv1UDM1RBKhiICwqRGBIzX9bPULaIuIyu7rYZC/eqXD0ojuFOIxwXpiVl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0VNNvFK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730136077; x=1761672077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gqd7buX7pAHkc5nP8dtfSh4i6M0BgYz9CcmIUR1vBrc=;
  b=T0VNNvFKJ97CeHpM3YIFDboLZLc0wC6tV3lzQ2uJog53/k467SUUGU/m
   h3tDhLjCd33fXSfnEnmyZHm3rKkOVC8BrisJDBKVManONtm17jLcUDm0H
   jQZb5g4Hn709ZJ0DXkUgBzulAXBVlc8E3DjygYDS/927y0vKaRV3fv207
   OFzaB3bELbMGvIui6y/8uMDvUR8iuqgpT/5GTHrbiPyKEHOFKWE1bw3gM
   nMETOfJWLvtESrD6JArUsEVn4KS+NljTcC4OGUas5Bxw3SgwT9zq9ipae
   aghAd5DefidM2EypXYKQuerGj3Xuu/73EeBTPi3cBNZyb+nmkpCgYRxwI
   A==;
X-CSE-ConnectionGUID: vQI4IxFNTLOaK/XYKicJAQ==
X-CSE-MsgGUID: B3t4o+iyRzaCpPtpy3xzDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41133091"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41133091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:21:16 -0700
X-CSE-ConnectionGUID: 2o8EXkXWQxetWqqP2hUXLg==
X-CSE-MsgGUID: L/zsjuNmRLSlsmqoRtMAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86471611"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2024 10:21:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5TQW-000cgO-1Q;
	Mon, 28 Oct 2024 17:21:12 +0000
Date: Tue, 29 Oct 2024 01:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Yann Sionneau <ysionneau@kalrayinc.com>
Subject: [arnd-asm-generic:master 14/17] lib/iomem_copy.c:10:10: fatal error:
 'linux/unaligned.h' file not found
Message-ID: <202410290137.rHycxdZj-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241029/202410290137.rHycxdZj-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290137.rHycxdZj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290137.rHycxdZj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/iomem_copy.c:10:10: fatal error: 'linux/unaligned.h' file not found
      10 | #include <linux/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +10 lib/iomem_copy.c

  > 10	#include <linux/unaligned.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

