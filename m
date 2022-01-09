Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62D488791
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 04:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiAID1c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 22:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiAID1a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 22:27:30 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C2C06173F;
        Sat,  8 Jan 2022 19:27:30 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6Ore-000goT-Ga; Sun, 09 Jan 2022 03:27:26 +0000
Date:   Sun, 9 Jan 2022 03:27:26 +0000
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
Subject: Re: [PATCH 06/10] exit: Implement kthread_exit
Message-ID: <YdpWHgJBwEF/21hR@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-6-ebiederm@xmission.com>
 <YdelKq9U86/dHPcm@zeniv-ca.linux.org.uk>
 <87mtk6xegz.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtk6xegz.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 08, 2022 at 12:35:40PM -0600, Eric W. Biederman wrote:

> There are kernel threads started by modules that do:
> 	complete(...);
>         return 0;
> 
> That should be at a minimum calling complete_and_exit.  Possibly should
> be restructured to use kthread_stop().
> 
> Some of those users of the now removed thread_exit() in staging are
> among the offenders.
> 
> However thread_exit() was implemented as:
> 	#define thread_exit() complete_and_exit(NULL, 0)
> 
> Which does nothing with a completion, it was just a really funny way to
> spell "do_exit(0)".

Yes.  And there's a plenty of cargo-culting in that area.
 
> While I agree digging through all of the kernel threads and finding the
> ones that should be calling complete_and_exit is a fine idea.  It is
> a concern independent of these patches.

BTW, could somebody explain how could this
/*
 * Prevent the kthread exits directly, and make sure when kthread_stop()
 * is called to stop a kthread, it is still alive. If a kthread might be
 * stopped by CACHE_SET_IO_DISABLE bit set, wait_for_kthread_stop() is
 * necessary before the kthread returns.
 */
static inline void wait_for_kthread_stop(void)
{ 
        while (!kthread_should_stop()) {
                set_current_state(TASK_INTERRUPTIBLE);
                schedule();
        }
} 

in drivers/md/bcache/bcache.h possibly avoid losing wakeups?

AFAICS, it can be called while in TASK_RUNNING.  Suppose kthread_stop()
gets called just after the check for kthread_should_stop().  Our thread
is still in TASK_RUNNING; kthread_stop() sets the flag for the next
kthread_should_stop() to observe and does wake_up_process() to our
thread.  Which does nothing.  Now our thread goes into TASK_INTERRUPTIBLE
and calls schedule().  Sure, as soon as it gets woken up it'll call
kthread_should_stop(), get true from it and that's it.  What's going
to wake it up, though?

The same goes for e.g. fs/btrfs/disk-io.c:cleaner_kthread():
                if (kthread_should_stop())
                        return 0;
                if (!again) {
                        set_current_state(TASK_INTERRUPTIBLE);
                        schedule();
                        __set_current_state(TASK_RUNNING);
                }
can't be right.  Similar fun exists in e.g. fs/jfs, etc.

Am I missing something?
