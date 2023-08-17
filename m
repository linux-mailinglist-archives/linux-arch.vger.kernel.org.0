Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1B7801CC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 01:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356155AbjHQXny (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356184AbjHQXnx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 19:43:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55EC635A7;
        Thu, 17 Aug 2023 16:43:51 -0700 (PDT)
Received: from [10.16.85.5] (unknown [131.107.8.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B4BF211F7BF;
        Thu, 17 Aug 2023 16:43:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B4BF211F7BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692315830;
        bh=SvpYja/c9jhYTVgBr6bqBPMX6EwsdHtUjssCTNc905I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n54pAAluDm4ITp73Rwu5QC1UVpr0ytnb154C4vANZa0ThPTwOXUHMGp8stqYQrTo/
         5ZVc3nOqbPxZiRy0C/mguB8JIF8Wx5Wzl32jAMcquOFhnTHjFLQG76pw37YL7j4Ol4
         5k0v96Q76WcxGyqavWhYM24cLUTMvDeN4oNlOab8=
Message-ID: <b3ce3163-aebf-4dd6-b08c-b09a1224b2cb@linux.microsoft.com>
Date:   Thu, 17 Aug 2023 16:43:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] mshyperv: Introduce hv_get_hypervisor_version
 function
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-3-git-send-email-nunodasneves@linux.microsoft.com>
 <0d18816a-c46e-ac7e-b98f-ef3dba1c356e@intel.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <0d18816a-c46e-ac7e-b98f-ef3dba1c356e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/17/2023 4:14 PM, Dave Hansen wrote:
> On 8/17/23 15:01, Nuno Das Neves wrote:
>> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>> +{
>> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
>> +			 (struct hv_get_vp_registers_output *)info);
>> +
>> +	return 0;
>> +}
> ...
>> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>> +{
>> +	unsigned int hv_max_functions;
>> +
>> +	hv_max_functions = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
>> +	if (hv_max_functions < HYPERV_CPUID_VERSION) {
>> +		pr_err("%s: Could not detect Hyper-V version\n",
>> +			__func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	info->eax = cpuid_eax(HYPERV_CPUID_VERSION);
>> +	info->ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
>> +	info->ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
>> +	info->edx = cpuid_edx(HYPERV_CPUID_VERSION);
>> +
>> +	return 0;
>> +}
> 
> I can't help but notice that the ARM version does *one* call to the
> hardware while the x86 version does CPUID four different times, once to
> get *EACH* register and throwing away the other three registers each
> time.  Also recall that CPUID is a big, fat architecturally serializing
> instruction.  This isn't a fast path, but CPUID is about as slow as you get.
> 

Good point, it is quite wasteful. I just went and checked cpuid.h, and of
course there is a generic cpuid() function that can get all 4 at once.
I will update it to use this in the next version. Thanks!

> Is there any reason you can't just have an x86 version of
> hv_get_vpreg_128() that gets the 128 bits bytes of data that comes back
> in the 4 CPUID registers?
> 
> That might even let you share some more code.

Unfortunately, for some reason the hypervisor only lets you get this data via
CPUID on x86_64, and via hypercall - i.e. hv_get_vpreg_128() - on ARM64.

