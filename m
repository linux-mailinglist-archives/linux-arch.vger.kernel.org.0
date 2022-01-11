Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F048A51B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 02:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiAKBeA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 20:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiAKBd7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 20:33:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82738C06173F;
        Mon, 10 Jan 2022 17:33:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so2957100pjb.5;
        Mon, 10 Jan 2022 17:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=F2ZMsidULY/UwIx/Ch3Zop5xXT7D40iAokDW8asVY/g=;
        b=njivyDZgo4ribC/UGiFHXUlbr3SoZTWCgeLro8eP65+y63P9MWd9771AimCjlaNK1K
         8N7QQejTNmi6I2/NQil8uOPoKaMTgApEEdrlCinEzACR47hX5M6VRP73L9/NPr8JANXh
         NOuIga20wQ7vDZ2r+mxIDZuYDCua50NSVYnW+hxS1OEyFhYVy6cDgaj+mg77P85bMYh6
         bNs5YGTDzWw8eFDm+Zv6mU8bkFu3GlmNcdAWxzF2abav6dedP9v61xmT0JYVadKiTJbX
         VeiCelnnvA/ul2p+2KAZF0GPwnud33/xrwVBTbwnm6gCFY6db/bl7aniq3UwlOPm554j
         nHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=F2ZMsidULY/UwIx/Ch3Zop5xXT7D40iAokDW8asVY/g=;
        b=FuBDrpHgt60Cgpalby2lZUsAkD3JvfiZY7S41lJ94IGsAHJKoTkmZU171q3YEgxE4p
         NtjVwHnYZ86oUVbx0HJQ+FeQSaruBAUjlztoQ6mbVcsSsr/DxRnSzoobdKMd+DV/llha
         h3PHpuujZ2bJTR5U9iQG6YvScYjJ3ovjrB5+rhVw4C6SaUMxh+vkbSS563bJUkfBWYup
         YbC1EL6qrM0lTs7dFdixiA9Lb/9vfHLwlsanZ13PsUosyp+rWdOPnHsD0Wkwa+MiruXP
         S+0/1WX3oMYwvQHCGyqTWrcYTyOsoLn0Twkr53rkxrB3Wz2oVDsTJCkuDZ0F8TSxFTrD
         QZEA==
X-Gm-Message-State: AOAM532dVClF6CYJGPgwUA6QhPOSLWcC3PVJCs+55KMcToxPX0MsPhq1
        R7e5soIaTEQKG0+w/xo5r34=
X-Google-Smtp-Source: ABdhPJzpY3sW1zsiJEXNIF+/rpB6tJbNyFAD8FoSPYbO+0hn3cWA/3OG783Mtr9NOyz4hiHj82UhQw==
X-Received: by 2002:a63:b407:: with SMTP id s7mr2119523pgf.202.1641864839097;
        Mon, 10 Jan 2022 17:33:59 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id a1sm253057pjs.20.2022.01.10.17.33.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jan 2022 17:33:58 -0800 (PST)
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com>
 <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
 <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
 <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <acf7b627-2dec-c76c-2aa0-6b4c6addd793@gmail.com>
Date:   Tue, 11 Jan 2022 14:33:50 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

Am 11.01.2022 um 06:54 schrieb Geert Uytterhoeven:
> Hi Al,
>
> CC Michael/m68k,
>
> On Mon, Jan 10, 2022 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Mon, Jan 10, 2022 at 04:26:57PM +0100, Geert Uytterhoeven wrote:
>>> On Mon, Jan 3, 2022 at 10:33 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>> The generic function ptrace_report_syscall does a little more
>>>> than syscall_trace on m68k.  The function ptrace_report_syscall
>>>> stops early if PT_TRACED is not set, it sets ptrace_message,
>>>> and returns the result of fatal_signal_pending.
>>>>
>>>> Setting ptrace_message to a passed in value of 0 is effectively not
>>>> setting ptrace_message, making that additional work a noop.
>>>>
>>>> Returning the result of fatal_signal_pending and letting the caller
>>>> ignore the result becomes a noop in this change.
>>>>
>>>> When a process is ptraced, the flag PT_PTRACED is always set in
>>>> current->ptrace.  Testing for PT_PTRACED in ptrace_report_syscall is
>>>> just an optimization to fail early if the process is not ptraced.
>>>> Later on in ptrace_notify, ptrace_stop will test current->ptrace under
>>>> tasklist_lock and skip performing any work if the task is not ptraced.
>>>>
>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>
>>> As this depends on the removal of a parameter from
>>> ptrace_report_syscall() earlier in this series:
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> FWIW, I would suggest taking it a bit further: make syscall_trace_enter()
>> and syscall_trace_leave() in m68k ptrace.c unconditional, replace the
>> calls of syscall_trace() in entry.S with syscall_trace_enter() and
>> syscall_trace_leave() resp. and remove syscall_trace().
>>
>> Geert, do you see any problems with that?  The only difference is that
>> current->ptrace_message would be set to 1 for ptrace stop on entry and
>> 2 - on leave.  Currently m68k just has it 0 all along.
>>
>> It is user-visible (the whole point is to let the tracer see which
>> stop it is - entry or exit one), so somebody using PTRACE_GETEVENTMSG
>> on syscall stops would start seeing 1 or 2 instead of "0 all along".
>> That's how it works on all other architectures (including m68k-nommu),
>> and I doubt that anything in userland will get broken.
>>
>> Behaviour of PTRACE_GETEVENTMSG for other stops (fork, etc.) remains
>> as-is, of course.
>
> In fact Michael did so in "[PATCH v7 1/2] m68k/kernel - wire up
> syscall_trace_enter/leave for m68k"[1], but that's still stuck...
>
> [1] https://lore.kernel.org/r/1624924520-17567-2-git-send-email-schmitzmic@gmail.com/

That patch (for reasons I never found out) did interact badly with 
Christoph Hellwig's 'remove set_fs' patches (and Al's signal fixes which 
Christoph's patches are based upon). Caused format errors under memory 
stress tests quite reliably, on my 030 hardware.

Probably needs a fresh look - the signal return path got changed by Al's 
patches IIRC, and I might have relied on offsets to data on the stack 
that are no longer correct with these patches. Or there's a race between 
the syscall trap and signal handling when returning from interrupt 
context ...

Still school hols over here so I won't have much peace and quiet until 
February.

Cheers,

	Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
