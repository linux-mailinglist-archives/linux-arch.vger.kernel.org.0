Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D661530708B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 09:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhA1ICl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 03:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhA1IB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2021 03:01:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF0CC061574;
        Thu, 28 Jan 2021 00:00:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id e2so2760963lfj.13;
        Thu, 28 Jan 2021 00:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gnZ/GDloV555+OnWhNxGUyFa3V1UNr+TUyX9DCKmvmo=;
        b=BvV+OmW8dWjmNJDvcrvjzcva8OWBy7a8Wldf3TYz+i6X3QYbdYVdx8XtO5leAkHTrU
         w3YMC/VHtwxm1x/Ic4nsp2y26eWjsO1yakRgVNAsk/+vPQ3tFI4ORflBdiqudTUbNQ15
         4udiNHAeivKX5c5MMjdj7/0f+Ywbb21vVg6oz3mMUyOwECoUO5sTQ+F7gyKkdUAVhOze
         vsQP8Kn/mYUO89v8SJNtfvxDDv5uZaZ+sphCBYtGqh9qpfbAr39PdAciszAdWiMDq33U
         CM0tCQ9qP6AgV+zPptT62EH2DQH0UbsDLxpsVPp63My+wTEFFdBYjDtMPkofAyv61LZq
         z8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gnZ/GDloV555+OnWhNxGUyFa3V1UNr+TUyX9DCKmvmo=;
        b=K4RmJ5kFOcEdWQgZ3ZDvDa4E0LzNWkgiuJ3/ko5vTbsdDWwIjmLKQwdVv00MNNidzr
         oC5o9ck9SgesCG4hHdZCni+UaRGtTd+rNX7xMM+4V+aXNLPBBU9eY9XmjWreVNGuP2g+
         lQNZFkU9bPsQKZi6VH2hdHiFSwUu3IUTWu7hSTpMWTlr0IXCCC6W38f4joH5HWOvmbpM
         iIyKwJnIml0Yu13zhFw9tGHjr454WSiNYcEJL1uiledEonwXy1QYq3h9pCqZBIBT8Bcf
         VFym+6EF0YBsOWJondnrTLXoLc4MXbPVY0jPmx1dbnNDNI9cLDcFSkIffFfnGwr5s/AF
         jYlg==
X-Gm-Message-State: AOAM530wMLlXv9x1XIytZshcggobDbXI966tkRV5USly/On/xpsnEssv
        IXwOkkLM58pMy0+S3NLrEv0VmCxqeopthA==
X-Google-Smtp-Source: ABdhPJx0NmJx1f9alnrCE9Umt15J9iBGC/sPqz1LULvUs4CMEHAB23hGApY2DMjRufppP/iSttVSHw==
X-Received: by 2002:ac2:4907:: with SMTP id n7mr4218547lfi.213.1611820841569;
        Thu, 28 Jan 2021 00:00:41 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.159])
        by smtp.gmail.com with ESMTPSA id b18sm1359053lfj.140.2021.01.28.00.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 00:00:41 -0800 (PST)
Subject: Re: [PATCH 02/27] x86/syscalls: fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>, linux-arch@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-3-masahiroy@kernel.org>
 <dd37a7f2-55e1-2e96-0c93-4a40980b8ef2@gmail.com>
Organization: Brain-dead Software
Message-ID: <605cea27-bd69-5b21-f285-2d3d0f6abd23@gmail.com>
Date:   Thu, 28 Jan 2021 11:00:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dd37a7f2-55e1-2e96-0c93-4a40980b8ef2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28.01.2021 10:59, Sergei Shtylyov wrote:

[...]
>> Building kernel/sys_ni.c with W=1 omits tons of -Wmissing-prototypes
> 
>     Emits?
> 
>> warnings.
>>
>> $ make W=1 kernel/sys_ni.o
>>    [ snip ]
>>    CC      kernel/sys_ni.o
>> In file included from kernel/sys_ni.c:10:
>> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous 
>> prototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
>>     83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>>        |              ^~
>> ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro 
>> '__COND_SYSCALL'
>>    100 |  __COND_SYSCALL(x64, sys_##name)
>>        |  ^~~~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro 
>> '__X64_COND_SYSCALL'
>>    256 |  __X64_COND_SYSCALL(name)     \
>>        |  ^~~~~~~~~~~~~~~~~~
>> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>>     39 | COND_SYSCALL(io_setup);
>>        | ^~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous 
>> prototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
>>     83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>>        |              ^~
>> ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro 
>> '__COND_SYSCALL'
>>    120 |  __COND_SYSCALL(ia32, sys_##name)
>>        |  ^~~~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro 
>> '__IA32_COND_SYSCALL'
>>    257 |  __IA32_COND_SYSCALL(name)
>>        |  ^~~~~~~~~~~~~~~~~~~
>> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>>     39 | COND_SYSCALL(io_setup);
>>        | ^~~~~~~~~~~~
>>    ...
>>
>> __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
>> declarations. Let's do likewise for __COND_SYSCALL() to fix the
>> warnings.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>
>>   arch/x86/include/asm/syscall_wrapper.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/syscall_wrapper.h 
>> b/arch/x86/include/asm/syscall_wrapper.h
>> index a84333adeef2..80c08c7d5e72 100644
>> --- a/arch/x86/include/asm/syscall_wrapper.h
>> +++ b/arch/x86/include/asm/syscall_wrapper.h
>> @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs 
>> *regs);
>>       }
>>   #define __COND_SYSCALL(abi, name)                    \
>> +    __weak long __##abi##_##name(const struct pt_regs *__unused);    \
>>       __weak long __##abi##_##name(const struct pt_regs *__unused)    \
> 
>     Aren't these two lines identical?

     Ah, got it! :-)

[...]

MBR, Sergei
