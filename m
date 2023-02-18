Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0669B876
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 08:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRHQQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 02:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRHQO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 02:16:14 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CE3D93E;
        Fri, 17 Feb 2023 23:16:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w9-20020a17090a028900b00236679bc70cso984214pja.4;
        Fri, 17 Feb 2023 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zeAyStGOAFnstrUajjYueyIYBwjl00KpR/f53YMTfg=;
        b=XvX6Qh9VLDn0hoAkDRv9heT0qhQaWB3AGZIizkKYTCVUSnBIR8d6YaC0FZGYNXsCwT
         9v8X0gMWKywWprau/Oo3skJxuOSHSEgG/QyK/Rhuu0913/a5yP0i6allU9vhxwS/Wtqq
         lfDu2umQzzmc0EvxysC3hmS/We55bTx/TjubE4eeL9xlwu2mZr4yJt/EYtvd84j7iZUA
         mwUmIb9fKzdrlKefeMExdXM3Nuiw81GfVlUyg8VJpG3JqrVcw5nvvwe3GQM9fZY+RdvN
         wGP6N/olAoTEx0T1t6CXthG7wtqJ1u/g22pduHAVX/gtuYHjWWK32cX7GhHOlltZ7aQW
         W+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zeAyStGOAFnstrUajjYueyIYBwjl00KpR/f53YMTfg=;
        b=rf3cGYiAZ3B6WigxluvJjC+0C5cqIqwao/osF4okFnF2sAbOTELBHuoZ+ntNYOcaHm
         VFNRz47SCMCnEhhtui/so3Cxp5S8eVOtdSjUiNuxcM/kUOnkxfsH5cW2JZQQGRLYA1ud
         qe0h3ViAk0yIfpMZMy1IJH/6XejFHEWce2XGZU6JuPKev/7JXgj9M1T1aAWAk60zbcKu
         U6bOR/ouNokrOdNE01/hEZhHDZS3MS05oeREeuTKRL16pE0SeSQM7bD4JXhGXb/mmsWE
         YSWVykI5hQ6aY3XE0pJoI2r8Bfq6YJLzyESHzhKwSUDHjW/CnMurEfWH9RFndP8AbS0W
         tnfA==
X-Gm-Message-State: AO0yUKWCvfqeGFZ9b0/L3H0bo7pq2sla5Xe5+JiWWHyHPz7GuG5FFzcx
        VlknH4fygwFrp3+kZRj4TT8=
X-Google-Smtp-Source: AK7set/UOWJ97CrDvzvUthnHbSBIgUOhimOsG8Qwgc/q/lUkAoTaohMx0gVAv3CVVGfVhrqmHW0ZWQ==
X-Received: by 2002:a17:903:1206:b0:19c:355c:6eb5 with SMTP id l6-20020a170903120600b0019c355c6eb5mr2073660plh.30.1676704571284;
        Fri, 17 Feb 2023 23:16:11 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902849300b0019460ac7c6asm4091827plo.283.2023.02.17.23.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 23:16:10 -0800 (PST)
Message-ID: <17278603-4328-3753-cae9-eb10ce69db7a@gmail.com>
Date:   Sat, 18 Feb 2023 15:15:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
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
 <fac62414-06f9-0454-8393-f039aa30571a@amd.com>
 <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/17/2023 8:47 PM, Gupta, Pankaj wrote:
> On 2/9/2023 12:36 PM, Gupta, Pankaj wrote:
>> Hi Tianyu,
>>
>>> This patchset is to add AMD sev-snp enlightened guest
>>> support on hyperv. Hyperv uses Linux direct boot mode
>>> to boot up Linux kernel and so it needs to pvalidate
>>> system memory by itself.
>>>
>>> In hyperv case, there is no boot loader and so cc blob
>>> is prepared by hypervisor. In this series, hypervisor
>>> set the cc blob address directly into boot parameter
>>> of Linux kernel. If the magic number on cc blob address
>>> is valid, kernel will read cc blob.
>>>
>>> Shared memory between guests and hypervisor should be
>>> decrypted and zero memory after decrypt memory. The data
>>> in the target address. It maybe smearedto avoid smearing
>>> data.
>>>
>>> Introduce #HV exception support in AMD sev snp code and
>>> #HV handler.
>>
>> I am interested to test the Linux guest #HV exception handling 
>> (patches 12-16 in this series) for the restricted interrupt injection 
>> with the Linux/KVM host.
>>
>> Do you have a git tree which or any base commit on which
>> I can use to apply these patches?
> 
> Never mind. I could apply the patches 12-16 on master (except minor 
> tweak in patch 14). Now, will try to test.
> 

Hi Pankaj:
	Sorry. I missed your first mail. Please let me know any issue son KVM 
side if available。Thanks in advance.
