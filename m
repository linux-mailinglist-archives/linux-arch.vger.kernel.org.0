Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375FBF012E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 16:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbfKEPWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 10:22:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33551 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389577AbfKEPWh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 10:22:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id u13so17968691ote.0
        for <linux-arch@vger.kernel.org>; Tue, 05 Nov 2019 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n5lN3Fg3bcrd2szeJ48Ty9IGAr+TLatcqKpJTnbQ3g=;
        b=maXxEj942BWmoW41/CVJa3LqGD+oIzxQO1oHplq8N6x4BrRHTYU5aAiJ2zGT5E3cdU
         9hDQb6yhWrUdSYFO2pMr94zWASk5U9ZPwTIXb6cc+y4/YN7SuYkouE8QbdCk7NZ5qeIv
         w2QV5D1BxUiNxQ/NEM1+LKson595UiIjU1kjlmyowekxXeAiJFi8epx1dvdwldDai9D0
         hvlOrIf019nfF5cfbCG0hgHUhlF7A99eiLy5eV2dkLG05kZQh4i+gyE66AxXw4SdZk1S
         txmaZFYL7p3mtQLEPM0AAcFg1eEPlvm0pvcEduGGEjkQUkMHFyNFAziG1nUlnpK2IVJJ
         2pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n5lN3Fg3bcrd2szeJ48Ty9IGAr+TLatcqKpJTnbQ3g=;
        b=DxMimLA8y4zahLXtdwiDZuz/LRSwwzhNbC8xbVgp399cSk0oA8VGtZz/uniaY8GwlQ
         SV2nYdXnc328cjvHQIJ12YauexnKTHh/XSftg/lJB6p6lFwi3hWE5yuuafSdeBQLx0LT
         pavosk2VhOhU7U3M4qy4cXKtic33cwP0RrLVhRB2+qQMtUvr8+wIcJk0EZtGoLVhnkG6
         suedk71g35sQVYCmWPcUfNTJzBzn5rV+5fchJYch6bbXK1e6m8U0COU5WL5svZRfzzYJ
         NTgmt8v0WhwS0y6Mz4wRtWwJ8sVxxWfIEyAA6UpsD8aCy8RQNV35INfiIbMiQR1AKHDt
         UfRw==
X-Gm-Message-State: APjAAAV3Ok8PuSn9BZGBwpS/EZaJoFt7HSf7v5DdcYAM7XoN/A/cuS0Y
        whfHjgg1ebaR9Kg49LfRxVr4DIk7oZXsyUljg4GHfA==
X-Google-Smtp-Source: APXvYqz4/2Fhrn96Gic/peeKhOdzvhnS+TVM8YGCm3OZ0Vx50A3Dq3MgU+ipPq2pQgtLpH5m/pCW/SpvMo1is3+GbCA=
X-Received: by 2002:a05:6830:2308:: with SMTP id u8mr2369861ote.2.1572967354873;
 Tue, 05 Nov 2019 07:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20191104142745.14722-6-elver@google.com> <201911051950.7sv6Mqoe%lkp@intel.com>
In-Reply-To: <201911051950.7sv6Mqoe%lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 Nov 2019 16:22:23 +0100
Message-ID: <CANpmjNM2d03K9yZP4OzuEoWZQz_FcDfLHJ1VhqiPA6+2F0qjPA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] seqlock, kcsan: Add annotations for KCSAN
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 5 Nov 2019 at 12:35, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Marco,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.4-rc6]
> [cannot apply to next-20191031]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Marco-Elver/Add-Kernel-Concurrency-Sanitizer-KCSAN/20191105-002542
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a99d8080aaf358d5d23581244e5da23b35e340b9
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-6-g57f8611-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
> >> include/linux/rcupdate.h:651:9: sparse: sparse: context imbalance in 'thread_group_cputime' - different lock contexts for basic block

This is a problem with sparse.

Without the patch series this warning is also generated, but sparse
seems to attribute it to the right file:
    kernel/sched/cputime.c:316:17: sparse: warning: context imbalance
in 'thread_group_cputime' - different lock contexts for basic block

