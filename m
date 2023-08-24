Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC2787206
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbjHXOo7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjHXOoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:44:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA01BC5;
        Thu, 24 Aug 2023 07:44:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf55a81eeaso34392775ad.0;
        Thu, 24 Aug 2023 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888276; x=1693493076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLp6AU4T9CmlqlzcBBx9W9b93BOe6AI+crrLVW91aHQ=;
        b=feZw1ufFszSbst8zv5IfR3t8FvFaJ/A2bnfp1o0/DBsHE9WU/AqCLoVANFeJie5V0f
         DpKFHrx/uhILLJXogK0ozwkb88be0UXFsLwscnoQ7Q/XrKggTtNsV89fQAKBGnQwb309
         PU7HtwWHSXRQlOzRE6sBNzLYpfUJ9evUuVWgwDOzahAU/VRXCq2fqpy0ABgUs3rJxsnr
         S80DoSXEB+xSgqGPlxZ6oYrM2XyXnqgPrpjcpjNLA8pNwPoJHkOzC6StN1v0wLmanvq8
         j9if9+pIKVDassu+DFKRw2L4O+3P1u+brc6Pa/qEBXHdk0eWzpkeSXCe3lDJrAIzLU9N
         VMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888276; x=1693493076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLp6AU4T9CmlqlzcBBx9W9b93BOe6AI+crrLVW91aHQ=;
        b=Itsi3+hKCP/OEioWcJqXr2kfsL/4bixH4LDjNprEdKm2hTyrWAo85NzmPTSki/oyV4
         qo3qxffh2D9FrtOnHXjsaQhXrjcdmXX8DgwGuW/Q1eJNPte8ybBCCSInkpdmxXMcDymK
         9p8/kA3TJ5P2pusFZtWdgcw0NKRRnVP/ah5y0b1lLJdWpWIZOXIsZIVye+2aXzqTbUFy
         cCEE+wxhZ51CT6jKtB6ZU9BrutwO4bY2DB2QoKK/58S6V2PPRs3ZB3W8KKuOvInVmw4X
         fPkZoiWkwzaktQ+1VKLtvBoFFSxRZT56eUrvXepSbzmUE2rjyNs8oXbh9yAFHsnrvbav
         e98w==
X-Gm-Message-State: AOJu0YwT3Qk/UOcfkKBd9N/9VLSaq2rQTSNKytmmAEo8UjD0kvn8qfU6
        OwK8jbsCdrouR09NpdXRbQg=
X-Google-Smtp-Source: AGHT+IE0wG0BP+1no0xfLGAriM8KyLhM2uLAQ/1Hx5KqYjLG4iC6NlKywJ5C8VKrH6eSZVq+H/Kesw==
X-Received: by 2002:a17:903:41cc:b0:1b8:5aba:509d with SMTP id u12-20020a17090341cc00b001b85aba509dmr12515959ple.21.1692888275811;
        Thu, 24 Aug 2023 07:44:35 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001bf3bdbceb5sm12795314pli.134.2023.08.24.07.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:44:35 -0700 (PDT)
Message-ID: <4ae6b858-da04-3f7f-dfd9-cd4c03716314@gmail.com>
Date:   Thu, 24 Aug 2023 22:44:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 08/10] x86/hyperv: Use TDX GHCI to access some MSRs in
 a TDX VM with the paravisor
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-9-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230824080712.30327-9-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/24/2023 4:07 PM, Dexuan Cui wrote:
> When the paravisor is present, a SNP VM must use GHCB to access some
> special MSRs, including HV_X64_MSR_GUEST_OS_ID and some SynIC MSRs.
> 
> Similarly, when the paravisor is present, a TDX VM must use TDX GHCI
> to access the same MSRs.
> 
> Implement hv_tdx_msr_write() and hv_tdx_msr_read(), and use the helper
> functions hv_ivm_msr_read() and hv_ivm_msr_write() to access the MSRs
> in a unified way for SNP/TDX VMs with the paravisor.
> 
> Do not export hv_tdx_msr_write() and hv_tdx_msr_read(), because we never
> really used hv_ghcb_msr_write() and hv_ghcb_msr_read() in any module.
> 
> Update arch/x86/include/asm/mshyperv.h so that the kernel can still build
> if CONFIG_AMD_MEM_ENCRYPT or CONFIG_INTEL_TDX_GUEST is not set, or
> neither is set.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
