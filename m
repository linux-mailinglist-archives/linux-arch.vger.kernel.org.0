Return-Path: <linux-arch+bounces-8683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B1D9B3F97
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 02:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F25282B2F
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F46FC0B;
	Tue, 29 Oct 2024 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSE3jRDH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48528E7;
	Tue, 29 Oct 2024 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164538; cv=none; b=Of2yc77cPLNOvmcnxn5jKRfcaTjVcr0qQ4WTxTz6f2M6S2qwstLKouwdK9dn1RCKS1yPbENXVV3iYVvxzQk6xF5XTa/TKXl+y8z5gxRdHmhytVusdQ0sC8YV2aOiLW/7PwAg5eUMBYwEWkf1ZR4DzJ1/5mMtGIBj90+3AnNtNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164538; c=relaxed/simple;
	bh=BPXHzgbikb8ukSh3ZvXHfskqukjyqJCn+2tP4slVmrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IhoDuuXOAvQehry49+KRwl6incR9WErMPEdzLuow0Z4MzS8tf7y5Zff9Au+IePx8x5/CMqe2OepG3hLHxB2efxc5VeWtjgO7rZTCMaZZqAjrd5Jyl6vFh7mFQAVI9cnHksHIgXDBXoT2tO+x2AwUgGlzwWmj2OLqll2PNdy/mSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSE3jRDH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730164537; x=1761700537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BPXHzgbikb8ukSh3ZvXHfskqukjyqJCn+2tP4slVmrU=;
  b=jSE3jRDHzszXyFSJTPfglwzQHes5LWJOwpBv4GmZelJusnQT2wlBTfEX
   zFikZKzlXCrJY7/5n1fQ27OxbisofpG/uMOpCJhYymy2G2E5q9EA+Scwg
   GNVd363ZoRz0uDCP/TWJuzvkGKEs8iHPkwbt3PBvn+QvZE/hyj5Q/3ybY
   LCL0tNzhaUKamuKK/cdO7Bk6eD/bv/askxutLmNsiECwHfkLIUJmXQbnr
   m7mIi4N8YtbIo9fN701RxRhjWriP3OmXeN1O0kyeLqGLqDqlQqqsECtcH
   bPkP2mncxbPo25tU/myA/+5Te9yvjW+7n8VI0QQL2IooLm1u+qufqjDm9
   w==;
X-CSE-ConnectionGUID: FU7zsXsyR0mVKdQr2oZKog==
X-CSE-MsgGUID: KkBiyXcASQS9UKyfg5hMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29749269"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29749269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 18:15:36 -0700
X-CSE-ConnectionGUID: AdFz5mbGQM255BWdv/jjyA==
X-CSE-MsgGUID: q0v2sqF2T6OS0OvhbUNXcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="82122446"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Oct 2024 18:15:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5apX-000d5s-36;
	Tue, 29 Oct 2024 01:15:31 +0000
Date: Tue, 29 Oct 2024 09:15:00 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Yann Sionneau <ysionneau@kalrayinc.com>, linux-doc@vger.kernel.org
Subject: [arnd-asm-generic:master 14/18] lib/iomem_copy.c:14: warning: This
 comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202410290907.0mDZVYPK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   a8cb1e92d29096b1fe58ef6fdcee699196eac1bd
commit: b660d0a2acb9053d627befbb259a397d26aa9582 [14/18] New implementation for IO memcpy and IO memset
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241029/202410290907.0mDZVYPK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290907.0mDZVYPK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290907.0mDZVYPK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/iomem_copy.c:14: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * memset_io            Set a range of I/O memory to a constant value
   lib/iomem_copy.c:55: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * memcpy_fromio        Copy a block of data from I/O memory
   lib/iomem_copy.c:97: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * memcpy_toio          Copy a block of data into I/O memory


vim +14 lib/iomem_copy.c

    11	
    12	#ifndef memset_io
    13	/**
  > 14	 * memset_io		Set a range of I/O memory to a constant value
    15	 * @addr:		The beginning of the I/O-memory range to set
    16	 * @val:		The value to set the memory to
    17	 * @count:		The number of bytes to set
    18	 *
    19	 * Set a range of I/O memory to a given value.
    20	 */
    21	void memset_io(volatile void __iomem *addr, int val, size_t count)
    22	{
    23		long qc = (u8)val;
    24	
    25		qc *= ~0UL / 0xff;
    26	
    27		while (count && !IS_ALIGNED((long)addr, sizeof(long))) {
    28			__raw_writeb(val, addr);
    29			addr++;
    30			count--;
    31		}
    32	
    33		while (count >= sizeof(long)) {
    34	#ifdef CONFIG_64BIT
    35			__raw_writeq(qc, addr);
    36	#else
    37			__raw_writel(qc, addr);
    38	#endif
    39	
    40			addr += sizeof(long);
    41			count -= sizeof(long);
    42		}
    43	
    44		while (count) {
    45			__raw_writeb(val, addr);
    46			addr++;
    47			count--;
    48		}
    49	}
    50	EXPORT_SYMBOL(memset_io);
    51	#endif
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

