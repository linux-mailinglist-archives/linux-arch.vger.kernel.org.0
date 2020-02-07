Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BEE155222
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 06:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGFke (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Feb 2020 00:40:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:11315 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgBGFke (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Feb 2020 00:40:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 21:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="gz'50?scan'50,208,50";a="236235805"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2020 21:40:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izwNP-0008PB-Pn; Fri, 07 Feb 2020 13:40:27 +0800
Date:   Fri, 7 Feb 2020 13:39:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     kbuild-all@lists.01.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v6 01/11] asm-generic/pgtable: Adds generic functions to
 track lockless pgtable walks
Message-ID: <202002071321.7I3DHPZA%lkp@intel.com>
References: <20200206030900.147032-2-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ybg6kdaexq4byqx3"
Content-Disposition: inline
In-Reply-To: <20200206030900.147032-2-leonardo@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ybg6kdaexq4byqx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Leonardo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on asm-generic/master paulus-powerpc/kvm-ppc-next linus/master v5.5 next-20200207]
[cannot apply to kvm-ppc/kvm-ppc-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Leonardo-Bras/Introduces-new-functions-for-tracking-lockless-pagetable-walks/20200207-071035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: xtensa-common_defconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/asm-generic/pgtable.h: Assembler messages:
   include/asm-generic/pgtable.h:1230: Error: unknown opcode or format name 'static'
   include/asm-generic/pgtable.h:1231: Error: unknown opcode or format name 'unsigned'
   include/asm-generic/pgtable.h:1233: Error: unknown opcode or format name 'unsigned'
   include/asm-generic/pgtable.h:1240: Error: unknown opcode or format name 'local_irq_save'
   include/asm-generic/pgtable.h:1248: Error: unknown opcode or format name 'smp_mb'
   include/asm-generic/pgtable.h:1250: Error: unknown opcode or format name 'return'
>> include/asm-generic/pgtable.h:1251: Error: couldn't find a valid instruction format
       ops were: 
   include/asm-generic/pgtable.h:1257: Error: unknown opcode or format name 'static'
   include/asm-generic/pgtable.h:1265: Error: unknown opcode or format name 'smp_mb'
   include/asm-generic/pgtable.h:1272: Error: unknown opcode or format name 'local_irq_restore'
   include/asm-generic/pgtable.h:1273: Error: couldn't find a valid instruction format
       ops were: 

vim +1251 include/asm-generic/pgtable.h

  1224	
  1225	#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
  1226	/*
  1227	 * begin_lockless_pgtbl_walk: Must be inserted before a function call that does
  1228	 *   lockless pagetable walks, such as __find_linux_pte()
  1229	 */
  1230	static inline
  1231	unsigned long begin_lockless_pgtbl_walk(void)
  1232	{
  1233		unsigned long irq_mask;
  1234	
  1235		/*
  1236		 * Interrupts must be disabled during the lockless page table walk.
  1237		 * That's because the deleting or splitting involves flushing TLBs,
  1238		 * which in turn issues interrupts, that will block when disabled.
  1239		 */
  1240		local_irq_save(irq_mask);
  1241	
  1242		/*
  1243		 * This memory barrier pairs with any code that is either trying to
  1244		 * delete page tables, or split huge pages. Without this barrier,
  1245		 * the page tables could be read speculatively outside of interrupt
  1246		 * disabling.
  1247		 */
  1248		smp_mb();
  1249	
  1250		return irq_mask;
> 1251	}
  1252	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--ybg6kdaexq4byqx3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ybg6kdaexq4byqx3--
