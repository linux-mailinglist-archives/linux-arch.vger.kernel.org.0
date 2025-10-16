Return-Path: <linux-arch+bounces-14156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17861BE1598
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 05:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B87134E17B9
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9C1F2C45;
	Thu, 16 Oct 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkfBDlLV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52192146593;
	Thu, 16 Oct 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584819; cv=none; b=QVzfzs/JMOGPU7kVVGH3IDD2N16MCcnca4auIs0VV15uj3vmMfZ9NbVB2X6UMEkFhsh7r2u0a+PTiTPEkKJVvVrCiTtPHHLYcStUxBitrF3Sbu3n619HES3v2fCgwspSHyCepmw3nj+eHSxLoO3VA7hInEgzmYz356dVTvZbW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584819; c=relaxed/simple;
	bh=oJedM1hfflEhgwLqf5S3MX4Pn/jZeroyYU1P+4AZNqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3mP8AO4m68e+G3lQOfSLEGjfgYm1VkJ+8KedD0r52QrnBXGqZSY2LXjbq5pcg6C9Up/aI39MB36M3UcOf9foz2LhYmnblv9P9U3BBEiTaWoPuPH+WRk4RjGMsXtjx0SSG3myyY1JtgFBqbXAz81GZyYhDYp1U6DIFOgkv1bipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkfBDlLV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760584818; x=1792120818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oJedM1hfflEhgwLqf5S3MX4Pn/jZeroyYU1P+4AZNqc=;
  b=MkfBDlLVvByLZe8fnyQpPL6U4C84NW15jDUQY5sUbib8IBEwo0DdMpMy
   CT6PbLoFbsKinHk9MsCfVbNOwqPDpRak4fWZADq5T0/B5hXRDWAtzzIQ/
   FuRrnrEsgGiCNV1C+1a8OCGdJNK6MNxvjlwLeIy8OQQDGMl5mnRCkT1ws
   koLHgnxNSF4w4Bk7yTwC31b1v/2pP8IVARZ0hoFwx4wqHQlZX+V/+oWdN
   ZfA+ckGKb8pM4BMTGFwRv6DetBQpF0ePota+WneOEUFVLUVjwFL4x5P74
   LDvto6JKxjw4J8VTpbgsqADjbGoV0x5/cDRzcFGByLHSzrViOTAuCF6QA
   g==;
X-CSE-ConnectionGUID: M/rczRKsTOGJROhwGWuWug==
X-CSE-MsgGUID: w0Q1RCRdRjeEPejhAPVtFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61975914"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="61975914"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:20:12 -0700
X-CSE-ConnectionGUID: JL9FhEcsTBm7GRTC6cDx6w==
X-CSE-MsgGUID: AiVFevBAQIGYUNZ1OFLBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="181470823"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 20:20:08 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9EUl-0004Pv-1C;
	Thu, 16 Oct 2025 03:18:34 +0000
Date: Thu, 16 Oct 2025 11:14:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yuan Tan <tanyuan@tinylab.org>, arnd@arndb.de, masahiroy@kernel.org,
	nathan@kernel.org, palmer@dabbelt.com, linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	i@maskray.me, tanyuan@tinylab.org, falcon@tinylab.org,
	ronbogo@outlook.com, z1652074432@gmail.com, lx24@stu.ynu.edu.cn
Subject: Re: [PATCH v2 6/8] compiler.h: introduce PUSHSECTION macro to
 establish proper references
Message-ID: <202510161119.Qau82x7Z-lkp@intel.com>
References: <40854460DE090346+c30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40854460DE090346+c30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan@tinylab.org>

Hi Yuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on arnd-asm-generic/master linus/master v6.18-rc1 next-20251015]
[cannot apply to masahiroy-kbuild/for-next masahiroy-kbuild/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuan-Tan/scripts-syscalltbl-sh-add-optional-used-syscalls-argument-for-syscall-trimming/20251015-181934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/40854460DE090346%2Bc30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan%40tinylab.org
patch subject: [PATCH v2 6/8] compiler.h: introduce PUSHSECTION macro to establish proper references
config: arm-randconfig-001-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161119.Qau82x7Z-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161119.Qau82x7Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161119.Qau82x7Z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: ./arch/arm/kernel/vmlinux.lds:1: unknown directive: .macro
   >>> .macro _PUSHSECTION label:req, section:req, args:vararg
   >>> ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

