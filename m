Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24FA6F793F
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEDWl2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEDWl1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:41:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B8086AD;
        Thu,  4 May 2023 15:41:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115e652eeso15908253b3a.0;
        Thu, 04 May 2023 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240086; x=1685832086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuR5Nn17jNx3hsu5wtmqgX3ulS4giwJ61q7gFIqEyfQ=;
        b=lKI3pfgrV+/x+0UIm+839VzQtOaWFfJDJQTUbgTy/Nl77X2aJAG7DgKZzZDFfgCyxe
         Us3UptKxw6DfJihFm2/yAJ9A1DbMsSiOpHEkdEPRYV65wLK6GzCydjiOdPmlN4baWhMq
         eVNP7kzRmZStDeh+neeplvdI19iFgKNomUdfE/p3VlHs7FfEVcJQU37oH4kvWnQcgh/U
         1V0AmfOSdfA7iAT0c1ZIBjgNMWYmJ9gbEwaNDrcHhp7XRIAkL4ijvDfyP6dGwhKOS1Dw
         b3l+hEHQ74QV39k+7DXeG4TQUi3R7x30YDJqsUbMfUVUCq2S57YMDJf/5fBGLSqwPmta
         sf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240086; x=1685832086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuR5Nn17jNx3hsu5wtmqgX3ulS4giwJ61q7gFIqEyfQ=;
        b=FcxmXs3/0W8UsoMxiij2FXP5DGyYT9s12HydTzS5PosiJwi4np1I84GafTDXIr/YpH
         gB1YIVWOtMQ7T0zuzvNDYpauEN/TKRcvMhYaghqqTkIIGjSRybOqYoYs9dP+L+QMYLLM
         LrxvpvyjhWbHm3z2BdAmL3AIZo0nKtHp3LQGEwMyOvW9+jHyt8WnJwXWRP9jVxWjqVKW
         v+e71obwFF7T7KMl3l6nUb4E4jFjXdt9YD1FrLMZejf/IoxSbm6XWh0a53tWxh1pfES9
         jrk0bZ9oUjhQspvuUERbo8yy9KDP5bKM+YOF2qNFP838uirvXyYeaSWMnjk2eyhZ6wYd
         dE4w==
X-Gm-Message-State: AC+VfDwEfsbsL0eDZYQQKwveyvIXmKsKdF4/+13BUhi4zjwUB7xlBlB4
        fBPyZcAPa1g5VSH1RLk3TEc=
X-Google-Smtp-Source: ACHHUZ5BKfeQ9wBTyrFRg5e6QEIj76WiIyPay+ndAQjIGQ0SMLB/6tqtD5yksIl8IIDJFWWKCqrvhQ==
X-Received: by 2002:a17:902:f546:b0:1a3:dcc1:307d with SMTP id h6-20020a170902f54600b001a3dcc1307dmr6387044plf.23.1683240085993;
        Thu, 04 May 2023 15:41:25 -0700 (PDT)
Received: from ?IPV6:2404:f801:10:102::36? ([2404:f801:8050:3:80be::36])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902b69600b001a6f6638595sm48874pls.92.2023.05.04.15.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:41:25 -0700 (PDT)
Message-ID: <6e9b5b99-04eb-9b6a-5218-6cfa696a08ee@gmail.com>
Date:   Thu, 4 May 2023 15:41:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH V5 15/15] x86/sev: Fix interrupt exit code paths from
 #HV exception
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>, luto@kernel.org,
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
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-16-ltykernel@gmail.com>
 <3c91e1ab-29f4-09cb-1268-52fd9c3e34f4@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <3c91e1ab-29f4-09cb-1268-52fd9c3e34f4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/1/2023 9:02 AM, Tom Lendacky wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> Add checks in interrupt exit code paths in case of returns
>> to user mode to check if currently executing the #HV handler
>> then don't follow the irqentry_exit_to_user_mode path as
>> that can potentially cause the #HV handler to be
>> preempted and rescheduled on another CPU. Rescheduled #HV
>> handler on another cpu will cause interrupts to be handled
>> on a different cpu than the injected one, causing
>> invalid EOIs and missed/lost guest interrupts and
>> corresponding hangs and/or per-cpu IRQs handled on
>> non-intended cpu.
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> 
> This should be merged into one of the appropriate #HV patches and just 
> add Ashish with a Co-developed-by: tag where appropriate. This would be 
> appropriate as a separate only if discovered after the series was merged.

Sure. Will update in the next version.
