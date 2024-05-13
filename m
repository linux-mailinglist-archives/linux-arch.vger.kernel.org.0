Return-Path: <linux-arch+bounces-4350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405D8C3A3B
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 04:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0421F2120E
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A464145B10;
	Mon, 13 May 2024 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVJ9kjYn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92279BA4D
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715567988; cv=none; b=G/TvkITJfEc5Ts2IiK9E3RVQsQj3a3J7ch1t2EJmk3QA/ab8MsD8M7sgZAUikgCWej6u57tNr9J00Eub7l3VFP/FfjgqiRhkTwSocJf+B53mnNAzrJVcd0OVzY7XdqRft72SSQsAuCI+DCnmUT201K9m1Oa/ym9NQslgGV4TS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715567988; c=relaxed/simple;
	bh=BJ3INmcyzip7tYZxKbEJ8QG+/zUWvN17KRx6bPdQxB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TqX7AvaRxEVXWO57REm98RSMuWb6MiWHcsezPOHGzkc4BIxB1+JKWxNU6jPc4hJvZw3N/qXGATjLIIIz6eIdj/VbGl0KEcNwxk8mqD1+d3vwfolVWNOmsxf/JvcK+g16iqXUigVAwjbPSJVBVhAijwACT6nsCDJADLh7SU3sj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVJ9kjYn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715567986; x=1747103986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BJ3INmcyzip7tYZxKbEJ8QG+/zUWvN17KRx6bPdQxB4=;
  b=fVJ9kjYn4FL5yLk88uUfUanpxb11EgmFl/E5RBaBcLzfwMq64h4/mZHU
   BA1qnUpkg91+S16RMEdzH+tefg/OW/II+uuDDUvtCJ7xikq3glsxtlmUc
   ZXq2Icx3AgLC2LFuyzFQIxSJK5dr7i42HqgdkkUC31ZOpZT0ojo2+SUg3
   MVNffnmjYf8wZpJTES9/roQ1Id1mRnnLExCRu6yDuRpk3tw9boxBsmX3B
   Us5igWZT1Ra/uit6NF8/xYIy3A16Ji8c4RYrGFRBFkovE3ScDjIebCoVa
   2VBVwso6wQw+QkowlIZ6LdLzJHc+N46edjxO/JdZdWt5ylICO4JVi/rVz
   g==;
X-CSE-ConnectionGUID: s1IUOfEkRlCFeMoyUrjGyg==
X-CSE-MsgGUID: Sej1ht3KToSToTBamHElhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29000092"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="29000092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 19:39:46 -0700
X-CSE-ConnectionGUID: SJKkwN3ySdqn5tPCg9UVPw==
X-CSE-MsgGUID: wYd+QCARTzOFezoVsGoSfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30758962"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 May 2024 19:39:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6LbK-0009SP-19;
	Mon, 13 May 2024 02:39:42 +0000
Date: Mon, 13 May 2024 10:38:47 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.9 34/46] make[3]: *** No rule to
 make target 'arch/um/include/generated/asm/bpf_perf_event.h', needed by
 'all'.
Message-ID: <202405131015.R5eW2BHz-lkp@intel.com>
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
commit: a07293862960e1329b45044916498891ed8161a1 [34/46] kbuild: verify asm-generic header list
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240513/202405131015.R5eW2BHz-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405131015.R5eW2BHz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405131015.R5eW2BHz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'arch/um/include/generated/asm/bpf_perf_event.h', needed by 'all'.
   make[3]: Target 'all' not remade because of errors.
   make[2]: *** [Makefile:1215: asm-generic] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

