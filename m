Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50AF484D14
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 05:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiAEEZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 23:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiAEEZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 23:25:34 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F283C061761;
        Tue,  4 Jan 2022 20:25:34 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4xre-00HNOY-55; Wed, 05 Jan 2022 04:25:30 +0000
Date:   Wed, 5 Jan 2022 04:25:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 01/10] exit/s390: Remove dead reference to do_exit from
 copy_thread
Message-ID: <YdUdui9j6CBjGAgn@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-1-ebiederm@xmission.com>
 <YbY2CDkZbOFRBN0i@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbY2CDkZbOFRBN0i@osiris>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 12, 2021 at 06:48:56PM +0100, Heiko Carstens wrote:
> On Wed, Dec 08, 2021 at 02:25:23PM -0600, Eric W. Biederman wrote:
> > My s390 assembly is not particularly good so I have read the history
> > of the reference to do_exit copy_thread and have been able to
> > verify that do_exit is not used.
> > 
> > The general argument is that s390 has been changed to use the generic
> > kernel_thread and kernel_execve and the generic versions do not call
> > do_exit.  So it is strange to see a do_exit reference sitting there.
> > 
> > The history of the do_exit reference in s390's version of copy_thread
> > seems conclusive that the do_exit reference is something that lingers
> > and should have been removed several years ago.
> ...
> > Remove this dead reference to do_exit to make it clear that s390 is
> > not doing anything with do_exit in copy_thread.
> >
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > ---
> >  arch/s390/kernel/process.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Applied to s390 tree. Just in case you want to apply this to your tree too:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

FWIW, this
                frame->childregs.psw.addr =
				(unsigned long)__ret_from_fork;
is also pointless.  We do want psw.mask (if nothing else, __ret_from_fork()
that is called by ret_from_fork() will, in effect, check user_mode(task_pt_regs()).
But psw.addr is, AFAICS, pointless - the only way the callback is allowed to
return is after successful kernel_execve(), which would set psw.addr; moreover,
psw.addr is meaningless until that happens.
