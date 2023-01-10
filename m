Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61913664237
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjAJNsg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 08:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjAJNoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 08:44:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D21A23B;
        Tue, 10 Jan 2023 05:44:08 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so8223498pgm.13;
        Tue, 10 Jan 2023 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYbMENWuMKujKDBInRTArAHplJKtKim9Z+aptsEQC40=;
        b=AkeZ3Qy4YVUYbXXqH9psYxTASuaGKkU3UsrfdowWdQpdz50lqffKb9gxKpPdEgMOdp
         V+6C3kq2HEG6TDVO78YI3Mw6tIB5jHYjEk+FFlUhCl3PKKa/wbOhhCXxoCJ8lXc2kVt1
         WMpf7qCKxALI4B4kJwMSiNm+reBpLl2FD1NUvfRGToCmSWFgPgnnkI2VE7cuHC/3dWT0
         u/MibqMWQT/cE450Zdw62WIhkx9IDdHNGbAs++yy0/6JSDa8dTHH6xcOCly/e8YiF5xp
         9ap82GzlxI5bXZ/lT3/G+QBnCDT5NnUWIAGIABoaEJvulVUVZye0nr0IUeWCeVn3R2Oa
         FJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYbMENWuMKujKDBInRTArAHplJKtKim9Z+aptsEQC40=;
        b=F0+j4Kn7w1vOmWYo/gvFkxSx5pZ772RC7Ez4V4/0ci3x36FBkfeII9BtCDTAx8wAGb
         F0HpLfgqBPz6m+nuBvpMUftY/JbcOIhxu5h8AbeUj3J9031leLQYkMJObHqs6LFyaBrt
         mBOgrxnb48c9YMQ+ontTU7iV5Sxy8MchX6ZLEnfs0AiN0blb7YtQJJBoMCXcmWpm5X1H
         CVuXbazpRQ0d1vojfRgGo73x1R9t9Ncu56eNEB+jkXc4ngdh3bu8y66+AsOjf1YS12jE
         Cy+UStnelKzbxp4ILD0lZ3pmNH7CQ5q526iEuYC1D2lr/V4UXxOUCIS9PadlQhGvxgk1
         cI6g==
X-Gm-Message-State: AFqh2kox5ThjCp9603XDbjlKj2GWO87M/ZVooqp5J9l9YLyVbofwfdkQ
        UbL5/hYTEnL9ihoPmCo+yNo=
X-Google-Smtp-Source: AMrXdXt5Xd0HE9YMMi22zeF4ikM53vMyWVSaqZ6V78DVHoIcrDisfSm3MgQKHiEerXxdJiF9iA3XoQ==
X-Received: by 2002:a62:4e94:0:b0:56b:3758:a2d9 with SMTP id c142-20020a624e94000000b0056b3758a2d9mr66888190pfb.21.1673358247865;
        Tue, 10 Jan 2023 05:44:07 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id p62-20020a622941000000b0058130f1eca1sm8036747pfp.182.2023.01.10.05.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:44:07 -0800 (PST)
Message-ID: <4b9964ad-045c-4db1-0616-81635b6221cf@gmail.com>
Date:   Tue, 10 Jan 2023 21:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 15/18] x86/sev: Add a #HV exception handler
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
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-16-ltykernel@gmail.com>
 <af54107e-a509-8f95-6044-b155539a590d@amd.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <af54107e-a509-8f95-6044-b155539a590d@amd.com>
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

On 1/10/2023 8:47 PM, Gupta, Pankaj wrote:
>> + *
>> + * To make this work the #HV entry code tries its best to pretend it 
>> doesn't use
>> + * an IST stack by switching to the task stack if coming from 
>> user-space (which
>> + * includes early SYSCALL entry path) or back to the stack in the 
>> IRET frame if
>> + * entered from kernel-mode.
>> + *
>> + * If entered from kernel-mode the return stack is validated first, 
>> and if it is
>> + * not safe to use (e.g. because it points to the entry stack) the 
>> #HV handler
>> + * will switch to a fall-back stack (HV2) and call a special handler 
>> function.
>> + *
>> + * The macro is only used for one vector, but it is planned to be 
>> extended in
>> + * the future for the #HV exception.
> 
> Noticed same comment line in the #VC exception handling section (macro 
> idtentry_vc). Just wondering we need to remove this line as the patch 
> being proposed for the #HV exception handling? unless this is planned to 
> be extended in some other way.

Nice catch! Will remove this in the next version.

Thanks.
