Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F383B1F77A
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfEOPae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 11:30:34 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:38534 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOPad (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 May 2019 11:30:33 -0400
Received: from [2a01:e35:39f2:1220:2452:dd6c:fe2f:be2c] (helo=opteyam2)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hQvqH-0005C0-ER; Wed, 15 May 2019 17:29:17 +0200
Message-ID: <7afb23699142a3a15f06afde43506458a58614a6.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Christian Brauner <christian@brauner.io>
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
Date:   Wed, 15 May 2019 17:29:16 +0200
In-Reply-To: <20190515141634.lrc5ynllcmjr64mn@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
         <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
         <20190515141634.lrc5ynllcmjr64mn@brauner.io>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:2452:dd6c:fe2f:be2c
X-SA-Exim-Mail-From: ydroneaud@opteya.com
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ou.quest-ce.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham version=3.3.2
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Le mercredi 15 mai 2019 à 16:16 +0200, Christian Brauner a écrit :
> On Wed, May 15, 2019 at 04:00:20PM +0200, Yann Droneaud wrote:
> > Le mercredi 15 mai 2019 à 12:03 +0200, Christian Brauner a écrit :
> > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > index 20881598bdfa..237d18d6ecb8 100644
> > > --- a/kernel/pid.c
> > > +++ b/kernel/pid.c
> > > @@ -451,6 +452,53 @@ struct pid *find_ge_pid(int nr, struct
> > > pid_namespace *ns)
> > >  	return idr_get_next(&ns->idr, &nr);
> > >  }
> > >  
> > > +/**
> > > + * pidfd_open() - Open new pid file descriptor.
> > > + *
> > > + * @pid:   pid for which to retrieve a pidfd
> > > + * @flags: flags to pass
> > > + *
> > > + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> > > + * the process identified by @pid. Currently, the process identified by
> > > + * @pid must be a thread-group leader. This restriction currently exists
> > > + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> > > + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> > > + * leaders).
> > > + *
> > 
> > Would it be possible to create file descriptor with "restricted"
> > operation ?
> > 
> > - O_RDONLY: waiting for process completion allowed (for example)
> > - O_WRONLY: sending process signal allowed
> 
> Yes, something like this is likely going to be possible in the future.
> We had discussion around this. But mapping this to O_RDONLY and O_WRONLY
> is not the right model. It makes more sense to have specialized flags
> that restrict actions.

Yes, dedicated flags are the way to go. I've used the old open() flags
here as examples as an echo of the O_CLOEXEC flag used in the comment.

> > For example, a process could send over a Unix socket a process a pidfd,
> > allowing this to only wait for completion, but not sending signal ?
> > 
> > I see the permission check is not done in pidfd_open(), so what prevent
> > a user from sending a signal to another user owned process ?
> 
> That's supposed to be possible. You can do the same right now already
> with pids. Tools like LMK need this probably very much.
> Permission checking for signals is done at send time right now.
> And if you can't signal via a pid you can't signal via a pidfd as
> they're both subject to the same permissions checks.
> 

I would have expect it to behave like most other file descriptor,
permission check done at opening time, which allow more privileged
process to open the file descriptor, then pass it to a less privileged
process, or change its own privileged with setuid() and such. Then the
less privileged process can act on behalf of the privileged process
through the file descriptor.

> > If it's in pidfd_send_signal(), then, passing the socket through
> > SCM_RIGHT won't be useful if the target process is not owned by the
> > same user, or root.
> > 

If the permission check is done at sending time, the scenario above
case cannot be implemented.

Sending a pidfd through SCM_RIGHT is only useful if the receiver
process is equally or more privileged than the sender then.

For isolation purpose, I would have expect to be able to give a right
to send a signal to a highly privileged process a specific less
privileged process though Unix socket.

But I can't come up with a specific use case. So I dunno.

Regards.

-- 
Yann Droneaud
OPTEYA


