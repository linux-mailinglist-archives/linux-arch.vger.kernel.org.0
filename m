Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F46244F6
	for <lists+linux-arch@lfdr.de>; Thu, 10 Nov 2022 16:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKJPBd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Nov 2022 10:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKJPBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Nov 2022 10:01:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D81408E;
        Thu, 10 Nov 2022 07:01:30 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i3so2371862pfc.11;
        Thu, 10 Nov 2022 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zz159+nxp6aQdQ7yNB3j3jGqMel9Ite57CMkzXKwRIU=;
        b=gnJM86DEAlr0mbDlTkhLQtdEVC4gTqfTPQizoE5xRLcUQgBiBc78N7ZfYCv3xGaf6m
         SoFCkmv83rJ0FF6m7mQJTalJYinJs59k9gAN/47Q+W3DDk696zHjDZ4iPHkUryTS9YFz
         ujJ3i8+KAn0laRP23MVyjJ1dFAxdr9V1Xwm9CAVs10FiZaLF9o43W+Nz5K3n0NxI2r3T
         Hn8XLAooeFglG3N0+Qg0Q/IHRMlZjk3/Wfp7oP4iJWi/6Lkij0k0YAesmxueQl9QLut+
         20brb7946zLFcWdt7K4x5UojRHYGgt5w/lj3KsCfTwYxIkL/Q8gaixP5vyjsoRa7Cwhe
         /IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zz159+nxp6aQdQ7yNB3j3jGqMel9Ite57CMkzXKwRIU=;
        b=WpstT+8k2XNrugMpc7rxWu3DvfbR06r0I9peI+kEZhCJNCjXfVI8hzvza8Nwpi80XD
         kCxdnmwRLFcHYoDPp2eaZlYdHzetJzK7ojDnvIJ3j5PyuXWduQc5NX6V89Tm/sOG8t3w
         /1UzNbcCVHOv70MV2f52Y3ZHfX7qs5O9YBadJsYbECRGPxaxzAgcc+Sy9dwvO6gzCRgD
         W0m3KVEoaU/zKL5pk4riEk/CZeUVuK5gXQX1qsnOOmXZ8yhERl8svEq5lKov+cBWeZw2
         Pf3cQPg7smoZVyLCK10Qb4ViMDwWKWO/ImMg8psY/Mw4cL1a4gEh+bDNJReeMiM24uYw
         9o8A==
X-Gm-Message-State: ACrzQf3JkEEBUTfip6Fy5d2gc+Y3eJJSg89jX9cxHrKRmYZfg8AOhhxo
        k10JZiU+Y75khqCxswuPq68=
X-Google-Smtp-Source: AMsMyM41vXNzICd0ORtm32x6FgWNlDIol38nrTOt3DYJwzlqSsYgmeh8S3o/NWl8S1B1BaY2ITv8YQ==
X-Received: by 2002:a62:32c4:0:b0:56c:d54a:9201 with SMTP id y187-20020a6232c4000000b0056cd54a9201mr2822045pfy.55.1668092489721;
        Thu, 10 Nov 2022 07:01:29 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id 72-20020a62194b000000b00562677968aesm10244639pfz.72.2022.11.10.07.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 07:01:29 -0800 (PST)
Message-ID: <42195460-8086-ce7b-fd8f-2017bad36d47@gmail.com>
Date:   Thu, 10 Nov 2022 23:01:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 01/17] x86/boot: Check boot param's cc_blob_address
 for direct boot mode
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20221109205353.984745-1-ltykernel@gmail.com>
 <20221109205353.984745-2-ltykernel@gmail.com>
 <20221109233904.scct4fih3b3kvnyk@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20221109233904.scct4fih3b3kvnyk@amd.com>
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

On 11/10/2022 7:39 AM, Michael Roth wrote:
>> -	 * bp->cc_blob_address should only be set by boot/compressed kernel.
>> -	 * Initialize it to 0 to ensure that uninitialized values from
>> -	 * buggy bootloaders aren't propagated.
>> +	 * bp->cc_blob_address should only be set by boot/compressed
>> +	 * kernel and hypervisor with direct boot mode. Initialize it
>> +	 * to 0 after checking in order to ensure that uninitialized
>> +	 * values from buggy bootloaders aren't propagated.
>>   	 */
>> -	if (bp)
>> -		bp->cc_blob_address = 0;
>> +	if (bp) {
>> +		cc_info = (struct cc_blob_sev_info *)(unsigned long)
>> +			bp->cc_blob_address;
>> +
>> +		if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
>> +			bp->cc_blob_address = 0;
> It doesn't seem great to rely on SEV_HDR_MAGIC to determine whether
> bp->cc_blob_address is valid or not since it is only a 32-bit value.
> 
> Would it be possible to use a setup_data entry of type SETUP_CC_BLOB
> in bp->hdr.setup_data instead? There's already handling for that in
> find_cc_blob_setup_data() so it should "just work".

Hi Michael:
	Thanks for your review. I will have a try. Hypervisor may set 
cc_blob_address directly and so propose this.




