Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263A420AFB
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfEPPXB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 11:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfEPPXB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 11:23:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6D1B81F0D;
        Thu, 16 May 2019 15:23:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id CF52210027B9;
        Thu, 16 May 2019 15:22:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 May 2019 17:22:59 +0200 (CEST)
Date:   Thu, 16 May 2019 17:22:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian@brauner.io>, jannh@google.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        dancol@google.com, serge@hallyn.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516152252.GD22564@redhat.com>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
 <20190516145607.j43xyj26k6l5vmbd@yavin>
 <20190516150611.GC22564@redhat.com>
 <20190516151202.hrawrx7hxllmz2di@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516151202.hrawrx7hxllmz2di@yavin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 16 May 2019 15:23:01 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/17, Aleksa Sarai wrote:
>
> On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 05/17, Aleksa Sarai wrote:
> > > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > > On 05/16, Christian Brauner wrote:
> > > > > With the introduction of pidfds through CLONE_PIDFD it is possible to
> > > > > created pidfds at process creation time.
> > > >
> > > > Now I am wondering why do we need CLONE_PIDFD, you can just do
> > > >
> > > > 	pid = fork();
> > > > 	pidfd_open(pid);
> > >
> > > While the race window would be exceptionally short, there is the
> > > possibility that the child will die
> >
> > Yes,
> >
> > > and their pid will be recycled
> > > before you do pidfd_open().
> >
> > No.
> >
> > Unless the caller's sub-thread does wait() before pidfd_open(), of course.
> > Or unless you do signal(SIGCHILD, SIG_IGN).
>
> What about CLONE_PARENT?

I should have mentioned CLONE_PARENT ;)

Of course in this case the child can be reaped before pidfd_open(). But how often
do you or other people use clone(CLONE_PARENT) ? not to mention you can trivially
eliminate/detect this race if you really need this.

Don't get me wrong, I am not trying to say that CLONE_PIDFD is a bad idea.

But to me pidfd_open() is much more useful. Say, as a perl programmer I can easily
use pidfd_open(), but not CLONE_PIDFD.

Oleg.

