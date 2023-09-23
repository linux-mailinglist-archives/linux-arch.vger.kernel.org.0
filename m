Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD897ABEB0
	for <lists+linux-arch@lfdr.de>; Sat, 23 Sep 2023 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjIWH6z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Sep 2023 03:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjIWH6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Sep 2023 03:58:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85C180;
        Sat, 23 Sep 2023 00:58:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C6BC433C8;
        Sat, 23 Sep 2023 07:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695455927;
        bh=Ijh7USVyCy8OB6+AzeKdkPsYF66NC4GSUfQEKgKYTvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+qYPdg+tAiRoIe73SG1cFIi9CDIxIvz7tWOvjyvJLX0inuMCIdhqquAec7ze81VT
         in/3GB4Q6PGeYXz3Cis2UWZH3tA2npiYhqeU2ElQdjq2J7sWD+NGCQCbrRfjM+ZK9j
         ph2epph/TfJYavdBfMVeD/aVfnGXJvTs3PAvksxI=
Date:   Sat, 23 Sep 2023 09:58:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092342-staunch-chafe-1598@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> +static int mshv_vtl_get_vsm_regs(void)
> +{
> +	struct hv_register_assoc registers[2];
> +	union hv_input_vtl input_vtl;
> +	int ret, count = 2;
> +
> +	input_vtl.as_uint8 = 0;
> +	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
> +
> +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       count, input_vtl, registers);
> +	if (ret)
> +		return ret;
> +
> +	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
> +
> +	pr_debug("%s: VSM code page offsets: %#016llx\n", __func__,
> +		 mshv_vsm_page_offsets.as_uint64);
> +	pr_info("%s: VSM capabilities: %#016llx\n", __func__,
> +		mshv_vsm_capabilities.as_uint64);

When drivers are working properly, they are quiet.  This is very noisy
and probably is leaking memory addresses to userspace?

Also, there is NEVER a need for __func__ in a pr_debug() line, it has
that for you automatically.

Also, drivers should never call pr_*() calls, always use the proper
dev_*() calls instead.



> +
> +	return ret;
> +}
> +
> +static int mshv_vtl_configure_vsm_partition(void)
> +{
> +	union hv_register_vsm_partition_config config;
> +	struct hv_register_assoc reg_assoc;
> +	union hv_input_vtl input_vtl;
> +
> +	config.as_u64 = 0;
> +	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
> +	config.enable_vtl_protection = 1;
> +	config.zero_memory_on_reset = 1;
> +	config.intercept_vp_startup = 1;
> +	config.intercept_cpuid_unimplemented = 1;
> +
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		pr_debug("%s: using intercept page", __func__);

Again, __func__ is not needed, you are providing it twice here for no
real reason except to waste storage space :)

> +		config.intercept_page = 1;
> +	}
> +
> +	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
> +	reg_assoc.value.reg64 = config.as_u64;
> +	input_vtl.as_uint8 = 0;
> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       1, input_vtl, &reg_assoc);


None of this needs to be unwound if initialization fails later on?

thanks,

greg k-h
