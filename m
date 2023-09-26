Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF017AECEC
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjIZMdo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjIZMdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 08:33:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA27711D;
        Tue, 26 Sep 2023 05:33:36 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 1318520B74C0; Tue, 26 Sep 2023 05:33:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1318520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695731616;
        bh=eorYgxmtB2WEDhSzSXglOLVbIYf2lmcE5SfGSmPo5ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBKDsWur+Azdt3wFsEq+NVIYYXomnLJSmI+9ykR00PihrafadUM1BDJrS6LBkr0IB
         VrduIN2jMFUPr2Q1R5ZNzFivvc+C7lQqYcg1bW/tfADL0tL51W+FJIdA8NSRFi1//e
         FNVzOhYT/BUX7jKP2bGXB+cMXVgf/Kzrs9L8ZrpI=
Date:   Tue, 26 Sep 2023 05:33:36 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <20230926123336.GA9863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
> Resend in plain text instead of HTML - oops!
> 
> On 9/23/2023 12:58 AM, Greg KH wrote:
> >On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> >>+static int mshv_vtl_get_vsm_regs(void)
> >>+{
> >>+	struct hv_register_assoc registers[2];
> >>+	union hv_input_vtl input_vtl;
> >>+	int ret, count = 2;
> >>+
> >>+	input_vtl.as_uint8 = 0;
> >>+	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> >>+	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
> >>+
> >>+	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> >>+				       count, input_vtl, registers);
> >>+	if (ret)
> >>+		return ret;
> >>+
> >>+	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
> >>+	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
> >>+
> >>+	pr_debug("%s: VSM code page offsets: %#016llx\n", __func__,
> >>+		 mshv_vsm_page_offsets.as_uint64);
> >>+	pr_info("%s: VSM capabilities: %#016llx\n", __func__,
> >>+		mshv_vsm_capabilities.as_uint64);
> >
> >When drivers are working properly, they are quiet.  This is very noisy
> >and probably is leaking memory addresses to userspace?
> >
> 
> I will remove these, thanks.
> 
> >Also, there is NEVER a need for __func__ in a pr_debug() line, it has
> >that for you automatically.
> >
> 
> Thank you, I didn't know this.
> 
> >Also, drivers should never call pr_*() calls, always use the proper
> >dev_*() calls instead.
> >
> 
> We only use struct device in one place in this driver, I think that
> is the only place it makes sense to use dev_*() over pr_*() calls.
> >
> >
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static int mshv_vtl_configure_vsm_partition(void)
> >>+{
> >>+	union hv_register_vsm_partition_config config;
> >>+	struct hv_register_assoc reg_assoc;
> >>+	union hv_input_vtl input_vtl;
> >>+
> >>+	config.as_u64 = 0;
> >>+	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
> >>+	config.enable_vtl_protection = 1;
> >>+	config.zero_memory_on_reset = 1;
> >>+	config.intercept_vp_startup = 1;
> >>+	config.intercept_cpuid_unimplemented = 1;
> >>+
> >>+	if (mshv_vsm_capabilities.intercept_page_available) {
> >>+		pr_debug("%s: using intercept page", __func__);
> >
> >Again, __func__ is not needed, you are providing it twice here for no
> >real reason except to waste storage space :)
> >
> 
> Thanks, I will review all the uses of pr_debug().
> 
> >>+		config.intercept_page = 1;
> >>+	}
> >>+
> >>+	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
> >>+	reg_assoc.value.reg64 = config.as_u64;
> >>+	input_vtl.as_uint8 = 0;
> >>+
> >>+	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> >>+				       1, input_vtl, &reg_assoc);
> >
> >
> >None of this needs to be unwound if initialization fails later on?
> >
> 
> I think unwinding this is not needed, not 100% sure.
> Saurabh, can you comment?

Yes unwinding is not useful here, as these are synthetic register
and there is no other use case of VSM supporting platforms other
than VSM configuration.

In a non VSM supported platform hv_call_set_vp_registers itself will
fail for HV_REGISTER_VSM_PARTITION_CONFIG.

- Saurabh

> 
> Thanks,
> Nuno
> 
> >thanks,
> >
> >greg k-h
> 
