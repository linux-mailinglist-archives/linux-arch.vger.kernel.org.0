Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB03A71E9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 00:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhFNWaA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 18:30:00 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39573 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhFNW36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 18:29:58 -0400
Received: by mail-pl1-f175.google.com with SMTP id v11so7397522ply.6;
        Mon, 14 Jun 2021 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2wHRYHn3irCXYL7For+pyhXkLVm13sKB64rDtBd32VI=;
        b=PqSXodK6N07bLspEMMWcvPzitnStxehhQAiPSELS8T8LHkqJ0thnWFLh49SdacSsY2
         mwfEWmZE7gfRIKKrAJKzf0VnP2FQu83DYScL0qtL+6yBz6jC1D5neNbKVRIq4KsrpMRl
         iCPzp1pYJ1cP2aDk2+Dpen5zvQYeeZLZPGYVT6X2hqVbQF+MvERc2iXu6jx6u/pnw5TQ
         lw22OikSINSCmlJW/cE92LS/dSqsVtBmKWHpdhqov40mrW+SFoZLlAVSRfuerKVbXygy
         N/bQ7S8MIEF8SQrb/cElur2NuQ7OL7I6/uGHuF/rCCsZ2J/13LS4CUGB5siOxSzSuS12
         I55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2wHRYHn3irCXYL7For+pyhXkLVm13sKB64rDtBd32VI=;
        b=Y+cU/HPfXO5c/xoeDQy+MFb4TXwWaQ5TNBHbgMp3GFhHWSBqmHwWHYwPkikRzfz8Qe
         GacRkim1qF5uwBPPHIbjtGDUArgOzIH1OJf5FAkdRHT/2VhvY30qBuPx1jEqOYMjozge
         avUrqiemtjyw3Itu8MgDQ2PHndI5UxP3D4z69g6ybxp2kp1p+WQLkk84zxi4ZLEqTqbG
         yx05kQdVC1IjludNm3gJCTNi6fnrsnnqlm145ddJ+vRhSLvk7clb2js72Jh9/JDyn8n/
         4AVTiF1vd1O4tPop2v++UWmKhCkjG5t0J/HGF6Kv8Sw+WA4DwFUxLW0h9EeC91nNA5oq
         KB8g==
X-Gm-Message-State: AOAM532lcb88IouolVlZTQHkDgQBx1CU1GITEqFWNeR8xxOWiZj489cm
        lfP4OACDBP2pVCC2E9I5sFU=
X-Google-Smtp-Source: ABdhPJygbvcn8zCklBMa7quiEyd7aRA7FuUVFrWXN9QUvOlCU/oXa2HsIJAJXO6Bh4uxWBVrg4utBg==
X-Received: by 2002:a17:902:8d92:b029:113:91e7:89d6 with SMTP id v18-20020a1709028d92b029011391e789d6mr1282283plo.85.1623709601728;
        Mon, 14 Jun 2021 15:26:41 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:108d:81dd:b77d:48cd? ([2001:df0:0:200c:108d:81dd:b77d:48cd])
        by smtp.gmail.com with ESMTPSA id j4sm433096pjv.7.2021.06.14.15.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 15:26:41 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
 <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133>
 <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
Date:   Tue, 15 Jun 2021 10:26:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eed4v2dc.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

On 15/06/21 4:26 am, Eric W. Biederman wrote:
> Michael Schmitz <schmitzmic@gmail.com> writes:
>
>> On second thought, I'm not certain what adding another empty stack frame would
>> achieve here.
>>
>> On m68k, 'frame' already is a new stack frame, for running the new thread
>> in. This new frame does not have any user context at all, and it's explicitly
>> wiped anyway.
>>
>> Unless we save all user context on the stack, then push that context to a new
>> save frame, and somehow point get_signal to look there for IO threads
>> (essentially what Eric suggested), I don't see how this could work?
>>
>> I must be missing something.
> It is only designed to work well enough so that ptrace will access
> something well defined when ptrace accesses io_uring tasks.
>
> The io_uring tasks are special in that they are user process
> threads that never run in userspace.  So as long as everything
> ptrace can read is accessible on that process all is well.
OK, I'm testing a patch that would save extra context in 
sys_io_uring_setup, which ought to ensure that for m68k.
> Having stared a bit longer at the code I think the short term
> fix for both of PTRACE_EVENT_EXIT and io_uring is to guard
> them both with CONFIG_HAVE_ARCH_TRACEHOOK.

Fair enough :-)

Cheers,

     Michael

>
> Today CONFIG_HAVE_ARCH_TRACEHOOK guards access to /proc/self/syscall.
> Which out of necessity ensures that user context is always readable.
> Which seems to solve both the PTRACE_EVENT_EXIT and the io_uring
> problems.
>
> What I especially like about that is there are a lot of other reasons
> to encourage architectures in a CONFIG_HAVE_ARCH_TRACEHOOK direction.
> I think the biggies are getting architectures to store the extra
> saved state on context switch into some place in task_struct
> and to implement the regset view of registers.
>
> Hmm. This is odd. CONFIG_HAVE_ARCH_TRACEHOOK is supposed to imply
> CORE_DUMP_USE_REGSET.  But alpha, csky, h8300, m68k, microblaze, nds32
> don't implement CORE_DUMP_USE_REGSET but nds32 implements
> CONFIG_ARCH_HAVE_TRACEHOOK.
>
> I will keep digging and see what clean code I can come up with.
>
> Eric
