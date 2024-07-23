Return-Path: <linux-arch+bounces-5594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA1893A8BC
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D032D1C22C37
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030F144D36;
	Tue, 23 Jul 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2EaSC36"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD1448FB;
	Tue, 23 Jul 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770319; cv=none; b=lMFprOqEe2p6RxAzIjPz08UKc639Y5zEg46Szh6mL7v+9xvE05RurRpGvNhQa/0yYrkw7V65qQQGpyDy2jxdWpvw8ulPdUyeTcuCO5L114tWvgyfGHHjyIHq0ehnfXV/58fOKXPW2iHJsqFiPnkAtPsKFHSq/G0URy2AqZAP4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770319; c=relaxed/simple;
	bh=emqRXC4zbFB95UYh4yI6o+bUQDFgG7kIbVNfc6B+a/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n08AnS2aKp9TraaFr5myujPvq+ycHp3o9D2r1iw0pUT4OAwWG/V6ro3x8ORXPxJ4Li72WlgUN4at41a3P9L6s1S6dxw5/I/UZUXfMy4ZZSuYZTNJpns3NRl8t/je+/0NFk+ls8ie+LBHuq3ZIfADMs0IXyZhk2r5Kf8U2x7Ch4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2EaSC36; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721770318; x=1753306318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=emqRXC4zbFB95UYh4yI6o+bUQDFgG7kIbVNfc6B+a/s=;
  b=l2EaSC36CRwYuclgheLeevXoDE+QVyVpaGWkU3FnYLlfKlPupB6ist5P
   +cHFa6pBW252JZb8ju+8KI7SYUIX8qWhlfIqBOlSG2EuDG+XsNUgY+7GA
   WmE/gJNyTWlNLrds+J1aYmIRCWCFsU1hm7r6950+54LLOpdCCVjghGy1C
   pcutx0GI44SYrlejtSNOhOHV2eJNyJXkVzpSa2SsykzyEDKk0zNhg0Dwp
   h+geDXw+XD4JTjqqZV1j7+XTN3y2RwfsaKGqHBwATUIPGt07QILnj4eUB
   FeF7HIf8a/sWgcw5iqKwwtbK8ZqFd3BzyKx19dXqbGcXDEb3YJ6i4hAgp
   A==;
X-CSE-ConnectionGUID: Wem086CXToe0WtaOamq3jw==
X-CSE-MsgGUID: pMst6wNeR5advhlE2Dj9Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="41946561"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="41946561"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 14:31:58 -0700
X-CSE-ConnectionGUID: 9PnZNZK5ROSFsJZBagkOvg==
X-CSE-MsgGUID: nknNECQjS+WNfr/mbbyZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52598208"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Jul 2024 14:31:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWN6s-000mN4-1a;
	Tue, 23 Jul 2024 21:31:50 +0000
Date: Wed, 24 Jul 2024 05:31:30 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 4/4] f2fs: Use module_{subinit, subeixt} helper macros
Message-ID: <202407240502.xqotqBQ1-lkp@intel.com>
References: <20240723083239.41533-5-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723083239.41533-5-youling.tang@linux.dev>

Hi Youling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master next-20240723]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev soc/for-next v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/module-Add-module_subinit-_noexit-and-module_subeixt-helper-macros/20240723-164434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20240723083239.41533-5-youling.tang%40linux.dev
patch subject: [PATCH 4/4] f2fs: Use module_{subinit, subeixt} helper macros
config: arm64-randconfig-002-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240502.xqotqBQ1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240502.xqotqBQ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240502.xqotqBQ1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:13:
   fs/f2fs/f2fs.h: In function 'f2fs_create_root_stats':
>> fs/f2fs/f2fs.h:4131:1: warning: no return statement in function returning non-void [-Wreturn-type]
    4131 | static inline int __init f2fs_create_root_stats(void) { }
         | ^~~~~~
--
   In file included from fs/f2fs/data.c:25:
   fs/f2fs/f2fs.h: In function 'f2fs_create_root_stats':
>> fs/f2fs/f2fs.h:4131:1: warning: no return statement in function returning non-void [-Wreturn-type]
    4131 | static inline int __init f2fs_create_root_stats(void) { }
         | ^~~~~~
   fs/f2fs/data.c: In function 'f2fs_mpage_readpages':
   fs/f2fs/data.c:2373:17: warning: variable 'index' set but not used [-Wunused-but-set-variable]
    2373 |         pgoff_t index;
         |                 ^~~~~
--
   aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/ext4/super.o' being placed in section `.subexitcall.exit'
   aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/ext4/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/f2fs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/f2fs/super.o' being placed in section `.subinitcall.init'
   aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/ext4/super.o' being placed in section `.subexitcall.exit'
   aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/ext4/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/f2fs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/f2fs/super.o' being placed in section `.subinitcall.init'
   aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/ext4/super.o' being placed in section `.subexitcall.exit'
   aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/ext4/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/f2fs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/f2fs/super.o' being placed in section `.subinitcall.init'


vim +4131 fs/f2fs/f2fs.h

  4128	
  4129	static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
  4130	static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
> 4131	static inline int __init f2fs_create_root_stats(void) { }
  4132	static inline void f2fs_destroy_root_stats(void) { }
  4133	static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
  4134	#endif
  4135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

