Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7053CC168
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jul 2021 07:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhGQFlH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Jul 2021 01:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGQFlH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Jul 2021 01:41:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A12C06175F
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 22:38:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 37so12160613pgq.0
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ufZLoU++KwzTLrSeOiNHYHKkFRVcvivHEu5YkyD6pFM=;
        b=bvVTP4elDiw5wrqRF917W8S6tLCfHIxaLKkqWeUzQNzC90aVtuY8f/3iRmfo+Btalb
         ZuRyd+bypUChxdxIBqPhWdKugitLldEIZmysifsRvacOx1j5d4Ka3muiMBmgt1HXZW9b
         1F+7RCs4gMXA4nWzDdE/wdaY3zoqX8YlFeNVQElgHfrM7hogA73VGWkVCQsyuynElbbR
         k5yNV+DSXDZgaHkPZlY6OCQ6vjp8AFvkqR9ScvieqgO8JqjqAEgjUbMyXPiwZ2BadkSM
         9TlAx7eOj9fBAwnNffQbitbiZhr8LdUe9Bu/iD9vCD69OcpUPL6DatiRZGcZfIsuTr2o
         pvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ufZLoU++KwzTLrSeOiNHYHKkFRVcvivHEu5YkyD6pFM=;
        b=nGSRkXQBtHo95HbAh0RN7PMoy2VCkfJv3I0dFqIu+KjFJOF7SpZAEdIxP1rXVoCFAj
         WPeHJ/4dcamtQiSWT24RsGjHD7+0b9UQEBHasDE6lBsYow/t5E/uGQJHltZvEaA+/Tu8
         TCxJq7H4bCMN7Z7A9oYmlgf9o1MNS3pUaoiLce8dLwmQE25NW9k63W5c6rSVXEMLcq84
         jdee7+DAd1UJxtfxaxTEwV0NA+i5fjFoNDC8+wySfrxhnuhnd9kQ4+qY462g432R1T6q
         x10PBmA79qmP7kuvSLWVR1IAto0jFnKeo4g2yYdYHrANrYe0uiDU/pnMGGLYUNTtiwCT
         XwIg==
X-Gm-Message-State: AOAM533gcMDMBR44WFel5xJ0B4QCWLyrNSAZEHor9AQ5lYRdSyiBVwLF
        SAVJSBwkzBacVqi2jj6fjER6v6O/EkE=
X-Google-Smtp-Source: ABdhPJwefctfw8nGpJeddfKU/GJyORZWYibARYL0WRzSQ8gucpY3XgMp9rjp+Ka3lgQRYuciF872Tg==
X-Received: by 2002:a63:2308:: with SMTP id j8mr9411051pgj.166.1626500289745;
        Fri, 16 Jul 2021 22:38:09 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id j20sm11824131pfc.203.2021.07.16.22.38.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jul 2021 22:38:09 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com>
Date:   Sat, 17 Jul 2021 17:38:01 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 16.07.2021 um 11:10 schrieb Michael Schmitz:
> Eric,
>
> On 16/07/21 1:29 am, Eric W. Biederman wrote:
>>
>> I have been digging into this some more and I have found one place
>> that I am having a challenge dealing with.
>>
>> In arch/m68k/fpsp040/skeleton.S there is an assembly version of
>> copy_from_user that calls fpsp040_die when the bytes can not be read.
>>
>> Now fpsp040_die is just:
>>
>> /*
>>   * This function is called if an error occur while accessing
>>   * user-space from the fpsp040 code.
>>   */
>> asmlinkage void fpsp040_die(void)
>> {
>>     do_exit(SIGSEGV);
>> }
>> The problem here is the instruction emulation performed in the fpsp040
>> code performs a very minimal saving of registers.  I don't think even
>> the normal system call entry point registers that are saved are present
>> at that point.
>>
>> Is there any chance you can help me figure out how to get a stack frame
>> with all of the registers present before fpsp040_die is called?
>
> I suppose adding the following code (untested) to entry.S:
>
> ENTRY(fpsp040_die)
>         SAVE_ALL_INT
>         jbsr    fpsp040_die_c
>         jra     ret_from_exception
>
> along with renaming above C entry point to fpsp040_die_c would add the
> basic saved registers, but these would not necessarily reflect the state
> of the processor when the fpsp040 trap was called. Is that what you're
> after?

I should have looked more closely at skeleton.S - most FPU exceptions 
handled there call trap_c the same way as is done for generic traps, 
i.e. SAVE_ALL_INT before, ret_from_exception after.

Instead of adding code to entry.S, much better to add it in skeleton.S. 
I'll try to come up with a way to test this code path (calling 
fpsp040_die from the dz exception hander seems much the easiest way) to 
make sure this doesn't have side effects.

Does do_exit() ever return?

Cheers,

	Michael
