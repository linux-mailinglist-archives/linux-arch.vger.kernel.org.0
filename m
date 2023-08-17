Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097E77FD5C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354166AbjHQR5L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354163AbjHQR5D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 13:57:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE971FD;
        Thu, 17 Aug 2023 10:57:01 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id B0B4A211F7B7;
        Thu, 17 Aug 2023 10:57:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0B4A211F7B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692295021;
        bh=fhtTpFYAMv833lQqJ6qJ8d9Ged09vSUMPZ70BIl7LAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LXHg/W29TS59LwUP3n+sp1QoALQZsTgWtf53m3WQC6VWJ+BJEriZMBWp+B59fzoDS
         EdkcAAzjZs3w8LRRvpuw1m606KN1KdLQ2LQakAMDHzpDn8nBYpBXk6152pxRRTz1BI
         /1hWzX4aikb8SKgHS9F7J77r57WfsfR/hwD99Eec=
Message-ID: <e8d95099-0477-4930-8a87-d4abacd1587f@linux.microsoft.com>
Date:   Thu, 17 Aug 2023 10:57:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-16-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMsBjAmPdqZdNPEF@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZMsBjAmPdqZdNPEF@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/2023 6:23 PM, Wei Liu wrote:
> On Thu, Jul 27, 2023 at 12:54:50PM -0700, Nuno Das Neves wrote:
>> Add mshv, mshv_root, and mshv_vtl modules.
>> - mshv provides /dev/mshv and common code, and is the parent module
>> - mshv_root provides APIs for creating and managing child partitions
>> - mshv_vtl provides VTL (Virtual Trust Level) support for VMMs
> 
> Please provide a slightly more detailed description of what these
> modules do. This is huge patch after all. People doing code archaeology
> will appreciate a better commit message.
> 
> For example (please correct if I'm wrong):
> 
> Module mshv provides /dev/mshv and common code, and is the parent module
> to the other two modules. At its core, it implements an eventfd frame
> work, and defines some helper functions for the other modules.
> 
> Module mshv_root provides APIs for creating and managing child
> partitions. It defines abstractions for vcpus, partitions and other
> things related to running a guest inside the kernel. It also exposes
> user space interfaces for the VMMs.
> 
> Module mshv_vtl provides VTL (Virtual Trust Level) support for VMMs. It
> allows the VMM to run in a higher trust level than the guest but still
> within the same context as the guest. This is a useful feature for in
> guest emulation for better isolation and performance.
> 

Thanks - I will provide some more detail, including what you described.

I will make a couple of changes - the eventfd framework is in mshv_root,
not mshv. I will amend the mshv_vtl part a little for clarity.

>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/Kconfig             |   54 +
>>  drivers/hv/Makefile            |   21 +
>>  drivers/hv/hv_call.c           |  119 ++
>>  drivers/hv/mshv.h              |  156 +++
>>  drivers/hv/mshv_eventfd.c      |  758 ++++++++++++
>>  drivers/hv/mshv_eventfd.h      |   80 ++
>>  drivers/hv/mshv_main.c         |  208 ++++
>>  drivers/hv/mshv_msi.c          |  129 +++
>>  drivers/hv/mshv_portid_table.c |   84 ++
>>  drivers/hv/mshv_root.h         |  194 ++++
>>  drivers/hv/mshv_root_hv_call.c | 1064 +++++++++++++++++
>>  drivers/hv/mshv_root_main.c    | 1964 ++++++++++++++++++++++++++++++++
>>  drivers/hv/mshv_synic.c        |  689 +++++++++++
>>  drivers/hv/mshv_vtl.h          |   52 +
>>  drivers/hv/mshv_vtl_main.c     | 1541 +++++++++++++++++++++++++
>>  drivers/hv/xfer_to_guest.c     |   28 +
>>  include/uapi/linux/mshv.h      |  298 +++++
>>  17 files changed, 7439 insertions(+)
>>  create mode 100644 drivers/hv/hv_call.c
>>  create mode 100644 drivers/hv/mshv.h
>>  create mode 100644 drivers/hv/mshv_eventfd.c
>>  create mode 100644 drivers/hv/mshv_eventfd.h
>>  create mode 100644 drivers/hv/mshv_main.c
>>  create mode 100644 drivers/hv/mshv_msi.c
>>  create mode 100644 drivers/hv/mshv_portid_table.c
>>  create mode 100644 drivers/hv/mshv_root.h
>>  create mode 100644 drivers/hv/mshv_root_hv_call.c
>>  create mode 100644 drivers/hv/mshv_root_main.c
>>  create mode 100644 drivers/hv/mshv_synic.c
>>  create mode 100644 drivers/hv/mshv_vtl.h
>>  create mode 100644 drivers/hv/mshv_vtl_main.c
>>  create mode 100644 drivers/hv/xfer_to_guest.c
>>  create mode 100644 include/uapi/linux/mshv.h
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 00242107d62e..b150d686e902 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -54,4 +54,58 @@ config HYPERV_BALLOON
>>  	help
>>  	  Select this option to enable Hyper-V Balloon driver.
>>  
>> +config MSHV
>> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
>> +	depends on X86_64 && HYPERV
>> +	select EVENTFD
>> +	select MSHV_VFIO
> 
> This is not needed yet, right? I think this is just dead code right now.
> 
> It can be introduced when we start upstreaming the VFIO bits.
> 

Right. Removed, along with config MSHV_VFIO below.

>> +	select MSHV_XFER_TO_GUEST_WORK
>> +	help
>> +	  Select this option to enable core functionality for managing guest
>> +	  virtual machines running under the Microsoft Hypervisor.
>> +
>> +	  The interfaces are provided via a device named /dev/mshv.
>> +
>> +	  To compile this as a module, choose M here.
>> +
>> +	  If unsure, say N.
>> +
>> +config MSHV_ROOT
>> +	tristate "Microsoft Hyper-V root partition APIs driver"
>> +	depends on MSHV
>> +	help
>> +	  Select this option to provide /dev/mshv interfaces specific to
>> +	  running as the root partition on Microsoft Hypervisor.
>> +
>> +	  To compile this as a module, choose M here.
>> +
>> +	  If unsure, say N.
>> +
>> +config MSHV_VTL
>> +	tristate "Microsoft Hyper-V VTL driver"
>> +	depends on MSHV
>> +	select HYPERV_VTL_MODE
>> +	select TRANSPARENT_HUGEPAGE
>> +	help
>> +	  Select this option to enable Hyper-V VTL driver.
>> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
>> +	  enlightenments offered to host and guest partitions which enables
>> +	  the creation and management of new security boundaries within
>> +	  operating system software.
>> +
>> +	  VSM achieves and maintains isolation through Virtual Trust Levels
>> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
>> +	  being more privileged than lower levels. VTL0 is the least privileged
>> +	  level, and currently only other level supported is VTL2.
>> +
>> +	  To compile this as a module, choose M here.
>> +
>> +	  If unsure, say N.
> 
> The changes to the function which indicates if output pages are needed
> should be in this patch.
> 

Yes - I will add it in this patch.

>> +
>> +config MSHV_VFIO
>> +	bool
>> +
>> +config MSHV_XFER_TO_GUEST_WORK
>> +	bool
>> +
>>  endmenu
>> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
>> index d76df5c8c2a9..113c79cfadb9 100644
>> --- a/drivers/hv/Makefile
>> +++ b/drivers/hv/Makefile
>> @@ -2,10 +2,31 @@
>>  obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
>>  obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
>>  obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
>> +obj-$(CONFIG_DXGKRNL)		+= dxgkrnl/
> 
> This is not yet upstreamed. It shouldn't be here. Does this not break
> the build for you?
> 
Oops! Nope, it doesn't seem to break the build... Anyway, removed.

> The rest is basically a copy of what was posted many moons before plus
> some VTL stuff, and new code for the root scheduler and async hypercall
> support. I've probably gone through some versions of this code already,
> so I only skim the code.
> 
> Since this is a Microsoft only driver, I don't expect to get much review
> from the community -- the last few rounds were quiet. I will however let
> this patch series float for a while before taking any further actions
> just in case.
> 
> If people are interested in specific bits of the code in the driver,
> please let Nuno and I know.
> 
> Thanks,
> Wei.

