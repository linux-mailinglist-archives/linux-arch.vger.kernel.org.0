Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7890A6F6F69
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEDPwI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEDPwH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 11:52:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DF4EE1;
        Thu,  4 May 2023 08:52:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64115e652eeso13498603b3a.0;
        Thu, 04 May 2023 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215524; x=1685807524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1Fe5ytFbgTTEzLGyRq3sGCP5XE7yG5MihlEMjjzzVc=;
        b=cNzVIfRaS8TbdDf+Iwc4rTABUw1zttFzYEeV6tdcL894o1n9IGTe67DWREGi19zjq8
         WbAeU7MT/ZRieVoRc6lsMy8DdKi+NOApCU6ubhQh2/b36vqjCp+xlvhnBWfWdoHg1bLZ
         GvKZ4XFDTsLNovicVyhJbuR2+Cytorhlw6qfWKgDQx1JSWRj0EH5AbbSGLlXtXDyzF10
         4ufSjDBCEb9ilNiAF+gA0IfDPTfDqyORvMmlr/7EHRu7e0uMnoZ2o6zh22Fon+MLFmyE
         yD+e1eViAKd5GQWAv8F839ZwXRJUpnz4uBYsnFYztDtfmBU6dBWdNB6rMDexrj5BjVQj
         QO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215524; x=1685807524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1Fe5ytFbgTTEzLGyRq3sGCP5XE7yG5MihlEMjjzzVc=;
        b=ShX8Yje1UilEaf38Y0Z/Lx/vHduYEya9bqHgtYCZF1IpTZ/b2Zp5+S7oabfeKpEu9b
         2cxDRWnf9rwhJ0R4n1PvFBOG7k66bxDZKHNsvVVW9ZajxKbdX3oXhirfQnny/ZwZgku5
         1QLyh8O1RK6zrZlveC8YkgY0fwAAjYSYTy1OoX82j+QQcAZrrnFiC+emc6d9JxeXgdzj
         zd0ET78GWihRNEXmAFBKcu22hzzen1H0EFl7rgeWx3K7/+2I0tmzkmncB9MIcxmaITRN
         UDcDRVhZ1LkDg9FmMG65BBgAkO0cberTw/TceiAx+r4timbuhCuB/6DzT1Ll0E1Ux8/x
         kgEQ==
X-Gm-Message-State: AC+VfDxI024yVoXAhMNKB655JU7TWeUN68Rif5iwYppNCKg0J0bxv9xt
        KyClhdXVAEhEKxqtYMLwEZw=
X-Google-Smtp-Source: ACHHUZ6MLDYPmOg3Q12Nkz6IbpYCerIFnS4tPOr8HZp2O5fM66aSY+zPeUP1qRWhjxKKbymqD4ab+g==
X-Received: by 2002:a17:902:c40a:b0:1a9:3c1d:66de with SMTP id k10-20020a170902c40a00b001a93c1d66demr4770453plk.15.1683215524542;
        Thu, 04 May 2023 08:52:04 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5::e29? ([2404:f801:9000:1a:6fea::e29])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902778300b001a1a07d04e6sm23604629pll.77.2023.05.04.08.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:52:04 -0700 (PDT)
Message-ID: <795a2977-c470-ac43-e3bd-bde272baa946@gmail.com>
Date:   Thu, 4 May 2023 08:51:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH V5 09/15] x86/hyperv: Add smp support for sev-snp
 guest
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-10-ltykernel@gmail.com>
 <5038c185-b9de-bc88-9f77-75d83501eb96@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <5038c185-b9de-bc88-9f77-75d83501eb96@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/1/2023 8:46 AM, Tom Lendacky wrote:
>> +    vmsa->sev_features.snp = 1;
>> +    vmsa->sev_features.restrict_injection = 1;
> 
> So this means that any other feature bits set in the BSP won't be set in 
> the AP? Shouldn't you be using the BSP value and checking to be sure 
> what you really want set is set?

So far, the snp flag is enough. You are right that we need to keep it as 
same value on the both BSP and APs. will update in the next version.
