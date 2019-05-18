Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A232230C
	for <lists+linux-arch@lfdr.de>; Sat, 18 May 2019 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbfERKFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 May 2019 06:05:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37509 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfERKFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 May 2019 06:05:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so14726068edw.4
        for <linux-arch@vger.kernel.org>; Sat, 18 May 2019 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kuxvODYNXQX1UADGYTekrXKJHl9GqTdixhHyMJoLFkg=;
        b=MzXf8JwF72gJj2Pq8n12P+UywZxc2BVXTvpiVUKrEniJVb1LIFP3IbcOliQYISdvq7
         CigvtYVzwi+8s8BzhGA7JzeYEAEgELRKSJUGXkBeKo3jIoY+k+AIz1NIGNQ3IbqWFvd/
         pZcoiBfjP1G87UNeXXgpYPrDlzF+SvvAxTS1B9J01RvJsEbVREubCnWtrpwlE+W8uhC8
         abJb2p1WNSljrqCFAQH7at9A4yXrlhg+5ZrhECybT+pFDJTv4XLPhvmKoEIQriQEdsEE
         2qeWRYeIhjWVjN8Omnws0ZotrB2BKKuxhO4+QGekj7Ec6VajrUKLl5oRB10tcR/KFGxb
         SomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kuxvODYNXQX1UADGYTekrXKJHl9GqTdixhHyMJoLFkg=;
        b=Bk/vEyygJevjDvDddQFvOB6DP4o1PR3dgxCuF8i/GqDi6xTxU+wRAig4X0Ymlz7ktQ
         PJiDIhInwN8BywjeZF3rEvNkA6xcmwwxmmsxeu7ah0A1GcJYOT+Rb8LwScyy6ZxFJXgZ
         FzuX9s5k0x7lby92QbhoEe8vfZ/qmMGu5o7SuiuzgURe1o8wuQ6knGQliGu7b+Hp7C19
         byJ48LNleaD9Jy7iea0ELi56NVzCV/gL7GhgRH7Cd1NJjMlEHtz99B7ueJbTiKuhqWoz
         CkL4yiTWvTeHN+ooRS02q+CBQJDqYBjEfgiPbXzJ8JBz4EIzFmI+SijhkV3CxnHfMriF
         fJ2A==
X-Gm-Message-State: APjAAAXvk1RSvy2jqJfidBbZOzM4UjBtY5/ZGXbR/0ZiuhrIfGNYP4iA
        pii1NeYHdBA212feoTu0wvqdmQ==
X-Google-Smtp-Source: APXvYqyJ8cSwup5T+wLOXgE4G1RIJN3Q14FiCUfotn6HCvE35vO+QFm+mQrHo4U4TisKcq8ZEYMBDQ==
X-Received: by 2002:a50:b82d:: with SMTP id j42mr63022736ede.186.1558173905455;
        Sat, 18 May 2019 03:05:05 -0700 (PDT)
Received: from brauner.io ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id y30sm3741910edc.83.2019.05.18.03.04.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 03:05:04 -0700 (PDT)
Date:   Sat, 18 May 2019 12:04:46 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, cyphar@cyphar.com,
        dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.orgg, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        dancol@google.com, serge@hallyn.com, surenb@google.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190518100435.c5bqpcnra53dsr6p@brauner.io>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516224949.GA15401@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516224949.GA15401@localhost>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 18, 2019 at 05:48:03AM -0400, Joel Fernandes wrote:
> Hi Christian,
> 
> For next revision, could you also CC surenb@google.com as well? He is also
> working on the low memory killer. And also suggest CC to
> kernel-team@android.com. And mentioned some comments below, thanks.

Yip, totally. Just added them both to my Cc list. :)
(I saw you added Suren manually. I added the Android kernel team now too.)

> 
> On Thu, May 16, 2019 at 03:59:42PM +0200, Christian Brauner wrote:
> [snip]  
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..4afca3d6dcb8 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/proc_ns.h>
> >  #include <linux/proc_fs.h>
> > +#include <linux/sched/signal.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/idr.h>
> >  
> > @@ -451,6 +452,55 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> >  	return idr_get_next(&ns->idr, &nr);
> >  }
> >  
> > +/**
> > + * pidfd_open() - Open new pid file descriptor.
> > + *
> > + * @pid:   pid for which to retrieve a pidfd
> > + * @flags: flags to pass
> > + *
> > + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> > + * the process identified by @pid. Currently, the process identified by
> > + * @pid must be a thread-group leader. This restriction currently exists
> > + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> > + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> > + * leaders).
> > + *
> > + * Return: On success, a cloexec pidfd is returned.
> > + *         On error, a negative errno number will be returned.
> > + */
> > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > +{
> > +	int fd, ret;
> > +	struct pid *p;
> > +	struct task_struct *tsk;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (pid <= 0)
> > +		return -EINVAL;
> > +
> > +	p = find_get_pid(pid);
> > +	if (!p)
> > +		return -ESRCH;
> > +
> > +	ret = 0;
> > +	rcu_read_lock();
> > +	/*
> > +	 * If this returns non-NULL the pid was used as a thread-group
> > +	 * leader. Note, we race with exec here: If it changes the
> > +	 * thread-group leader we might return the old leader.
> > +	 */
> > +	tsk = pid_task(p, PIDTYPE_TGID);
> 
> Just trying to understand the comment here. The issue is that we might either
> return the new leader, or the old leader depending on the overlap with
> concurrent de_thread right? In either case, we don't care though.
> 
> I suggest to remove the "Note..." part of the comment since it doesn't seem the
> race is relevant here unless we are doing something else with tsk in the
> function, but if you want to keep it that's also fine. Comment text should
> probably should be 'return the new leader' though.

Nah, I actually removed the comment already independently (cf. see [1]).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=pidfd_open&id=dcfc98c2d957bf3ac14b06414cb2cf4c673fc297
> 
> > +	if (!tsk)
> > +		ret = -ESRCH;
> 
> Perhaps -EINVAL?  AFAICS, this can only happen if a CLONE_THREAD pid was
> passed as argument to pidfd_open which is invalid. But let me know what you
> had in mind..

Hm, from the kernel's perspective ESRCH is correct but I guess EINVAL is
nicer for userspace. So I don't have objections to using EINVAL. My
first version did too I think.

Thanks!
Christian
