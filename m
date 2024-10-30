Return-Path: <linux-arch+bounces-8723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CD9B58F6
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 02:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312901C22A35
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B456770F5;
	Wed, 30 Oct 2024 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X85G6aym"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F5126C09
	for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250624; cv=none; b=JL9yVtnnO+HqCWHLzsaG7Fkdy+337QHdySlKYE7J4IpgqV1AYeBjG8lvdroRBEReOlBRi9YLRPq1VdJuZmYpmCfHcN6MbJ+2HsC4VjVAKJwkr8sWlb/zM3GdvJFNKECwMVS6RAdT+vBSbWp6AeZ5NooAopGRNUcY0KnkX/OH9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250624; c=relaxed/simple;
	bh=QThzT/PP3Q75uZvPihPRU8HaJI0mfVIyGX6FkH+pS2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T05O2w2oo6DTved35vDlZquCDe4dD8wXswY7QC6uPWZ5ap4imRtLDdE8bcBwzs1RR7ryrc9yEbGwVclKabtPh81w5YB9bgbkdhbYxDRnTei41fUvAx8kBVhifzp2hnqXURg5JvyVZZnAgezIuGpcoBj63jQMD3mb/DJy/EbSzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X85G6aym; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730250622; x=1761786622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QThzT/PP3Q75uZvPihPRU8HaJI0mfVIyGX6FkH+pS2E=;
  b=X85G6aym/3CnDsA8ANI35ByA2XOACa3nplofPxRzI1NZ9mEm37dOXSpE
   cxhxCy5hLBeHqg3dPuk34zRyAyOjZ7c+c7l5E8Lx/DmTZNNTGrXUp++/j
   8qzY02JOkSkrAzf7oMwzaA9pcbhZRyViGmdxDwR3f/9quVWLyj3/78ZBp
   ppDa/PBcTnmBfP0lWn0pc+pIDgF/vqdWw6mls6TejWHvVg3J3Z/EYmm2h
   4B/vSsjDBCNkobczcy3Q+R1IAt9IMonFs3e06onHnKFKtpps5xKDrbh0P
   OF4tl3wgyjxQptEmpyhayvBdZCdN0At+FvfwsNgFq2648Kzdc5tQOeiV/
   Q==;
X-CSE-ConnectionGUID: fwfRcJG3Q3y02CihCp+Nrw==
X-CSE-MsgGUID: 4OHeq+gFQsSH9qGIH2B4gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="55338161"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="55338161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 18:09:40 -0700
X-CSE-ConnectionGUID: VEiho8uBQk+O1cdgDN7rcA==
X-CSE-MsgGUID: 05S0vg8YRSmjO5lz3Cvbqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="86749983"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Oct 2024 18:09:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5xDM-000eLy-1f;
	Wed, 30 Oct 2024 01:09:36 +0000
Date: Wed, 30 Oct 2024 09:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Yann Sionneau <ysionneau@kalrayinc.com>
Subject: [arnd-asm-generic:master 14/20] lib/iomem_copy.c:27:26: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <202410300955.s4EEXG5n-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   c0dc92144ba181cf7ba366a87909bbaa93d5b713
commit: b660d0a2acb9053d627befbb259a397d26aa9582 [14/20] New implementation for IO memcpy and IO memset
config: nios2-randconfig-r131-20241029 (https://download.01.org/0day-ci/archive/20241030/202410300955.s4EEXG5n-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241030/202410300955.s4EEXG5n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300955.s4EEXG5n-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/iomem_copy.c:27:26: sparse: sparse: cast removes address space '__iomem' of expression
>> lib/iomem_copy.c:27:26: sparse: sparse: cast removes address space '__iomem' of expression
   lib/iomem_copy.c:64:26: sparse: sparse: cast removes address space '__iomem' of expression
   lib/iomem_copy.c:64:26: sparse: sparse: cast removes address space '__iomem' of expression
   lib/iomem_copy.c:106:26: sparse: sparse: cast removes address space '__iomem' of expression
   lib/iomem_copy.c:106:26: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +27 lib/iomem_copy.c

    11	
    12	#ifndef memset_io
    13	/**
    14	 * memset_io		Set a range of I/O memory to a constant value
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
  > 27		while (count && !IS_ALIGNED((long)addr, sizeof(long))) {
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

