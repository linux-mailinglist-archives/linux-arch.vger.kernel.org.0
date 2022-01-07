Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2B487193
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 04:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbiAGD7r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 22:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbiAGD7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 22:59:47 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5612BC061245;
        Thu,  6 Jan 2022 19:59:47 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5gPp-000GSv-9P; Fri, 07 Jan 2022 03:59:45 +0000
Date:   Fri, 7 Jan 2022 03:59:45 +0000
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
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all
 kthreads
Message-ID: <Yde6sQqp9Rx0Zm5I@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-9-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:31PM -0600, Eric W. Biederman wrote:
> Today the rules are a bit iffy and arbitrary about which kernel
> threads have struct kthread present.  Both idle threads and thread
> started with create_kthread want struct kthread present so that is
> effectively all kernel threads.  Make the rule that if PF_KTHREAD
> and the task is running then struct kthread is present.
> 
> This will allow the kernel thread code to using tsk->exit_code
> with different semantics from ordinary processes.

Getting rid of ->exit_code abuse is independent from this.
I'm not saying that this change is a bad idea, but it's an
independent thing.  Simply turn these two failure exits
into do_exit(0) in 06/10 and that's it.  Then this one
would get rid of if (!self) and the second of those two
calls, but it won't be nailed to that point of queue.
