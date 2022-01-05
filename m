Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D56484D33
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 06:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiAEFBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 00:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiAEFBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 00:01:46 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F514C061761;
        Tue,  4 Jan 2022 21:01:46 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4yQh-00HNkI-3e; Wed, 05 Jan 2022 05:01:43 +0000
Date:   Wed, 5 Jan 2022 05:01:43 +0000
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
Subject: Re: [PATCH 02/10] exit: Add and use make_task_dead.
Message-ID: <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-2-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:24PM -0600, Eric W. Biederman wrote:
> There are two big uses of do_exit.  The first is it's design use to be
> the guts of the exit(2) system call.  The second use is to terminate
> a task after something catastrophic has happened like a NULL pointer
> in kernel code.
> 
> Add a function make_task_dead that is initialy exactly the same as
> do_exit to cover the cases where do_exit is called to handle
> catastrophic failure.  In time this can probably be reduced to just a
> light wrapper around do_task_dead. For now keep it exactly the same so
> that there will be no behavioral differences introducing this new
> concept.
> 
> Replace all of the uses of do_exit that use it for catastraphic
> task cleanup with make_task_dead to make it clear what the code
> is doing.
> 
> As part of this rename rewind_stack_do_exit
> rewind_stack_and_make_dead.

Umm...   What about .Linvalid_mask: in arch/xtensa/kernel/entry.S?
That's an obvious case for your make_task_dead().
