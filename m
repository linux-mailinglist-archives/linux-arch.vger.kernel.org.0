Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900970629E
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjEQITT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEQITS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 04:19:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE410EF;
        Wed, 17 May 2023 01:19:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f6461af24so277597a12.2;
        Wed, 17 May 2023 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684311557; x=1686903557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEV6UskM3XbK5S9GbqWMhXe1iQQdPul0K2M1kn2nZ4I=;
        b=Y1z8PDrYZDsAaoYM5lQ2pYjq2SlJP3HjVolaOCncqewUNxeGPpKOeBhbwWtmERGhSl
         Rc4CwdzG/r7bznAzp6ztkdTSW2nWQsI538E2tS9GmCr+0GM1c3xDHgdXZghRBYUxbvzm
         3c2bfG+Olm4kZynh2LdeXhrzYbnIcNHYhHOOJzSzX2SNKG9UgaNYBDeuycEoA0EWYcsf
         kqC5gUbtFKGx/yzfKdV4VKjwb5hIX992Fb+ZsFn5v7FFdi2nD3eNh4f5Hi9Th1BdCP5Q
         /K3wREKF1SYUfsxK4IeWOW3Y1c22ZNRT5q2yRMcqYBNmCtNV05d7FRzW/6Dq8lQQQaw8
         rjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311557; x=1686903557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEV6UskM3XbK5S9GbqWMhXe1iQQdPul0K2M1kn2nZ4I=;
        b=Cr6vqXWux+18oDRmtio4NrV++KOBeGUdd1564bYr9GIdfWhuv5sIuNrxJvKKBaiJBk
         RaxTKHE8QWORYYegN5aIIfjOeGRFnNBSgXZe78PvK7J2aPMsnD90cSdtlulJlz9mcBYN
         vJcFnT9mY5Bop7mOLiMiVQJI773CdqH2cCTZux3lrVCkMG4F3YhmLbVdSJWsWe4F0WOe
         IhvX4+ZYQPYyG7HI1ZvAO7K+XQAMzKU+9XdSIZ/ZnVA3izAUOhfYCfWfDMUaHZVopQ6A
         1Bhqn3c2pl2R43zbWKXordlyf8gREG67tGbTzdi6EXg9RDs48GeVuV5cPK5kzSI2mSCt
         6/5w==
X-Gm-Message-State: AC+VfDzm2b1m2+JgBBFgnSi6jr1m3ufI5rnHcx3FcipteeRG/Rftg0tf
        z0Wj+UoKbESjnRZGR1KFT10=
X-Google-Smtp-Source: ACHHUZ4G4fk5rt0WdvD2RK98Kt1wKOayGB7abc1lBmKmpZ/TkZxJGEImsp44tUcaOm1qesS3ln/8rg==
X-Received: by 2002:a05:6a20:8e0c:b0:106:dfc8:6f4e with SMTP id y12-20020a056a208e0c00b00106dfc86f4emr6857291pzj.32.1684311556717;
        Wed, 17 May 2023 01:19:16 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id w25-20020aa78599000000b00649281e2f03sm11172261pfn.141.2023.05.17.01.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:19:16 -0700 (PDT)
Message-ID: <7d3371ce-de5a-11b2-964e-9be122da2cde@gmail.com>
Date:   Wed, 17 May 2023 16:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [EXTERNAL] [RFC PATCH V6 13/14] x86/hyperv: Add smp support for
 sev-snp guest
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
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
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-14-ltykernel@gmail.com>
 <PUZP153MB074906CBC3E7B13AEFD17472BE799@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <PUZP153MB074906CBC3E7B13AEFD17472BE799@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
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

On 5/16/2023 1:16 PM, Saurabh Singh Sengar wrote:
>> +		(struct hv_enable_vp_vtl *)ap_start_input_arg;
>> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
>> +	start_vp_input->partition_id = -1;
>> +	start_vp_input->vp_index = cpu;
>> +	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
>> +	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
>> +
>> +	do {
>> +		ret = hv_do_hypercall(HVCALL_START_VP,
>> +				      start_vp_input, NULL);
>> +	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
> can we restore local_irq here ?
> 
>> +
>> +	if (!hv_result_success(ret)) {
>> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
>> +		goto done;
> No need of goto here.
> 

Nice catch. The goto label should be removed here. Will update in the 
next version.
