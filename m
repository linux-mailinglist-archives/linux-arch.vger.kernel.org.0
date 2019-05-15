Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78D61F657
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfEOOQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 10:16:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45893 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfEOOQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 10:16:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so4288615edc.12
        for <linux-arch@vger.kernel.org>; Wed, 15 May 2019 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5teuJo4XSRrnL6XxnC+QODipuz2WCzByYGo45sEdpQE=;
        b=gAJyzptkeah2CnPVHf8ki6Ey+Aje7kt4hiLFQY/UoXftAeb5KMt9kDcge1dL70700f
         v4lzCF24qKMgoDDJqK48PCIsuOAEIEWh56QloYL0Zx1Ytcl8wEHGZj2FHlHTDjeh1xHN
         qgtG9Lh2tYpVWiUdw1UsD0iGHta3lP4Ta8QIkzIE14Ud+jGfSqHpCDEAvWIr2Z7unvQT
         7zkggOJrHmZj/c4eERJMnDK2ju7392d0B+Atitgv36pLJz4hMjFGB1lnPt+6SoqUGyah
         IPYOEdYPIgWXRHQq6puWtz6SFEJeqqmkoJuWNHfimIVIYgR96+2ydELKuFEvw/jF51Hq
         +B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5teuJo4XSRrnL6XxnC+QODipuz2WCzByYGo45sEdpQE=;
        b=gOMFOdTjjmtLOshBwfjLf8gLJUwHezaKKELM1n1Gk/W50HkaRLXXDUOG1Mth4RDU4c
         FduqMtHMbGF+4hWQ8VFRI9euDNPr/KJGRMnW30OTLtZ/ocY7kqR3AKqhRZ/+cwvomk/s
         8US6DWtMDzM9eOB5VJolnmQZ3dANnSQ66uz7MTFS7mopziHmLN8As6t3XHnbC37odQAK
         ZqoVRAZhmEKJauI6x6ep4wWwDZnUJEX5PojtsW3s4RxoeKcTb5gYIeqsHoBMZojnqI+d
         XjO/YIX5HdIsNOrZflzSR2S2fLs6IfqwLuMglXaODm/Pksy+bF0z4TjHb4x/921bhgnB
         /Pfg==
X-Gm-Message-State: APjAAAX+yTBSANooZJYg6WUUUhPWAoKhFpF3lXqe7tKg/VDi80eSaA4T
        s6Y1GURMYJHSy1lP5KyLYRo/Ww==
X-Google-Smtp-Source: APXvYqz/5w9Bko49z66nfUW8rJGtWbKGmV1irTYSDrNlaxrZSh+Ve4PPN0bCyixGXoTczpolwiOJ2g==
X-Received: by 2002:a50:8bbb:: with SMTP id m56mr44288042edm.230.1557929797459;
        Wed, 15 May 2019 07:16:37 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id h13sm493114ejs.3.2019.05.15.07.16.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 07:16:36 -0700 (PDT)
Date:   Wed, 15 May 2019 16:16:35 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515141634.lrc5ynllcmjr64mn@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 15, 2019 at 04:00:20PM +0200, Yann Droneaud wrote:
> Hi,
> 
> Le mercredi 15 mai 2019 à 12:03 +0200, Christian Brauner a écrit :
> > 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..237d18d6ecb8 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -451,6 +452,53 @@ struct pid *find_ge_pid(int nr, struct
> > pid_namespace *ns)
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
> 
> Would it be possible to create file descriptor with "restricted"
> operation ?
> 
> - O_RDONLY: waiting for process completion allowed (for example)
> - O_WRONLY: sending process signal allowed

Yes, something like this is likely going to be possible in the future.
We had discussion around this. But mapping this to O_RDONLY and O_WRONLY
is not the right model. It makes more sense to have specialized flags
that restrict actions.

> 
> For example, a process could send over a Unix socket a process a pidfd,
> allowing this to only wait for completion, but not sending signal ?
> 
> I see the permission check is not done in pidfd_open(), so what prevent
> a user from sending a signal to another user owned process ?

That's supposed to be possible. You can do the same right now already
with pids. Tools like LMK need this probably very much.
Permission checking for signals is done at send time right now.
And if you can't signal via a pid you can't signal via a pidfd as
they're both subject to the same permissions checks.

> 
> If it's in pidfd_send_signal(), then, passing the socket through
> SCM_RIGHT won't be useful if the target process is not owned by the
> same user, or root.
> 
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
> > +	rcu_read_lock();
> > +	tsk = pid_task(p, PIDTYPE_PID);
> > +	if (!tsk)
> > +		ret = -ESRCH;
> > +	else if (unlikely(!thread_group_leader(tsk)))
> > +		ret = -EINVAL;
> > +	else
> > +		ret = 0;
> > +	rcu_read_unlock();
> > +
> > +	fd = ret ?: pidfd_create(p);
> > +	put_pid(p);
> > +	return fd;
> > +}
> > +
> >  void __init pid_idr_init(void)
> >  {
> >  	/* Verify no one has done anything silly: */
> 
> Regards.
> 
> -- 
> Yann Droneaud
> OPTEYA
> 
> 
