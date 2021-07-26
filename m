Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477EC3D6825
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 22:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhGZTtM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 15:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhGZTtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 15:49:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23508C061757
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 13:29:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso1736935pjf.4
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b0cpUmTkdR33wAPZUmcINMwluTGFSUTfQo/46a4YWL8=;
        b=rbE2sK8qHvFmr7d1frDPkyXLmKaemGwoJT8N2gj5o63Gq+IAjb7IM068DJB3AlUhWi
         33GMwgVloKH44e0/ctG6JkbdDUhczbZJoh2aoQO5mHUwrM4ReB09HLXfaOxGArhbwbDQ
         F78oL7wZba7Ua3hPYqiD2lemVCPVEKuQGB3KBmfAVsMff3HVftc1YPrkxjuR3sMAQqv/
         YptkBYsQayrrpqRk/BrZ1fiSYqrEv/adjam1cBNVRZxAS/sNLfpqd0Pysy7DBcflY3Cq
         Dp5vP1oHM6wS66xWBL/7spKMTNG2iZlRHFpD6txbDrRbaR7VRm3+XSRZ4+cP4gVxmii7
         Z0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b0cpUmTkdR33wAPZUmcINMwluTGFSUTfQo/46a4YWL8=;
        b=MecYs3hq2/FEMzHJBBNzf6C2OguqqK3+wEF0cuvZQy6n919fo0gOeOweZb7CRSrgs4
         Ub29HX/m+56HLY996skMy7ZEf/ZWw761Ud+q36NezQ7c8cdAJXIHgGpglkpzJGtW3z3Q
         8izLnBsxKYaYgZ6E7NFwZnah2EWIfxdmZNrO+cH7wdrgE76Xpvxg/wIPsupsTg87Cjp4
         frQkje5FPumCXNMUifPhAksmgMeOm/73LQznDlc555oLrcpNKM/X1dOMpxEYOHT1/Ea/
         oy9xJhYB06e9eAs+NKJuJR34Ag9nMXg2ZdRFlCH8p0ZH/hNG4X5M/23maVBYY0tIzzq1
         MUwA==
X-Gm-Message-State: AOAM533AF4rWGklreLMLkDB0a/vv2V8NPsE3inFQID7/IyEULGQqzKfo
        1CZOH5PKP6/L43PNNI13IGc=
X-Google-Smtp-Source: ABdhPJx705wWfBlEiGq/mvRaFBLynOBWoa4BdeAycqugizLlQFub8ONIjBe2pLWETduh27cxD9swwA==
X-Received: by 2002:a63:5620:: with SMTP id k32mr19900506pgb.32.1627331379495;
        Mon, 26 Jul 2021 13:29:39 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:7043:97bb:80f3:5eda? ([2001:df0:0:200c:7043:97bb:80f3:5eda])
        by smtp.gmail.com with ESMTPSA id ce15sm384440pjb.48.2021.07.26.13.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 13:29:38 -0700 (PDT)
Subject: Re: [RFC][PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in
 fpsp040_die
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brad Boyer <flar@allandria.com>,
        Andreas Schwab <schwab@linux-m68k.org>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87h7gopvz2.fsf@disp2133>
 <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com> <877dhio13t.fsf@disp2133>
 <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com> <87tukkk6h3.fsf@disp2133>
 <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com> <87eebn7w7y.fsf@igel.home>
 <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
 <20210725101253.GA6096@allandria.com>
 <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com> <87a6m8kgtx.fsf_-_@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <33327fd4-47fc-2eab-04e4-242697a23d5f@gmail.com>
Date:   Tue, 27 Jul 2021 08:29:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87a6m8kgtx.fsf_-_@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

looks good to me!

On 27/07/21 7:36 am, Eric W. Biederman wrote:
> In the fpsp040 code when copyin or copyout fails call
> force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).
>
> This solves a couple of problems.  Because do_exit embeds the ptrace
> stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
> that to work correctly.  There is always the information needed for a
> ptrace stop where get_signal is called.  So exiting with a signal
> solves the ptrace issue.
>
> Further exiting with a signal ensures that all of the threads in a
> process are killed not just the thread that malfunctioned.  Which
> avoids confusing userspace.
>
> To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
> save all of the registers and jump to ret_from_exception (which
> ultimately calls get_signal) after fpsp040_die returns.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> Can someone please check my m68k assembly changes?
>
> I think I have them correct, and the code assembles but I don't
> understand the fine points of when the different branch instructions
> should be used.

Since the exception handler ends up in a different text section from the 
actual code, long offsets are in use for jumps there.

According to the gas manual (and pointed out by Andreas just now), 'jmp' 
is used only for longword offsets on 68000/010. Use 'bral' for 020 etc. 
The pseudo-ops 'jra' or 'jbra' will pick the correct version (shortest 
offset possible). Similar for 'jbsr' when calling a subroutine.

  1:
-    jbra    fpsp040_die
+    jbsr    fpsp040_die
+    jbra    .Lnotkern

would be the most generic version to write this (but as this code is 
never used on 68000, 'brsl' and 'jbra' is perfectly OK).

Cheers,

     Michael

>
>   arch/m68k/fpsp040/skeleton.S | 3 ++-
>   arch/m68k/kernel/traps.c     | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> index a8f41615d94a..ec767523c012 100644
> --- a/arch/m68k/fpsp040/skeleton.S
> +++ b/arch/m68k/fpsp040/skeleton.S
> @@ -502,7 +502,8 @@ in_ea:
>   	.section .fixup,#alloc,#execinstr
>   	.even
>   1:
> -	jbra	fpsp040_die
> +	bsrl	fpsp040_die
> +	jmp	.Lnotkern
>   
>   	.section __ex_table,#alloc
>   	.align	4
> diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> index 9e1261462bcc..5b19fcdcd69e 100644
> --- a/arch/m68k/kernel/traps.c
> +++ b/arch/m68k/kernel/traps.c
> @@ -1150,7 +1150,7 @@ asmlinkage void set_esp0(unsigned long ssp)
>    */
>   asmlinkage void fpsp040_die(void)
>   {
> -	do_exit(SIGSEGV);
> +	force_sigsegv(SIGSEGV);
>   }
>   
>   #ifdef CONFIG_M68KFPU_EMU
