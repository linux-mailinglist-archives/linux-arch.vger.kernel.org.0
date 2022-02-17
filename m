Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55664BACAF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbiBQWhT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 17:37:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBQWhS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 17:37:18 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D7811B9;
        Thu, 17 Feb 2022 14:36:55 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:48942)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKpOJ-001bK3-23; Thu, 17 Feb 2022 15:36:47 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:32906 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKpOG-00GKIm-Md; Thu, 17 Feb 2022 15:36:46 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        ardb@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
References: <20220216131332.1489939-1-arnd@kernel.org>
        <20220216131332.1489939-19-arnd@kernel.org>
Date:   Thu, 17 Feb 2022 16:36:20 -0600
In-Reply-To: <20220216131332.1489939-19-arnd@kernel.org> (Arnd Bergmann's
        message of "Wed, 16 Feb 2022 14:13:32 +0100")
Message-ID: <8735khi0ij.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nKpOG-00GKIm-Md;;;mid=<8735khi0ij.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/V+0C7NWKuSkdwXmdluwhE5ZIu3hq7L5I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Arnd Bergmann <arnd@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1733 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.27
        (0.1%), extract_message_metadata: 18 (1.0%), get_uri_detail_list: 2.3
        (0.1%), tests_pri_-1000: 25 (1.4%), tests_pri_-950: 1.37 (0.1%),
        tests_pri_-900: 1.22 (0.1%), tests_pri_-90: 280 (16.2%), check_bayes:
        278 (16.0%), b_tokenize: 12 (0.7%), b_tok_get_all: 173 (10.0%),
        b_comp_prob: 2.8 (0.2%), b_tok_touch_all: 86 (5.0%), b_finish: 0.97
        (0.1%), tests_pri_0: 1377 (79.4%), check_dkim_signature: 0.66 (0.0%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 0.47 (0.0%), tests_pri_10:
        3.3 (0.2%), tests_pri_500: 10 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> There are no remaining callers of set_fs(), so CONFIG_SET_FS
> can be removed globally, along with the thread_info field and
> any references to it.
>
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
>
> With CONFIG_SET_FS gone, so drop all remaining references to
> set_fs()/get_fs(), mm_segment_t and uaccess_kernel().

For the bits I have looked at recently, and think I understand.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/exec.c                                 |  6 --
>  kernel/exit.c                             | 14 -----
>  kernel/kthread.c                          |  5 --
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..bc68a0c089ac 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1303,12 +1303,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out_unlock;
>  
> -	/*
> -	 * Ensure that the uaccess routines can actually operate on userspace
> -	 * pointers:
> -	 */
> -	force_uaccess_begin();
> -
>  	if (me->flags & PF_KTHREAD)
>  		free_kthread_struct(me);
>  	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
> diff --git a/kernel/exit.c b/kernel/exit.c
> index b00a25bb4ab9..0884a75bc2f8 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -737,20 +737,6 @@ void __noreturn do_exit(long code)
>  
>  	WARN_ON(blk_needs_flush_plug(tsk));
>  
> -	/*
> -	 * If do_dead is called because this processes oopsed, it's possible
> -	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
> -	 * continuing. Amongst other possible reasons, this is to prevent
> -	 * mm_release()->clear_child_tid() from writing to a user-controlled
> -	 * kernel address.
> -	 *
> -	 * On uptodate architectures force_uaccess_begin is a noop.  On
> -	 * architectures that still have set_fs/get_fs in addition to handling
> -	 * oopses handles kernel threads that run as set_fs(KERNEL_DS) by
> -	 * default.
> -	 */
> -	force_uaccess_begin();
> -
>  	kcov_task_exit(tsk);
>  
>  	coredump_task_exit(tsk);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 38c6dd822da8..16c2275d4b50 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -55,7 +55,6 @@ struct kthread {
>  	int result;
>  	int (*threadfn)(void *);
>  	void *data;
> -	mm_segment_t oldfs;
>  	struct completion parked;
>  	struct completion exited;
>  #ifdef CONFIG_BLK_CGROUP
> @@ -1441,8 +1440,6 @@ void kthread_use_mm(struct mm_struct *mm)
>  		mmdrop(active_mm);
>  	else
>  		smp_mb();
> -
> -	to_kthread(tsk)->oldfs = force_uaccess_begin();
>  }
>  EXPORT_SYMBOL_GPL(kthread_use_mm);
>  
> @@ -1457,8 +1454,6 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
>  	WARN_ON_ONCE(!tsk->mm);
>  
> -	force_uaccess_end(to_kthread(tsk)->oldfs);
> -
>  	task_lock(tsk);
>  	/*
>  	 * When a kthread stops operating on an address space, the loop
