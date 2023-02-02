Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7F687413
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 04:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjBBDoO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 22:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjBBDoN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 22:44:13 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFD65ECD;
        Wed,  1 Feb 2023 19:44:11 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id bd15so291379pfb.8;
        Wed, 01 Feb 2023 19:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ4OvSrI9i3wTjZH4UgVIohgOi5v6nJaniit595IPUE=;
        b=kAhPH1vsxzkm3Zk+AJ2jmSa3DquYFflB7jfjU84c3JFBtOzYqc+T6smVQ/f6wbpttN
         C28HakSvKZpDDlPHpvAsbsng8TjmrfCjYDepLrp71zdAZYOWERN+jnxHYV3ZV2MwhEFr
         ezpRbzKf2WI9k3XX2Fc8FXS4x5Ne5YdLv0GjU3ZeI7lfevQIR2Nt4tkQIff2SXB0Rzgf
         wdq1WeoL0GNbQYQguUYxDQTUriq0w8MD6sXgGzv3t0w7cdnTK3ppcyTjMxhR7/cFjzNc
         Y8N4vtXU3RPVLp6BBOvi++FianyNG24Z7np/V/HeXksb76sxcZzmGSirWC58joTvVAht
         3fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJ4OvSrI9i3wTjZH4UgVIohgOi5v6nJaniit595IPUE=;
        b=EEzz7q1sv4HHaghTT9w7fkvtfg5OSgSxFRhCJ49XkSmaHEVHqnL2jvaJrwF8eLewWL
         EreVChn7MJv0K3bA06GVsslMBdmZWw9LXz1U5HgtPtqduwkwaPxL03J13GkykGBQ8q2E
         jsMWyg9jn4V4d5O/8Bw4UV8YEVwUudOknhQewW2/AnLQeF7wu+MJnDEp/yF9xwbMvwQo
         IgSDMAN19RX5zA+QKqDc/hyQOkkDEUP9y0nWULjno4yelfmAZag3eU1SjUqdmJpaKzvI
         fD5NeX+ITuR2LoNCZEgVE4yIUvPJW01PYwQHwsiYVLo6cs+7ExNM5Ct79Ei62aiaeCNO
         4SqQ==
X-Gm-Message-State: AO0yUKVcvbFi6o4vcDHqGsrp1KSyvM8QTl28BqfmtZW8cCFIB/rzV/ry
        TLI+tlYrvG/orMlCp41I2Gc=
X-Google-Smtp-Source: AK7set+5CayVAM74aQ8jXURDnHvYcokJw6f2pljQvo1z5dlyb8ApKK87s3FIaQUF3b1WOb77e4ZNEQ==
X-Received: by 2002:a05:6a00:1c89:b0:594:1902:cafe with SMTP id y9-20020a056a001c8900b005941902cafemr3382939pfw.16.1675309451131;
        Wed, 01 Feb 2023 19:44:11 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b00591b0c847b5sm11007042pfn.218.2023.02.01.19.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 19:44:09 -0800 (PST)
Message-ID: <f8c7c646-bb99-3a79-98d9-349a4f8cbbd1@gmail.com>
Date:   Thu, 2 Feb 2023 11:43:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 09/16] x86/hyperv: SEV-SNP enlightened guest don't
 support legacy rtc
To:     Wei Liu <wei.liu@kernel.org>
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
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-10-ltykernel@gmail.com>
 <Y9kfuFGVoIlOfnoK@liuwe-devbox-debian-v2>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Y9kfuFGVoIlOfnoK@liuwe-devbox-debian-v2>
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

On 1/31/2023 10:03 PM, Wei Liu wrote:
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 1a4af0a4f29a..7266d71d30d6 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -33,6 +33,12 @@ extern bool hv_isolation_type_en_snp(void);
>>   
>>   extern union hv_ghcb * __percpu *hv_ghcb_pg;
>>   
>> +/*
>> + * Hyper-V puts processor and memory layout info
>> + * to this address in SEV-SNP enlightened guest.
>> + */
>> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR	0x802000
> This hunk should be moved to the previous patch. It is not needed in
> this patch.

Nice catch. Sorry for noise. Will fix in the next version.

Thanks.
