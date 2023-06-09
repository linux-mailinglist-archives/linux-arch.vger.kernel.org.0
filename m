Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C097729643
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbjFIKGr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFIKF6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 06:05:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 848E565A1;
        Fri,  9 Jun 2023 02:56:45 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 2EE7820C1473; Fri,  9 Jun 2023 02:56:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EE7820C1473
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686304605;
        bh=QCAfbAdMJ4hq/jLexUoenZqABGBc2UI5B4FxLEQLDhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c71GVxoshBaJT+JmmEXKMETgHlQqie6/1B1zvQm1lko5kFta+orf/3fDmIvVdEoV7
         0M/tCdICZ0MBaVddlp0ZN1wghI0x9kVsZHKQS/BiF0aP9wDd5qeNtY0fb0oDl+HE1d
         dqckaHpOM92p4CC+HFBrVBYiIzZ+U72VdNtl2IzY=
Date:   Fri, 9 Jun 2023 02:56:45 -0700
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Message-ID: <20230609095645.GA21469@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-8-ltykernel@gmail.com>
 <BYAPR21MB1688B4F74FF7B670267D32FAD750A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688B4F74FF7B670267D32FAD750A@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 08, 2023 at 01:51:35PM +0000, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 1, 2023 8:16 AM
> > 
> > Hyper-V enlightened guest doesn't have boot loader support.
> > Boot Linux kernel directly from hypervisor with data(kernel
> 
> Add a space between "data" and "(kernel"
> 
> > image, initrd and parameter page) and memory for boot up that
> > is initialized via AMD SEV PSP proctol LAUNCH_UPDATE_DATA
> 
> s/proctol/protocol/
> 
> > (Please refernce https://www.amd.com/system/files/TechDocs/55766_SEV-KM_API_Specification.pdf 1.3.1 Launch).
> 
> s/refernce/reference/
> 
> And the link above didn't work for me -- the "55766_SEV-KM_API_Specification.pdf"
> part was separated from the rest of the URL, though it's possible the mangling
> was done by Microsoft's email system.  Please double check that the URL is
> correctly formatted with no spurious spaces.
> 
> Even better, maybe write this as:
> 
> Please reference Section 1.3.1 "Launch" of [1].
> 
> Then put the full link as [1] at the bottom of the commit message.
> 

Tianyu: that document is SEV specific, and does not have the parts that SEV-SNP
uses. For SNP this is the firmware ABI:

https://www.amd.com/system/files/TechDocs/56860.pdf

and the API I think you mean is SNP_LAUNCH_UPDATE.

It would also help to mention that the data at EN_SEV_SNP_PROCESSOR_INFO_ADDR
is loaded as PAGE_TYPE_UNMEASURED.

Thanks,
Jeremi
