Return-Path: <linux-arch+bounces-5593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9693A771
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16487282641
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EA13D898;
	Tue, 23 Jul 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FV7yl5au"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3B13D600;
	Tue, 23 Jul 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760716; cv=none; b=gHXmP084Z+WdrO+ESP9hdczqa1b+90egdiBVPGyUemumaQXtD+pAmW/7L/jxXC2uJBt31aZpLMJwDH5jXKcyTmITip+UV3wtthydkxBhDy8T007+87hUkPWLV6H8geixwEUbqkDxZD3u+xgT/lCDIcvUK6EYi6oLbBdUSi4+Th0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760716; c=relaxed/simple;
	bh=jwFoh6L9rTQrrkMo4N/xtydd5G7+Zqn3pnTBTVbfISg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHon+eQP6X6ADjmsXcKAXQ6pH0Xem9u3ZqdHmFfp2G/2GUJD16KWzbWRSk1loj+2SUuLUWEoqn0NTtJ4x5m9SWFSFGZi21K1ZITDFAcwCYUXDuQX8t0vZaAFGrzX3ZSc/m2+MYInpzcsD6XPKBnvtQGX9mx4PhVt48MmPK9kyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FV7yl5au; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721760714; x=1753296714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jwFoh6L9rTQrrkMo4N/xtydd5G7+Zqn3pnTBTVbfISg=;
  b=FV7yl5auZxSf++jGVJ31ha8wAZh4CWp5XV16A6MB9uNoWmO1g+w0ldtD
   2M1EtzatiNMh2ZrDoDgRC3TMKYDe/Ug1UaciKm54Nv6D9otrl9Kl84k1e
   CTkxYK3kxfH1TrpfU9FOnshTEXb3ofMk/WFDWrgn+T5iDzolM+KJmk/70
   o4OEeiMfcQjxlDDiIae1ytR5Cb6oHugH2SbROd6+9WxJelAVRLVki0Okk
   M4MyJ5Kb9rLifpcB/sdgsx3GKjioaH4DM/1NcVnnugJGK56n66f09PVFW
   BJjrPnHnq3Ps69COxquC4cbzLlaIHQ4gMa234OjDuJfotNc5EDlKWOS76
   g==;
X-CSE-ConnectionGUID: pw9JKDkdSeOaWLV3+wywNg==
X-CSE-MsgGUID: fkxG+PZ6T62hnlu21nQ3AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19591188"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19591188"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 11:51:53 -0700
X-CSE-ConnectionGUID: xOcSniOWQmiD7YKSdDl0lA==
X-CSE-MsgGUID: YApj6lHvSC+kCsDNk6CK3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="82959106"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jul 2024 11:51:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWKbx-000mGC-2V;
	Tue, 23 Jul 2024 18:51:45 +0000
Date: Wed, 24 Jul 2024 02:51:45 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	youling.tang@linux.dev, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 4/4] f2fs: Use module_{subinit, subeixt} helper macros
Message-ID: <202407240204.KcPiCniO-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240204.KcPiCniO-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240204.KcPiCniO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240204.KcPiCniO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/f2fs/node.c:16:
>> fs/f2fs/f2fs.h:4131:57: warning: non-void function does not return a value [-Wreturn-type]
    4131 | static inline int __init f2fs_create_root_stats(void) { }
         |                                                         ^
   1 warning generated.
--
   In file included from fs/f2fs/data.c:25:
>> fs/f2fs/f2fs.h:4131:57: warning: non-void function does not return a value [-Wreturn-type]
    4131 | static inline int __init f2fs_create_root_stats(void) { }
         |                                                         ^
   fs/f2fs/data.c:2373:10: warning: variable 'index' set but not used [-Wunused-but-set-variable]
    2373 |         pgoff_t index;
         |                 ^
   2 warnings generated.


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

