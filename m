Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B3484DDA
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 06:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiAEF6k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 00:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiAEF6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 00:58:40 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05720C061761;
        Tue,  4 Jan 2022 21:58:39 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4zJm-00HOGU-6X; Wed, 05 Jan 2022 05:58:38 +0000
Date:   Wed, 5 Jan 2022 05:58:38 +0000
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
Subject: Re: [PATCH 04/10] exit: Stop poorly open coding do_task_dead in
 make_task_dead
Message-ID: <YdUzjrLAlRiNLQp2@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-4-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:26PM -0600, Eric W. Biederman wrote:
> When the kernel detects it is oops or otherwise force killing a task
> while it exits the code poorly attempts to permanently stop the task
> from scheduling.
> 
> I say poorly because it is possible for a task in TASK_UINTERRUPTIBLE
> to be woken up.
> 
> As it makes no sense for the task to continue call do_task_dead
> instead which actually does the work and permanently removes the task
> from the scheduler.  Guaranteeing the task will never be woken
> up again.

NAK.  This is not all do_task_dead() leads to - see what finish_task_switch()
does upon seeing TASK_DEAD:
                /* Task is done with its stack. */
		put_task_stack(prev);
		put_task_struct_rcu_user(prev);


Now take a look at the comment just before that check for PF_EXITING -
the point is to leave the task leaked, rather than proceeding with
freeing the sucker.

We are not going through the normal "turn zombie" motions, including
waking wait(2) callers up, etc.  Going ahead and freeing it could
fuck the things up quite badly.

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/exit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index d0ec6f6b41cb..f975cd8a2ed8 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -886,8 +886,7 @@ void __noreturn make_task_dead(int signr)
>  	if (unlikely(tsk->flags & PF_EXITING)) {
>  		pr_alert("Fixing recursive fault but reboot is needed!\n");
>  		futex_exit_recursive(tsk);
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule();
> +		do_task_dead();
>  	}
>  
>  	do_exit(signr);
> -- 
> 2.29.2
> 
