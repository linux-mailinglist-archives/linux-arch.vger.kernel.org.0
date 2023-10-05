Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858067BA202
	for <lists+linux-arch@lfdr.de>; Thu,  5 Oct 2023 17:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJEPLC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Oct 2023 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjJEPKJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2023 11:10:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACADC3693;
        Thu,  5 Oct 2023 07:42:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D80EC433AD;
        Thu,  5 Oct 2023 06:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696487200;
        bh=9xyNVyN7N7MBzA9UwuP9xPWMA9I3taWkS2jqsvKhr3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLcSNkQ/LCUGlX23x7bKHMrm6O+lCfLyVyl4lJFpqj9ZiSYYzwxEp9jZma31Pfllr
         wdUrN6biBfOS5V6bMBNu6EAM0Sq3HUrUansreS7bmBd3mLFduc2pF/kqcY06+yQC5z
         D87SMtm/bM/1USoOdPqeLZaEubagHNYsjEKm7koc=
Date:   Thu, 5 Oct 2023 08:26:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100540-linked-remote-3da7@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <dd5159fe-5337-44ed-bf1b-58220221b597@linux.microsoft.com>
 <2023100443-wrinkly-romp-79d9@gregkh>
 <SA1PR21MB1335F5145ACB0ED4F378105ABFCBA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <2023100415-diving-clapper-a2a7@gregkh>
 <e960ffec-f367-4180-b857-4aceedb7cd89@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e960ffec-f367-4180-b857-4aceedb7cd89@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 04, 2023 at 11:16:46AM -0700, Nuno Das Neves wrote:
> On 10/4/2023 10:50 AM, Greg KH wrote:
> > On Wed, Oct 04, 2023 at 05:36:32PM +0000, Dexuan Cui wrote:
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Tuesday, October 3, 2023 11:10 PM
> > > > [...]
> > > > On Tue, Oct 03, 2023 at 04:37:01PM -0700, Nuno Das Neves wrote:
> > > > > On 9/30/2023 11:19 PM, Greg KH wrote:
> > > > > > On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
> > > > > > > On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> > > > > > > > On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > > > > > > > > +/* Define connection identifier type. */
> > > > > > > > > +union hv_connection_id {
> > > > > > > > > +   __u32 asu32;
> > > > > > > > > +   struct {
> > > > > > > > > +           __u32 id:24;
> > > > > > > > > +           __u32 reserved:8;
> > > > > > > > > +   } __packed u;
> > > 
> > > IMO the "__packed" is unnecessary.
> > > 
> > > > > > > > bitfields will not work properly in uapi .h files, please never do that.
> > > > > > > 
> > > > > > > Can you clarify a bit more why it wouldn't work? Endianess? Alignment?
> > > > > > 
> > > > > > Yes to both.
> > > > > > 
> > > > > > Did you all read the documentation for how to write a kernel api?  If
> > > > > > not, please do so.  I think it mentions bitfields, but it not, it really
> > > > > > should as of course, this will not work properly with different endian
> > > > > > systems or many compilers.
> > > > > 
> > > > > Yes, in
> > > > https://docs.k/
> > > > ernel.org%2Fdriver-
> > > > api%2Fioctl.html&data=05%7C01%7Cdecui%40microsoft.com%7Ce404769e0f
> > > > 85493f0aa108dbc4a08a27%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C
> > > > 0%7C638319966071263290%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > > > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> > > > 7C%7C&sdata=RiLNA5DRviWBQK6XXhxC4m77raSDBb%2F0BB6BDpFPUJY%3D
> > > > &reserved=0 it says that it is
> > > > > "better to avoid" bitfields.
> > > > > 
> > > > > Unfortunately bitfields are used in the definition of the hypervisor
> > > > > ABI. We import these definitions directly from the hypervisor code.
> > > > 
> > > > So why do you feel you have to use this specific format for your
> > > > user/kernel api?  That is not what is going to the hypervisor.
> > > 
> These *are* going to the hypervisor - we use these same definitions in
> our driver for the kernel/hypervisor API. This is so we don't have to
> maintain two separate definitions for user/kernel and kernel/hypervisor
> APIs.

So these fields are just pass-through from userspace to the hypervisor
and are not touched at all by the kernel?  If so, I hope the hypervisor
is doing some validation of the data :)

> > > If it's hard to avoid bitfield here, maybe we can refer to the definition of
> > > struct iphdr in include/uapi/linux/ip.h
> > 
> > It is not hard to avoid using bitfields, just use the proper definitions
> > to make this portable for all compilers.  And ick, ip.h is not a good
> > thing to follow :)
> > 
> Greg, there is nothing making us use bitfields. It just makes the work
> of porting the hypervisor definitions to Linux easier - aided by the
> fact that in practice, all the compilers in our stack produce the same
> code for these.

"our stack" is not how Linux works, you have to write files that work
for all compilers here.

Just use a normal variable and define the bits in them with proper bit
shifts or masks and that will be portable everywhere.  This isn't rocket
science...

thanks,

greg k-h
