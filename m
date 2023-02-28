Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB86A5F81
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjB1TTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 14:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjB1TTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 14:19:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FD1ABCC;
        Tue, 28 Feb 2023 11:19:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2267941pjv.0;
        Tue, 28 Feb 2023 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677611948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpEVz7SmprPoPkB0vfE/PqJxuugSFBKj6AY2r5uLAhc=;
        b=oWlcXRzyqWqEIYwyzrAbhH5dfbtnZIzo1YdAD6EbxrkG1UYmywauWswlbWUb9RyzJT
         brrhvXg9BV/J80dlhPlO1Y21wLf6vRkFdXy7JICIvDrelyzHIZjZVwrR4yuaicL7f3Vk
         2p3merJr6M4IafXoXz51BvBxgjw+2vFOvA7iQCX7+ipsnTqqyjWJ3THXEnrQ8p4gJgDk
         xZ3DYrEnn6dh5SSFWIpnSPW533U6fF1NRXuZZhGMXkF858tTyzkALowN2hKgVfeUNsrR
         5wS/6VMndefgSb0UUhYGxgiYLa81lYWrHHI0iDazPBKk+F/PHzqrgvgcgWVcBnyOqxfC
         HgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677611948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpEVz7SmprPoPkB0vfE/PqJxuugSFBKj6AY2r5uLAhc=;
        b=IgsDJxxCebXYqyEY3kq3eAZdEaGlndayAJAbti+v7t6YgV0B4z5WRhuecd2IkF8Ucf
         A2ZEoMjUhlbAEM1niF7z5pWOThppZOWBDHqDYJgOPbpzrytgfyb5eYn/5ErODHbbrR0X
         vMWhnRxnbC0tbP/hTo9zp8LaCHkzsTnX2W5LRWSR4536Zwj11A92sNHUyhRVVYEDcknq
         pIrmVuON72UR1COYISpDd0Rv/ke3KAuHQdF+SooG/0PZ4MtxmaYibgi8WJYYH+HPhCKf
         iiZ0RBUEwh6WnSA19cjbvmaviOosFVWxIEZkjDQJ9cCN0cI4jmVaS+sKGukpV0oN7ktg
         6usA==
X-Gm-Message-State: AO0yUKWTFIkqJ1sMX5Qz4h+3g8m4ELIfZ7o9NrHu2clTzrhEfnw04ymT
        ydHaO0NmsdnFMJ6H4fX3J5sjYRPwGhMvHA==
X-Google-Smtp-Source: AK7set9nvpB6Jm7bh8EL2CSZ/onqaLVDtbrhvaG0Y49z4Hn9XsjcfvrcAyDG9rY99D0UL9m1Qq4bXA==
X-Received: by 2002:a05:6a20:7f8e:b0:cb:6e9e:e6df with SMTP id d14-20020a056a207f8e00b000cb6e9ee6dfmr5180512pzj.14.1677611948146;
        Tue, 28 Feb 2023 11:19:08 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:112f:75e9:7ff2:6774? ([2001:df0:0:200c:112f:75e9:7ff2:6774])
        by smtp.gmail.com with ESMTPSA id j8-20020a62b608000000b005ded4825201sm6382146pff.112.2023.02.28.11.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 11:19:07 -0800 (PST)
Message-ID: <f619e8ce-1fce-ace9-3685-e0b50646e8fb@gmail.com>
Date:   Wed, 1 Mar 2023 08:18:59 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0w4M91DwYLO3N@ZenIV>
 <20230228152236.GA4088022@roeck-us.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <20230228152236.GA4088022@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guenter,

On 1/03/23 04:22, Guenter Roeck wrote:
> On Tue, Jan 31, 2023 at 08:06:27PM +0000, Al Viro wrote:
>> parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
>> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
>> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
>> to page tables.  In such case we must *not* return to the faulting insn -
>> that would repeat the entire thing without making any progress; what we need
>> instead is to treat that as failed (user) memory access.
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> ---
>>   arch/parisc/mm/fault.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
>> index 869204e97ec9..bb30ff6a3e19 100644
>> --- a/arch/parisc/mm/fault.c
>> +++ b/arch/parisc/mm/fault.c
>> @@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
>>   
>>   	fault = handle_mm_fault(vma, address, flags, regs);
>>   
>> -	if (fault_signal_pending(fault, regs))
>> +	if (fault_signal_pending(fault, regs)) {
>> +		if (!user_mode(regs))
>> +			goto no_context;
> 0-day rightfully complains that this leaves 'msg' uninitialized.
>
> arch/parisc/mm/fault.c:427 do_page_fault() error: uninitialized symbol 'msg'
>
> Guenter

What happens if you initialize msg to "Page fault: no context" right at 
the start of do_page_fault (and drop the assignment a few lines down as 
that's now redundant)?

(Wondering if the zero page access on parisc could cause a trip right 
back into do_page_fault, ad infinitum...)

Cheers,

     Michael


>>   		return;
>> +	}
>>   
>>   	/* The fault is fully completed (including releasing mmap lock) */
>>   	if (fault & VM_FAULT_COMPLETED)
