Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6B6B4BBD
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCJP4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCJP4F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 10:56:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34AFCF83;
        Fri, 10 Mar 2023 07:49:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so6036068pla.2;
        Fri, 10 Mar 2023 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678463343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEtKc8sZos+Dc0t1cvJCnmLbpSWQyhy/XbEqe/9t3YE=;
        b=V4oF8hwnLguFv3mXEyDsumx2wAfSQ1BkJ75sLRfmlA7fZWCvpbjHwIh9ZIjfp3oj/k
         lPFFaFlxb/C5/SG5YjaRXbn1aZMaKvwvatu6ccjB8ROCqjbmB5V5FG1qD72zTgaUyzYh
         hEGrF5IElLdTb2Uwtfk69sg4RWdqFhEObgabdiACr9+hLAN7pHJowez/DbJ4cStFTjkL
         uPxzlsZkj4eb5mx6f0Jd6ynpGaZVH5WweWt7g/qEBAE8CoLdwc9OUrr85BiFvWwMsfnV
         eycvFmLlyaG+/OOjsY7iTNNU0knrsfINF1o5T96I/1miKojfIrhL9poGV4AIAd3YUvbV
         11qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678463343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JEtKc8sZos+Dc0t1cvJCnmLbpSWQyhy/XbEqe/9t3YE=;
        b=tbgMlrB730acj7vRO20d2kWtQaVQtdK4asb+lUlDgO9Wyk4Zc093zTzs7miWmQxvny
         cxN5gEmr7cROhw13cMd7OQuHJrzEirfZgJymm6uiKWZt6p7DeVDLlsbZ4Sv3WU/lRI1q
         oVssBbGvLYRgppP0GybNEQFpnEsGhitODwZrHp/iwtCGw8/1mtGj5Q/hXhkx9vyOaYoi
         KoU3IJrc6LcoGp3LWVnxmmdgQMUI7oZ2I5sFw0wGBJBXifskFeB0b4LZwlvlBTC2VrCE
         AwOnF2n8GnpIxIf3E7Y5xV5A8V+tyRGH7ClP6Efs29JFFPR/GsAujXwTWp1eow32JJjc
         kg3A==
X-Gm-Message-State: AO0yUKVEeYTk5hEK8/UjYUzLYvwzrdPZ/JD3NJy+eSKFO4gHSbEIQCAJ
        Yz2RQrg8qTJJ/HpQVU6bpsg=
X-Google-Smtp-Source: AK7set897PHks1qrrgkHdgqr+up48NII37yYJ85g+JFJ5MG99gJiqPK08lELsucoAFezQa6HAYKEAQ==
X-Received: by 2002:a17:902:e551:b0:19d:121a:6795 with SMTP id n17-20020a170902e55100b0019d121a6795mr30623064plf.55.1678463342766;
        Fri, 10 Mar 2023 07:49:02 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902788600b0019c2cf1554csm230472pll.13.2023.03.10.07.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 07:49:02 -0800 (PST)
Message-ID: <ea387ecf-ac5a-4a22-e99c-bc283b39c1e1@gmail.com>
Date:   Fri, 10 Mar 2023 23:48:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V3 12/16] x86/sev: Add a #HV exception handler
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-13-ltykernel@gmail.com>
 <a25a21f9-0059-3e39-4284-7c4164d170ed@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <a25a21f9-0059-3e39-4284-7c4164d170ed@amd.com>
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


On 3/9/2023 7:48 PM, Gupta, Pankaj wrote:
> On 1/22/2023 3:46 AM, Tianyu Lan wrote:
>> From: Tianyu Lan <tiala@microsoft.com>
>> +    UNWIND_HINT_IRET_REGS
>> +    ASM_CLAC
>> +    pushq    $-1            /* ORIG_RAX: no syscall to restart */
>> +
>> +    testb    $3, CS-ORIG_RAX(%rsp)
>> +    jnz    .Lfrom_usermode_switch_stack_\@
>> +
>> +    call    paranoid_entry
>> +
>> +    UNWIND_HINT_REGS
>> +
>> +    /*
>> +     * Switch off the IST stack to make it free for nested exceptions.
>> +     */
>> +    movq    %rsp, %rdi        /* pt_regs pointer */
>> +    call    hv_switch_off_ist
>> +    movq    %rax, %rsp        /* Switch to new stack */
>> +
> 
> We need "ENCODE_FRAME_POINTER" similar to "vc_switch_off_ist" here as we 
> are switching stack?
> 

Agree. Will add it into the next version. Thanks.
