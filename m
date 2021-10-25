Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89BD43A6BC
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhJYWn0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 18:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234204AbhJYWnZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Oct 2021 18:43:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4205E6103C;
        Mon, 25 Oct 2021 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635201662;
        bh=ex+zDaQP63Cn6bMQxc/uGRqILguHZWqLS9gEpm92DDU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PEHDxeNK/gqMFjw58J3tXy7BRkq+Yrg2AgrWIgVWwpTzkGhZl8HpMgJJ+nVMB3EBG
         08VE8MbdRGn866NTwITZJjLQwSCtXwYX0dhgN51JNqKA4rWs+kBrVXLob2Jsnj5JiX
         J/DDPX+VaJqglRJNT4NO/LiwPG7I/iXmd2mmwS672OilByu8oj2+qgfzvbXGu+kIaA
         FRRGrWOcyfGaD7QNMJQ0Go0gBXrWhQEG3U8PwXuqDo7oziFU5Q/9IFOiAMaMAowymk
         rrMo1/6ognvTAZIE2zAKiaElx39mOPw+mmwbCzTMcIk13s1REJTLUpNx8ZQMKZwsmV
         XJIQNm3J8umig==
Message-ID: <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
Date:   Mon, 25 Oct 2021 15:41:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-13-ebiederm@xmission.com>
 <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/20/21 13:05, Linus Torvalds wrote:
> On Wed, Oct 20, 2021 at 7:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Add a simple helper force_fatal_sig that causes a signal to be
>> delivered to a process as if the signal handler was set to SIG_DFL.
>>
>> Reimplement force_sigsegv based upon this new helper.
> 
> Can you just make the old force_sigsegv() go away? The odd special
> casing of SIGSEGV was odd to begin with, I think everybody really just
> wanted this new "force_fatal_sig()" and allow any signal - not making
> SIGSEGV special.
> 

I'm rather nervous about all this, and I'm also nervous about the 
existing code.  A quick skim is finding plenty of code paths that assume 
force_sigsegv (or a do_exit that this series touches) are genuinely 
unrecoverable.  For example:

- rseq: the *kernel* will be fine if a signal is handled, but the 
userspace process may be in a very strange state.

- bprm_execve: The comment says it best:

         /*
          * If past the point of no return ensure the code never
          * returns to the userspace process.  Use an existing fatal
          * signal if present otherwise terminate the process with
          * SIGSEGV.
          */
         if (bprm->point_of_no_return && !fatal_signal_pending(current))
                 force_sigsegv(SIGSEGV);

- vm86: already discussed

Now force_sigsegv() at least tries to kill the task, but not very well. 
With the whole series applied and force_sigsegv() gone, these errors 
become handleable, and that needs real care.

(I don't think bprm_execve() is exploitable.  It looks like it's 
attackable in the window between setting point_of_no_return and 
unshare_sighand(), but I'm not seeing any useful way to attack it unless 
a core dump is already in progress or a *different* fatal signal is 
already pending, and in either of those cases we're fine.)
