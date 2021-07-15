Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC703CAF8D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 01:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGOXNx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 19:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXNx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 19:13:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F7C06175F
        for <linux-arch@vger.kernel.org>; Thu, 15 Jul 2021 16:10:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y17so8089363pgf.12
        for <linux-arch@vger.kernel.org>; Thu, 15 Jul 2021 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZKZNTsgqHnrNxZh/SAE44Z985am6aILcgY4zhrZ3sxk=;
        b=uVz+OK2Jy4a8lEKsLSEGo2j1vou015O6gC9GsKtddySmvXtX+CSdbrKyqdLjsBMUF2
         vpqzoUWOW64LAYpqs1+N5eQoz9aJzzl4kzvwyK9kb8CXZCLHYIQhQvJiS663Jm7H6Pjo
         17js2HbJ5oCXPXIUPBsx3wyKahSqtTewSYNeA1pLxmSq1KNYf0XbRAo/v8kfOGoBWGn8
         NwiT68BSLKzepQkty7vRcAbC0q7yFSd9FN0uwRgb3sJnsrsJ/kW2ta2Y6FUXvzPlgNzE
         sF8Mo1osKd2lSpgTs0tZqRBpZQYpX62/cFIGH4yUwwftHFdoK/IxrNoFBq5W1vstX0ef
         9Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZKZNTsgqHnrNxZh/SAE44Z985am6aILcgY4zhrZ3sxk=;
        b=JSvdKYojiNkpI7fkWHiJqtqRIcvhy6wQA3cGprFi7T9i7HPaQjWmY1RgRyhXNIxZ6I
         YdCqIHE9au5JFIWOJoGBpCRswzaOEe00Wvi3QDQiFVuQIANkxTMlli8vKXvGJ1mYpkt/
         YKOKdFwWMfD9wFMKwYKOnib8/aX5XAcLx1JPS8CQn7v+0uTPsdJsbTgI3mysSbnKLNUp
         9nDL72bkGt7FnsC08S3RiB7hAQ1qGH28tdwJaK016V3GorMDt/4uE894h/ZyVLnzp5YG
         YaDUDTwJ7oWeOoSVA26FfTvMZ+OXgsEV08Sqsfyh6cJIRCdrXqsDndbZ/5ZAsfKs71yC
         pWoA==
X-Gm-Message-State: AOAM532n+CQGKMsI3BlN+MReb7lxsr0uvZ4YQydOfD27r21YPAEzlyYv
        TaqmDJpm9+umzah+/Y6r7ao=
X-Google-Smtp-Source: ABdhPJwybjkcSwKtfczA7oymoeqzSzOmRRYi0V9ZLJiuYIboLaS3xmHLMdLh3JNFWGCCB/H2sT6bRA==
X-Received: by 2002:a05:6a00:234f:b029:32d:fceb:4f8a with SMTP id j15-20020a056a00234fb029032dfceb4f8amr6934196pfj.11.1626390659315;
        Thu, 15 Jul 2021 16:10:59 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:bd84:68b:cf56:4515? ([2001:df0:0:200c:bd84:68b:cf56:4515])
        by smtp.gmail.com with ESMTPSA id z5sm7666960pfb.114.2021.07.15.16.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 16:10:58 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
Date:   Fri, 16 Jul 2021 11:10:53 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87zgunzovm.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Eric,

On 16/07/21 1:29 am, Eric W. Biederman wrote:
>
> I have been digging into this some more and I have found one place
> that I am having a challenge dealing with.
>
> In arch/m68k/fpsp040/skeleton.S there is an assembly version of
> copy_from_user that calls fpsp040_die when the bytes can not be read.
>
> Now fpsp040_die is just:
>
> /*
>   * This function is called if an error occur while accessing
>   * user-space from the fpsp040 code.
>   */
> asmlinkage void fpsp040_die(void)
> {
> 	do_exit(SIGSEGV);
> }

In other places (bus error handlers) we have

force_sig(SIGSEGV);

or

force_sig_fault(sig, si_code, addr);

(the latter for floating point traps from FPU hardware). Would that be 
any better?

>
> The problem here is the instruction emulation performed in the fpsp040
> code performs a very minimal saving of registers.  I don't think even
> the normal system call entry point registers that are saved are present
> at that point.
>
> Is there any chance you can help me figure out how to get a stack frame
> with all of the registers present before fpsp040_die is called?

I suppose adding the following code (untested) to entry.S:

ENTRY(fpsp040_die)
         SAVE_ALL_INT
         jbsr    fpsp040_die_c
         jra     ret_from_exception

along with renaming above C entry point to fpsp040_die_c would add the 
basic saved registers, but these would not necessarily reflect the state 
of the processor when the fpsp040 trap was called. Is that what you're 
after?

To add the rest of the switch stack (again, won't reflect state before 
entering fpsp040), try:

ENTRY(fpsp040_die)
         SAVE_ALL_INT

         SAVE_SWITCH_STACK

         jbsr    fpsp040_die_c

         addql   #24,%sp_c

         jra     ret_from_exception


If you need the registers saved at fpsp040 entry, the only way I can see 
is to change the code in arch/m68k/kernel/vectors.c to use a common fpsp 
trap entry point that saves state, before jumping to the desired fpsp040 
entry point using a FPU trap table. Just like we do for system calls.

Cheers,

     Michael


> Eric
