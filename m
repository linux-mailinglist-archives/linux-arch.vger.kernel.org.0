Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219F7484DE0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 07:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiAEGC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 01:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiAEGCZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 01:02:25 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21846C061761;
        Tue,  4 Jan 2022 22:02:25 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4zNP-00HOIu-92; Wed, 05 Jan 2022 06:02:23 +0000
Date:   Wed, 5 Jan 2022 06:02:23 +0000
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/10] exit: Stop exporting do_exit
Message-ID: <YdU0bzBuHCokPgCM@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-5-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:27PM -0600, Eric W. Biederman wrote:
> Now that there are no more modular uses of do_exit remove the EXPORT_SYMBOL.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/exit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f975cd8a2ed8..57afac845a0a 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -843,7 +843,6 @@ void __noreturn do_exit(long code)
>  	lockdep_free_task(tsk);
>  	do_task_dead();
>  }
> -EXPORT_SYMBOL_GPL(do_exit);

"Now" in the commit message is misleading, AFAICS - there's no such users
in the mainline right now (and yes, that one could be moved all the way
up).
