Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6944F6D62B1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjDDNXK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjDDNXI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 09:23:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF7273D;
        Tue,  4 Apr 2023 06:23:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso1453131pjc.1;
        Tue, 04 Apr 2023 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680614587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RPu6VlUeSzQsBCDXOfMV1nLDEC2lpZYeS7SpzCxn7M=;
        b=X+lpYf9kBFMDrYX3qQl+JFRPqkRUZz4ZkxQ+Q25Dj1AMebmfplDn1BOElWSkzT646U
         DJxbPpk8y4va/y+NhRG7uWm6r/fPssypDJTiVtCN9Zy8NAs6twU19IHnAjBrvlXzWChN
         0pTe9LSe55ogF+5HUnUX+MdmMxcAstAu++uWU1Hw2h02yQsrCl97AKWYvh4qFvT+unMq
         VcY5G0XJdhZAzMNtCuAMuN/bWp+8/0rMiNIOxdecqgialjrE+uDzHynlonbFNdroPCxP
         /MH96xB3ymGHatj3v6rp4Sz3PeTZDnlnwbofv3k6HqQp1q1/jwLFsAUju9/u1UgSZgzL
         3MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3RPu6VlUeSzQsBCDXOfMV1nLDEC2lpZYeS7SpzCxn7M=;
        b=lEacYkUNUhabUmbFn12xKlrrAOU9Qwd+4unr3VmU39riK0MSDLgY1eGHpXmfC6lglp
         A3Wfak/YhC4FuwAnuHHRehSWDP2Zo9y+eCJtpNL1+79kItVmdwRtwubXvIse69///l9A
         oTlODdrq04GV9suUQkwMOYzY9MjmUEMZyLFvvLGsim9L4KkWTGpDlbIGWvQFzwO2pElM
         0/2q+T4tb1Hxr8ZzB56Vm2fKaRS2Ia93MdNYVjS21fqpim/C3ACb+oHK0YWjdlGPvGu2
         64dWUWst9bIsn29QGOdJrhDsasSOpYwsLUwvHAuoT9J1L64WfKGHSsRfqTSMVhwLmVtU
         lbkA==
X-Gm-Message-State: AAQBX9ddz6aGD53WRTaKL8IfqdW4xdMPj/lzBrQ89+Ci1+VciQeEwSXt
        Ym3iVMnxtWWJ1J0iBP/DOy8=
X-Google-Smtp-Source: AKy350anCelYHz08so8729YR0rRHw6Mupx2hEhWHQv8ym9I9UJCr21nrksRn8FlZ63WQrXoIWvhCKg==
X-Received: by 2002:a17:90b:33c4:b0:23f:7843:93ed with SMTP id lk4-20020a17090b33c400b0023f784393edmr2842209pjb.8.1680614586865;
        Tue, 04 Apr 2023 06:23:06 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902bc4600b0019ab151eb90sm8298961plz.139.2023.04.04.06.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:23:06 -0700 (PDT)
Message-ID: <e1579ebd-6436-4dc1-9983-20cefc100619@gmail.com>
Date:   Tue, 4 Apr 2023 21:22:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V4 17/17] x86/sev: Remove restrict interrupt injection
 from SNP_FEATURES_IMPL_REQ
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-18-ltykernel@gmail.com>
 <f2dde9d6-dc04-4c33-7f9d-49454bb192da@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <f2dde9d6-dc04-4c33-7f9d-49454bb192da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 4/4/2023 8:25 PM, Gupta, Pankaj wrote:
> 
>> Enabled restrict interrupt injection function. Remove MSR_AMD64_
>> SNP_RESTRICTED_INJ from SNP_FEATURES_IMPL_REQ to let kernel boot
>> up with this function.
>> ---
>>   arch/x86/boot/compressed/sev.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c 
>> b/arch/x86/boot/compressed/sev.c
>> index d63ad8f99f83..a5f41301a600 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -299,7 +299,6 @@ static void enforce_vmpl0(void)
>>    */
>>   #define SNP_FEATURES_IMPL_REQ    (MSR_AMD64_SNP_VTOM |            \
>>                    MSR_AMD64_SNP_REFLECT_VC |        \
>> -                 MSR_AMD64_SNP_RESTRICTED_INJ |        \
> 
> Should we update the bit in "SNP_FEATURES_PRESENT" instead?
> 

Nice cath! we should add the bit in the SNP_FEATURES_PRESENT.

