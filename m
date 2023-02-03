Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404E6688E74
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 05:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjBCELq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 23:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBCELp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 23:11:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE5889B5;
        Thu,  2 Feb 2023 20:11:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso3811021pjb.4;
        Thu, 02 Feb 2023 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6SutkkPN90XD99Vz5rZcOuOIBT6F073Izv3cfX4L6Y=;
        b=LR+uushjFX5Yl32iRIfbrakVGmfD4q44AT0eKuy7DOqNEC9Bx2dJMbfs81NvcayfKk
         OHC/qz/dpCJHl4W5ZrbZbJ0sCi7vonP+Zpk0zn1Bbey3rNhQcTIrPJ6Tj2PGsmH9ruR/
         RelLFwe8neUWQ68jK0bIzxHC00h4Oon/nCjuQHb8bh6LE71XJozSrX6OMUe5MYn0f8xB
         dD3a7JhIJDaXujzdh3B2u5bqTfwMPYDf6MewPhgMfEivY5OHmx5zNiQ2zdEFUgTqx96l
         38N1R2IBlR0HAc7x0eZXUJMA2zfSWisF3hsZH/TXDwvwroVZOKfvW/HyFUk3t+KC3Okb
         0Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6SutkkPN90XD99Vz5rZcOuOIBT6F073Izv3cfX4L6Y=;
        b=XuA2gmuNBDEVm+SBpMEdcgAg+Z/W5Oln1UeW5gT+DCqv7/BVNqFFoO42NmHKfStTuH
         +UI5UGxWY66Bn01F/J47lhd7o0MLl3/I+n7so6R7RYbqcSzL8sCwpNYvfPPIsNmBe8cP
         NmQNFMBLwLczngslQ6es7Q2ey+6vAVRPNswh5pk7Sk9JNdX7HiqfjWcbeK3+Up9fDpWM
         whQ//ok0g3VKKOYzyjy2HWvmv/rXQihE6mcH1Fayf2LFSoscLCYmL8jKHnFmxln46WPY
         5XQm/f0OGaSf/SfbyNJE3xXI8BGWb7S0Qsab2moZ8ObDXL0eimiBmk7aDhoOQgog3Q9G
         voqw==
X-Gm-Message-State: AO0yUKV8CxHF8f7thjFYaD6qdozEx0PmZ3Z0yauax/lY0t+Fwv8Ukn/h
        DJx4DUkwj/rmOw6jqy1dagU=
X-Google-Smtp-Source: AK7set/ZCPGn5k2O6fvqA++fmfJfTUdpOPqgHayHUBGBgYGncgLTWQZkMXfmvlwKFCrilHS72RI9XA==
X-Received: by 2002:a17:90b:4d10:b0:229:ee75:5d09 with SMTP id mw16-20020a17090b4d1000b00229ee755d09mr8904607pjb.40.1675397503892;
        Thu, 02 Feb 2023 20:11:43 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090a481100b00218a7808ec9sm461899pjh.8.2023.02.02.20.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 20:11:43 -0800 (PST)
Message-ID: <0aea3782-b494-4c1b-1c74-2337bcdae3ef@gmail.com>
Date:   Fri, 3 Feb 2023 12:11:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 06/16] x86/hyperv: decrypt vmbus pages for sev-snp
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
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-7-ltykernel@gmail.com>
 <BYAPR21MB16882851012198FD7ADB5CD1D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16882851012198FD7ADB5CD1D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 2/1/2023 1:58 AM, Michael Kelley (LINUX) wrote:
>> +
>> +			ret = set_memory_decrypted((unsigned long)
>> +				hv_cpu->post_msg_page, 1);
>> +			if (ret)
>> +				goto err_decrypt_msg_page;
>> +
>> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
>> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
>> +			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
>> +		}
> Having decrypted the pages here in hv_synic_alloc(), shouldn't
> there be corresponding re-encryption in hv_synic_free()?
> 

Yes, I ignore in this version and will fix it.

Thanks.
