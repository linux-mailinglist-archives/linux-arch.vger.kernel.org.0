Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74FA7064B3
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjEQJ4I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEQJ4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 05:56:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968044209;
        Wed, 17 May 2023 02:56:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b33c72686so365541a12.1;
        Wed, 17 May 2023 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684317361; x=1686909361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayYNauh9YOj0YuMbIMh+fZvBeOH7YM6wlBBt72xWnhI=;
        b=jMRIWYqEgbvXYuhnGgk45LlPtJB67tD2df9o2Ef8nY5Jr4Ct1wQHVwKLRD9CiiyPTp
         vwZIarGqWvB31/jkH3HYZJrisEb5hiAYr0aRHxZaG2qKAKBvdpu96EQOUvOvoaZ/77jN
         jSTX5FpZR4VrOTGZcixeEQl2R5mBefwz7Hc1RSC9dJmhnHO2UU/iTPzALJo9PQHrIv8N
         FLpDWANJRIM/d/5A/JCoycDb0JWOKp33gZwPSmwst7YdCF7C6RCKq2G9YlhmRdCpTujM
         nSEb1/B4OsOb6440+nWy930mTxBFZzdiFOJMRVtLbHSsZUbvV4a3+Na5veQHeO87/Qw9
         Zbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684317361; x=1686909361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ayYNauh9YOj0YuMbIMh+fZvBeOH7YM6wlBBt72xWnhI=;
        b=GQxwvZ0Kv9elNv3N1tUx89JaIN7eHXJ2U+Blk3iIxiFrVk5ig+exiolGBUynwCUZ8x
         sMLm9Oz5eepY2pZoRlSwrTyMYQJ/CJAJy8meqB4qRRZdUMuT/2OHhP2CExy3kfuThtJR
         2Pvp5HJaQvXtz9NgjqkgMNfe17+7peG5mTCBXGD8MTQImffDk5GacEmpqzU6M1kd77gT
         QLT1C3foGUySUfLKc9PTkkre2WnwUzWsN+1teWB/BSAqexgssVZXEZD0GX51j02rVWtH
         ApE06e2E+ErI7S/4S4SJyEJBmvUTgZoo4snX5jr+zT90C5TxZezmFihowsYwrbsCLUEB
         UjHw==
X-Gm-Message-State: AC+VfDyoiyFmccAy4OujUipJQu07m2dydwsuBKwssNTWosD0C303TfUF
        uzT0c8kcgxOHghkGpvjkQrw=
X-Google-Smtp-Source: ACHHUZ5hXvFTup24JPN1NmOVtxyJWdFuwnnZ/SrTyzOet8dUUnQEq+IxV3mh5Y9b2PKgrA8uzhrQWQ==
X-Received: by 2002:a17:903:120d:b0:1a5:2993:8aa6 with SMTP id l13-20020a170903120d00b001a529938aa6mr47905055plh.63.1684317360866;
        Wed, 17 May 2023 02:56:00 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001a6c15cad12sm667642plh.166.2023.05.17.02.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:56:00 -0700 (PDT)
Message-ID: <851f6305-2145-d756-91e3-55ab89bfcd42@gmail.com>
Date:   Wed, 17 May 2023 17:55:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH V6 02/14] x86/sev: Add Check of #HV event in path
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
 <20230515165917.1306922-3-ltykernel@gmail.com>
 <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
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

On 5/16/2023 5:32 PM, Peter Zijlstra wrote:
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1019,6 +1019,15 @@ SYM_CODE_END(paranoid_entry)
>>    * R15 - old SPEC_CTRL
>>    */
>>   SYM_CODE_START_LOCAL(paranoid_exit)
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +	/*
>> +	 * If a #HV was delivered during execution and interrupts were
>> +	 * disabled, then check if it can be handled before the iret
>> +	 * (which may re-enable interrupts).
>> +	 */
>> +	mov     %rsp, %rdi
>> +	call    check_hv_pending
>> +#endif
>>   	UNWIND_HINT_REGS
>>   
>>   	/*
>> @@ -1143,6 +1152,15 @@ SYM_CODE_START(error_entry)
>>   SYM_CODE_END(error_entry)
>>   
>>   SYM_CODE_START_LOCAL(error_return)
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +	/*
>> +	 * If a #HV was delivered during execution and interrupts were
>> +	 * disabled, then check if it can be handled before the iret
>> +	 * (which may re-enable interrupts).
>> +	 */
>> +	mov     %rsp, %rdi
>> +	call    check_hv_pending
>> +#endif
>>   	UNWIND_HINT_REGS
>>   	DEBUG_ENTRY_ASSERT_IRQS_OFF
>>   	testb	$3, CS(%rsp)
> Oh hell no... do now you're adding unconditional calls to every single
> interrupt and nmi exit path, with the grand total of 0 justification.
> 

Sorry to Add check inside of check_hv_pending(). Will move the check 
before calling check_hv_pending() in the next version. Thanks.
