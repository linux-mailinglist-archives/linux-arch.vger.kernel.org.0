Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4063AD6DA
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhFSCzK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 22:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhFSCzK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 22:55:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF27C061574
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 19:52:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so7012473pjn.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8ig2KbLkNfZB9qEEyBrZcLTjZ1+b1zPHZ1SGxRMAjQc=;
        b=n6m29m6b5dCAFgH3xm7od+G0GMX4GLnWpm106q5u6knyCK2JpHr8Yj3ZVktqDlkoiZ
         ULXOedDjaoOWvo1z3vRlMuwWThkCvF8MIU9VnpA6cSuixdxqwhuuhXHahCjFg9ucZ+bH
         tWPs02z9AsRcrlLxgzLFoAgdXAKCtsY7jd4g/n+ZhMv53WXz0NcfQMbXdkdXfNWPdte7
         M1PT2g0NkBxNmPbHLiHwymBJ/g2x6u3lvsNe2vMIc6NVd06ZPwzcDWM1aKqLrAvc6q0f
         VN6AH5r4rF+ohmPluXTzwtDrd0PmJMsEuUiukbY1iMQQJIflsHTQpLLHQM1+NmOKVRy2
         r73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8ig2KbLkNfZB9qEEyBrZcLTjZ1+b1zPHZ1SGxRMAjQc=;
        b=c3Q220VCjD/JTSrG6gNwx5QxzhSNiEBhWjOCaxmkBwpY3dDaoDpupObcBi2FjAoC6l
         M3d0L47s9z0gFjIaiuYZ1aHjHYNCojCHrUQzZighz9v2MVTYiO/rNZSIXH425+d/PijE
         q1Ie2rtqHDkYYwczBoGKoXrg1Z8njCT3LEwKW/Bx/LbadyBPBYu8GGiUAci47CRGwyEG
         CSdxn0QGZAdeNVIUjTCPDkRp2ew4rZ4tYK2+x66Eo4ZW3VDLEO7zVxpSMAeMCmQPwACw
         U+iYQK4Mpqpb4TLcfDVcJbMxJ7X+x12fGv9hG32rWakfXV3eKU++vw1yuQ9p+IO8Qn34
         CVKw==
X-Gm-Message-State: AOAM531sH4RXCtLxNcuKjrm/CG6dm0MY4JBTjQ+yQ+USy48yXUr7VSJ8
        7Mdb0Y0iLQZazdokAH8P+rc=
X-Google-Smtp-Source: ABdhPJxABOGPSB9I/bbJnveSi6g0bKjSjC49IqGgcmQxnyaj9/UyMkv5F16NZY+hJp6pDFY2WbWHMg==
X-Received: by 2002:a17:90a:4490:: with SMTP id t16mr14563959pjg.193.1624071178679;
        Fri, 18 Jun 2021 19:52:58 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id gd3sm11820342pjb.39.2021.06.18.19.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jun 2021 19:52:58 -0700 (PDT)
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry
 points
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
 <91865b90-c597-6119-5e14-dfe521a33489@gmail.com>
 <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
 <2b2ba866-104c-afea-9c29-145e9d80c2d5@gmail.com>
 <CAHk-=wjFG7zfO7RXu8RUOkuRPE59-OuqzBFsH-Zk1ieSKYbrYA@mail.gmail.com>
 <CAHk-=wgJkOSXKTL8L9Pv1k0T5tfUmCogsSGfbBdU_3ekS0dW7w@mail.gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ca589151-212d-8009-2171-df4050536e0b@gmail.com>
Date:   Sat, 19 Jun 2021 14:52:49 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgJkOSXKTL8L9Pv1k0T5tfUmCogsSGfbBdU_3ekS0dW7w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

that one boots OK now, thanks (applied on top of mine but that should 
not matter). I'll run a test on the actual hardware once the previous 
one is done.

Cheers,

	Michael


Am 19.06.2021 um 14:13 schrieb Linus Torvalds:
> On Fri, Jun 18, 2021 at 6:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The registers being zero at that point is actually expected, so that's
>> not much of a hint. But yeah, clearly I got some stack initialization
>> offset or something wrong there, and I don't know modern m68k nearly
>> well enough to even guess where I screwed up.
>
> Oh. I think I might have an idea.
>
> In that ret_from_kernel_thread code, after it returns from thge kernel
> thread, I did
>
>         addql   #4,%sp
>         RESTORE_SWITCH_STACK
>         jra     ret_from_exception
>
> where that "RESTORE_SWITCH_STACK" loads the user space registers from
> the user-space switch stack.
>
> BUT.
>
> The switch stack also has that "retpc", and that one should just be popped.
>
> So I think that code should read
>
>         addql   #4,%sp
>         RESTORE_SWITCH_STACK
>         addql   #4,%sp
>         jra     ret_from_exception
>
> because we want to restore the switch stack registers (they'll all be
> 0) but we then want to get rid of retpc too before we jump to
> ret_from_exception, which will do the RESTORE_ALL.
>
> (The first 'addql' is to remove the argument we've pushed on the stack
> earlier in ret_from_kernel_thread, the second addql is to remove
> retpc).
>
>  All the *normal* uses of RESTORE_SWITCH_STACK will just do "rts", but
> that's because they were called from the shallower stack. The
> ret_from_kernel_thread case is kind of special, because it had that
> stack frame layout built up manually, rather than have a call to it.
>
> In that sense, it's a bit more like the 'do_trace_entry/exit' code,
> which builds that switch stack using
>
>         subql   #4,%sp
>         SAVE_SWITCH_STACK
>
> and then undoes it using that same
>
>         RESTORE_SWITCH_STACK
>         addql   #4,%sp
>
> sequence that I _should_ have done in ret_from_kernel_thread. (Also,
> see ret_from_signal)
>
> I've attached an updated patch just in case my incoherent ramblings
> above didn't explain what I meant. It's the same as the previous
> patch, it just has that one extra stack update there.
>
> Does _this_ one perhaps work?
>
>                  Linus
>