Without the patch series, I observe that sparse also generates 5
warnings that it attributes to include/linux/rcupdate.h ("different
lock contexts for basic block") but the actual function is in a
different file.

In the function thread_group_cputime in kernel/sched/cputime.c, what
seems to happen is that a seq-reader critical section is contained
within an RCU reader critical section (sparse seems unhappy with this
pattern to begin with). The KCSAN patches add annotations to seqlock.h
which seems to somehow affect sparse to attribute the problem in
thread_group_cputime to rcupdate.h. Note that, the config does not
even enable KCSAN and all the annotations are no-ops (empty inline
functions).

So I do not think that I can change this patch to make sparse happy
here, since this problem already existed, only sparse somehow decided
to attribute the problem to rcupdate.h instead of cputime.c due to
subtle changes in the code.

Thanks,
-- Marco

> vim +/thread_group_cputime +651 include/linux/rcupdate.h
>
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  603
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  604  /*
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  605   * So where is rcu_write_lock()?  It does not exist, as there is no
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  606   * way for writers to lock out RCU readers.  This is a feature, not
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  607   * a bug -- this property is what provides RCU's performance benefits.
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  608   * Of course, writers must coordinate with each other.  The normal
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  609   * spinlock primitives work well for this, but any other technique may be
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  610   * used as well.  RCU does not care how the writers keep out of each
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  611   * others' way, as long as they do so.
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  612   */
> 3d76c082907e8f Paul E. McKenney    2009-09-28  613
> 3d76c082907e8f Paul E. McKenney    2009-09-28  614  /**
> ca5ecddfa8fcbd Paul E. McKenney    2010-04-28  615   * rcu_read_unlock() - marks the end of an RCU read-side critical section.
> 3d76c082907e8f Paul E. McKenney    2009-09-28  616   *
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  617   * In most situations, rcu_read_unlock() is immune from deadlock.
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  618   * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  619   * is responsible for deboosting, which it does via rt_mutex_unlock().
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  620   * Unfortunately, this function acquires the scheduler's runqueue and
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  621   * priority-inheritance spinlocks.  This means that deadlock could result
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  622   * if the caller of rcu_read_unlock() already holds one of these locks or
> ec84b27f9b3b56 Anna-Maria Gleixner 2018-05-25  623   * any lock that is ever acquired while holding them.
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  624   *
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  625   * That said, RCU readers are never priority boosted unless they were
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  626   * preempted.  Therefore, one way to avoid deadlock is to make sure
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  627   * that preemption never happens within any RCU read-side critical
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  628   * section whose outermost rcu_read_unlock() is called with one of
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  629   * rt_mutex_unlock()'s locks held.  Such preemption can be avoided in
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  630   * a number of ways, for example, by invoking preempt_disable() before
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  631   * critical section's outermost rcu_read_lock().
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  632   *
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  633   * Given that the set of locks acquired by rt_mutex_unlock() might change
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  634   * at any time, a somewhat more future-proofed approach is to make sure
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  635   * that that preemption never happens within any RCU read-side critical
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  636   * section whose outermost rcu_read_unlock() is called with irqs disabled.
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  637   * This approach relies on the fact that rt_mutex_unlock() currently only
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  638   * acquires irq-disabled locks.
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  639   *
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  640   * The second of these two approaches is best in most situations,
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  641   * however, the first approach can also be useful, at least to those
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  642   * developers willing to keep abreast of the set of locks acquired by
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  643   * rt_mutex_unlock().
> f27bc4873fa8b7 Paul E. McKenney    2014-05-04  644   *
> 3d76c082907e8f Paul E. McKenney    2009-09-28  645   * See rcu_read_lock() for more information.
> 3d76c082907e8f Paul E. McKenney    2009-09-28  646   */
> bc33f24bdca8b6 Paul E. McKenney    2009-08-22  647  static inline void rcu_read_unlock(void)
> bc33f24bdca8b6 Paul E. McKenney    2009-08-22  648  {
> f78f5b90c4ffa5 Paul E. McKenney    2015-06-18  649      RCU_LOCKDEP_WARN(!rcu_is_watching(),
> bde23c6892878e Heiko Carstens      2012-02-01  650                       "rcu_read_unlock() used illegally while idle");
> bc33f24bdca8b6 Paul E. McKenney    2009-08-22 @651      __release(RCU);
> bc33f24bdca8b6 Paul E. McKenney    2009-08-22  652      __rcu_read_unlock();
> d24209bb689e2c Paul E. McKenney    2015-01-21  653      rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
> bc33f24bdca8b6 Paul E. McKenney    2009-08-22  654  }
> ^1da177e4c3f41 Linus Torvalds      2005-04-16  655
>
> :::::: The code at line 651 was first introduced by commit
> :::::: bc33f24bdca8b6e97376e3a182ab69e6cdefa989 rcu: Consolidate sparse and lockdep declarations in include/linux/rcupdate.h
>
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/201911051950.7sv6Mqoe%25lkp%40intel.com.
