Return-Path: <linux-arch+bounces-14092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45549BD7F4D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEEE84E7ADE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182E2E6CB3;
	Tue, 14 Oct 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeETP5mB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7672BF00A;
	Tue, 14 Oct 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427364; cv=none; b=F016hsHEAQe12eSvtvTbL2TTKiaodVenJ7lAPglAtelxBwIgfFH1lQnBXiNzeO00DCOEeu9dgQFY2tifs/NYGPIjkwnFoCYoId2i8FhN/T+0+kg3j2HW/eBQtbwtuNqF68KEtgVJ4XvjGH/D5pQ+6+xYBcgvVMfeLffnAe6hCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427364; c=relaxed/simple;
	bh=2284CvY5KmX5EI9TFoaFTarD8eR3jMtTJMBg6GQjNRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJGJQABz+Td97f456XwXr2PrN4snGeNRJEpF5kiXWiX7Py4qTtEEqvBRBVPLpI3dJZq/CCq3yI3w/yWvnVZtzApyqhGw0DSjzl25nY01+m5U5oSbXKDgSCGj+nNcKaz1bIvumVkt6/bIyPFe848iwSssq3zR5M2FGxTMwsPi14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeETP5mB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760427362; x=1791963362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2284CvY5KmX5EI9TFoaFTarD8eR3jMtTJMBg6GQjNRU=;
  b=NeETP5mBo5TBVX8A2D1tqSu8bWV8LrJXJLMLl7rZ6tx563C2NLy6rObi
   8MEorqkaUXb/y1VdbyEDwZPkDDl2bC10hXfqwcPPgD4tQlLbzHx8nZ1Er
   mtwNC6IExHoAumaQIYe/XHUrPp9rp63bhbPikqpuBSea971Dzh11/F3dG
   bCxuSiTEF0NaD1kr4Ot8dygByRmtZAjt97wrjrbW05fObZiGZuy6VxMaC
   nrmjXqEIQCBb+GARrTQCFWdPnC7aoSSnjs2vX69SaWNvJ5b/kWqWJAQ2y
   0x+eZXu7CcRpno+xK+MPrmVuPswaMuQoQp1ckQxALP6itU228qn+X0B76
   A==;
X-CSE-ConnectionGUID: CqGbbvIHQ2ik6kFTQ94w+A==
X-CSE-MsgGUID: 5Q0DaljVRxCmMznHi+4lAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62676435"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62676435"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:36:01 -0700
X-CSE-ConnectionGUID: gTATWPGlTfSS0LfoG70TaA==
X-CSE-MsgGUID: mhAv5gGKRSmK6SgdH2mMkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="205508506"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 14 Oct 2025 00:35:58 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8ZZT-0002Vz-2H;
	Tue, 14 Oct 2025 07:35:49 +0000
Date: Tue, 14 Oct 2025 15:34:57 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Nayyar <sidnayyar@google.com>, petr.pavlu@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev,
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com,
	gprocida@google.com
Subject: Re: [PATCH v2 10/10] module loader: enforce symbol import protection
Message-ID: <202510141538.VZqnRzHh-lkp@intel.com>
References: <20251013153918.2206045-11-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013153918.2206045-11-sidnayyar@google.com>

Hi Siddharth,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on soc/for-next linus/master v6.18-rc1 next-20251013]
[cannot apply to mcgrof/modules-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Nayyar/define-kernel-symbol-flags/20251014-005305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251013153918.2206045-11-sidnayyar%40google.com
patch subject: [PATCH v2 10/10] module loader: enforce symbol import protection
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251014/202510141538.VZqnRzHh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510141538.VZqnRzHh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510141538.VZqnRzHh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/module/main.c:1271:32: error: no member named 'sig_ok' in 'struct module'
    1271 |         if (fsa.is_protected && !mod->sig_ok) {
         |                                  ~~~  ^
   1 error generated.


vim +1271 kernel/module/main.c

  1228	
  1229	/* Resolve a symbol for this module.  I.e. if we find one, record usage. */
  1230	static const struct kernel_symbol *resolve_symbol(struct module *mod,
  1231							  const struct load_info *info,
  1232							  const char *name,
  1233							  char ownername[])
  1234	{
  1235		struct find_symbol_arg fsa = {
  1236			.name	= name,
  1237			.gplok	= !(mod->taints & (1 << TAINT_PROPRIETARY_MODULE)),
  1238			.warn	= true,
  1239		};
  1240		int err;
  1241	
  1242		/*
  1243		 * The module_mutex should not be a heavily contended lock;
  1244		 * if we get the occasional sleep here, we'll go an extra iteration
  1245		 * in the wait_event_interruptible(), which is harmless.
  1246		 */
  1247		sched_annotate_sleep();
  1248		mutex_lock(&module_mutex);
  1249		if (!find_symbol(&fsa))
  1250			goto unlock;
  1251	
  1252		if (fsa.license == GPL_ONLY)
  1253			mod->using_gplonly_symbols = true;
  1254	
  1255		if (!inherit_taint(mod, fsa.owner, name)) {
  1256			fsa.sym = NULL;
  1257			goto getname;
  1258		}
  1259	
  1260		if (!check_version(info, name, mod, fsa.crc)) {
  1261			fsa.sym = ERR_PTR(-EINVAL);
  1262			goto getname;
  1263		}
  1264	
  1265		err = verify_namespace_is_imported(info, fsa.sym, mod);
  1266		if (err) {
  1267			fsa.sym = ERR_PTR(err);
  1268			goto getname;
  1269		}
  1270	
> 1271		if (fsa.is_protected && !mod->sig_ok) {
  1272			pr_warn("%s: Cannot use protected symbol %s\n",
  1273				mod->name, name);
  1274			fsa.sym = ERR_PTR(-EACCES);
  1275			goto getname;
  1276		}
  1277	
  1278		err = ref_module(mod, fsa.owner);
  1279		if (err) {
  1280			fsa.sym = ERR_PTR(err);
  1281			goto getname;
  1282		}
  1283	
  1284	getname:
  1285		/* We must make copy under the lock if we failed to get ref. */
  1286		strscpy(ownername, module_name(fsa.owner), MODULE_NAME_LEN);
  1287	unlock:
  1288		mutex_unlock(&module_mutex);
  1289		return fsa.sym;
  1290	}
  1291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

