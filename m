Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF36633E05
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 14:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiKVNq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 08:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiKVNq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 08:46:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D85E3EA;
        Tue, 22 Nov 2022 05:46:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b11so13305251pjp.2;
        Tue, 22 Nov 2022 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVTM4A73qJGSSEloWNLoqvF5MY8jd3iZQoKxxU2Mn44=;
        b=n1uPwGarX993N3niKUyWMplrgd30jCR09b8RxbKnmLZHi26Z6w5oRDEodA/jhkNWmu
         kRtNWvzxuLPpp6UWErGjbIcwTVG5xegoqyCH5ArX0TV8XJzaYGlyfsY0XmNGfwfayT/L
         h4NXCXOkV1kivV8DUtUCW2X0vIBH7yHaKnqr8K5AfEksDfHySFcTPz7A/NSQTSr5kJNW
         JOBtKM4IHPRJxf8U7xdBjQw2013as9wB3JZfIuaIQMZoRroTVG2oD047GwYJrOBE69xp
         e94ZCusqpC8lUDK2oYYancD1JRAFE8/HY1fJjVIi7P3YMfYl1lqF06zFUmcmAUI/H9CV
         e53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVTM4A73qJGSSEloWNLoqvF5MY8jd3iZQoKxxU2Mn44=;
        b=4J6fgmNrElsrRMlQ5kzQeTvb3CLUHejbk9oH58EFiaw48wKhewn3mDMXddrkm3x4ZK
         eGN3Cexqd0x4H0ePWpsDy23AErz+mCeBi42SvFgUPtg1ComnuQspfKZeQXrR1J26spVZ
         7R3OQnr0U7M9R3a0T3YABmhNrZQuAc+PhstXxrHSP0NQWaZceo2jy9WLwXaR2GkAJa8Q
         4EFiH4r1wvmsQKwAA81Kljj/aColY5M6BqR47vzoyKQ3+3T4gAEnPA7cBwQlZIuL3i/e
         fqIoLkcAw4T2l4SRM7ZoXoipE/UQScpXkrWHoNRMDdElTAVYDHI+ERHTdkqTZ1xM4QZC
         7Ivg==
X-Gm-Message-State: ANoB5pmo8s5chGeSvqYN3uPGcpKKxLq78gABFtZGtqnlgWzhXqNqLAuq
        m+KlTaOee6hbZQdrTb23w6CSpJi1KjcOXib/
X-Google-Smtp-Source: AA0mqf6mBuVBnHthUDZGJp4gDXN9r+8/41ANiXXoYROa2Ht1Ikc9yTyJpUdZx6kFEKWWVOZBOGVSaA==
X-Received: by 2002:a17:902:b40b:b0:188:75bb:36d4 with SMTP id x11-20020a170902b40b00b0018875bb36d4mr4724061plr.55.1669124786804;
        Tue, 22 Nov 2022 05:46:26 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709027fc800b00186c37270f6sm11921165plb.24.2022.11.22.05.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 05:46:25 -0800 (PST)
Message-ID: <2f3c100f-355d-e4f2-ff42-2cb076e8aa86@gmail.com>
Date:   Tue, 22 Nov 2022 21:46:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
To:     "Kalra, Ashish" <ashish.kalra@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-17-ltykernel@gmail.com>
 <116799e9-8b14-66d6-d494-66272faec9e9@amd.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <116799e9-8b14-66d6-d494-66272faec9e9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/21/2022 11:05 PM, Kalra, Ashish wrote:
>> +static void do_exc_hv(struct pt_regs *regs)
>> +{
>> +    union hv_pending_events pending_events;
>> +    u8 vector;
>> +
>> +    while (sev_hv_pending()) {
>> +        asm volatile("cli" : : : "memory");
>> +
> 
> Do we really need to disable interrupts here, #HV exception will be 
> dispatched via an interrupt gate in the IDT, so interrupts should be 
> implicitly disabled, right ?
>>    panic("Unexpected vector %d\n", vector);
>> +                unreachable();
>> +            }
>> +        } else {
>> +            common_interrupt(regs, pending_events.vector);
>> +        }
>> +
>> +        asm volatile("sti" : : : "memory");
> 
> Again, why do we need to re-enable interrupts here (in this loop), 
> interrupts will get re-enabled in the irqentry_exit() code path ?

Hi Ashish:
	Thanks for your review.	check_hv_pending() is also called in the
native_irq_enable() to handle some pending interrupt requests after re
-enabling interrupt. For such case, disables irq when handle exception
or interrupt event.


