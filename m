Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4981688F85
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 07:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBCGLk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 01:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBCGLh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 01:11:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1373765;
        Thu,  2 Feb 2023 22:10:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id pj3so4091080pjb.1;
        Thu, 02 Feb 2023 22:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PasdPm0ruMjHHc/jYxUTTUFHsqQQeYT3E3v9depPqSY=;
        b=DeACYSWRHZY/AFaLkDELrVwTfnkYEIXW9gUX9VEH2WyEQpuQjadz5JmoUE2PKOgQby
         rlcp5jKrLmiq2EwWgKMrIQdd/2+1mmlAo4X98HU1rb+rpCKNquYMgy2HDoZFdykEBPt7
         fn/CfPmz4VmYV0fCs/NTKKmpCSaFCKLDxYcJF7vKaYnyn56rwDTsnBS0FoFwPOcyzbtk
         56/9aEfBEaFWhbqaiFLxmkxl2Ze1w3Cay59mhWgZKE5WxD+PhdS0lvHzIYIcRs4Pao5F
         jns68q2f/hCo9uvkJPxpsCO83Dx+YjBEtFs1qH8kua8cZHMbxDdG7Ty96+3TKR8OB92C
         E54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PasdPm0ruMjHHc/jYxUTTUFHsqQQeYT3E3v9depPqSY=;
        b=zqYBLm4cZlmuTQ3xpo/s7e0+nFZmZ3xLYY2+PzioLeZ9eOpxZ/zGAaWuZagIHgG9xM
         +MTfwAIiCmQ92yZ+h5+JYYIOL+Bj4sFYRSt5q6orqj0ei0ljzMYyECm/o6oY4d5Lyvma
         2ri5Ei2f2YzYfkVSbKcR1fiMBeF7/6LVSAOx3aELFHjDulGCM+plZ2a7VfZGG9saRYeD
         OByLem9GlXLS391Z+phyLDpceYeU96AUEOgP3tOzXnUAVKpnLE9F1Eni588imiKNMYNk
         8OHNZeyk14J2OHSnMHutLDdddS0PtHZ/4icZSjzAHMJD0UghTY4XVuLqgPiPkrwnHYOV
         jzlQ==
X-Gm-Message-State: AO0yUKWySuxa7ZvCoFcRz9DkzrbgeUAW6xaXiJxoV0SgHk7Rycyrn53X
        dTsTWydcd+IvdepMBVqq7QA=
X-Google-Smtp-Source: AK7set/e9dLgRCkJF7IYel+eMA6xqP6bK7pJPkdXSX/O1LRdAarjnBvhvfKDUL+QUH7nAEU+GrG2tQ==
X-Received: by 2002:a17:90b:3b90:b0:22c:1986:553b with SMTP id pc16-20020a17090b3b9000b0022c1986553bmr9606862pjb.38.1675404657549;
        Thu, 02 Feb 2023 22:10:57 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id m12-20020a63710c000000b004cd2eebc551sm743098pgc.62.2023.02.02.22.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 22:10:57 -0800 (PST)
Message-ID: <a0a39ba2-0bea-59c2-b426-6e7957520234@gmail.com>
Date:   Fri, 3 Feb 2023 14:10:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
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
 <20230122024607.788454-11-ltykernel@gmail.com>
 <BYAPR21MB16886B496845962DFBFB112DD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16886B496845962DFBFB112DD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 2/1/2023 2:34 AM, Michael Kelley (LINUX) wrote:
>> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
>> +		goto done;
>> +	}
>> +
>> +done:
>> +	local_irq_restore(flags);
>> +	return ret;
>> +}
>> +
> Like a comment in an earlier patch, I'm wondering if the bulk of
> this code could move to ivm.c, to avoid overloading mshyperv.c.

Sure. Will update in the next version.
> 
