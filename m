Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED777655FB0
	for <lists+linux-arch@lfdr.de>; Mon, 26 Dec 2022 05:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiLZEUG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Dec 2022 23:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZEUE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Dec 2022 23:20:04 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB0182;
        Sun, 25 Dec 2022 20:20:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 82so6645035pgc.0;
        Sun, 25 Dec 2022 20:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ihv+rRergc0+rZ9vlteUpmym/v26iiTrc7B/gFQDU1I=;
        b=EQx2qS8wZKvgmrNacE2vzxNchD2qsdYshv9lre2VaV8DDwHTpG/bU5cmx7D7zSU/kz
         apIA33umqiWIpuRYQ6aloNW8ZBR2f7JLXBxT5kRKZ6n89lRncjjTkB+IJLWie3Ah2uMG
         6BpRYUL03yBW8g+k2Ga7txUUQcnWc88+SUIV205XAH+cpRM6qJI4nRC7bNTRsnX4eEnq
         ReUeHsbaf/nmbtld76Yz9F72uR0SJhQ5kf82GCKu6dwJkRyYAfZ+q0UXvxdSQxyHXAJF
         72TrEPLahcJGPyZFxWPsrOdGUot+Hqu8a1N4QidvvwUU7cuNAh69M8CFdbS5MCeEubnA
         tLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihv+rRergc0+rZ9vlteUpmym/v26iiTrc7B/gFQDU1I=;
        b=A46s1rKQRp8SMerTv8FhcP66SPArUxfUdd19kdUa0vbQHeA3QOOv5sdh/fpEykjev+
         M7Kwey5U8Du3/vL+1ptRZQAAD1RfaurfWhm3ZLDQ4nKCCxK1We9Tr3GmxlSCVeJnxL28
         lqoKllPpsZunN/778hsRsendapvboOZMb9YajY1P/H6gGtI/4CusssMG38HRnWoTURhR
         HgfZ9pPkm+/unK8/BU6NDxhP51gR6Y/bMcn7kNa/0GH0SJ7V4jsKLX5skw5tCX7RwzCN
         pPRxOcEsBCXGypBNrOdyMAZ6QDQrcAKIj+ths7WGL8++UnqMFtL0VRV2cNn2nMtpQXuq
         4W9Q==
X-Gm-Message-State: AFqh2kr3T0dKdNGHQzUXzHYboAKGQTKQVhpD9UBmiWhc6tjqonJrrlVd
        MKY5C4/7ziS7BuwjKJhYUu4=
X-Google-Smtp-Source: AMrXdXsgGYu5uvxvnzfPorgJsB6j6WbxZ6RsZwQigXjvL1TI+MTyjSlsMeKFHhv8SXu5kfWdHqOLHA==
X-Received: by 2002:aa7:9054:0:b0:580:c75f:44dc with SMTP id n20-20020aa79054000000b00580c75f44dcmr9964268pfo.19.1672028402142;
        Sun, 25 Dec 2022 20:20:02 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id l190-20020a6225c7000000b005771d583893sm6057338pfl.96.2022.12.25.20.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 20:20:01 -0800 (PST)
Message-ID: <ec2b1723-1698-ac64-279b-c47b38b8d16f@gmail.com>
Date:   Mon, 26 Dec 2022 12:19:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 08/18] x86/hyperv: decrypt vmbus pages for sev-snp
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
 <20221119034633.1728632-9-ltykernel@gmail.com>
 <BYAPR21MB168838758CAA630B55E73DB2D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168838758CAA630B55E73DB2D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 12/14/2022 2:08 AM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46 PM
>>
> 
> The Subject prefix for this patch should be "Drivers: hv: vmbus:"

Sure. Will update in the next version.

> 
>> Vmbus int, synic and post message pages are shared with hypervisor
>> and so decrypt these pages in the sev-snp guest.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>   drivers/hv/connection.c | 13 +++++++++++++
>>   drivers/hv/hv.c         | 32 +++++++++++++++++++++++++++++++-
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index 9dc27e5d367a..43141225ea15 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -215,6 +215,15 @@ int vmbus_connect(void)
>>   		(void *)((unsigned long)vmbus_connection.int_page +
>>   			(HV_HYP_PAGE_SIZE >> 1));
>>
>> +	if (hv_isolation_type_snp() || hv_isolation_type_en_snp()) {
> 
> This decryption should be done only for a fully enlightened SEV-SNP
> guest, not for a vTOM guest.
> 
>> +		ret = set_memory_decrypted((unsigned long)
>> +				vmbus_connection.int_page, 1);
>> +		if (ret)
>> +			goto cleanup;
> 
> This cleanup path doesn't work correctly.  It calls
> vmbus_disconnect(), which will try to re-encrypt the memory.
> But if the original decryption failed, re-encrypting is the wrong
> thing to do.
> 
> It looks like this same bug exists in current code if the decryption
> of the monitor pages fails or if just one of the original memory
> allocations fails.  vmbus_disconnect() doesn't know whether it
> should re-encrypt the pages.

Agree. It's necessary to handle decryption failure case by case in stead 
of re-encryting all pages. Will fix this in the next version. Thanks to 
point out.
