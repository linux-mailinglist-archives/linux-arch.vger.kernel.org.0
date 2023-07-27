Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B5765DB7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 23:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjG0VFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0VFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 17:05:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2033273E;
        Thu, 27 Jul 2023 14:05:35 -0700 (PDT)
Received: from [10.16.84.220] (unknown [131.107.1.156])
        by linux.microsoft.com (Postfix) with ESMTPSA id D270D2380B36;
        Thu, 27 Jul 2023 14:05:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D270D2380B36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690491935;
        bh=kVgS1g9V+trlI19O7bsfTSt6IyzXD6xKp1GbaRCH+J8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=n7Niff/xpZLe+RX/vLOQce9B7nt2YsCuYwED+2v3M13JyAaaSd/EKeHkqDCTikm6m
         +dDG1yfFyL3l52Ddjt/0q8RH6URvZnl9ai3bSNNC9MnvvKZlz5pzJi5QdLRpn7Stf8
         JpXS1ZojZGi87iTCXtjUSFJeQpETaGHn68t6MN3o=
Message-ID: <fd718124-7b71-6746-2b09-e3208894f94c@linux.microsoft.com>
Date:   Thu, 27 Jul 2023 14:05:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/15] Introduce /dev/mshv drivers
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Apologies, it seems patch 15 bouncing from some mailing lists.
As a workaround, here is a link to the patch on github while we figure
out a solution:
https://github.com/NunoDasNeves/linux/commit/54329d18d68b0cbff4f1e0aeba00bc6dd9a21288

