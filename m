Return-Path: <linux-arch+bounces-463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B17F9221
	for <lists+linux-arch@lfdr.de>; Sun, 26 Nov 2023 11:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CAF281180
	for <lists+linux-arch@lfdr.de>; Sun, 26 Nov 2023 10:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28904802;
	Sun, 26 Nov 2023 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nwa/bFBC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1468F;
	Sun, 26 Nov 2023 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700993835; x=1732529835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f5ewHJh/9BqgbcAhVDbCfvTAFMqEnNsEPaeDtNcovOk=;
  b=Nwa/bFBCMXwzn23bM6DVmOqJ+fs6uXQwcw3vWF5gjvszUa/29L1HxzK6
   SePnOQsuWqHeHdZFqh8JxzGL0r/ZetLfBh1UxeiLLFsFjgqAcJONioUrM
   COLvne18trLZfZRNIIClgRZl1gAIVtlGr4Xf9NJ108I5AckXntE/RKMEX
   pDWtbiaidAJ/8OxOsoVyIJ11x7XIchV9fWhhKA7fUFeu8tbkxG1208jyL
   r7sLcMd8pecM4BK/TPS7XJC8V5w8SJhIU969BvioGprBifBZNB+uN5Nfl
   mD1Z2s+xdxN92FZelXq12VHqCpjX/SBl0QRdBNxxyC15NrWGnyn3Z2Ppu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="5805491"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="5805491"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 02:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="767873892"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="767873892"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2023 02:17:11 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7CCL-00051k-23;
	Sun, 26 Nov 2023 10:17:09 +0000
Date: Sun, 26 Nov 2023 18:16:13 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export.h: remove include/asm-generic/export.h
Message-ID: <202311261754.Kd1lFhPF-lkp@intel.com>
References: <20231126054917.930324-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126054917.930324-1-masahiroy@kernel.org>

Hi Masahiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc2]
[also build test ERROR on linus/master next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/export-h-remove-include-asm-generic-export-h/20231126-135120
base:   v6.7-rc2
patch link:    https://lore.kernel.org/r/20231126054917.930324-1-masahiroy%40kernel.org
patch subject: [PATCH] export.h: remove include/asm-generic/export.h
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231126/202311261754.Kd1lFhPF-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311261754.Kd1lFhPF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311261754.Kd1lFhPF-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from arch/arm64/kernel/vdso/note.S:15:
>> arch/arm64/include/asm/assembler.h:15:10: fatal error: 'asm-generic/export.h' file not found
      15 | #include <asm-generic/export.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/kernel/vdso/sigreturn.S:15:
   In file included from include/linux/linkage.h:8:
   In file included from arch/arm64/include/asm/linkage.h:5:
>> arch/arm64/include/asm/assembler.h:15:10: fatal error: 'asm-generic/export.h' file not found
      15 | #include <asm-generic/export.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[3]: *** [scripts/Makefile.build:360: arch/arm64/kernel/vdso/note.o] Error 1
   1 error generated.
   make[3]: *** [scripts/Makefile.build:360: arch/arm64/kernel/vdso/sigreturn.o] Error 1
   make[3]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[3]: Target 'arch/arm64/kernel/vdso/vdso.so' not remade because of errors.
   make[2]: *** [arch/arm64/Makefile:194: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +15 arch/arm64/include/asm/assembler.h

f3e39273e0a9a5 Marc Zyngier 2015-02-20  14  
386b3c7bdafcc6 Mark Rutland 2018-12-07 @15  #include <asm-generic/export.h>
386b3c7bdafcc6 Mark Rutland 2018-12-07  16  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

