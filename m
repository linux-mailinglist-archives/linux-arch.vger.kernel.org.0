Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1D484DC6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 06:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiAEFsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 00:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiAEFsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 00:48:10 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1297C061761;
        Tue,  4 Jan 2022 21:48:10 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4z9c-00HOBW-Jy; Wed, 05 Jan 2022 05:48:08 +0000
Date:   Wed, 5 Jan 2022 05:48:08 +0000
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
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
Message-ID: <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-3-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:25PM -0600, Eric W. Biederman wrote:
> The beginning of do_exit has become cluttered and difficult to read as
> it is filled with checks to handle things that can only happen when
> the kernel is operating improperly.
> 
> Now that we have a dedicated function for cleaning up a task when the
> kernel is operating improperly move the checks there.

Umm...  I would probably take profile_task_exit() crap out before that
point.
	1) the damn thing is dead - nothing registers notifiers there
	2) blocking_notifier_call_chain() is not a nice thing to do on oops...

I'll post a patch ripping the dead parts of kernel/profile.c out tomorrow
morning (there's also profile_handoff_task(), equally useless these days
and complicating things for __put_task_struct()).

> -	/*
> -	 * If do_exit is called because this processes oopsed, it's possible
> -	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
> -	 * continuing. Amongst other possible reasons, this is to prevent
> -	 * mm_release()->clear_child_tid() from writing to a user-controlled
> -	 * kernel address.
> -	 */
> -	force_uaccess_begin();

Are you sure about that one?  It shouldn't matter, but... it's a potential
change for do_exit() from a kernel thread.  As it is, we have that
force_uaccess_begin() for exiting threads and for kernel ones it's not
a no-op.  I'm not concerned about attempted userland access after that
point for those, obviously, but I'm not sure you won't step into something
subtle here.

I would prefer to split that particular change off into a separate commit...
