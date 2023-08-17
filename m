Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA478018B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355970AbjHQXPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 19:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356003AbjHQXOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 19:14:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D42D79;
        Thu, 17 Aug 2023 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692314074; x=1723850074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HPtftuttc3nnrGELFH+bHrdAFWcXr46RVKvnOFRQIDI=;
  b=ghrd9sE6inxB6eL9YzTov5N9008en5IYqEXlCZElxp5GXLLlH7JoPRs+
   EYgG8OQf4QdySY6kRwk+qPPI0PBI2CuUVYjSBDNwNqInf/R6nE2U0ecx2
   2DP7sH/ImmDuQ7sSB9/N6WOMoE4AiiexDbXlWGMXy8YiCibtiofoaRC9t
   Msm5nXHGOPQrcoTV3HWzRlSx060b4wDm20WBVPWYfWSj+SEUztPf4hfG7
   DKfSjSD9U/TpdzEMBffTGWe2tycJ6sLz6YEdMSZ3ADMBCYkHCN/+IU6JS
   V2tfMpO/+7m68LpmHarjw9bKhcViLHxCmq1cgBQsNJpT6PamBxCwcHskK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436872064"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="436872064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824863019"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824863019"
Received: from lacoffin-mobl.amr.corp.intel.com (HELO [10.212.196.192]) ([10.212.196.192])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:14:31 -0700
Message-ID: <0d18816a-c46e-ac7e-b98f-ef3dba1c356e@intel.com>
Date:   Thu, 17 Aug 2023 16:14:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/15] mshyperv: Introduce hv_get_hypervisor_version
 function
Content-Language: en-US
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1692309711-5573-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/17/23 15:01, Nuno Das Neves wrote:
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> +			 (struct hv_get_vp_registers_output *)info);
> +
> +	return 0;
> +}
...
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	unsigned int hv_max_functions;
> +
> +	hv_max_functions = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
> +	if (hv_max_functions < HYPERV_CPUID_VERSION) {
> +		pr_err("%s: Could not detect Hyper-V version\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	info->eax = cpuid_eax(HYPERV_CPUID_VERSION);
> +	info->ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
> +	info->ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
> +	info->edx = cpuid_edx(HYPERV_CPUID_VERSION);
> +
> +	return 0;
> +}

I can't help but notice that the ARM version does *one* call to the
hardware while the x86 version does CPUID four different times, once to
get *EACH* register and throwing away the other three registers each
time.  Also recall that CPUID is a big, fat architecturally serializing
instruction.  This isn't a fast path, but CPUID is about as slow as you get.

Is there any reason you can't just have an x86 version of
hv_get_vpreg_128() that gets the 128 bits bytes of data that comes back
in the 4 CPUID registers?

That might even let you share some more code.
