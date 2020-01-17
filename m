Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130ED141438
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 23:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAQWhg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 17:37:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:14749 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgAQWhg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 17:37:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="gz'50?scan'50,208,50";a="227391647"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2020 14:37:31 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isaF9-000DkL-81; Sat, 18 Jan 2020 06:37:31 +0800
Date:   Sat, 18 Jan 2020 06:37:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Xuefeng Wang <wxf.wang@hisilicon.com>
Cc:     kbuild-all@lists.01.org, arnd@arndb.de, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        chenzhou10@huawei.com
Subject: Re: [PATCH 1/2] mm: add helpers pmdp_modify_prot_start/commit
Message-ID: <202001180630.6Fc05qBN%lkp@intel.com>
References: <1579144157-7736-2-git-send-email-wxf.wang@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rejnauerctsrt3t7"
Content-Disposition: inline
In-Reply-To: <1579144157-7736-2-git-send-email-wxf.wang@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--rejnauerctsrt3t7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Xuefeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Xuefeng-Wang/mm-thp-rework-the-pmd-protect-changing-flow/20200117-115821
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/nds32/include/asm/pgtable.h:394,
                    from include/linux/mm.h:99,
                    from include/linux/ring_buffer.h:5,
                    from include/linux/trace_events.h:6,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:85,
                    from init/main.c:21:
   include/asm-generic/pgtable.h: In function '__pmdp_modify_prot_commit':
>> include/asm-generic/pgtable.h:677:2: error: implicit declaration of function 'set_pmd_at'; did you mean 'set_pte_at'? [-Werror=implicit-function-declaration]
     677 |  set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
         |  ^~~~~~~~~~
         |  set_pte_at
   cc1: some warnings being treated as errors
--
   In file included from arch/nds32/include/asm/pgtable.h:394,
                    from include/linux/mm.h:99,
                    from arch/nds32/include/asm/uaccess.h:14,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/ptrace.h:7,
                    from arch/nds32/kernel/signal.c:6:
   include/asm-generic/pgtable.h: In function '__pmdp_modify_prot_commit':
>> include/asm-generic/pgtable.h:677:2: error: implicit declaration of function 'set_pmd_at'; did you mean 'set_pte_at'? [-Werror=implicit-function-declaration]
     677 |  set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
         |  ^~~~~~~~~~
         |  set_pte_at
   arch/nds32/kernel/signal.c: In function 'do_signal':
   arch/nds32/kernel/signal.c:362:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     362 |    regs->uregs[15] = __NR_restart_syscall;
   arch/nds32/kernel/signal.c:363:3: note: here
     363 |   case -ERESTARTNOHAND:
         |   ^~~~
   arch/nds32/kernel/signal.c: In function 'handle_signal':
   arch/nds32/kernel/signal.c:315:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
     315 |    if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
         |       ^
   arch/nds32/kernel/signal.c:319:3: note: here
     319 |   case -ERESTARTNOINTR:
         |   ^~~~
   cc1: some warnings being treated as errors

vim +677 include/asm-generic/pgtable.h

   672	
   673	static inline void __pmdp_modify_prot_commit(struct vm_area_struct *vma,
   674							unsigned long addr,
   675							pmd_t *pmdp, pmd_t pmd)
   676	{
 > 677		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
   678	}
   679	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--rejnauerctsrt3t7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ovEL2RNIbmSyEkpX59f0sSMBOGIj/tsABfcBNRLIRIl8SL+WL05PrVrgM7DvCG9KarV3DuFG
B+yuy41LsQwFwSwYlMrLSJ6zmPaUJOzGugmLAvNsfFcsD0nc+oM4aUAPkfpLK/yUfhpGdaq4
KhwiTSIz0XHh5ROaBuLtw8qNurluVKAOngTdASU3CrowzddCgih22TbM0WDdWO1kZBDcIkFe
xESxjOticSOPrugdFblI1CbvIJjM5eC7CFp+v88uj5RMLnXEmjL18nKSUetgJHcRyfnmRYZW
77ZxTlfupXKKYRBv9QCzZffkck05CdUh5+hkm1K0EZljDSKCHHkzktN1kngFfdhoHxjFNnZX
aCODAwzzyw58gtluURFdcrlQkYRFR93WjseGYwcbwYWiAwflkJR6Mwg9wlKhqCKZl8ZdmdxM
YStk8U63whx1escn4QISEjtGRulLlOkaM2lbutJnbkuQYCopKsYBGQlQTKf124grXY4Tl1sq
E8oWKeradv3W0QXqAnkcnBujOKPvUpCigGsgzLviGHDupghREdBXf2oeT5kMBADOEl5gU50v
MX+16xONctfww53OJMONjDbRiYTkgeVXOLK2sbYuI7djQqHLoKM/hD7HnJBoe8lanqpJmWSO
GSGFN19u7c7VgddPzF1GVwlLIDFedYWibxN4lQcXS0Wds4e/SinPeIyNSo/yYMJyue+LcZoo
/bDNposAFczl8naU0cyypWRUisf6Zb2nAiBM68EodNUYj/wPQCIzmGelAAA=

--rejnauerctsrt3t7--
