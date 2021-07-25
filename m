Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6933D5000
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 22:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGYUIJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jul 2021 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGYUII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 16:08:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953ECC061757
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 13:48:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a20so9440446plm.0
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+soFvlggdNemFNXTJHD7EfeCnCEyuBk0Q2su2ig+5L8=;
        b=YbUUTDNk7o/e5YA1/aFcqfEKITpxP2h0EuKnA5r7WqwXnMivekCIcIQmbg1iwboQka
         fMNAUchCEEB35l1T/bMYGc4Sco/iTnVs4acwuzDgPrUskiEFpXE7Wo7xeXm4WQ1ueKgZ
         gpW4VqTCNPsKW2jzcpV9HwJ++paEjxxpS0eLdAAZQXnhUOezgKhIZxwQDlQIdDYuVJuM
         J04nWgVmTOynoPC36dUcrRFZvLSu2oPivRCcC6GpKNEeN5Crtj4eM4KLw/79ufVw0Ra7
         sC2yRovewpVjZboSunDlpEPTPt71zdToIv2FgNvAJE304e8VsiLCfXGcmAAI3ibkNOGl
         uVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+soFvlggdNemFNXTJHD7EfeCnCEyuBk0Q2su2ig+5L8=;
        b=piLlpWqQakzsYLNxyBlA/MI55ZrT9bHMf6HqaM0an5cMKgAizS1qgXrGYkDsaazlzX
         Bree95th52qmHEsxAxmtyFQcRio+tWyKo4nSKJaKCkgPyYTcAVXg/slvzPzLFdH1+afL
         dlLEIIs/X4F3GTk45yGUr6DroPCAV+xc3vY06Jl85NE4urFFt7BGLapwpb+GeMyetkcf
         ogdAQvtPJblCdw+GN4RPiqxvVJ/0Bgo6GYKQ2Dzu+Bn3Xjbm2+KGeOAilJXEI1xcpLbW
         NPiHXCcS83jLLjvhf+h7K3GsQHkMmnopUNt2hQIdcOPugO+9eobzrAsj8NRnl2AcfDRj
         QxxQ==
X-Gm-Message-State: AOAM531t1flS5arKzeKT5FpZfrVOuxdqd8XNxd/7DfXHFbquQM86Oz0c
        m4+UOwNs5M54eY1JeXfnmkY=
X-Google-Smtp-Source: ABdhPJxAwUjtf6aH2nU8kNF07zj4jThELQp/vaYPpNBhwADETnR0gtGwQwM2yIarqctVz6Yes5QGZg==
X-Received: by 2002:a62:15c5:0:b029:32c:ea9f:a5ed with SMTP id 188-20020a6215c50000b029032cea9fa5edmr14360945pfv.27.1627246117087;
        Sun, 25 Jul 2021 13:48:37 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:29ad:8fa7:168b:a8c8? ([2001:df0:0:200c:29ad:8fa7:168b:a8c8])
        by smtp.gmail.com with ESMTPSA id r128sm12785460pfc.155.2021.07.25.13.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 13:48:36 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] m68k: track syscalls being traced with shallow
 user context stack
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <1624407696-20180-4-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdVA5d7z6awGrpJ+Tb3PRxz7Nczd_SLXZ=cAwsS8tFU_vg@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f99d3d82-150b-62fc-3b38-141710a4826e@gmail.com>
Date:   Mon, 26 Jul 2021 08:48:30 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVA5d7z6awGrpJ+Tb3PRxz7Nczd_SLXZ=cAwsS8tFU_vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

thanks for the feedback!

As far as I understand, Eric's 'refactor exit()' patch series has 
obsoleted this band-aid fix of mine. The last remnant of code using 
do_exit() is our fpsp040 copyin/copyout exception handling, and there's 
another patch in testing for that. (I'd need access to a 040 hardware 
setup to properly test that one, but that's a different matter.)

Eric, Andreas - please correct me if I'm wrong (again).

Just out of interest - what would be the correct way to set/clear a 
single bit on Coldfire? Add/subtract the 1<<bit value?

Cheers,

     Michael


On 25/07/21 10:05 pm, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Wed, Jun 23, 2021 at 2:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Add 'status' field to thread_info struct to hold syscall trace
>> status info.
>>
>> Set flag bit in thread_info->status at syscall trace entry, clear
>> flag bit on trace exit.
>>
>> Set another flag bit on entering syscall where the full stack
>> frame has been saved. These flags can be checked whenever a
>> syscall calls ptrace_stop().
>>
>> Check flag bits in get_reg()/put_reg() and prevent access to
>> registers that are saved on the switch stack, in case the
>> syscall did not actually save these registers on the switch
>> stack.
>>
>> Tested on ARAnyM only - boots and survives running strace on a
>> binary, nothing fancy.
>>
>> CC: Eric W. Biederman <ebiederm@xmission.com>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Andreas Schwab <schwab@linux-m68k.org>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Thanks for your patch!
>
>> --- a/arch/m68k/kernel/entry.S
>> +++ b/arch/m68k/kernel/entry.S
>> @@ -51,75 +51,115 @@
>>
>>   .text
>>   ENTRY(__sys_fork)
>> +       movel   %curptr@(TASK_STACK),%a1
>> +       orb     #TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
> This doesn't work on Coldfire:
>
> arch/m68k/kernel/entry.S:55: Error: invalid instruction for this
> architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001,
> 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k,
> 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32
> [68330, 68331, 68332,
>   68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) --
> statement `orb #(1<<1),%a1@(16+3)' ignored
>
>>          SAVE_SWITCH_STACK
>>          jbsr    sys_fork
>>          lea     %sp@(24),%sp
>> +       movel   %curptr@(TASK_STACK),%a1
>> +       andb    #TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
> arch/m68k/kernel/entry.S:60: Error: invalid instruction for this
> architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001,
> 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k,
> 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32
> [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349,
> 68360], fidoa [fido]) -- statement `andb #(~((1<<1))),%a1@(16+3)'
> ignored
>
>>          rts
> Gr{oetje,eeting}s,
>
>                          Geert
>
