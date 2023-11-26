Return-Path: <linux-arch+bounces-462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A497F9215
	for <lists+linux-arch@lfdr.de>; Sun, 26 Nov 2023 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F15B20D01
	for <lists+linux-arch@lfdr.de>; Sun, 26 Nov 2023 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C3802;
	Sun, 26 Nov 2023 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRLlMIep"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CAFE3;
	Sun, 26 Nov 2023 02:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700993535; x=1732529535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h/LLhdSvEk/cgSco2Zse5iLa8y9W4V/6wPojyS/oJBU=;
  b=eRLlMIep3WmGXgcSw9W3mgU6/uVhxAevhQtlWv8Kpo9TAG97j5ht1vtc
   UwmC3tAz7DHRu4Zug7tPb+fzoEq6ADN2KYikg5yWJ4HozCmALmQLhfEs6
   LU0apDJUOTzdPt1jSW+x35JuzO9xIoWS6JEWDDTnqQUjjbpHjl24hL5Rm
   lLd0axI1ae10uBC+DDI931YAlcvuAheybtKev3brsWALY+DgwJbT3X8GD
   11R+T0XrC1PnmJOUHmToUbeX2JVmwT0U2AEtsJ9jWlW3f/S61kgLTyq9U
   lvAi7RTkODnIP3AxZlDhv4wikiY3K74jlgLGMfRz85J6PS1JjJ1/S89Rt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="5805302"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="5805302"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 02:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="941294053"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="941294053"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2023 02:12:11 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7C7V-00051W-05;
	Sun, 26 Nov 2023 10:12:09 +0000
Date: Sun, 26 Nov 2023 18:12:02 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export.h: remove include/asm-generic/export.h
Message-ID: <202311261737.dQEkPNHF-lkp@intel.com>
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
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20231126/202311261737.dQEkPNHF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311261737.dQEkPNHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311261737.dQEkPNHF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/vdso/note.S:15:
>> arch/arm64/include/asm/assembler.h:15:10: fatal error: asm-generic/export.h: No such file or directory
      15 | #include <asm-generic/export.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   In file included from arch/arm64/include/asm/linkage.h:5,
                    from include/linux/linkage.h:8,
                    from arch/arm64/kernel/vdso/sigreturn.S:15:
>> arch/arm64/include/asm/assembler.h:15:10: fatal error: asm-generic/export.h: No such file or directory
      15 | #include <asm-generic/export.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.build:360: arch/arm64/kernel/vdso/note.o] Error 1
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