On 7/27/2023 12:54 PM, Nuno Das Neves wrote:
> This series introduces support for creating and running guest machines
> while running on the Microsoft Hypervisor. [0]
> This is done via an IOCTL interface accessed through /dev/mshv, similar to
> /dev/kvm. Another series introducing this support was previously posted.
> [1]
> 
> These interfaces support VMMs running in:
> 1. The root patition - provided in the mshv_root module, and
> 2. VTL 2 - provided in the mshv_vtl module [2]
> 
> Patches breakdown
> -----------------
> The first 7 patches are refactoring and adding some helper functions.
> They provide some benefit on their own and could be applied independently
> as cleanup patches.
> 
> The following 5 patches just set things up for the driver code to come.
> These are very small. They are separated so that the remaining patches are
> more self-contained.
> 
> The final 3 patches are the meat of the series:
> - Patch 13 contains new header files used by the driver.
>   These are designed to mirror the ABI headers exported by Hyper-V. This is
>   done to avoid polluting hyperv-tlfs.h and help track changes to the ABIs
>   that are still unstable. (See FAQ below).
> - Patch 14 conditionally includes these new header files into mshyperv.h
>   and linux/hyperv.h, in order to be able to use these files in the new
>   drivers while remaining independent from hyperv-tlfs.h.
> - Patch 15 contains the new driver code located in drivers/hv. This is a
>   large amount of code and new files, but it is mostly self-contained and
>   all within drivers/hv - apart from the IOCTL interface itself in uapi.
> 
> FAQ on include/uapi/hyperv/*.h
> ------------------------------
> Q:
> Why not just add these definitions to hyperv-tlfs.h?
> A:
> The intention of hyperv-tlfs.h is to contain stable definitions documented
> in the public TLFS document. These new definitions don't fit that criteria,
> so they should be separate.
> 
> Q:
> Why are these files named hvgdk.h, hvgdk_mini.h, hvhdk.h and hvhdk_mini.h?
> A:
> The precise meaning of the names reflects conventions used internally at
> Microsoft.
> Naming them this way makes it easy to find where particular Hyper-V
> definitions come from, and check their correctness.
> It also facilitates the future work of automatically generating these files.
> 
> Q:
> Why are they in uapi?
> A:
> In short, to keep things simple. There are many definitions needed in both
> the kernel and the VMM in userspace. Separating them doesn't serve much
> purpose, and makes it more laborious to import definitions from Hyper-V
> code.
> 
> Q:
> The new headers redefine many things that are already in hyperv-tlfs.h - why?
> A:
> Some definitions are extended compared to what is documented in the TLFS.
> In order to avoid adding undocumented or unstable definitions to hyperv-tlfs.h,
> the new headers must compile independently.
> Therefore, the new headers must redefine many things in hyperv-tlfs.h in order
> to compile.
> 
> --------------------------
> [0] "Hyper-V" is more well-known, but it really refers to the whole stack
>     including the hypervisor and other components that run in Windows
>     kernel and userspace.
> [1] Previous /dev/mshv patch series and discussion:
>     https://lore.kernel.org/linux-hyperv/1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com/
> [2] Virtual Secure Mode (VSM) and Virtual Trust Levels (VTL):
>     https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm
> 
> Nuno Das Neves (15):
>   hyperv-tlfs: Change shared HV_REGISTER_* defines to HV_MSR_*
>   mshyperv: Introduce hv_get_hypervisor_version
>   mshyperv: Introduce numa_node_to_proximity_domain_info
>   asm-generic/mshyperv: Introduce hv_recommend_using_aeoi()
>   hyperv: Move hv_connection_id to hyperv-tlfs
>   hyperv-tlfs: Introduce hv_status_to_string and hv_status_to_errno
>   Drivers: hv: Move hv_call_deposit_pages and hv_call_create_vp to
>     common code
>   Drivers: hv: Introduce per-cpu event ring tail
>   Drivers: hv: Introduce hv_output_arg_exists in hv_common
>   x86: hyperv: Add mshv_handler irq handler and setup function
>   Drivers: hv: export vmbus_isr, hv_context and hv_post_message
>   Documentation: Reserve ioctl number for mshv driver
>   uapi: hyperv: Add mshv driver headers hvhdk.h, hvhdk_mini.h, hvgdk.h,
>     hvgdk_mini.h
>   asm-generic: hyperv: Use mshv headers conditionally. Add
>     asm-generic/hyperv-defs.h
>   Drivers: hv: Add modules to expose /dev/mshv to VMMs running on
>     Hyper-V
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |    2 +
>  arch/arm64/hyperv/mshyperv.c                  |   23 +-
>  arch/arm64/include/asm/hyperv-tlfs.h          |   25 +
>  arch/arm64/include/asm/mshyperv.h             |    2 +-
>  arch/x86/hyperv/hv_init.c                     |    2 +-
>  arch/x86/hyperv/hv_proc.c                     |  166 +-
>  arch/x86/include/asm/hyperv-tlfs.h            |  137 +-
>  arch/x86/include/asm/mshyperv.h               |   13 +-
>  arch/x86/kernel/cpu/mshyperv.c                |   71 +-
>  drivers/acpi/numa/srat.c                      |    1 +
>  drivers/clocksource/hyperv_timer.c            |   24 +-
>  drivers/hv/Kconfig                            |   54 +
>  drivers/hv/Makefile                           |   21 +
>  drivers/hv/hv.c                               |   46 +-
>  drivers/hv/hv_call.c                          |  119 +
>  drivers/hv/hv_common.c                        |  225 +-
>  drivers/hv/hyperv_vmbus.h                     |    2 +-
>  drivers/hv/mshv.h                             |  156 ++
>  drivers/hv/mshv_eventfd.c                     |  758 +++++++
>  drivers/hv/mshv_eventfd.h                     |   80 +
>  drivers/hv/mshv_main.c                        |  208 ++
>  drivers/hv/mshv_msi.c                         |  129 ++
>  drivers/hv/mshv_portid_table.c                |   84 +
>  drivers/hv/mshv_root.h                        |  194 ++
>  drivers/hv/mshv_root_hv_call.c                | 1064 +++++++++
>  drivers/hv/mshv_root_main.c                   | 1964 +++++++++++++++++
>  drivers/hv/mshv_synic.c                       |  689 ++++++
>  drivers/hv/mshv_vtl.h                         |   52 +
>  drivers/hv/mshv_vtl_main.c                    | 1541 +++++++++++++
>  drivers/hv/vmbus_drv.c                        |    3 +-
>  drivers/hv/xfer_to_guest.c                    |   28 +
>  include/asm-generic/hyperv-defs.h             |   26 +
>  include/asm-generic/hyperv-tlfs.h             |   77 +-
>  include/asm-generic/mshyperv.h                |   76 +-
>  include/linux/hyperv.h                        |   11 +-
>  include/uapi/hyperv/hvgdk.h                   |   41 +
>  include/uapi/hyperv/hvgdk_mini.h              | 1077 +++++++++
>  include/uapi/hyperv/hvhdk.h                   | 1352 ++++++++++++
>  include/uapi/hyperv/hvhdk_mini.h              |  164 ++
>  include/uapi/linux/mshv.h                     |  298 +++
>  40 files changed, 10653 insertions(+), 352 deletions(-)
>  create mode 100644 drivers/hv/hv_call.c
>  create mode 100644 drivers/hv/mshv.h
>  create mode 100644 drivers/hv/mshv_eventfd.c
>  create mode 100644 drivers/hv/mshv_eventfd.h
>  create mode 100644 drivers/hv/mshv_main.c
>  create mode 100644 drivers/hv/mshv_msi.c
>  create mode 100644 drivers/hv/mshv_portid_table.c
>  create mode 100644 drivers/hv/mshv_root.h
>  create mode 100644 drivers/hv/mshv_root_hv_call.c
>  create mode 100644 drivers/hv/mshv_root_main.c
>  create mode 100644 drivers/hv/mshv_synic.c
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>  create mode 100644 drivers/hv/xfer_to_guest.c
>  create mode 100644 include/asm-generic/hyperv-defs.h
>  create mode 100644 include/uapi/hyperv/hvgdk.h
>  create mode 100644 include/uapi/hyperv/hvgdk_mini.h
>  create mode 100644 include/uapi/hyperv/hvhdk.h
>  create mode 100644 include/uapi/hyperv/hvhdk_mini.h
>  create mode 100644 include/uapi/linux/mshv.h
> 

