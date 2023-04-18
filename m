Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171A66E66D8
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDRONb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Apr 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjDRONa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2023 10:13:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9D146CC;
        Tue, 18 Apr 2023 07:13:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b4960b015so1837166b3a.3;
        Tue, 18 Apr 2023 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681827188; x=1684419188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npDv5LC1r9JSGXUXIXePbFZi4sqFB2N2IstaArUVjL0=;
        b=ClqLXF8d7sPJbUb/SveuP11ZXI3VmJKRH3782pI/eX1Wqz2twyCQ4cr7C+1fVmqMbD
         8XXZ5iB/EiT7OfeMYaJoXw11opTx94xydwFVvzc0Yy+Ulv9I0PFNSNj6eSxW5rfIG2IM
         uskwHEFuh5PWSP6lNfZtR2pzmQvGeV3Jc/qHfDAKHvyKxQlrl1QdzBfySVGvDpTO8EqG
         QR/9X4ixqEuqmcYc9BSaWP8ngxI2bfuvqF5I8k8tw3UVlFqQgLfxx8JQqSyjDANC1qgo
         hMDpxEH9vf20iKhBIpxROCbLJ29sgc93jhhRqHizdj3LzZmYTxEp1R7UFkO0NdKLDYa4
         Acrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827188; x=1684419188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npDv5LC1r9JSGXUXIXePbFZi4sqFB2N2IstaArUVjL0=;
        b=P7yE/9f1AGJqKiI06MJVBsCRMD/libiOvpyN1Khf2zQm+BfQ+0WC6/UOqkfj506Slo
         0NlzbwJf0tcnNXSmf1ZdEisLYCXo3OSiZXeax089RP+MCllOxrz6yN4+uINB2HMyxjKf
         cyn2f1Fgf6w2T5HOOIy7tzT9rKMMCmA1gmC4Cmbh++9QJo9wJhdliCYEGu0eqAP7rehN
         COVHEgIXwM7FtEhX6yXEAAaBIGyVXDU+HbGzho+f2VlvBGmaf+8RmpIjkrnG3hkHczFV
         Fhm1VwYrdOHg5PZLWRVqMn+JLVmOS40PZVSjlWuDyBBezrZBDPx3DaxC3dlFWTjIXinO
         j01Q==
X-Gm-Message-State: AAQBX9c51gS1tMDVIw8cLwFOBnL29SI/jUdvDljwb16uB/i3Ci6dKAW3
        8oA+lF3puNukCgXwWF+YnKs=
X-Google-Smtp-Source: AKy350bqPpqp9A4D2EFebGGadvDtS8IKwioKIwIeZEoavoHpccoyay1CkQnyBXsJDT1vc3qzuTZ6og==
X-Received: by 2002:a17:902:9004:b0:1a5:2621:34cd with SMTP id a4-20020a170902900400b001a5262134cdmr1976607plp.39.1681827188580;
        Tue, 18 Apr 2023 07:13:08 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id iy14-20020a170903130e00b001a63ba28052sm9666969plb.69.2023.04.18.07.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:13:08 -0700 (PDT)
Message-ID: <2c3b4042-c9ef-5b69-34b5-9ee7f418d983@gmail.com>
Date:   Tue, 18 Apr 2023 22:12:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
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
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-9-ltykernel@gmail.com>
 <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <b4c74d0e-5b54-5101-ec18-cc09449ed358@gmail.com>
 <BYAPR21MB16889228F8F5E91DFE43AF3CD79C9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16889228F8F5E91DFE43AF3CD79C9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/17/2023 8:49 PM, Michael Kelley (LINUX) wrote:
>>> Why is the first map entry being skipped?
>> The first entry is populated with processor count by Hyper-V.
> Perhaps add a comment to acknowledge that the behavior
> is a bit unexpected:
> 
> The 0th entry in the memory layout array contains just a 32-bit
> processor count.  Read that value and then skip over the reminder
> of the 0th entry.  Start processing memory_map_entry's with array
> element 1.
> 

Good suggestion! Will update in the next version.
