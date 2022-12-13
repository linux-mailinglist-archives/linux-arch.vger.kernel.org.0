Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5864B849
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiLMPV7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 10:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiLMPV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 10:21:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA41FCE0;
        Tue, 13 Dec 2022 07:21:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t2so95837ply.2;
        Tue, 13 Dec 2022 07:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2bzNobqTDC+2ln3lq46cpDNMRgqzeQWlFrXg9gpkHE=;
        b=elwZ8ZqQPKPIu2pGCJ1ddzh8cMQmQoqZyWDuplOGmpuHdT9TcrWwzcCyZpsAP4KbV2
         xoqQcI5vH6Dzd7KMdxRD/FFDVIOz53fwclF/1VXlNMdMJk4F0blY7rj0ipAMDVf1lv1r
         Qw8WxZGzxE1/X+teSfqQypjWucAAfCO6wzN89z7WOZTZ/JjcVXqlD36qyL6xQFCD8+gv
         AlYG9LIJjdpT9ZC10zx1XPT1OoyoNaF1w0+huNXAa7nd2Q2RVYtexcCm9PlzZXd3Cbxk
         IX3czu79QguQaKYpCWySTWxlsvC7ywfDvvKjGwwdk0DvLgr5A2w1DDHRT4Hu0DW/2qXR
         bBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2bzNobqTDC+2ln3lq46cpDNMRgqzeQWlFrXg9gpkHE=;
        b=K2WBdKgcgRFWRY0TiDfreC0x9TtTKHyvJqVu0NHOu+zVSnhzgDByY/bjD5zXrVeJr5
         afCr+e5tE2DEadgfmfx7oIjVIlkOg2hM4I5YKSCJ3kedbxQ+YJsSo5wfYFxxilGsBpe3
         mrwUwQde0owObKHs8MBjPMMJKavFILyU/bvlj0wC/y7I1GAgmSad/ut6h9lq51J54Cpj
         7tXtiN0hdHkXtDjGzUNjOihL4oWnZxfiWyDmluHMHIP0IXFD5joszP33CyeTKsSolhsB
         k3iv7Z9OWjzNkrR9nchjdIKhvAJjxbeZfN14RuGL4O435lSLJWjg0wIjTgHRmjKdGINg
         HdZQ==
X-Gm-Message-State: ANoB5pl880DQleQf0gYYpXXV1K5ubj5L5Ac6GW5oAwPqwDqu22Dgjr6i
        CGt7PPoiHZj85Z1Os+X90Js=
X-Google-Smtp-Source: AA0mqf5tq4O3CcoL0oIjaJ+XsNY+Qf7TD3uAZwCxGlHlox0S7+V/N4TeVYVowERB+SW4+/lWJ2jGWQ==
X-Received: by 2002:a17:902:9696:b0:189:cfce:529e with SMTP id n22-20020a170902969600b00189cfce529emr21586868plp.62.1670944917641;
        Tue, 13 Dec 2022 07:21:57 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001788ccecbf5sm40426plh.31.2022.12.13.07.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:21:57 -0800 (PST)
Message-ID: <407ab4f1-eac2-21ce-95d7-e861a1da73c8@gmail.com>
Date:   Tue, 13 Dec 2022 23:21:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 04/18] x86/hyperv: Decrypt hv vp assist page in
 sev-snp enlightened guest
Content-Language: en-US
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
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-5-ltykernel@gmail.com>
 <BYAPR21MB168851BAABC0BEA0790C5A4BD7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168851BAABC0BEA0790C5A4BD7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 12/13/2022 3:41 AM, Michael Kelley (LINUX) wrote:
>> @@ -228,6 +234,12 @@ static int hv_cpu_die(unsigned int cpu)
>>
>>   	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>>   		union hv_vp_assist_msr_contents msr = { 0 };
>> +
>> +		if (hv_isolation_type_en_snp())
>> +			WARN_ON_ONCE(set_memory_encrypted(
>> +				    (unsigned long)hv_vp_assist_page[cpu],
>> +				    1) != 0);
>> +
> The re-encryption should not be done here (or anywhere else, for
> that matter) since the VP assist pages are never freed.   The Hyper-V
> synthetic MSR pointing to the page gets cleared, but the memory isn't
> freed.  If the CPU should come back online later, the previously allocated
> VP assist page is reused.   The decryption in hv_cpu_init() is done only
> when a new page is allocated to use as a VP assist page.  So just leave
> the page decrypted here, and it will get reused in its decrypted state.
> 
> This handling of the VP assist page is admittedly a bit weird.  But
> it is needed.  See discussion with Vitaly Kuznetsov here:
> https://lore.kernel.org/linux-hyperv/878rkqr7ku.fsf@ovpn-192-136.brq.redhat.com/
> 
Agree. Good point. Will update in the next version.

Thanks.

