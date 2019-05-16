Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08920A72
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfEPO51 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 10:57:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33285 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEPO5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 10:57:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so5768445edb.0
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zu/DFoA8gurZzDl4gRPBRIxRpOpQplODrEJWOL6D0bE=;
        b=N/UXULef7deCmqVDFFuhdRP+EE/HVwi/f8Xw9poIWaOZnQrgvAqVWfNExWGd8BOsJf
         33o1T0+h2MUW+EUGMeLcQHkrt56q01RBA4HuUCpP1HhL+qbKYrx8/hsh8yLGkBvmD49R
         8+PbTDBAKauvYkDZWTDJ6HTdkLHobcXK0IWVXwUdxsfwEzukIgCacfL1mkKlnh4BufAE
         cmndL7Y+bK4GfjQMr6DNIgpxClV5ziCpFELiCjoMMwn4lPnJkr6DjWQm5xrMWvDy9MoN
         9Tz8wKlpHlaRJ+TCJu0UoV0aK7s1NnsOhDY4lT/AMXF5dPM+Twab8dYUty/tvzJmCNb5
         QTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zu/DFoA8gurZzDl4gRPBRIxRpOpQplODrEJWOL6D0bE=;
        b=QTU1QZko69JGf3Jr3Cvh9b34+fXkLKPGKPVDkgkiDkTjQSPcMRIfpPxQnJJ4cAvp2s
         YOd8Zm4PgVkDGiaFETC2YNX6ybafJMR3KKeeXsYVUDPLhvIwdmWSNs1MYtnENOIZPSw6
         BiYw0HjYKKypEZYu9QAfuEsFiwVwPrC+GluSF/3WkQKrdKhnqMjS4R7R8U2oG6FtV2s1
         KVkHEX2Ne0K4XXgZ7adUnTkr2dYQlC5knU75njAGsdxB1WJ7R2VHP2euR7f4lezwvu5a
         inLoJODSyayBpHBGfkC1bAG1NqF/9NJ183SpwnNaugz17q7R00WufTYrohBslSNeAghH
         zimg==
X-Gm-Message-State: APjAAAU6ESAvIP4H8nBU1SCS92UsdBY6ZmyxhcFj1ol8RgZC195YELaU
        irzr3EcgDA4SKlVlo1CNBYtEyA==
X-Google-Smtp-Source: APXvYqwezzg+v8pMXQltznYwK70iO/BCmxK3JFRnM2IhYSWFpsND0L8cwVVVFYHGIM+owfjxdC4+8Q==
X-Received: by 2002:aa7:c483:: with SMTP id m3mr21927311edq.161.1558018640584;
        Thu, 16 May 2019 07:57:20 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id u11sm1122263ejr.48.2019.05.16.07.57.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 07:57:20 -0700 (PDT)
Date:   Thu, 16 May 2019 16:57:17 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, cyphar@cyphar.com,
        dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joel@joelfernandes.org, dancol@google.com, serge@hallyn.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516145716.ool2pzdqbfclnnqi@brauner.io>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516142659.GB22564@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 16, 2019 at 04:27:00PM +0200, Oleg Nesterov wrote:
> On 05/16, Christian Brauner wrote:
> >
> > With the introduction of pidfds through CLONE_PIDFD it is possible to
> > created pidfds at process creation time.
> 
> Now I am wondering why do we need CLONE_PIDFD, you can just do
> 
> 	pid = fork();
> 	pidfd_open(pid);

CLONE_PIDFD eliminates the race at the source and let's us avoid two
syscalls for the sake of one. That'll obviously matter even more when we
enable CLONE_THREAD | CLONE_PIDFD.
pidfd_open() is really just a necessity for anyone who does non-parent
process management aka LMK or service managers.
I also would like to reserve the ability at some point (e.g. with cloneX
or sm) to be able to specify specific additional flags at process
creation time that modify pidfd behavior.

> 
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
> > +	if (!tsk)
> > +		ret = -ESRCH;
> > +	rcu_read_unlock();
> > +
> > +	fd = ret ?: pidfd_create(p);
> > +	put_pid(p);
> > +	return fd;
> > +}
> 
> Looks correct, feel free to add Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> But why do we need task_struct *tsk?
> 
> 	rcu_read_lock();
> 	if (!pid_task(PIDTYPE_TGID))
> 		ret = -ESRCH;
> 	rcu_read_unlock();

Sure, that's simpler. I'll rework and add your Reviewed-by.

> 
> and in fact we do not even need rcu_read_lock(), we could do
> 
> 	// shut up rcu_dereference_check()
> 	rcu_lock_acquire(&rcu_lock_map);
> 	if (!pid_task(PIDTYPE_TGID))
> 		ret = -ESRCH;
> 	rcu_lock_release(&rcu_lock_map);
> 
> Well... I won't insist, but the comment about the race with exec looks a bit
> confusing to me. It is true, but we do not care at all, we are not going to
> use the task_struct returned by pid_task().

Yeah, I can remove it.

Thanks!
Christian
