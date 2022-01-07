Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664C48712D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 04:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbiAGDWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 22:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344897AbiAGDWQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 22:22:16 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45DC061245;
        Thu,  6 Jan 2022 19:22:16 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5fpW-000Fy5-3j; Fri, 07 Jan 2022 03:22:14 +0000
Date:   Fri, 7 Jan 2022 03:22:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 10/10] exit/kthread: Move the exit code for kernel
 threads into struct kthread
Message-ID: <Ydex5jwYyVsmIt3w@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-10-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:32PM -0600, Eric W. Biederman wrote:
> The exit code of kernel threads has different semantics than the
> exit_code of userspace tasks.  To avoid confusion and allow
> the userspace implementation to change as needed move
> the kernel thread exit code into struct kthread.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/kthread.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 8e5f44bed027..9c6c532047c4 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -52,6 +52,7 @@ struct kthread_create_info
>  struct kthread {
>  	unsigned long flags;
>  	unsigned int cpu;
> +	int result;
>  	int (*threadfn)(void *);
>  	void *data;
>  	mm_segment_t oldfs;
> @@ -287,7 +288,9 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
>   */
>  void __noreturn kthread_exit(long result)
>  {
> -	do_exit(result);
> +	struct kthread *kthread = to_kthread(current);
> +	kthread->result = result;
> +	do_exit(0);
>  }
>  
>  /**
> @@ -679,7 +682,7 @@ int kthread_stop(struct task_struct *k)
>  	kthread_unpark(k);
>  	wake_up_process(k);
>  	wait_for_completion(&kthread->exited);
> -	ret = k->exit_code;
> +	ret = kthread->result;
>  	put_task_struct(k);
>  
>  	trace_sched_kthread_stop_ret(ret);

Fine, except that you've turned the first two do_exit() in kthread() into
calls of kthread_exit().  If they are hit, you are screwed, especially
the second one - there you have an allocation failure for struct kthread,
so this will instantly oops on attempt to store into ->result.

See reply to your 6/10 regarding the difference between the last
call of do_exit() in kthread() and the first two of them.  They
(the first two) should be simply do_exit(0); transmission of error
value happens differently and not in direction of kthread_stop().
