Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AF3D0462
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhGTVgh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbhGTVgd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jul 2021 17:36:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D2C061767
        for <linux-arch@vger.kernel.org>; Tue, 20 Jul 2021 15:16:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2578449pjx.1
        for <linux-arch@vger.kernel.org>; Tue, 20 Jul 2021 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HMP4hOg3SpK+nsKtMUngLG5eW2U79IIKIlymfzgnAXs=;
        b=hXUjgTVkiGDcwRj0K05Ze1rB4fS2Tk8YOBWplqcHc/RigtxHWeA743PNhvx6dnYMnq
         ePnWoKM6/hjh5nXSS3yKHnFlNiJLuAE4xb8Htd8G9e+81G51Mjc4yqzSsIlpLz2puMfs
         CiUSQEsh4GELOi0RKKxG4HvBpzIZC6HC4D9Ozk+T7oJ3R9lVK9+z29LKinq9yhF2M1UE
         tHL6vkX40Xx2LPjW287pN5LNzoTHQ5KB0KrDi46QPn0J89XdTc7CxqXavBkDzKGMm0nR
         OYDWlh8tkedWHon/t845oVJx/81lHguh5HVyzz8ifyZnJgP9sutebEgpV4x2fkNlz/fU
         cQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HMP4hOg3SpK+nsKtMUngLG5eW2U79IIKIlymfzgnAXs=;
        b=F9ElXyR+bi4BJ2ktcvgixugk0pk712pK3b4FSdLcmEr7S1rShsrqzWnnsjkZRgFDtq
         A6SWSjEuWGaOl2d91iV6JEYgghbfEMZDNaTbsDtv/y4zj4f61lHqgpOYZG4y+XLaoMGb
         uSEfTvSZ78meJKi+rY/gWQAoULEaY3l+QpjfDeaYp9Eq3Dx8PHYLzOjjMqZP7xsvyqTU
         TV6q2dUI3jOVykHtJyMNGH7urxDk8loKvbbqisioogL4UhJeySL9InhknfvPycJsrIbQ
         MUC8A1malNiDIA2Ubmgg+SbCP9+IBl27YFl7mXIOKWR4oSxFPGhCc1uw5wms9SSN9q9J
         vmHA==
X-Gm-Message-State: AOAM531h3C1Cy77jvCu0GSNb2beQMcHXyNyFD1njIqbTR3meugApOtxE
        vapkwwrs1zwc5EiyS0AeLBs=
X-Google-Smtp-Source: ABdhPJwEPgQZE7JpUgmFjH+qkNOCJb48z+MSJu0/zjqro44n6IkH2fjA3vP8tuRIgejRIs6b0U8zqw==
X-Received: by 2002:a17:90a:2906:: with SMTP id g6mr31523081pjd.100.1626819370838;
        Tue, 20 Jul 2021 15:16:10 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9497:db03:a72f:4a88? ([2001:df0:0:200c:9497:db03:a72f:4a88])
        by smtp.gmail.com with ESMTPSA id s36sm12519531pgl.8.2021.07.20.15.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 15:16:10 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87h7gopvz2.fsf@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
Date:   Wed, 21 Jul 2021 10:16:05 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7gopvz2.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

On 21/07/21 8:32 am, Eric W. Biederman wrote:
>
>> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
>> index a8f4161..6c92d38 100644
>> --- a/arch/m68k/fpsp040/skeleton.S
>> +++ b/arch/m68k/fpsp040/skeleton.S
>> @@ -502,7 +502,17 @@ in_ea:
>>   	.section .fixup,#alloc,#execinstr
>>   	.even
>>   1:
>> +
>> +	SAVE_ALL_INT
>> +	SAVE_SWITCH_STACK
>          ^^^^^^^^^^
>
> I don't think this saves the registers in the well known fixed location
> on the stack because some registers are saved at the exception entry
> point.

The FPU exception entry points are not using the exception entry code in 
head.S. These entry points are stored in the exception vector table 
directly. No saving of a syscall stack frame happens there. The FPU 
places its exception frame on the stack, and that is what the FPU 
exception handlers use.

(If these have to call out to the generic exception handlers again, they 
will build a minimal stack frame, see code in skeleton.S.)

Calling fpsp040_die() is no different from calling a syscall that may 
need to have access to the full stack frame. The 'fixed location' is 
just 'on the stack before calling  fpsp040_die()', again this is no 
different from calling e.g. sys_fork() which does not take a pointer to 
the begin of the stack frame as an argument.

I must admit I never looked at how do_exit() figures out where the stack 
frame containing the saved registers is stored, I just assumed it 
unwinds the stack up to the point where the caller syscall was made, and 
works from there. The same strategy ought to work here.

>
> Without being saved at the well known fixed location if some process
> stops in PTRACE_EVENT_EXIT in do_exit we likely get some complete
> gibberish.
>
> That is probably safe.
>
>>   	jbra	fpsp040_die
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #4,%sp
>> +	rts
> Especially as everything after jumping to fpsp040_die does not execute.

Unless we change fpsp040_die() to call force_sig(SIGSEGV).

Cheers,

     Michael


>
> Eric
>
>
>>   
>>   	.section __ex_table,#alloc
>>   	.align	4
