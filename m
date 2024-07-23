Return-Path: <linux-arch+bounces-5596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328D93A943
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 00:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17E71F21440
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F20148848;
	Tue, 23 Jul 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb4auE96"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4F1422AB;
	Tue, 23 Jul 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773501; cv=none; b=cvNIsDWrE4iDyzS78KQbGf1Bb5HGHWTXqiRxUEbSWhES2BIhQnddufBhpZSBDn4t7qfN5hSgq+b7hizOkWHqD+zQrFCmJyWIyX/GOT0PYMt4rvlziMHyPfc3eCw5hc23qc+6GPVUxHunnN6T20i71cFtDOSzkHR873FZnDy2FK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773501; c=relaxed/simple;
	bh=ViQtFf4C97IjtVQAJCI22eGpWrUZSSX3Zptd3VqhktI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/gsVnX3kfDZSIl6666HSO8PLt1+jYeeX5xf/Wu93KxoLQbsBcqUNSPLYH08Ruzw8wkqrsqXjvS00oRu0W8qoYYHqRvgEHuJy0UREmLPbzQZEKrLYTnHy1Iqwjg6v9VEQYTxbLx9DmNbs1JExTjvsI4M7PI4SPUXXF/W0mJTWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb4auE96; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721773498; x=1753309498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViQtFf4C97IjtVQAJCI22eGpWrUZSSX3Zptd3VqhktI=;
  b=Sb4auE96xJXdkpnVbIl/PQOUV1cC3P9ilqD61dKrBpWbrqCQup7bQsOG
   FdMbXZwfbrI530DIWJmMuqxIho+zOhPhOItOKusWeopB+PKXyM0bMV6Ch
   zymHQimXjruSxn49CGhIvhTbZdlMFDVNBd3n1JfGcs0PxEQOMFhpAalxX
   /fDAQQiFus9Q95vD3d27ekyCP3M0p2scwkbQdpxuegeHQaiJHID8eMZ3O
   6qS5wT6bl5vbGgDM49AGxDE2AgbpCEO3GFZQndgcbu+J6eTApw2gJDs5l
   igmgG6QAbQ0dQCvzpFUmxCnl4HarvNa3U/+5t/R7K6MxrnC8aqG82qNQd
   g==;
X-CSE-ConnectionGUID: 0g9rx9PZTJGN1o196Jwq7g==
X-CSE-MsgGUID: 7VWNvgvCTq+YiggzGEynfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30088129"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="30088129"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 15:24:58 -0700
X-CSE-ConnectionGUID: 7X5r9o4GQ7eA/VcONYNQvQ==
X-CSE-MsgGUID: pOxbvXMtRta4kwubr+gFnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52094633"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Jul 2024 15:24:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWNwB-000mOu-1Y;
	Tue, 23 Jul 2024 22:24:51 +0000
Date: Wed, 24 Jul 2024 06:24:46 +0800
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
Subject: Re: [PATCH 2/4] btrfs: Use module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <202407240648.afyUbKEP-lkp@intel.com>
References: <20240723083239.41533-3-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723083239.41533-3-youling.tang@linux.dev>

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
patch link:    https://lore.kernel.org/r/20240723083239.41533-3-youling.tang%40linux.dev
patch subject: [PATCH 2/4] btrfs: Use module_subinit{_noexit} and module_subeixt helper macros
config: arm64-randconfig-004-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240648.afyUbKEP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240648.afyUbKEP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240648.afyUbKEP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

