Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E0487154
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 04:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiAGDnD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 22:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbiAGDnD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 22:43:03 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C8C061245;
        Thu,  6 Jan 2022 19:43:02 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5g9b-000GHp-Vy; Fri, 07 Jan 2022 03:43:00 +0000
Date:   Fri, 7 Jan 2022 03:42:59 +0000
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
Message-ID: <Yde2wwNmqzRTxh1f@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com>
 <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 05:48:08AM +0000, Al Viro wrote:
> On Wed, Dec 08, 2021 at 02:25:25PM -0600, Eric W. Biederman wrote:
> > The beginning of do_exit has become cluttered and difficult to read as
> > it is filled with checks to handle things that can only happen when
> > the kernel is operating improperly.
> > 
> > Now that we have a dedicated function for cleaning up a task when the
> > kernel is operating improperly move the checks there.
> 
> Umm...  I would probably take profile_task_exit() crap out before that
> point.
> 	1) the damn thing is dead - nothing registers notifiers there
> 	2) blocking_notifier_call_chain() is not a nice thing to do on oops...
> 
> I'll post a patch ripping the dead parts of kernel/profile.c out tomorrow
> morning (there's also profile_handoff_task(), equally useless these days
> and complicating things for __put_task_struct()).

Argh...  OK, so your subsequent series had pretty much the same thing.
My apologies - still digging myself out from mail pile that had accumulated
over two months ;-/
