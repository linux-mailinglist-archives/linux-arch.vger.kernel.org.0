Return-Path: <linux-arch+bounces-5602-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E693ACE0
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 09:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D7E1C20D56
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622EC3EA98;
	Wed, 24 Jul 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dqn/397R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365D4D8BD
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804413; cv=none; b=LJ8+cxUztVZ7f9oU1jADst0z6oesgamsJnCBA5XslAHgaERgaiNg2ccyiPKeaidLyRq5yaf7ZRxMXWjcmLiaYkUSr8Jj1jc/CUKTusa5DzLYurZCzwdz6U0qA+Es0dEKjwvOoqvb9bbiQMUE04WV6yTiXRX10Uxl32XpWXGgG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804413; c=relaxed/simple;
	bh=Bf6ZUVbJMbBGKngx8hDcJM5/5ZBEnwVeRmWno6pmYTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bvfP+XyRiFRpK3OqWQIxRqo8IOojMRdFXjr9+0fA+oQHEQlnMW7sC2mJ9mmVeB73yFUJF57g5/l0cd+W1VzDfsbdPQtcqGGx0Lsj3MFmwXOrqBxbOoSmHr9A/DhRzaOH9fqdTK4tcYa2i7YQAGYV6Y8I5BV88Vh1K8msb5asuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dqn/397R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721804412; x=1753340412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bf6ZUVbJMbBGKngx8hDcJM5/5ZBEnwVeRmWno6pmYTg=;
  b=Dqn/397RK9fVNO/v7OPXqFN8f/m81eiKOswCaA6ezGL1LR/Z5KKjiw/L
   S6MLcaRb/uXJ5/mqpROjqaO0XMFkZHoupeLAtjyJtdXqoW25sDA0GzR4f
   CgaWU8JMgwbYrOwx3/fsCtZExHkwBC7XPzMg5S7qtLCryfet/IlZe8nnG
   91AZLMiRTjltdtKpzgRUZCqaNhZ8AjI8J5CW9+2JkPGemHzZ/m+B5i08W
   JA0sxj7yjn7HoO5E6woppHDDwYzjhr/ml7d1YgKVCn2oPkmXBj5LdSmTV
   XXJhEISaVeOEVBGmSr6EYGs09dfbdH+iYFiMA/CZXXQzndPpcNtYyPw4L
   w==;
X-CSE-ConnectionGUID: waCMYHrcR8a8Mo8XdrVTlA==
X-CSE-MsgGUID: Y53iChLHQA2gh8/oLT5bxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="23222282"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="23222282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:00:11 -0700
X-CSE-ConnectionGUID: IDLpmrUkRtulYEhnf9V/sQ==
X-CSE-MsgGUID: 0TXS2BRbRNGMi4I1RNgr5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52728851"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Jul 2024 00:00:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWVyp-000mlI-0s;
	Wed, 24 Jul 2024 07:00:07 +0000
Date: Wed, 24 Jul 2024 14:59:58 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 30/80] riscv64-linux-ld:
 arch/riscv/kernel/syscall_table.o:undefined reference to
 `__riscv_sys_fadvise64'
Message-ID: <202407241404.i00uka5s-lkp@intel.com>
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
config: riscv-nommu_k210_sdcard_defconfig (https://download.01.org/0day-ci/archive/20240724/202407241404.i00uka5s-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241404.i00uka5s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241404.i00uka5s-lkp@intel.com/

All errors (new ones prefixed by >>):

>> riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0x6f8): undefined reference to `__riscv_sys_fadvise64'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

