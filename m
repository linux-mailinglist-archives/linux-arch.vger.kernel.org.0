Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB72264CDA8
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 17:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiLNQFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 11:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiLNQFX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 11:05:23 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3C1145;
        Wed, 14 Dec 2022 08:05:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k79so4764095pfd.7;
        Wed, 14 Dec 2022 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXbc/jfqnCGUqCw2moMEcw2IXH8EkgaJ3B94yLixEls=;
        b=duVBSq/oHWrm6AdEIi+Wx2srTYC158ZbhRXJUsD5AgkaZUS3hMhG5edH18GbW/YstY
         kSCB1XlB+p4wNke1nHVljepAxKFOAEnXkm/+aAWjtZK9z43ODGh4EfNLEP7NfIs/J8Hw
         qE2ItvvXSQTjPWMB8ac+1rkjJuIvYbk+Qb4VktxxxWACUmg3+Gc4BJpc6VFBynmIw2ux
         F7oyBhmZXSe4cJL4brqio83UREebC+RbtHKxO9jwvxXow4MqPvmgIenwD0+QoTOeq0uE
         SBKTn0TjVfICtqzSL/q4P652Y8jP2DH5X60dCp4R59w9uLIi0RkNWeIEZsDMDf+25u6A
         ykGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXbc/jfqnCGUqCw2moMEcw2IXH8EkgaJ3B94yLixEls=;
        b=Tg2egT2kUvEU0ey+hQwl3mX14bzPmK63Co0It6qIztsh1ZqWMhFc+7TVzon6m/nkm7
         PjAbZE4kfTTCTVmH0B+DWhcncaJ7DcKYRrg8JA0FC50Rt5Bo5WigBhSOew1AbGnNRoAR
         aHCT9nF0jMHEmmR6KOWTdHGziv155B3+ojh9HqJj3cEClqGjClslhs8OBIh1onX90SMb
         R+YkLCm58y5s/ZR2/ena6VMy31HbOMOwQdqdzXbLktZXQjUPOe8/FMR7qGo0LiKK1rdR
         YRj60uNS2fTwWyybPXFyPhonqdFq+oQmGrMi+bm+mwY7nfVCN60HEpS1eg8b1WGnZSNG
         4GkQ==
X-Gm-Message-State: ANoB5pnafJGYGX6eUfk6jInXWzJd2qxERnMpRLxHBGPrEQtw+DRsKP9q
        R5TTl1gZrxiAGE4yx3EUxnED5Ye+xbk7Sx9Kzf4=
X-Google-Smtp-Source: AA0mqf6jXQ5+nkr8xrSzl6Ap+TVssMX6zs8LItbQhlBMJyGiHbJiW3lcc6d3IsytMBUqufvjBWLpCg==
X-Received: by 2002:a62:4e96:0:b0:574:1d8a:d4f with SMTP id c144-20020a624e96000000b005741d8a0d4fmr24438109pfb.16.1671033922104;
        Wed, 14 Dec 2022 08:05:22 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b005765a5ff1fasm20890pfq.213.2022.12.14.08.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:05:21 -0800 (PST)
Message-ID: <9d9398e5-3b34-a086-119f-e11ff4c10cd0@gmail.com>
Date:   Thu, 15 Dec 2022 00:05:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 07/18] clocksource: hyper-v: decrypt hyperv tsc
 page in sev-snp enlightened guest
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
 <20221119034633.1728632-8-ltykernel@gmail.com>
 <BYAPR21MB16887BAC34B73C9D9BA9FC33D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16887BAC34B73C9D9BA9FC33D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 12/14/2022 1:30 AM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan<ltykernel@gmail.com>  Sent: Friday, November 18, 2022 7:46 PM
> Previous patches to the Hyper-V clocksource driver have not been very
> consistent in the Subject line prefix, but let's use
> "clocksource/drivers/hyper-v:" since it has been used the most.
> 

OK. Will update in the next version.

Thanks.
