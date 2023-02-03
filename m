Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F396890DB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBCH1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjBCH1Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:27:24 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76428B7E8;
        Thu,  2 Feb 2023 23:27:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v23so4445188plo.1;
        Thu, 02 Feb 2023 23:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edbX+4MC5b+srO3yHczbdBgc/tPpYqJoWHt3T7lC7SQ=;
        b=HODstuc15O4Z0/BygJiX8SkZj/gjCfhMLuhWURz3K3rxDS9NSpxIsbeMFDmDRlkO4M
         hCA1vFikS/q/wG85vjfTDuu0ORRobX3/dUT9YNV3W6y1fLjq+AhjnSj98CFbh1ukLrO9
         WmxO9SqjL60RJpawsuQ/S143ohX8EHmjtf8MyerGuf661DLLntV8/okXyYQGYATmbqek
         lejYMupeIh03gTm+fAmVhTvrlIrJp+CUylRVbBqE2dnZXDpB38yOzlWIaRgQaXXNXxEB
         7YanMNO0NHfMFNV6+KN+rsynWieyj//2RjeLFh9HQZxrqlWIZ6Hpr0cVBG3u8wsZEBkn
         0Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edbX+4MC5b+srO3yHczbdBgc/tPpYqJoWHt3T7lC7SQ=;
        b=EZnE+PSEZLKTADq/bnPKxckyehjgUczt/zHIjKjoEy5EwfQXpPkR8zI4qhybor5p5b
         0upMB8ksaPm41XW2ENuvGzVT1Ov9S5+jlNxg1xgRuWxcACCmj2WdH+FWGN9oC/htf8O/
         F2j/Yb9VHcSRECg4XakBZf2XZgK/l9RMSJ2FjwxmQnLObG2/KuGVO4VUrlwDrOwQpkgS
         Cn9V4EhiAxGV8AI+0jDj3uWKE5fSrwrdQN8Uu+wDrgvkwUCFs62E9QNOzAW+FUKw5256
         Y3GUvYzfIFisAdEJh8h3o8M5lq/2r7SzqJQj+GRbgKw2alyMl2tloZpYrowJ3Lc1+4Gs
         fHQQ==
X-Gm-Message-State: AO0yUKVBPbtoqqyH1Nk4MSkK953AUhDyKxJxmVXBXpV53JLmqRy2XPet
        G1xcVPr/KzacshB/ZnbNRek=
X-Google-Smtp-Source: AK7set+JpyrjPDWAG8FnISsyg+KVKKeXx4q66CNamTLJ/nmBURaNsWGgQaBsYZmyUs6gfsmYobxPjw==
X-Received: by 2002:a17:902:d0d3:b0:194:a1f6:65ae with SMTP id n19-20020a170902d0d300b00194a1f665aemr7156793pln.12.1675409243410;
        Thu, 02 Feb 2023 23:27:23 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090331d800b00198e40d95d1sm360350ple.47.2023.02.02.23.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:27:22 -0800 (PST)
Message-ID: <7dbc845a-0ada-f97a-ba50-a6b2c31ee9c0@gmail.com>
Date:   Fri, 3 Feb 2023 15:27:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
 <0098b974-7ceb-664a-aa53-afac8cc26d47@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <0098b974-7ceb-664a-aa53-afac8cc26d47@amd.com>
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

On 1/23/2023 3:33 PM, Gupta, Pankaj wrote:
> 
>> + */
>> +.macro idtentry_hv vector asmsym cfunc
>> +SYM_CODE_START(\asmsym)
>> +    UNWIND_HINT_IRET_REGS
>> +    ASM_CLAC
> 
> Did you get a chance to review the new instructions
> added at the start similar to idtentry_vc and comments
> added assuggested here?
> 
> https://lore.kernel.org/lkml/16e50239-39b2-4fb4-5110-18f13ba197fe@amd.com/

Hi Pankaj:
	Thanks for your reminder. Yes, CLD should be add after ASM_CLAC. Will 
fix it.
