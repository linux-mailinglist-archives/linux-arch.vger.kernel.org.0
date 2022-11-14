Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA705627426
	for <lists+linux-arch@lfdr.de>; Mon, 14 Nov 2022 02:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiKNB2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Nov 2022 20:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKNB2n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Nov 2022 20:28:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29DB2A;
        Sun, 13 Nov 2022 17:28:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z26so9722810pff.1;
        Sun, 13 Nov 2022 17:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IyJ3xF8kcuSZ9pu7miMBG0rWqw2GU0G6gA219XlxRI=;
        b=RtqxB0eAZIpp2BD2ltwjKgrNELLhn/BHiH11lxn5S+2b4KFFD9CsR5OJfXAtkv0Zch
         dJ/1z2TZywQNkYyx1hDpANTfZMS/CsGXSynb0memuVvXLOVkoLiAQe4EBO91kAXO8SYs
         CA3uGD2W18Ofk+fGV64MIMravk+RkxIDZTtbZOr9dwaxflzJbUi1nC0fqCRGGPiIv0AP
         buA16O/t1oDKRtj6i3B74Mkk8APaX0h422OLKjevqxp+YxDIC232RH0xnJ7HDunnAGQ9
         4DvqYVrZAlXbj88ukG5sEYnCgZvJV3vvsgBpvmcaHmgPstCLu1lVklhCyY7AgL1YSg7p
         tTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IyJ3xF8kcuSZ9pu7miMBG0rWqw2GU0G6gA219XlxRI=;
        b=PjPmf0VLC5hBcNQ45uJY2Tqe0aJ2QLhnXDzQU1mUCJYXcRTw+tf8ZyJtWi3oI8zggb
         GaLPhaUgTvsvfxDvziz1/ypiombe4lBk/ThNMzy37lJ4pnD+VP9cFk0nX4tbFFIw5KIP
         V6NodTCP/zKYi/JuFAaZDtR0Vt/iKi65ufddL9NmPqLY6PusKHI959tVnzufad4ShKp2
         Q7VC+s+CsRZIpSNIUx0jNlpg43zNUlM0eti9O+Av11haD/eCz3JYPftv3n8N7mEpFHD1
         9n1cigVke4Ng+VzMl88xw0ad9s5Tar3F7CM4RhULy/ksIJzQzHlMWFF2xr2NvsTl7C1e
         iEdQ==
X-Gm-Message-State: ANoB5plxXw37PwSZoq6QBRt+qxaZCYe1PGhAKjiZM4B2ci3DYjTIqKIV
        Hvn6HJXCemn/FUjapr96D+o=
X-Google-Smtp-Source: AA0mqf7Y4DAeFRFu4osfoLyHEA1cT+aXeFCWauYexb1W5TozDZ4hWWsuCQybUlcwT8um7BkMqzE5+A==
X-Received: by 2002:a62:1c94:0:b0:56b:cc74:4bd5 with SMTP id c142-20020a621c94000000b0056bcc744bd5mr12013895pfc.79.1668389322416;
        Sun, 13 Nov 2022 17:28:42 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902edc700b0018693643504sm5879033plk.40.2022.11.13.17.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 17:28:41 -0800 (PST)
Message-ID: <60adb804-8a3a-599a-64cd-3149cc82447d@gmail.com>
Date:   Mon, 14 Nov 2022 09:28:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 16/17] x86/sev: Add a #HV exception handler
Content-Language: en-US
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
References: <20221109205353.984745-1-ltykernel@gmail.com>
 <20221109205353.984745-17-ltykernel@gmail.com>
 <aed619fe-3e08-e99d-67c3-3a91da47eefb@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <aed619fe-3e08-e99d-67c3-3a91da47eefb@amd.com>
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

Thanks for your review.

On 11/11/2022 4:38 AM, Kalra, Ashish wrote:
>> +    UNWIND_HINT_REGS
>> +
>> +    /* Update pt_regs */
>> +    movq    ORIG_RAX(%rsp), %rsi    /* get error code into 2nd 
>> argument*/
>> +    movq    $-1, ORIG_RAX(%rsp)    /* no syscall to restart */
>> +
>> +    movq    %rsp, %rdi        /* pt_regs pointer */
>> +    call    kernel_\cfunc
>> +
>> +    jmp    paranoid_exit
>> +
>> +.Lfrom_usermode_switch_stack_\@:
>> +    idtentry_body user_\cfunc, has_error_code=1
> 
> #HV exception handler cannot/does not inject an error code, so shouldn't
> has_error_code == 0?

Nice catch. Will update in the next version.

>> +    irqentry_state_t irq_state;
>> +
>> +    if (unlikely(on_hv_fallback_stack(regs))) {
>> +            instrumentation_begin();
>> +            panic("Can't handle #HV exception from unsupported 
>> context\n");
>> +            instrumentation_end();
>> +    }
> 
> HV fallback stack exists and is used if we couldn't switch to HV stack. 
> If we have to issue a panic() here, why don't we simply issue the 
> panic() in hv_switch_off_ist(), when we couldn't switch to HV stack ?
> 

Yes, this is a good idea. Will update. Thanks.
