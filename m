Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE557A6E6
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiGSTF3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiGSTF1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 15:05:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96C42AD9;
        Tue, 19 Jul 2022 12:05:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g126so14460058pfb.3;
        Tue, 19 Jul 2022 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TU4UpPo9ZVPBxhlcj9sePtcValYnuhCsXqSVbDsLcgY=;
        b=B8wRTnhZUqlyX8fhAN6D6BU/0t0GXgOU5OOi6oi2KlBRXDSVm/7Lh0S+7g4Xo5dg7W
         pfstOWdCb4AN+AD/UhKuHGH9xIArbAPp+8/dHy1RIU7jS3N8CdYv0Rf+xYEnOxoPDFhj
         KlUb+Lx1bBR42XKkWqEoZo9BjvjBZCPK5HaxCf4G2PXmTx4AJWv82zAR0mWLEC51R+cx
         m4xss1z781Wl0nV26E5xWlFwRDxG4Tg0dYfXN2zscsZFQE2py6LnNxWv4gqoqqQ4EmdX
         T7+/Be44SzPT9Gu8+98tYcCq37HNkkTOT5sdncINA0Pi3Vwia7qn2HJfPL25yKAl3zjQ
         rogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TU4UpPo9ZVPBxhlcj9sePtcValYnuhCsXqSVbDsLcgY=;
        b=FOxlcniOmUNYXWlcdy/xMexC7IaoI1mrIQ3G86+CIgdIQeNkJOriRKvgqIRJEq1+AQ
         VLjvYQio1IqQQ/fxMlhGQNzBtNPRlRuvA2rKArhxPQ8+D1iNitZ7qYKnH9ax9qwcZLIz
         L35o4V5rsrwRTmdcp41tk8VYmy3o1hUiqhkrpuBYEyxG3++ua99Xhp+leBNkdr0NBFWO
         dJxcuLhTcoOoMJAQjVayxldus76RXQoyu3YIVxw9Vio+ZEc5Tjg84QLVIp7h20tMtXmv
         7w+odtXde+wpn8T7X9pwF5LVIrCHSMjP9347rZfb0C/FBzzArDQ15g0UpwoH0mRcrEzm
         Y72Q==
X-Gm-Message-State: AJIora/L9CMW6a8iLFgK3x2mbyTYhZlleGBxmnpIqciKKseKzXWM53x8
        kdRWL69+FtWYRP3In1cL1aA=
X-Google-Smtp-Source: AGRyM1upOS8vn6kxXT6sf8Gy6sLvlnBduGdiGyoaV2Cov1g/WnBNdslNVAgtz0RTg4fMMbiVnWdPGg==
X-Received: by 2002:a62:ea01:0:b0:52b:39ec:a72f with SMTP id t1-20020a62ea01000000b0052b39eca72fmr25324858pfh.52.1658257524985;
        Tue, 19 Jul 2022 12:05:24 -0700 (PDT)
Received: from [192.168.1.106] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b00168a216f629sm12315119plg.11.2022.07.19.12.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:05:24 -0700 (PDT)
Message-ID: <2656551b-2c6f-9f0d-93a6-ef6177ec265e@gmail.com>
Date:   Tue, 19 Jul 2022 12:05:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock
 re-definition
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
 <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/19/2022 12:42 AM, Arnd Bergmann wrote:
> On Fri, Jul 15, 2022 at 8:55 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Building perf for MIPS failed after 9f79b8b72339 ("uapi: simplify
>> __ARCH_FLOCK{,64}_PAD a little") with the following error:
>>
>>    CC
>> /home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o
>> In file included from
>> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:77,
>>                   from ../include/uapi/linux/fcntl.h:5,
>>                   from trace/beauty/fcntl.c:10:
>> ../include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of
>> 'struct flock'
>>   struct flock {
>>          ^~~~~
>> In file included from ../include/uapi/linux/fcntl.h:5,
>>                   from trace/beauty/fcntl.c:10:
>> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:63:8:
>> note: originally defined here
>>   struct flock {
>>          ^~~~~
>>
>> This is due to the local copy under
>> tools/include/uapi/asm-generic/fcntl.h including the toolchain's kernel
>> headers which already define 'struct flock' and define
>> HAVE_ARCH_STRUCT_FLOCK to future inclusions make a decision as to
>> whether re-defining 'struct flock' is appropriate or not.
>>
>> Make sure what do not re-define 'struct flock'
>> when HAVE_ARCH_STRUCT_FLOCK is already defined.
>>
>> Fixes: 9f79b8b72339 ("uapi: simplify __ARCH_FLOCK{,64}_PAD a little")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   tools/include/uapi/asm-generic/fcntl.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
>> index 0197042b7dfb..312881aa272b 100644
>> --- a/tools/include/uapi/asm-generic/fcntl.h
>> +++ b/tools/include/uapi/asm-generic/fcntl.h
>> @@ -185,6 +185,7 @@ struct f_owner_ex {
>>
>>   #define F_LINUX_SPECIFIC_BASE  1024
>>
>> +#ifndef HAVE_ARCH_STRUCT_FLOCK
>>   struct flock {
>>          short   l_type;
>>          short   l_whence;
>> @@ -209,5 +210,6 @@ struct flock64 {
>>          __ARCH_FLOCK64_PAD
>>   #endif
>>   };
>> +#endif /* HAVE_ARCH_STRUCT_FLOCK */
>>
> 
> I applied this to the asm-generic tree, but now I'm having second thoughts, as
> this only changes the tools/include/ version but not the version we ship to user
> space. Normally these are meant to be kept in sync.

Thanks! Just to be clear, applying just your patch is not enough as the 
original build issue is still present, so we would need my change plus 
yours, I think that is what you intended but just wanted to double 
confirm. On a side note your tree at:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/refs/heads

does not appear to have it included/pushed out yet, should I be looking 
at another git tree?

> 
> It appears that commit 306f7cc1e906 ("uapi: always define
> F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h") already caused
> them to diverge, presumably the uapi version here is correct and we
> forgot to adapt the tools version at some point. There are also some
> non-functional differences from older patches.
> 
> I think the correct fix to address the problem in both versions and
> get them back into sync would be something like the patch below.
> I have done zero testing on it though.
> 
> Christoph and Florian, any other suggestions?

This works for me with my patch plus your patch in the following 
configurations:

- MIPS toolchain with kernel-headers 4.1.x
- MIPS toolchain with kernel headers using my patch plus your patch

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
