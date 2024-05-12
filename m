Return-Path: <linux-arch+bounces-4348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7D8C3931
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A566A1F21740
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 23:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B658ABF;
	Sun, 12 May 2024 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWA5ewsd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD358AC1
	for <linux-arch@vger.kernel.org>; Sun, 12 May 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555926; cv=none; b=GJ6qLd/s8Hc3SFb0Qnwu1ygyEixmybFwmVCK2eNhd0+u/ejHbC6MwR0XxGN7SXFLBzk6X9bQuylcF64Suy0txtGa3fx1ZCgTsipUKO5Vw3b/lqoR0Cug4ezJlP8SX21nN6/rm1+UOQm3bqoFcZwk0W3oggjWyiZPTLYtk4OwytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555926; c=relaxed/simple;
	bh=UnYtC+1AsoqqotFotNI25S3YYJeF/5igazba8ur4wuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gI0pAT7u8ZU/Mey/0s8MAIi90ZeVPKIkMPmKIs6sbvkofPJ/Zv1mY5Z56sLsTl5pzDCpwaMaw5WA7a3wc52RTR5fTUn9smRo64twNj9yN7Y180JxwH5hrgcbpCbeZM++CE6aSivmCV4fsOHvOfDwHGFl7X0RRYQM2mpSJCQ/tSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWA5ewsd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715555924; x=1747091924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UnYtC+1AsoqqotFotNI25S3YYJeF/5igazba8ur4wuk=;
  b=aWA5ewsd1s+UAkwz4LxBr09nl0BfapewFB9rlNvFF1z5qaDSJpZrZwtT
   vQBb7G7w21s/mpwQl7c7svpJNmcPibew0XPQJJQ+mR+Wv/cujiB69+OS/
   OXAeONJIZ5t5g/3SGsQWUKBPG0sC83QXTfpjLmJfp6irOf37tjWK7jqk1
   gdSSdAkvPNzKrnjJRPg728P7oTHgFszlwqURPMSHiTH8eLFt1giPsgi7e
   iUeVULVVGBxinL1O4WaJeo2skoABMsZq26yjUuDqcvvXLWs/vxMCXijzZ
   vna7zDlHAel0+ri+t2CYSFXVpiSf/tci6iEb2p/jxLAeWCPEN9L2Ab+nl
   g==;
X-CSE-ConnectionGUID: NueJan+jQq6yX6cm9bS+1A==
X-CSE-MsgGUID: IPHr21WNTrynuP52AyTJ/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22624621"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="22624621"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 16:18:44 -0700
X-CSE-ConnectionGUID: 672mFqmgT6WKWWDMOd/l8w==
X-CSE-MsgGUID: kOwvDi2kS12gW73RnrPE1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30239270"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2024 16:18:42 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6ISm-0009Hm-1S;
	Sun, 12 May 2024 23:18:40 +0000
Date: Mon, 13 May 2024 07:17:27 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.9 43/46] kernel/fork.c:3087:2:
 warning: #warning clone3() entry point is missing, please fix
Message-ID: <202405130707.pzKiV49b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.9
head:   e0d7a2fe9b74052a280531e773ebaba59e2d523f
commit: 6bca3b47be851b7e05f0117d8022a0daabc84c72 [43/46] clone3: drop __ARCH_WANT_SYS_CLONE3 macro
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240513/202405130707.pzKiV49b-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405130707.pzKiV49b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405130707.pzKiV49b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/fork.c: In function '__do_sys_clone3':
>> kernel/fork.c:3087:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
    3087 | #warning clone3() entry point is missing, please fix
         |  ^~~~~~~


vim +3087 kernel/fork.c

  3067	
  3068	/**
  3069	 * sys_clone3 - create a new process with specific properties
  3070	 * @uargs: argument structure
  3071	 * @size:  size of @uargs
  3072	 *
  3073	 * clone3() is the extensible successor to clone()/clone2().
  3074	 * It takes a struct as argument that is versioned by its size.
  3075	 *
  3076	 * Return: On success, a positive PID for the child process.
  3077	 *         On error, a negative errno number.
  3078	 */
  3079	SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
  3080	{
  3081		int err;
  3082	
  3083		struct kernel_clone_args kargs;
  3084		pid_t set_tid[MAX_PID_NS_LEVEL];
  3085	
  3086	#ifdef __ARCH_BROKEN_SYS_CLONE3
> 3087	#warning clone3() entry point is missing, please fix
  3088		return -ENOSYS;
  3089	#endif
  3090	
  3091		kargs.set_tid = set_tid;
  3092	
  3093		err = copy_clone_args_from_user(&kargs, uargs, size);
  3094		if (err)
  3095			return err;
  3096	
  3097		if (!clone3_args_valid(&kargs))
  3098			return -EINVAL;
  3099	
  3100		return kernel_clone(&kargs);
  3101	}
  3102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

