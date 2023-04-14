Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A86E1B22
	for <lists+linux-arch@lfdr.de>; Fri, 14 Apr 2023 06:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDNEk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Apr 2023 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNEk5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Apr 2023 00:40:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FC2D78;
        Thu, 13 Apr 2023 21:40:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id la3so17084584plb.11;
        Thu, 13 Apr 2023 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681447256; x=1684039256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN3UavDEbWO3KjZEle7Kz/Qvhsq6Rh8evSX6rVr7o0g=;
        b=pY3J9UyIcOpsG/MFEIEc58FJv7hxxg04caAHyc749ZkqBDNIkMH5zhSpxgvcFXqYGU
         jONEKQDt+CeM4vmbUNPxyUNmg9jdVCYsIOW46/k5aXQcNu0aKjtT08u+THF9AkEvI8TI
         eKIqNGYxtaAd1UGLy2vytu2atJW21IdPveHrhS4+W1xjbS09gu0tF5tqvzz2vPxRif2B
         Iia3rNfKQGYAg0uktlPwbyv5OM/EqO1SDhDXKvzICCHeH0632R9/NHeU3EOXcHzQceXq
         +wLtVMHkLLskWp8TKwg7yde3dkig6QWPVinezC5IlWq0Ns3E09HttgMYkWhS6jTD6gT9
         I+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681447256; x=1684039256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bN3UavDEbWO3KjZEle7Kz/Qvhsq6Rh8evSX6rVr7o0g=;
        b=I3pZLctoY8aOVTeVHnlfh0MFj83ah4hqOC8zIuURLUDHKbWbA01Qub+j+73ZcTn8Tg
         wlqb3USfxUtt2eZUdTtnzgA4gd77Gg33oiKclZrUJ9Eo5bwmYK53aAPOMwTDkNWFIItc
         WnJUHk2/m52gUMWfnoFb/1fcXIQGaYdnYpyk6m+kgessLYIexOTqXokPaNc1e8Ez0w8+
         U2bMwF1Y+6XV4YD34LuGl/PJKt5hIEc2K4VXvKkDhwkZDggObREeHFkRoRxu/+3UAy9W
         HOC5jf4qSO2PxhXaoVUwwolw8tniyuo7O8z4vKyBqMTsJx0aKkKpOoB9JQSBdpB+/6Qd
         3dDg==
X-Gm-Message-State: AAQBX9fxd/Z+wjnVgb30FTF1Kp1WDKuW5d3bmDkSlA4vvOUVlFdnnsRT
        G+O/39KV85LZB09j2Ie7WV8=
X-Google-Smtp-Source: AKy350ahwx5AwENDOG/S4oQKIQ3znSP2XtCq0w5Jb2/QlTMIlQoZDecguLJSxiUbvGC7YqyWXL8DpA==
X-Received: by 2002:a17:90a:f310:b0:246:79be:ae10 with SMTP id ca16-20020a17090af31000b0024679beae10mr4388042pjb.41.1681447256182;
        Thu, 13 Apr 2023 21:40:56 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090aa38200b0023b3d80c76csm2098025pjp.4.2023.04.13.21.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 21:40:55 -0700 (PDT)
Message-ID: <583dd8ba-24f8-c1c6-256b-21a00ae3bd0a@gmail.com>
Date:   Fri, 14 Apr 2023 12:40:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 06/17] x86/hyperv: decrypt VMBus pages for sev-snp
 enlightened guest
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
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-7-ltykernel@gmail.com>
 <BYAPR21MB16882B5A167C985B516B6E5FD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16882B5A167C985B516B6E5FD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  On 4/12/2023 10:32 PM, Michael Kelley (LINUX) wrote:
>> @@ -191,6 +222,15 @@ void hv_synic_free(void)
>>   		free_page((unsigned long)hv_cpu->synic_event_page);
>>   		free_page((unsigned long)hv_cpu->synic_message_page);
>>   		free_page((unsigned long)hv_cpu->post_msg_page);
>> +
>> +		if (hv_isolation_type_en_snp()) {
>> +			set_memory_encrypted((unsigned long)
>> +				hv_cpu->synic_message_page, 1);
>> +			set_memory_encrypted((unsigned long)
>> +				hv_cpu->synic_event_page, 1);
>> +			set_memory_encrypted((unsigned long)
>> +				hv_cpu->post_msg_page, 1);
>> +		}
> The re-encryption must be done*before*  pages are freed!
> 
> Furthermore, if the re-encryption fails, we should not free
> the page as it would pollute the free memory pool.  The best
> we can do is leak the memory.  See Patch 5 in Dexuan's
> TDX series, which does the same thing (but still doesn't
> get it quite right, per my comments).
> 

You are right. The order is wrong. we should figure out a right solution 
to handle such case.
