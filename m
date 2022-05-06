Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621951E172
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444600AbiEFV7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388588AbiEFV73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 17:59:29 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106BCFD2E;
        Fri,  6 May 2022 14:55:45 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:51392)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn5vI-002qGu-RE; Fri, 06 May 2022 15:55:40 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37284 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn5vH-009fTk-Lj; Fri, 06 May 2022 15:55:40 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-arch@vger.kernel.org, kbuild-all@lists.01.org,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220506141512.516114-2-ebiederm@xmission.com>
        <202205070451.wstjDYm7-lkp@intel.com>
Date:   Fri, 06 May 2022 16:52:14 -0500
In-Reply-To: <202205070451.wstjDYm7-lkp@intel.com> (kernel test robot's
        message of "Sat, 7 May 2022 04:38:03 +0800")
Message-ID: <87r156z5v5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nn5vH-009fTk-Lj;;;mid=<87r156z5v5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18wpx3bMD1y5ayFn901iqPauFSXlIozA08=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;kernel test robot <lkp@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 597 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (2.2%), b_tie_ro: 12 (1.9%), parse: 1.14
        (0.2%), extract_message_metadata: 31 (5.1%), get_uri_detail_list: 2.9
        (0.5%), tests_pri_-1000: 24 (4.0%), tests_pri_-950: 1.61 (0.3%),
        tests_pri_-900: 1.21 (0.2%), tests_pri_-90: 190 (31.9%), check_bayes:
        171 (28.7%), b_tokenize: 11 (1.8%), b_tok_get_all: 13 (2.1%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 139 (23.3%), b_finish: 1.29
        (0.2%), tests_pri_0: 319 (53.4%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 6 (0.9%), poll_dns_idle: 0.28 (0.0%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/7] fork: Pass struct kernel_clone_args into copy_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi "Eric,
>
> Thank you for the patch! Yet something to improve:

Fixed in my tree now.  Thank you.

Eric

>
> [auto build test ERROR on deller-parisc/for-next]
> [also build test ERROR on linus/master v5.18-rc5]
> [cannot apply to tip/x86/core next-20220506]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-W-Biederman/kthread-Don-t-allocate-kthread_struct-for-init-and-umh/20220506-221832
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
> config: h8300-randconfig-r025-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070451.wstjDYm7-lkp@intel.com/config)
> compiler: h8300-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/22689080e2beece6919f918620e4c780cf7320eb
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Eric-W-Biederman/kthread-Don-t-allocate-kthread_struct-for-init-and-umh/20220506-221832
>         git checkout 22689080e2beece6919f918620e4c780cf7320eb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/h8300/kernel/process.c:58:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
>       58 | void arch_cpu_idle(void)
>          |      ^~~~~~~~~~~~~
>>> arch/h8300/kernel/process.c:108:46: error: unknown type name 'kernel_cloen_args'
>      108 | int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
>          |                                              ^~~~~~~~~~~~~~~~~
>>> arch/h8300/kernel/process.c:108:5: error: conflicting types for 'copy_thread'; have 'int(struct task_struct *, const int *)'
>      108 | int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
>          |     ^~~~~~~~~~~
>    In file included from arch/h8300/kernel/process.c:30:
>    include/linux/sched/task.h:71:12: note: previous declaration of 'copy_thread' with type 'int(struct task_struct *, const struct kernel_clone_args *)'
>       71 | extern int copy_thread(struct task_struct *, const struct kernel_clone_args *);
>          |            ^~~~~~~~~~~
>    arch/h8300/kernel/process.c: In function 'copy_thread':
>>> arch/h8300/kernel/process.c:110:33: error: request for member 'stack' in something not a structure or union
>      110 |         unsigned long usp = args->stack;
>          |                                 ^~
>    arch/h8300/kernel/process.c:111:36: error: request for member 'stack_size' in something not a structure or union
>      111 |         unsigned long topstk = args->stack_size;
>          |                                    ^~
>    arch/h8300/kernel/process.c: At top level:
>    arch/h8300/kernel/process.c:153:16: warning: no previous prototype for 'sys_clone' [-Wmissing-prototypes]
>      153 | asmlinkage int sys_clone(unsigned long __user *args)
>          |                ^~~~~~~~~
>
>
> vim +/kernel_cloen_args +108 arch/h8300/kernel/process.c
>
>    107	
>  > 108	int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
>    109	{
>  > 110		unsigned long usp = args->stack;
>    111		unsigned long topstk = args->stack_size;
>    112		struct pt_regs *childregs;
>    113	
>    114		childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
>    115	
>    116		if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
>    117			memset(childregs, 0, sizeof(struct pt_regs));
>    118			childregs->retpc = (unsigned long) ret_from_kernel_thread;
>    119			childregs->er4 = topstk; /* arg */
>    120			childregs->er5 = usp; /* fn */
>    121		}  else {
>    122			*childregs = *current_pt_regs();
>    123			childregs->er0 = 0;
>    124			childregs->retpc = (unsigned long) ret_from_fork;
>    125			p->thread.usp = usp ?: rdusp();
>    126		}
>    127		p->thread.ksp = (unsigned long)childregs;
>    128	
>    129		return 0;
>    130	}
>    131	
