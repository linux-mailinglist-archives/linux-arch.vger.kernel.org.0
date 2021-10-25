Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBC43A69C
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhJYWfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 18:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233933AbhJYWfQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Oct 2021 18:35:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8765A6103C;
        Mon, 25 Oct 2021 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635201174;
        bh=0BzdB5d92X2i7ldftw0ekDl6iGfPoKqmLtnwLssAJDo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sbbiUXaPkbJ0VPl0NqHf8kSkjvjCer1JuUSIX/rs7xOUT6WXkCx5El+AmNuaM2Mg2
         QqcfNv8hRFxEVlbVWVciWEtweYRiFgPoieo0FUBFvLZDx/5StICNIX6AR42H/J8ats
         exXSpcVRAwVES+NeZM5SCLOKbAwCyAdgbHi84Z2vThJLXnhcETxhmYVYPpKzzHbo+w
         bbsV8jm1VUB0kLl/kXa/pWYSFMAja2KY7skXEM4BZP35OLkaig3DOq+F/+hdGFu5M9
         uzxXmJxAk4vlg3TU+99Z5qfcp2/BLKC2/a8xNKV7pmPZxglyI748qgNehJCqmR+Owb
         vJGucCE3BaMhQ==
Message-ID: <baf77664-596d-d679-261a-6a2a3b9b948a@kernel.org>
Date:   Mon, 25 Oct 2021 15:32:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals
 on failure
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-14-ebiederm@xmission.com>
 <202110210925.9DEAF27CA@keescook>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <202110210925.9DEAF27CA@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/21 09:25, Kees Cook wrote:
> On Wed, Oct 20, 2021 at 12:44:00PM -0500, Eric W. Biederman wrote:
>> Use force_fatal_sig instead of calling do_exit directly.  This ensures
>> the ordinary signal handling path gets invoked, core dumps as
>> appropriate get created, and for multi-threaded processes all of the
>> threads are terminated not just a single thread.
>>
>> When asked Gabriel Krisman Bertazi <krisman@collabora.com> said [1]:
>>> ebiederm@xmission.com (Eric W. Biederman) asked:
>>>
>>>> Why does do_syscal_user_dispatch call do_exit(SIGSEGV) and
>>>> do_exit(SIGSYS) instead of force_sig(SIGSEGV) and force_sig(SIGSYS)?
>>>>
>>>> Looking at the code these cases are not expected to happen, so I would
>>>> be surprised if userspace depends on any particular behaviour on the
>>>> failure path so I think we can change this.
>>>
>>> Hi Eric,
>>>
>>> There is not really a good reason, and the use case that originated the
>>> feature doesn't rely on it.
>>>
>>> Unless I'm missing yet another problem and others correct me, I think
>>> it makes sense to change it as you described.
>>>
>>>> Is using do_exit in this way something you copied from seccomp?
>>>
>>> I'm not sure, its been a while, but I think it might be just that.  The
>>> first prototype of SUD was implemented as a seccomp mode.
>>
>> If at some point it becomes interesting we could relax
>> "force_fatal_sig(SIGSEGV)" to instead say
>> "force_sig_fault(SIGSEGV, SEGV_MAPERR, sd->selector)".
>>
>> I avoid doing that in this patch to avoid making it possible
>> to catch currently uncatchable signals.
>>
>> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> [1] https://lkml.kernel.org/r/87mtr6gdvi.fsf@collabora.com
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Yeah, looks good. Should be no visible behavior change.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

I'm confused.  Before this series, this error path would unconditionally 
kill the task (other than the race condition in force_sigsegv(), but at 
least a well-behaved task would get killed).  Now a signal handler might 
be invoked, and it would be invoked after the syscall that triggered the 
fault got processed as a no-op.  If the signal handler never returns, 
that's fine, but if the signal handler *does* return, the process might 
be in an odd state.  For SIGSYS, this behavior is probably fine, but 
having SIGSEGV swallow a syscall seems like a mistake.

Maybe rewind (approximately!) the syscall?  Or actually send SIGSYS?  Or 
actually make the signal uncatchable?

--Andy
