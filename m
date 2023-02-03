Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A160A688E08
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 04:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBCDdJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 22:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBCDdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 22:33:03 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02F88CFE;
        Thu,  2 Feb 2023 19:32:45 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id r8so4026085pls.2;
        Thu, 02 Feb 2023 19:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sO/I/hapLPdlFrgOgCj3YUdlJCdmaojJPiwxcYZTHw=;
        b=om+qrGa0QJU9y5GLrQUi3293WCGq/RV7RWKkzs79vM+mF7LstskZi0DFKWjKCBORxr
         aBJEW9FuMIiDdHr5ZnqHmLf6NkF7r1HtPVK0R864e+0IHHuRwIoLk6B+JAT6xmxQyJhv
         Co4Lg4l+n0M0OUjfzvq7trn9tBaObHoumwibEediLWIVQ1s/VFxl8/0B3DQWSFBVNBr9
         ciaQetM0eZiV5sl7iG+GIhQf+tVNztTKo4MmHF2t9vHT1lfnOcgfvKduymsal7Rkja0E
         yFOLUIUutIa+nZJl9ZgenNa6qZhVYxXPFiWRk1FEnowU3Cxt+Uj/RSSao/fSDjX4UqYD
         cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0sO/I/hapLPdlFrgOgCj3YUdlJCdmaojJPiwxcYZTHw=;
        b=c7X+PRxfx7kkvpAGHfCDKzA9HZOef0lZo+1x9swsmjHjZXKTjegAukUKKlhTDfIj2/
         toagZblU2IPAa9t0yCZuFrYUEmgmt/FCUO6zkV1SJn/LU1IGLUED+A7VeL9lP8s52olI
         AOJbxuN92Azl48us/MZLWwzoWpzmpN5GUmVeyEoedIozXpalzRz2GElrDlKlQrGEOhLk
         qsND25eMH/+wgcZ/ENQ98J04SYY9p2WsYuIImtBznBvt/6cs1qAwNqys0YppUFIMp7FP
         T6U1/vjhUItKN3/Scjo75FZfKoZYaMFIR5cGSHe0HxTT9Oh3+iPjDSBq3cydap+6D3GM
         jmQQ==
X-Gm-Message-State: AO0yUKX9/mZeiqhJ6ur7LC0evE42hiyQua7/50r/9wdx9IgjkW7UV+AF
        swydrH0e6UBeB+kSetEe8O8=
X-Google-Smtp-Source: AK7set86YHchxl3IgwYooZpALzvQegpf3ZJ4iw88C5pZynpIjltH+qCY/RkEFP1v+LvdhM9Z0GhMrw==
X-Received: by 2002:a17:902:f105:b0:196:2cc1:5082 with SMTP id e5-20020a170902f10500b001962cc15082mr2469626plb.67.1675395165002;
        Thu, 02 Feb 2023 19:32:45 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709026b8700b001948107490csm433838plk.19.2023.02.02.19.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 19:32:44 -0800 (PST)
Message-ID: <afb70dc4-8f7a-32d0-35b5-92b35902a7dc@gmail.com>
Date:   Fri, 3 Feb 2023 11:32:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 03/16] x86/hyperv: Set Virtual Trust Level in vmbus
 init message
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-4-ltykernel@gmail.com>
 <BYAPR21MB16885D6652BEEA882D96C97CD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16885D6652BEEA882D96C97CD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/1/2023 1:55 AM, Michael Kelley (LINUX) wrote:
>> index db2202d985bd..6dcbb21aac2b 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -36,6 +36,10 @@
>>   #define HYPERV_CPUID_MIN			0x40000005
>>   #define HYPERV_CPUID_MAX			0x4000ffff
>>
>> +/* Support for HVCALL_GET_VP_REGISTERS hvcall */
> The above comment isn't really right, in that these definitions
> aren't for the hypercall.  They are for the specific synthetic register.
> 
>> +#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
>> +#define HV_X64_VTL_MASK			GENMASK(3, 0)
> Hyper-V synthetic registers have two different numbering schemes.
> For registers that have synthetic MSR equivalents, there's a full list
> starting with HV_X64_MSR_GUEST_OS_ID, which defines the MSR
> address.  But these registers also have register numbers that are
> not the same as the MSR address.  These register numbers
> aren't defined anywhere in x86 Linux code because we don't access
> them using the register number.   (The register numbers*are*
> defined in ARM64 code since ARM64 doesn't have MSRs.)  But this
> register is an exception on x86.  There's no MSR equivalent so we
> must use a hypercall to fetch the value.
> 
> I'd suggest starting a separate list after the definition of
> HV_X64_MSR_REFERENCE_TSC and make clear in a comment
> about the list that this is a list of register numbers, not MSR addresses.
> 

Agree. Will update in the next version.
