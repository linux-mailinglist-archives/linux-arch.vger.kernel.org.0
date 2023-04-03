Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548C46D5007
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjDCSKC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDCSKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 14:10:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C22134;
        Mon,  3 Apr 2023 11:10:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z19so28893394plo.2;
        Mon, 03 Apr 2023 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680545400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa2BV/2hukT+SOvhLFebRK93sjsVntvwqiFRZkq+S+8=;
        b=Ft1qqfdfNGU5SGGFhFJNTwfnyli0Ti5FvIuAoBaGQFmOv1UTShqS/OfC3YTYjAUQs0
         dJKvkxBdJPgpi90Y0F85ubmo/RVC8OiYG8AENDXv4/VnYMlmKD8jM6MBWMb6Sfcnr4JH
         H/Hxx0NOLriYHwfg3xDQPPHQYsBHIqAOG+w6Vv8EXmkiY8XmOZFJDfleP8N+/EJdUxNi
         A1Q8PUhpj273Vr0Gjmm/xGVl8xnG9jqsl0s7Swia350HDxZ7w77JQMMY4sWLSOm1Km2s
         A+2RPlTw8BMCXO0z8jv2cyaPCtT+6UkAnH99lmKLyE5hqlRw8keomBUy+dLCS+QFYo5F
         r8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pa2BV/2hukT+SOvhLFebRK93sjsVntvwqiFRZkq+S+8=;
        b=Ht55l5xrNZ7CT/c3CjPQu4pEChUzCfZz3nhYYpFgLw/QI3fJK0tdQYXkvDP0IvkHzd
         JSd/b610iW1OqjitgfS95dJk7zrmxoUsiLa6Tm1lDWLpR35Ot5pRcv4qKQcTENNm0y5q
         gr8huhfQWX+NzCgsup/Z062z0D3WkSNaoU0cwOQizI93OKEYkN13jrNd0V1GPeaY2BER
         oFsd+CKOmV8qDYjJLOr9zP9iM1ckSR/wvbie8l5TWXKweMeYQ6v5vYne6m9WgRnmCGY7
         c63AX0YaX3eDkZ/d5V5uxV8wl5UuT52uPoYpMf/Q/0PJkEO6jc16pOxuwWKl5GeihHd5
         PL+Q==
X-Gm-Message-State: AAQBX9c//o8IF/3orRW7mUvabS1G5EMSOoik1vXoqnUaMf1Q2grkGs0N
        KxOz3MLKN0CxStv1eZSZ+Pg=
X-Google-Smtp-Source: AKy350Zef2NXFx8d/z1eeGXLPDrs0U7IRPUog3tPrwe+/NGcARuYKvdU1cdBJ5iugXXsESTU7UsL9A==
X-Received: by 2002:a17:902:ce8e:b0:19e:2fb0:a5d9 with SMTP id f14-20020a170902ce8e00b0019e2fb0a5d9mr22338760plg.32.1680545400262;
        Mon, 03 Apr 2023 11:10:00 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709027c1700b001a23e056423sm6893029pll.283.2023.04.03.11.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:09:59 -0700 (PDT)
Message-ID: <7efbc4fa-1797-0da8-2846-e0753e578ffe@gmail.com>
Date:   Tue, 4 Apr 2023 02:09:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 12/16] x86/sev: Add a #HV exception handler
To:     Borislav Petkov <bp@alien8.de>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
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
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-13-ltykernel@gmail.com>
 <20230331155714.GCZCcC2pHVZgIHr8k8@fat_crate.local>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230331155714.GCZCcC2pHVZgIHr8k8@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/31/2023 11:57 PM, Borislav Petkov wrote:
>> + *
>> + * If entered from kernel-mode the return stack is validated first, and if it is
>> + * not safe to use (e.g. because it points to the entry stack) the #HV handler
>> + * will switch to a fall-back stack (HV2) and call a special handler function.
>> + *
>> + * The macro is only used for one vector, but it is planned to be extended in
>> + * the future for the #HV exception.
>> + */
>> +.macro idtentry_hv vector asmsym cfunc
>> +SYM_CODE_START(\asmsym)
> ...
> 
> why is this so much duplicated code instead of sharing it with
> idtentry_vc and all the facilities it does?
> 

Hi Boris:
	#VC and #HV use different stack. I try reusing vc code path for #HV 
doesn't work. I will continue to work on this direction and report back 
later. In the RFC v4, I still keep the old version and other patches may 
be reviewed in the parellel.

Thanks.
