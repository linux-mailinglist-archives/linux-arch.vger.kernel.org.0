Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E823AF943
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 01:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFUX1X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 19:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhFUX1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 19:27:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E69FC061574;
        Mon, 21 Jun 2021 16:25:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y21so3553725plb.4;
        Mon, 21 Jun 2021 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r0VwenRqskFTDoxa2BG069i4DjqqTYGW10YD8Bvo/q0=;
        b=F+xHU0Aq6hmH1YvvN8TsIaDZ+1YxE0TAC/D7AUDfDVD99ivp1J2/ZEe+x6H78uyvXj
         E3ihUPFI1h6CinFlQiMGG9N/FK57sYaQBEHYKmbxomJfPEevCH3VNE9VvZYCh2EFsghE
         f/HFVrKLPWMR/AoMFOGbraO2smRAYLfRB9g2p0gs6svzmnCwmD2LKKhlymdV7bvrAyiF
         bZ5H+34iH1uRaGrMDypbUXzPC99bK1vJS/SsOQ1yuMsrhStJouJdPbuOTjsC4KacgFq7
         zNn+nXPzUDdD/SjHRFw34nmjK53kw1U/2GRYEOaSyDHA8Wp7EQ+lOYrEvt5YlvltZ1kq
         7nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r0VwenRqskFTDoxa2BG069i4DjqqTYGW10YD8Bvo/q0=;
        b=HnhapqjeeD2GU5PXqrRKLUUQb3Aw14gUH16s+rLQU1K+c412ngbxSMu+/MkiKS6Gxh
         famaqzKl065AhSf+j1sbJQLryW9HHy2/PglQ+CG0WG2tzUlY8B21gXoNQSLMSjq4YJVg
         pCUMbZ4vbt8/1fjVreatp1uv6ISMqvp+aD0wpOjjECJhmSmYuMTvPO5SUTd6QL4ruYJ5
         0O7jRZ2stQBzwHRe9jyqWy1g4TVqVC9x8Bm/Y/YL4kPdXYWum0x+fUnhiVMAeuVq2s5d
         qHEqC6li6wokp5YGVxoC054TyccH7v1n0QM4YNDXe98RspOL/EYL1goYo2zJBLTqn7TY
         5tHg==
X-Gm-Message-State: AOAM532MFDj8YW/o1kSganGiVgnvlH+knOkHZpaFmXdMrcg0cGYgLyu+
        txl5NDkShBwiQvwymxsvsH4=
X-Google-Smtp-Source: ABdhPJxZXn+aC1eJ8kEUSL89QiRwAcF2SYH1ok/wnVJVoR/0d2Q7ch0UBMjyXnIPBipspF93KtOPVg==
X-Received: by 2002:a17:90a:1541:: with SMTP id y1mr701499pja.74.1624317907229;
        Mon, 21 Jun 2021 16:25:07 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:2114:f868:6a99:ac19? ([2001:df0:0:200c:2114:f868:6a99:ac19])
        by smtp.gmail.com with ESMTPSA id m4sm252608pjv.41.2021.06.21.16.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:25:06 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
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
References: <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <YNDnY0niP+IfSx+X@zeniv-ca.linux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d8105fc4-9551-c80a-37f4-2c57b3173283@gmail.com>
Date:   Tue, 22 Jun 2021 11:24:57 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNDnY0niP+IfSx+X@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

On 22/06/21 7:24 am, Al Viro wrote:
>
>> 	There's a large mess around do_exit() - we have a bunch of
>> callers all over arch/*; if nothing else, I very much doubt that really
>> want to let tracer play with a thread in the middle of die_if_kernel()
>> or similar.
>>
>> We sure as hell do not want to arrange for anything on the kernel
>> stack in such situations, no matter what's done in exit(2)...
> FWIW, on alpha it's die_if_kernel(), do_entUna() and do_page_fault(),
> all in not-from-userland cases.  On m68k - die_if_kernel(), do_page_fault()
> (both for non-from-userland cases) and something really odd - fpsp040_die().
> Exception handling for floating point stuff on 68040?  Looks like it has
Exception handling for emulated floating point instructions, really - 
exceptions happening when excecuting FPU instructions on hardware will 
do the normal exception processing.
> an open-coded copy_to_user()/copy_from_user(), with faults doing hard
> do_exit(SIGSEGV) instead of raising a signal and trying to do something
> sane...

Yes, that's what it does. Not pretty ... though all that using m68k 
copy_to_user()/copy_from_user() would change is returning how many bytes 
could not copied. In contrast to the ifpsp060 code, we could not pass on 
that return status to callers of copyin/copyout in fpsp040, so I don't 
see what sane thing could be done if a fault happens.

(I'd expect the MMU would have raised a bus error and resolved the 
problem by a page fault if possible, before we ever get to this point?)

> I really don't want to try and figure out how painful would it be to
> teach that code how to deal with faults - _testing_ anything in that
> area sure as hell will be.  IIRC, details of recovery from FPU exceptions
> on 68040 in the manual left impression of a minefield...

This is only about faults when moving data from/to user space. FPU 
exceptions are handled elsewhere in the code. So we at least don't have 
to deal with that particular minefield.

Teaching the fpsp040 code to deal with access faults looks horrible 
indeed... let's not go there.

Cheers,

     Michael


