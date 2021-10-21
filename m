Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598E4367F6
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJUQiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhJUQiE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:38:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39AEC061764;
        Thu, 21 Oct 2021 09:35:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8817B1F44CC0;
        Thu, 21 Oct 2021 17:35:46 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals
 on failure
Organization: Collabora
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-14-ebiederm@xmission.com>
Date:   Thu, 21 Oct 2021 13:35:40 -0300
In-Reply-To: <20211020174406.17889-14-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 20 Oct 2021 12:44:00 -0500")
Message-ID: <875ytq1gkj.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Use force_fatal_sig instead of calling do_exit directly.  This ensures
> the ordinary signal handling path gets invoked, core dumps as
> appropriate get created, and for multi-threaded processes all of the
> threads are terminated not just a single thread.
>
> When asked Gabriel Krisman Bertazi <krisman@collabora.com> said [1]:
>> ebiederm@xmission.com (Eric W. Biederman) asked:
>>
>> > Why does do_syscal_user_dispatch call do_exit(SIGSEGV) and
>> > do_exit(SIGSYS) instead of force_sig(SIGSEGV) and force_sig(SIGSYS)?
>> >
>> > Looking at the code these cases are not expected to happen, so I would
>> > be surprised if userspace depends on any particular behaviour on the
>> > failure path so I think we can change this.
>>
>> Hi Eric,
>>
>> There is not really a good reason, and the use case that originated the
>> feature doesn't rely on it.
>>
>> Unless I'm missing yet another problem and others correct me, I think
>> it makes sense to change it as you described.
>>
>> > Is using do_exit in this way something you copied from seccomp?
>>
>> I'm not sure, its been a while, but I think it might be just that.  The
>> first prototype of SUD was implemented as a seccomp mode.
>
> If at some point it becomes interesting we could relax
> "force_fatal_sig(SIGSEGV)" to instead say
> "force_sig_fault(SIGSEGV, SEGV_MAPERR, sd->selector)".
>
> I avoid doing that in this patch to avoid making it possible
> to catch currently uncatchable signals.
>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> [1] https://lkml.kernel.org/r/87mtr6gdvi.fsf@collabora.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/entry/syscall_user_dispatch.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>

Hi Eric,

Feel free to add:

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks,

-- 
Gabriel Krisman Bertazi
