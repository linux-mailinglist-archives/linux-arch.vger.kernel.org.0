Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5294EE510
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfKDQrV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 11:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfKDQrV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 11:47:21 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.216.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205412084D;
        Mon,  4 Nov 2019 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572886039;
        bh=P8jnNo+i4H38L/cwZHxznFW/uN8TNkWtycod/9FL4LI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RBlzKtfO650PQaV+Dl6ECp9IKh1IPdCfolPKAv19KzdV3bb/uJaz8PWgrWIohjr/q
         4EV12HcH2BYB5knlovAayLHV9pEqRjAUwcHH4V0pT5x6pA0oMiTc7KhcIbw434otHQ
         +PFkDAIZPT8tn23yeK+yqSfJw4vRucQvKIurCBNg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3F5003520B56; Mon,  4 Nov 2019 08:47:17 -0800 (PST)
Date:   Mon, 4 Nov 2019 08:47:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 0/9] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191104164717.GE20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191104142745.14722-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104142745.14722-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 04, 2019 at 03:27:36PM +0100, Marco Elver wrote:
> This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> KCSAN is a sampling watchpoint-based data-race detector. More details
> are included in Documentation/dev-tools/kcsan.rst. This patch-series
> only enables KCSAN for x86, but we expect adding support for other
> architectures is relatively straightforward (we are aware of
> experimental ARM64 and POWER support).
> 
> To gather early feedback, we announced KCSAN back in September, and
> have integrated the feedback where possible:
> http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> 
> We want to point out and acknowledge the work surrounding the LKMM,
> including several articles that motivate why data-races are dangerous
> [1, 2], justifying a data-race detector such as KCSAN.
> [1] https://lwn.net/Articles/793253/
> [2] https://lwn.net/Articles/799218/
> 
> The current list of known upstream fixes for data-races found by KCSAN
> can be found here:
> https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan

Making this more accessible to more people seems like a good thing.
So, for the series:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Changelog
> ---------
> v3:
> * Major changes:
>  - Add microbenchmark.
>  - Add instruction watchpoint skip randomization.
>  - Refactor API and core runtime fast-path and slow-path. Compared to
>    the previous version, with a default config and benchmarked using the
>    added microbenchmark, this version is 3.8x faster.
>  - Make __tsan_unaligned __alias of generic accesses.
>  - Rename kcsan_{begin,end}_atomic ->
>    kcsan_{nestable,flat}_atomic_{begin,end}
>  - For filter list in debugfs.c use kmalloc+krealloc instead of
>    kvmalloc.
>  - Split Documentation into separate patch.
> 
> v2: http://lkml.kernel.org/r/20191017141305.146193-1-elver@google.com
> * Major changes:
>  - Replace kcsan_check_access(.., {true, false}) with
>    kcsan_check_{read,write}.
>  - Change atomic-instrumented.h to use __atomic_check_{read,write}.
>  - Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
>    contexts.
> 
> v1: http://lkml.kernel.org/r/20191016083959.186860-1-elver@google.com
> 
> Marco Elver (9):
>   kcsan: Add Kernel Concurrency Sanitizer infrastructure
>   kcsan: Add Documentation entry in dev-tools
>   objtool, kcsan: Add KCSAN runtime functions to whitelist
>   build, kcsan: Add KCSAN build exceptions
>   seqlock, kcsan: Add annotations for KCSAN
>   seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
>   asm-generic, kcsan: Add KCSAN instrumentation for bitops
>   locking/atomics, kcsan: Add KCSAN instrumentation
>   x86, kcsan: Enable KCSAN for x86
> 
>  Documentation/dev-tools/index.rst         |   1 +
>  Documentation/dev-tools/kcsan.rst         | 217 +++++++++
>  MAINTAINERS                               |  11 +
>  Makefile                                  |   3 +-
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/boot/Makefile                    |   2 +
>  arch/x86/boot/compressed/Makefile         |   2 +
>  arch/x86/entry/vdso/Makefile              |   3 +
>  arch/x86/include/asm/bitops.h             |   6 +-
>  arch/x86/kernel/Makefile                  |   7 +
>  arch/x86/kernel/cpu/Makefile              |   3 +
>  arch/x86/lib/Makefile                     |   4 +
>  arch/x86/mm/Makefile                      |   3 +
>  arch/x86/purgatory/Makefile               |   2 +
>  arch/x86/realmode/Makefile                |   3 +
>  arch/x86/realmode/rm/Makefile             |   3 +
>  drivers/firmware/efi/libstub/Makefile     |   2 +
>  include/asm-generic/atomic-instrumented.h | 393 +++++++--------
>  include/asm-generic/bitops-instrumented.h |  18 +
>  include/linux/compiler-clang.h            |   9 +
>  include/linux/compiler-gcc.h              |   7 +
>  include/linux/compiler.h                  |  35 +-
>  include/linux/kcsan-checks.h              |  97 ++++
>  include/linux/kcsan.h                     | 115 +++++
>  include/linux/sched.h                     |   4 +
>  include/linux/seqlock.h                   |  51 +-
>  init/init_task.c                          |   8 +
>  init/main.c                               |   2 +
>  kernel/Makefile                           |   6 +
>  kernel/kcsan/Makefile                     |  11 +
>  kernel/kcsan/atomic.h                     |  27 ++
>  kernel/kcsan/core.c                       | 560 ++++++++++++++++++++++
>  kernel/kcsan/debugfs.c                    | 275 +++++++++++
>  kernel/kcsan/encoding.h                   |  94 ++++
>  kernel/kcsan/kcsan.h                      | 131 +++++
>  kernel/kcsan/report.c                     | 306 ++++++++++++
>  kernel/kcsan/test.c                       | 121 +++++
>  kernel/sched/Makefile                     |   6 +
>  lib/Kconfig.debug                         |   2 +
>  lib/Kconfig.kcsan                         | 119 +++++
>  lib/Makefile                              |   3 +
>  mm/Makefile                               |   8 +
>  scripts/Makefile.kcsan                    |   6 +
>  scripts/Makefile.lib                      |  10 +
>  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
>  tools/objtool/check.c                     |  18 +
>  46 files changed, 2526 insertions(+), 206 deletions(-)
>  create mode 100644 Documentation/dev-tools/kcsan.rst
>  create mode 100644 include/linux/kcsan-checks.h
>  create mode 100644 include/linux/kcsan.h
>  create mode 100644 kernel/kcsan/Makefile
>  create mode 100644 kernel/kcsan/atomic.h
>  create mode 100644 kernel/kcsan/core.c
>  create mode 100644 kernel/kcsan/debugfs.c
>  create mode 100644 kernel/kcsan/encoding.h
>  create mode 100644 kernel/kcsan/kcsan.h
>  create mode 100644 kernel/kcsan/report.c
>  create mode 100644 kernel/kcsan/test.c
>  create mode 100644 lib/Kconfig.kcsan
>  create mode 100644 scripts/Makefile.kcsan
> 
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
