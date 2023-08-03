Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72776DD14
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 03:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjHCBXe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 21:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHCBXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 21:23:33 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4842D5F;
        Wed,  2 Aug 2023 18:23:32 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bba48b0bd2so3355965ad.3;
        Wed, 02 Aug 2023 18:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691025811; x=1691630611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L99r2ZTEs0s1xRLWCPq6Icmbu/mSWzl3/Bl+vsItAA4=;
        b=ZVHfQc2D526hzJHalVaik4FRs4jvcozIoipwX7NFYqiSeJQ5DLwXHlGD3x0TkVW6c1
         yeiss/jxKLgF75qwPsoOQhIwZ1rXhHQbQYB8skmwteYFX5/wMbxaeBgevWpYvOkBwQds
         +IpCArg/9LMEwt3N9AHGsXQvPWPoPfsSrOu2LeJvb+prGTyuCxMlO7gfrRhD2xIC4ZeJ
         0mObfGGb/yN+oTaPHP93U9eHy0/se+xped7ezQGW63PbFqltUpB7/ozpV7sDLtcxPugQ
         9Ps+69xZaFeuNcWQ6QispUXskwxyYN32NMCSNJNW25/OHFdMF3KNUDgcgLZolHpimaqU
         UI1A==
X-Gm-Message-State: ABy/qLbvdOinbgX6BObP/6ThKC9qmgIAohbqxQnIrZ2GyRZPTVSeBBot
        bAaAT9m86+2fsEwTjufcw0Q=
X-Google-Smtp-Source: APBJJlFyzZ0APpf2dycVzuSAvEuollZAIArFhKmP7z/2OuO+QhL68E2G6sLjZLtbq2SX86vDmTVLeg==
X-Received: by 2002:a17:902:bb8d:b0:1b8:b436:c006 with SMTP id m13-20020a170902bb8d00b001b8b436c006mr15268682pls.12.1691025811335;
        Wed, 02 Aug 2023 18:23:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001b9c5e0393csm13073219plg.225.2023.08.02.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 18:23:30 -0700 (PDT)
Date:   Thu, 3 Aug 2023 01:23:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZMsBjAmPdqZdNPEF@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-16-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:50PM -0700, Nuno Das Neves wrote:
> Add mshv, mshv_root, and mshv_vtl modules.
> - mshv provides /dev/mshv and common code, and is the parent module
> - mshv_root provides APIs for creating and managing child partitions
> - mshv_vtl provides VTL (Virtual Trust Level) support for VMMs

Please provide a slightly more detailed description of what these
modules do. This is huge patch after all. People doing code archaeology
will appreciate a better commit message.

For example (please correct if I'm wrong):

Module mshv provides /dev/mshv and common code, and is the parent module
to the other two modules. At its core, it implements an eventfd frame
work, and defines some helper functions for the other modules.

Module mshv_root provides APIs for creating and managing child
partitions. It defines abstractions for vcpus, partitions and other
things related to running a guest inside the kernel. It also exposes
user space interfaces for the VMMs.

Module mshv_vtl provides VTL (Virtual Trust Level) support for VMMs. It
allows the VMM to run in a higher trust level than the guest but still
within the same context as the guest. This is a useful feature for in
guest emulation for better isolation and performance.

> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig             |   54 +
>  drivers/hv/Makefile            |   21 +
>  drivers/hv/hv_call.c           |  119 ++
>  drivers/hv/mshv.h              |  156 +++
>  drivers/hv/mshv_eventfd.c      |  758 ++++++++++++
>  drivers/hv/mshv_eventfd.h      |   80 ++
>  drivers/hv/mshv_main.c         |  208 ++++
>  drivers/hv/mshv_msi.c          |  129 +++
>  drivers/hv/mshv_portid_table.c |   84 ++
>  drivers/hv/mshv_root.h         |  194 ++++
>  drivers/hv/mshv_root_hv_call.c | 1064 +++++++++++++++++
>  drivers/hv/mshv_root_main.c    | 1964 ++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_synic.c        |  689 +++++++++++
>  drivers/hv/mshv_vtl.h          |   52 +
>  drivers/hv/mshv_vtl_main.c     | 1541 +++++++++++++++++++++++++
>  drivers/hv/xfer_to_guest.c     |   28 +
>  include/uapi/linux/mshv.h      |  298 +++++
>  17 files changed, 7439 insertions(+)
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
>  create mode 100644 include/uapi/linux/mshv.h
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 00242107d62e..b150d686e902 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -54,4 +54,58 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> +config MSHV
> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
> +	depends on X86_64 && HYPERV
> +	select EVENTFD
> +	select MSHV_VFIO

This is not needed yet, right? I think this is just dead code right now.

It can be introduced when we start upstreaming the VFIO bits.

> +	select MSHV_XFER_TO_GUEST_WORK
> +	help
> +	  Select this option to enable core functionality for managing guest
> +	  virtual machines running under the Microsoft Hypervisor.
> +
> +	  The interfaces are provided via a device named /dev/mshv.
> +
> +	  To compile this as a module, choose M here.
> +
> +	  If unsure, say N.
> +
> +config MSHV_ROOT
> +	tristate "Microsoft Hyper-V root partition APIs driver"
> +	depends on MSHV
> +	help
> +	  Select this option to provide /dev/mshv interfaces specific to
> +	  running as the root partition on Microsoft Hypervisor.
> +
> +	  To compile this as a module, choose M here.
> +
> +	  If unsure, say N.
> +
> +config MSHV_VTL
> +	tristate "Microsoft Hyper-V VTL driver"
> +	depends on MSHV
> +	select HYPERV_VTL_MODE
> +	select TRANSPARENT_HUGEPAGE
> +	help
> +	  Select this option to enable Hyper-V VTL driver.
> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> +	  enlightenments offered to host and guest partitions which enables
> +	  the creation and management of new security boundaries within
> +	  operating system software.
> +
> +	  VSM achieves and maintains isolation through Virtual Trust Levels
> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> +	  being more privileged than lower levels. VTL0 is the least privileged
> +	  level, and currently only other level supported is VTL2.
> +
> +	  To compile this as a module, choose M here.
> +
> +	  If unsure, say N.

The changes to the function which indicates if output pages are needed
should be in this patch.

> +
> +config MSHV_VFIO
> +	bool
> +
> +config MSHV_XFER_TO_GUEST_WORK
> +	bool
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index d76df5c8c2a9..113c79cfadb9 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,10 +2,31 @@
>  obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
> +obj-$(CONFIG_DXGKRNL)		+= dxgkrnl/

This is not yet upstreamed. It shouldn't be here. Does this not break
the build for you?

The rest is basically a copy of what was posted many moons before plus
some VTL stuff, and new code for the root scheduler and async hypercall
support. I've probably gone through some versions of this code already,
so I only skim the code.

Since this is a Microsoft only driver, I don't expect to get much review
from the community -- the last few rounds were quiet. I will however let
this patch series float for a while before taking any further actions
just in case.

If people are interested in specific bits of the code in the driver,
please let Nuno and I know.

Thanks,
Wei.
