Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571273B0FAD
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 23:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFVV7v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 17:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVV7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 17:59:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD3C061756;
        Tue, 22 Jun 2021 14:57:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso2542627pjv.4;
        Tue, 22 Jun 2021 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=q3sSzRhIYRc08dnfAfmCyTORkqMDLuhDq0YQcDshAkw=;
        b=b7F/isKgmlnCGn7ktKvQiwQaGkX//vxpblPW5Aj3zNKiPyoIi7L6xPA0H+VD3mmaV2
         KK3ZmsT5Kx0XYBSi6rAJB6yf4y+ypdpaF4k8xNGxuXiRoWYyzkzKrFOsZB2bTfuWyz1V
         pIZ6u6YjIWAFEzdxEpXck55WHYWnXfeO9tM4jXryNbRGP8x9lTwwMV7z1J5rYgQIb11J
         bwCo2XoKzw1Byt5bpTGrEVmHlrjyhQd9lRLB1mkL3qgJ/mZ4MLBh6HcydQ5giJyPyUg0
         o3lLcUur7tND7+LxDLyXT5AbbRNWGXXKNCuI54z4x98prRHyaHRJSFwZZyGaonB77FJq
         fE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q3sSzRhIYRc08dnfAfmCyTORkqMDLuhDq0YQcDshAkw=;
        b=WP/CrrTo8XaACEBNUMQrZpjOUT61SUPd4t3q/Y6YkCCnPikoO+qGLxIpC8G8kW7JFM
         yeh4fU8hZ+KxGcZCi632kJtytUH/LhgbRWgyyN/Kb1CeBk3L//9IUfBnFd6f9eA+Yubk
         /f+zXz6xsR0wgARthk6cB23F7ZVbAG4o4qLwlcH94f8Xj8VaNZ5D9R+F8hQ7IdqLS3ft
         hoAfO4/I5ZsQLEe4o1K0rqCMoNK6MmkcCe9Dw/5NPRyB/umV0oPtKdDAA62Z9rjcN9wV
         0R1UNKEm/fma1WeNBDCzxP/mTngh7WHnsax5Nd7D4Lw1QMNiAFbtNlgRC+GD1ebEouik
         dqoQ==
X-Gm-Message-State: AOAM531iePzEY5IT25Vv7IGiAd2UbSwWGjp+u4IOfUSh79Qs/RS2qGTa
        wSNIjhQHkpfuKsE5EceWOiM=
X-Google-Smtp-Source: ABdhPJwlKwvoG5Z9DeeMyE3mjGfDMy5eHoV3xhucGbnHdUQlgp85EV7UAlHh9fZyxo3tpwvOVevOAg==
X-Received: by 2002:a17:90b:3581:: with SMTP id mm1mr5936783pjb.98.1624399053199;
        Tue, 22 Jun 2021 14:57:33 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9491:40e4:164d:6ab3? ([2001:df0:0:200c:9491:40e4:164d:6ab3])
        by smtp.gmail.com with ESMTPSA id z9sm270622pfa.2.2021.06.22.14.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:57:32 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
 <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
 <de5f0132-eed4-f1d0-ddd2-f65a62de6b81@gmail.com>
 <YNJFr5xUOm91Vy1r@zeniv-ca.linux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8badff67-64c9-ca03-7af1-de73d0d75285@gmail.com>
Date:   Wed, 23 Jun 2021 09:57:23 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNJFr5xUOm91Vy1r@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

On 23/06/21 8:18 am, Al Viro wrote:
> On Wed, Jun 23, 2021 at 08:04:11AM +1200, Michael Schmitz wrote:
>
>> All syscalls that _do_ save the switch stack are currently called through
>> wrappers which pull the syscall arguments out of the saved pt_regs on the
>> stack (pushing the switch stack after the SAVE_ALL saved stuff buries the
>> syscall arguments on the stack, see comment about m68k_clone(). We'd have to
>> push the switch stack _first_ when entering system_call to leave the syscall
>> arguments in place, but that will require further changes to the syscall
>> exit path (currently shared with the interrupt exit path). Not to mention
>> the register offset calculations in arch/m68k/kernel/ptrace.c, and perhaps a
>> few other dependencies that don't come to mind immediately.
>>
>> We have both pt_regs and switch_stack in uapi/asm/ptrace.h, but the ordering
>> of the two is only mentioned in a comment. Can we reorder them on the stack,
>> as long as we don't change the struct definitions proper?
>>
>> This will take a little more time to work out and test - certainly not
>> before the weekend. I'll send a corrected version of my debug patch before
>> that.
> This is insane, *especially* on m68k where you have the mess with different
> frame layouts and associated ->stkadj crap (see mangle_kernel_stack() for
> the (very) full barfbag).

Indeed - that's one of the uses of pt_regs and switch_stack that I 
hadn't yet seen.

So it's either leave the stack layout in system calls unchanged (aside 
from the ones that need the extra registers) and protect against 
accidental misuse of registers that weren't saved, with the overhead of 
playing with thread_info->status bits, or tackle the mess of redoing the 
stack layout to save all registers, always (did I already mention that 
I'd need a _lot_ of help from someone more conversant with m68k assembly 
coding for that option?).

Which one of these two barf bags is the fuller one?

Cheers,

     Michael

