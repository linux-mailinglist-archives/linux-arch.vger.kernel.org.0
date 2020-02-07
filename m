Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210BD155001
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 02:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGBU3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 20:20:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:34395 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgBGBU3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 20:20:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 17:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="gz'50?scan'50,208,50";a="232228007"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 17:20:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izsJj-000EFj-7F; Fri, 07 Feb 2020 09:20:23 +0800
Date:   Fri, 7 Feb 2020 09:19:40 +0800
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
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
Message-ID: <202002070928.0W7YYLih%lkp@intel.com>
References: <20200206030900.147032-3-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fekiciwyntwr4veh"
Content-Disposition: inline
In-Reply-To: <20200206030900.147032-3-leonardo@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--fekiciwyntwr4veh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Leonardo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on paulus-powerpc/kvm-ppc-next linus/master v5.5 next-20200206]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Leonardo-Bras/Introduces-new-functions-for-tracking-lockless-pagetable-walks/20200207-071035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/gup.c: In function 'get_user_pages_fast':
>> mm/gup.c:2435:27: error: 'IRQS_ENABLED' undeclared (first use in this function); did you mean 'IS_ENABLED'?
      end_lockless_pgtbl_walk(IRQS_ENABLED);
                              ^~~~~~~~~~~~
                              IS_ENABLED
   mm/gup.c:2435:27: note: each undeclared identifier is reported only once for each function it appears in

vim +2435 mm/gup.c

  2395	
  2396	/**
  2397	 * get_user_pages_fast() - pin user pages in memory
  2398	 * @start:	starting user address
  2399	 * @nr_pages:	number of pages from start to pin
  2400	 * @gup_flags:	flags modifying pin behaviour
  2401	 * @pages:	array that receives pointers to the pages pinned.
  2402	 *		Should be at least nr_pages long.
  2403	 *
  2404	 * Attempt to pin user pages in memory without taking mm->mmap_sem.
  2405	 * If not successful, it will fall back to taking the lock and
  2406	 * calling get_user_pages().
  2407	 *
  2408	 * Returns number of pages pinned. This may be fewer than the number
  2409	 * requested. If nr_pages is 0 or negative, returns 0. If no pages
  2410	 * were pinned, returns -errno.
  2411	 */
  2412	int get_user_pages_fast(unsigned long start, int nr_pages,
  2413				unsigned int gup_flags, struct page **pages)
  2414	{
  2415		unsigned long addr, len, end;
  2416		int nr = 0, ret = 0;
  2417	
  2418		if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM)))
  2419			return -EINVAL;
  2420	
  2421		start = untagged_addr(start) & PAGE_MASK;
  2422		addr = start;
  2423		len = (unsigned long) nr_pages << PAGE_SHIFT;
  2424		end = start + len;
  2425	
  2426		if (end <= start)
  2427			return 0;
  2428		if (unlikely(!access_ok((void __user *)start, len)))
  2429			return -EFAULT;
  2430	
  2431		if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
  2432		    gup_fast_permitted(start, end)) {
  2433			begin_lockless_pgtbl_walk();
  2434			gup_pgd_range(addr, end, gup_flags, pages, &nr);
> 2435			end_lockless_pgtbl_walk(IRQS_ENABLED);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fekiciwyntwr4veh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7YCjVAzdo589OAU2Z0M/AExU287UZwAA

--fekiciwyntwr4veh--
