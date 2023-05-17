Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BC7069D5
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjEQN3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEQN3K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 09:29:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA753AA2;
        Wed, 17 May 2023 06:29:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so13186746b3a.0;
        Wed, 17 May 2023 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684330148; x=1686922148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7fUi0uUSTLefJhQrMS5dB+b+4igUM/2mBF0vBwhbj4=;
        b=T1I8dooEuy0Xaz/72qUtqgEV6XW8BgXxwwivTBUoiQ+hWWXj0JjqeSKAbim6jNQGNq
         I+7vnjvB22CYw4PkGc3QEd0EZ+odis5D48h7o59taDkuQk6KlQIEugcDOPprBZ69J4iz
         zR0gZj6wXP5Nn52V0cf0VQcfk54TSlmmGuCp5jiLsZ5Fo0quz9qaG8JMW7gzaLt12QcY
         nAd2xE7QGlaC1jsCqAWf2D6GFHMpDR/jiw1DPnm1gNo7bA+9piXdwVEfV10SVTsx51yX
         M/S6n3Tn6eydHxuD1LEYyrTLc5FZ7MbHjoT9jAde1sWFKH4lEHG7j419ZRmUzLI8Ru40
         Gqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330148; x=1686922148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7fUi0uUSTLefJhQrMS5dB+b+4igUM/2mBF0vBwhbj4=;
        b=FDZ01BKnRZ3rpnVGU2FQ9RuzAey+57fPlSD3orHXiQAogvVRpRLBR6Oy3I0/C40rwY
         zRPdgwbqPSplY0XOuux/l/BuFuDMmBkeSW40R2dW0/k+BXObZCJKon14MqlJI7wtPdmJ
         rYy2YsaioEjNx2LrYev87FYU1PskeTtRje7z7gOC5ErgzFwfBM5/IF1WQlMhb2qHR0w2
         nRhcAIjrDasOmzPziR0xkTR8OZBFeLB3VLS8Tn01EP3JJoAM+a3mUEAz1ClVyLJ0v9PD
         5lZyCM4GYb1vgYXCmc5wigtPfz4MIgt5bw+fj0ZalEfOa2rcZEVGU+NdiJMTYK9Z8n4q
         M21g==
X-Gm-Message-State: AC+VfDwA+XLryXuUPPWfflDkgAWtVLrC/YnfXm/M6wk3wC5FcWXr5LML
        7BgpUoYRbOwN2kyQIHdN7ag=
X-Google-Smtp-Source: ACHHUZ6V4ODexFGAFpTBY4Zkwqy+xMls6VC858q8OwfRriM7SthUZFxP4bSZbWiH4eaHjSWqCvrRAQ==
X-Received: by 2002:a17:90a:8186:b0:24e:3e07:9e27 with SMTP id e6-20020a17090a818600b0024e3e079e27mr2974101pjn.10.1684330148042;
        Wed, 17 May 2023 06:29:08 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a2fcb00b0023cfdbb6496sm1546651pjm.1.2023.05.17.06.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:29:07 -0700 (PDT)
Message-ID: <7d9c4d9a-05aa-29c2-34dd-092f3e9b16a6@gmail.com>
Date:   Wed, 17 May 2023 21:28:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH V6 04/14] x86/sev: optimize system vector processing
 invoked from #HV exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-5-ltykernel@gmail.com>
 <20230516102305.GF2587705@hirez.programming.kicks-ass.net>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230516102305.GF2587705@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/16/2023 6:23 PM, Peter Zijlstra wrote:
>> -				panic("Unexpected vector %d\n", vector);
>> -				unreachable();
>> +			if (!(sysvec_table[pending_events.vector - FIRST_SYSTEM_VECTOR])) {
>> +				WARN(1, "system vector entry 0x%x is NULL\n",
>> +				     pending_events.vector);
>> +			} else {
>> +				(*sysvec_table[pending_events.vector - FIRST_SYSTEM_VECTOR])(regs);
>>   			}
>>   		} else {
>>   			common_interrupt(regs, pending_events.vector);
> But your code replace direct calls with an indirect call. Now AFAIK,
> this SNP shit came with Zen3, and Zen3 still uses retpolines for
> indirect calls.
> 
> Can you connect the dots?


The title is no exact and will update in the next version. Thanks.
