Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE66E2863
	for <lists+linux-arch@lfdr.de>; Fri, 14 Apr 2023 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDNQdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Apr 2023 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDNQdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Apr 2023 12:33:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70581B4;
        Fri, 14 Apr 2023 09:32:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5465fc13so333105b3a.3;
        Fri, 14 Apr 2023 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681489979; x=1684081979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbYspClGP43xt+dAPh6cycYu19bqp5mbIOxJUIwH2q0=;
        b=M7G7JBt2YJzpLr4X5erkXqEez80go/lMnrCworaMlIDcr6N9qR4K2YKUZIzd0YIQKM
         1Br96VlucFxJkV/ir8SQOsmg63VpDm15tSHjmLFs/7w8ou1B/HQnfij1EVbQpw5+Yqln
         d60Lgl2RoRGRhgBhTS8ZtBR4f/0SgkLSe9T7BKK1WDfLu6H9Ovl/1g7UyPCJ+B+/hc8s
         7J9cB8Y3Mw1uw/axko/KQaATZ0jDrl6OoiHgzZyW+L2nxIxXT23YC8dD0x9Lgi+qrNgY
         4lsi6GP0jBe5/CBjMWS0EyDymAls2DsJ9D7EDrfu8jywAGgDcYgJArWeKLurx4JC86Mj
         8/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489979; x=1684081979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YbYspClGP43xt+dAPh6cycYu19bqp5mbIOxJUIwH2q0=;
        b=IsVV5kqWJp87p0doqrtaGzgT+l4M/gajzFN92AVe8+5DKbDH5kF2WhIhNcxW6PZNTw
         5PcH1CQqYX/6m7t76sGbfmQYBxOQIsqi0yMy5T3aTrVlsuFm3Dwnunbk5EirybNCMKua
         MLtPPvF+nauc+a63AA535i6S9apFdfL+a++v3eO89tvu9+kpGJ7Oz2FavvRjkGbnNQhz
         2U+CIMKNUroFcRzSWJwunwJcslt/v0kbrR/VMa2XjvBUmls2GY8l5WOY+JqwNZn9PleJ
         wL0DA4Cmq+WJrhqqdhh7HpO1EMuAcV7uDM1tGfIG1J9+YwnQoeEF0/gCIPoOE/uaA9mz
         nlkA==
X-Gm-Message-State: AAQBX9eE+MnuA752uoGmUfvRx6zJjOBlWw4Eac9TafHQVC2Ai1CTP2Fw
        6+SzjAjndyA/AkNIi2w+gyM=
X-Google-Smtp-Source: AKy350aISEg+669oC0+0RfuzFBTsYRmbHLK1jNIg9oebLxkkqIpt85KTk0+lZ2pPVLhlI6/Aos8yjA==
X-Received: by 2002:a05:6a00:2402:b0:637:3234:4e22 with SMTP id z2-20020a056a00240200b0063732344e22mr9104068pfh.23.1681489979182;
        Fri, 14 Apr 2023 09:32:59 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id x20-20020a62fb14000000b005abc0d426c4sm3239232pfm.54.2023.04.14.09.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:32:58 -0700 (PDT)
Message-ID: <21210f9c-8831-9f5a-e391-0f44f277b024@gmail.com>
Date:   Sat, 15 Apr 2023 00:32:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 13/17] x86/sev: Add Check of #HV event in path
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-14-ltykernel@gmail.com>
 <CAM9Jb+gsHLgkqFf=ydtv4_Tr1uE5qeMQu4PhnD-aJ10OvzBbhA@mail.gmail.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <CAM9Jb+gsHLgkqFf=ydtv4_Tr1uE5qeMQu4PhnD-aJ10OvzBbhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/14/2023 7:02 PM, Pankaj Gupta wrote:
>> +void check_hv_pending_irq_enable(void)
>> +{
>> +       struct pt_regs regs;
>> +
>> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> +               return;
>> +
>> +       memset(&regs, 0, sizeof(struct pt_regs));
>> +       asm volatile("movl %%cs, %%eax;" : "=a" (regs.cs));
>> +       asm volatile("movl %%ss, %%eax;" : "=a" (regs.ss));
>> +       regs.orig_ax = 0xffffffff;
>> +       regs.flags = native_save_fl();
>> +
>> +       /*
>> +        * Disable irq when handle pending #HV events after
>> +        * re-enabling irq.
>> +        */
>> +       asm volatile("cli" : : : "memory");
> Just curious, Does the hypervisor injects irqs via doorbell page when
> interrupts are disabled with "cli" ? Trying to understand the need to
> cli/sti covering on "do_exc_hv".


Hi Pankaj:
	Thanks for your review. Yes, Hypervisor still injects #HV exception 
when irq was disabled check_hv_pending() is called when
there is a #HV exception. It checks irq flag and return back without 
handling irq event when irq was disabled.
