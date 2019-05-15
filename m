Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA921F758
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfEOPTX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 11:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26961 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfEOPTW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 May 2019 11:19:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1942D301A3E1;
        Wed, 15 May 2019 15:19:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC9925D9C0;
        Wed, 15 May 2019 15:19:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 15 May 2019 17:19:19 +0200 (CEST)
Date:   Wed, 15 May 2019 17:19:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
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
Message-ID: <20190515151912.GE18892@redhat.com>
References: <20190515100400.3450-1-christian@brauner.io>
 <20190515143857.GB18892@redhat.com>
 <20190515144927.f2yxyi6w6lhn3xx7@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515144927.f2yxyi6w6lhn3xx7@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 15 May 2019 15:19:22 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/15, Christian Brauner wrote:
>
> On Wed, May 15, 2019 at 04:38:58PM +0200, Oleg Nesterov wrote:
> >
> > it seems that you can do a single check
> >
> > 	tsk = pid_task(p, PIDTYPE_TGID);
> > 	if (!tsk)
> > 		ret = -ESRCH;
> >
> > this even looks more correct if we race with exec changing the leader.
>
> The logic here being that you can only reach the thread_group leader
> from struct pid if PIDTYPE_PID == PIDTYPE_TGID for this struct pid?

Not exactly... it is not that PIDTYPE_PID == PIDTYPE_TGID for this pid,
struct pid has no "type" or something like this.

The logic is that pid->tasks[PIDTYPE_XXX] is the list of task which use
this pid as "XXX" type.

For example, clone(CLONE_THREAD) creates a pid which has a single non-
empty list, pid->tasks[PIDTYPE_PID]. This pid can't be used as TGID or
SID.

So if pid_task(PIDTYPE_TGID) returns non-NULL we know that this pid was
used for a group-leader, see copy_process() which does

	if (thread_group_leader(p))
		attach_pid(p, PIDTYPE_TGID);


If we race with exec which changes the leader pid_task(TGID) can return
the old leader. We do not care, but this means that we should not check
thread_group_leader().

Oleg.

