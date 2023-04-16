Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8036E35CC
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDPHiD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Apr 2023 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjDPHiC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Apr 2023 03:38:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228921FFC;
        Sun, 16 Apr 2023 00:38:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b4960b015so844888b3a.3;
        Sun, 16 Apr 2023 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681630680; x=1684222680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5NhvhFxKX4Eel+mjyeudZ+71BGwovQHUqehBfxjjbo=;
        b=Wq2JSSOcotk2koSIqamk3acYvBpROM5iA8zomrDZXIIFuFSEYQI9UoHiiiQ+C3LiT4
         lspt7yhui0LBRekgQ4qZrSAFYDSRhNzbX0tuhGA+lb145WQP0zQVVYhDH+b12U+Wy0iF
         gYImZ9ka1A5WsYRLNNHptVnDmubY/hILmhD0Z3X1PmF6SBflIlBDNO244wPcQjklnOvC
         TarKt3tv1iFENcM3Bm1S/CW+y9TfLvi+9L1rnSlm/hiOfGPWZxU6TG+EOILYl6j/uBMN
         Wlvlc10VArc5FrgasZSYfiFpFeJi8dSDNRfBXIM5nNfuugLjg2EPy0WPq4dv+AYnEArB
         Z9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681630680; x=1684222680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5NhvhFxKX4Eel+mjyeudZ+71BGwovQHUqehBfxjjbo=;
        b=ZKejT8CCHYg/QNFRVLuTHtpvUFx5yryhmjcYuj3h4ylYjJVy+i+qw9C2yEdRtvGB4t
         UQ/Av/AiBcd9cBMDr/nbgclstr1m0Rt0OmDsEO3BkqfI/O+rXMVFISIpemmKa1UwdiPN
         3uuK70SOuQClTF/diLspgc06D/B45+c1DP2Gk8eVoI+dFDunCil7L82aQLURx0ehK4ys
         JLMfwPcZSQjPRuuR2gbtiTkIMl6Z4WOdBD/pQhr1NaqG4W/Kyk84riJ9SS2PkkzHtOoO
         kq/6t8VlYFJA5Opl3XZip+WdHSVpbKm3s1xhMgb8Em4Qu+enUcLA0W0aNuBb23FnF9mq
         1MMg==
X-Gm-Message-State: AAQBX9fD7K6rLJnJoW9b+AyvK64XSBMSUVVksRxB9G7IJPeRuICnRswl
        J/CRlHkcv5ZAn3suvYo8VS4=
X-Google-Smtp-Source: AKy350ZdVtbyE9peGmRyH7eUsqqLQvUeElVcM5ven2Cb85XZ2BPQRqQm9YUSOfSUVQWBejQBwCsoLA==
X-Received: by 2002:a05:6a00:1acb:b0:63b:23b0:a72e with SMTP id f11-20020a056a001acb00b0063b23b0a72emr16202900pfv.15.1681630680586;
        Sun, 16 Apr 2023 00:38:00 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id 12-20020aa7914c000000b00637ca3eada8sm5555427pfi.6.2023.04.16.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:38:00 -0700 (PDT)
Message-ID: <1ec6d77e-c5a1-52ac-de12-a878b753abcc@gmail.com>
Date:   Sun, 16 Apr 2023 15:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 14/17] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
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
 <20230403174406.4180472-15-ltykernel@gmail.com>
 <BYAPR21MB16884681B85CE6C83CBC2B1FD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16884681B85CE6C83CBC2B1FD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/12/2023 11:02 PM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan<ltykernel@gmail.com>  Sent: Monday, April 3, 2023 10:44 AM
> The patch subject prefix of "x86/hyperv/sev:" doesn't make sense.
> There's no pathname like that in the kernel code.  I think it should just be
> "x86/sev:".
>

Agree. Will update in the next version.

