Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BCDEFC7A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 12:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfKELfx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 06:35:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:58868 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbfKELfw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 06:35:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 03:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="227068904"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2019 03:35:42 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iRx7b-000Fr1-O6; Tue, 05 Nov 2019 19:35:39 +0800
Date:   Tue, 5 Nov 2019 19:35:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     kbuild-all@lists.01.org, elver@google.com, akiyks@gmail.com,
        stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 5/9] seqlock, kcsan: Add annotations for KCSAN
Message-ID: <201911051950.7sv6Mqoe%lkp@intel.com>
References: <20191104142745.14722-6-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104142745.14722-6-elver@google.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marco,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.4-rc6]
[cannot apply to next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Marco-Elver/Add-Kernel-Concurrency-Sanitizer-KCSAN/20191105-002542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a99d8080aaf358d5d23581244e5da23b35e340b9
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-6-g57f8611-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> include/linux/rcupdate.h:651:9: sparse: sparse: context imbalance in 'thread_group_cputime' - different lock contexts for basic block

vim +/thread_group_cputime +651 include/linux/rcupdate.h

^1da177e4c3f41 Linus Torvalds      2005-04-16  603  
^1da177e4c3f41 Linus Torvalds      2005-04-16  604  /*
^1da177e4c3f41 Linus Torvalds      2005-04-16  605   * So where is rcu_write_lock()?  It does not exist, as there is no
^1da177e4c3f41 Linus Torvalds      2005-04-16  606   * way for writers to lock out RCU readers.  This is a feature, not
^1da177e4c3f41 Linus Torvalds      2005-04-16  607   * a bug -- this property is what provides RCU's performance benefits.
^1da177e4c3f41 Linus Torvalds      2005-04-16  608   * Of course, writers must coordinate with each other.  The normal
^1da177e4c3f41 Linus Torvalds      2005-04-16  609   * spinlock primitives work well for this, but any other technique may be
^1da177e4c3f41 Linus Torvalds      2005-04-16  610   * used as well.  RCU does not care how the writers keep out of each
^1da177e4c3f41 Linus Torvalds      2005-04-16  611   * others' way, as long as they do so.
^1da177e4c3f41 Linus Torvalds      2005-04-16  612   */
3d76c082907e8f Paul E. McKenney    2009-09-28  613  
3d76c082907e8f Paul E. McKenney    2009-09-28  614  /**
ca5ecddfa8fcbd Paul E. McKenney    2010-04-28  615   * rcu_read_unlock() - marks the end of an RCU read-side critical section.
3d76c082907e8f Paul E. McKenney    2009-09-28  616   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  617   * In most situations, rcu_read_unlock() is immune from deadlock.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  618   * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  619   * is responsible for deboosting, which it does via rt_mutex_unlock().
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  620   * Unfortunately, this function acquires the scheduler's runqueue and
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  621   * priority-inheritance spinlocks.  This means that deadlock could result
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  622   * if the caller of rcu_read_unlock() already holds one of these locks or
ec84b27f9b3b56 Anna-Maria Gleixner 2018-05-25  623   * any lock that is ever acquired while holding them.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  624   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  625   * That said, RCU readers are never priority boosted unless they were
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  626   * preempted.  Therefore, one way to avoid deadlock is to make sure
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  627   * that preemption never happens within any RCU read-side critical
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  628   * section whose outermost rcu_read_unlock() is called with one of
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  629   * rt_mutex_unlock()'s locks held.  Such preemption can be avoided in
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  630   * a number of ways, for example, by invoking preempt_disable() before
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  631   * critical section's outermost rcu_read_lock().
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  632   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  633   * Given that the set of locks acquired by rt_mutex_unlock() might change
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  634   * at any time, a somewhat more future-proofed approach is to make sure
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  635   * that that preemption never happens within any RCU read-side critical
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  636   * section whose outermost rcu_read_unlock() is called with irqs disabled.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  637   * This approach relies on the fact that rt_mutex_unlock() currently only
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  638   * acquires irq-disabled locks.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  639   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  640   * The second of these two approaches is best in most situations,
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  641   * however, the first approach can also be useful, at least to those
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  642   * developers willing to keep abreast of the set of locks acquired by
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  643   * rt_mutex_unlock().
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  644   *
3d76c082907e8f Paul E. McKenney    2009-09-28  645   * See rcu_read_lock() for more information.
3d76c082907e8f Paul E. McKenney    2009-09-28  646   */
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  647  static inline void rcu_read_unlock(void)
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  648  {
f78f5b90c4ffa5 Paul E. McKenney    2015-06-18  649  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
bde23c6892878e Heiko Carstens      2012-02-01  650  			 "rcu_read_unlock() used illegally while idle");
bc33f24bdca8b6 Paul E. McKenney    2009-08-22 @651  	__release(RCU);
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  652  	__rcu_read_unlock();
d24209bb689e2c Paul E. McKenney    2015-01-21  653  	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  654  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  655  

:::::: The code at line 651 was first introduced by commit
:::::: bc33f24bdca8b6e97376e3a182ab69e6cdefa989 rcu: Consolidate sparse and lockdep declarations in include/linux/rcupdate.h

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
