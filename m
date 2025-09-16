Return-Path: <linux-arch+bounces-13659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35025B59C79
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D21896DB3
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D734AAEE;
	Tue, 16 Sep 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BENlAFr/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660C38DE1;
	Tue, 16 Sep 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037815; cv=none; b=bWUjSSCK/jRVp2GtaYE5amQ2LWa+jp3gRTqPIJyd8HdF1xzJNZ1Fn6t0bOEQo6JUOsk7emRTBpAnLlxQ2rtJ0LOSRp2TtgX560lOOTn+LfbIXoCodTsNU9hjWjl4bC2oH9DNRqPeVqyaV4Xn1b148br1oaMm7HeqmNOAVQrBMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037815; c=relaxed/simple;
	bh=3KoryAxr6Svd8fLp3XSHCXgsOwaACFiZ4QTZ3soPyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tw8US4U8YsRM/rfxthhQkuklsI/gtET2jLQaBswhZx5LIQIbdl0rl4uIEgGepW2QCWu+2uITABAhnOW5hhH5SB4h98zyDrI2gVXt3dnoCHs6PsLqyLBW7hJrAWEY1HL249y5A9h/3Yy/uDc3dlEU3XSaY4vTINJeWVjKkgR87hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BENlAFr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F542C4CEEB;
	Tue, 16 Sep 2025 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037814;
	bh=3KoryAxr6Svd8fLp3XSHCXgsOwaACFiZ4QTZ3soPyRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BENlAFr/oFel1GF5GFPtU6oxWpWfzfStVPue8IstxyUsG7Fj9lLDTP68RAnHHPWNp
	 3weMqWp3xfO18Izf+tYI18UTMjiJebfCVqGy2N8OMUvS/Lm7EO7ocrKiB+JCgXmurI
	 /JERjnllW4rsjlrlvWN5PBIYn/VwqYQo0omGanX6HKEm4Euo2rGi5PTGDnOz2QH2JF
	 CUo3zeMJhv9jJ+sWRmhN8s5gDS9lrxZaSxB6enAei8oC4TCwWubQ+UD7kLx7z7aOOa
	 o8CW5BQ68zUX0TG0kJvnK96r8dw+scJ+NC99L+TRdEzeSJSdIySAE1LcAVXDF0T9YH
	 Dv35WtzjQh/Tg==
Date: Tue, 16 Sep 2025 10:50:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	jikos@kernel.org, bentiss@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	dmitry.torokhov@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bhelgaas@google.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	gregkh@linuxfoundation.org, deller@gmx.de, arnd@arndb.de,
	sgarzare@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2 1/2] Driver: hv: Add CONFIG_HYPERV_VMBUS option
Message-ID: <20250916155013.GA1800495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915234604.3256611-2-mrathor@linux.microsoft.com>

On Mon, Sep 15, 2025 at 04:46:03PM -0700, Mukesh Rathor wrote:
> At present VMBus driver is hinged off of CONFIG_HYPERV which entails
> lot of builtin code and encompasses too much. It's not always clear
> what depends on builtin hv code and what depends on VMBus. Setting
> CONFIG_HYPERV as a module and fudging the Makefile to switch to builtin
> adds even more confusion. VMBus is an independent module and should have
> its own config option. Also, there are scenarios like baremetal dom0/root
> where support is built in with CONFIG_HYPERV but without VMBus. Lastly,
> there are more features coming down that use CONFIG_HYPERV and add more
> dependencies on it.
> 
> So, create a fine grained HYPERV_VMBUS option and update Kconfigs for
> dependency on VMBus.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci

> ---
>  drivers/gpu/drm/Kconfig        |  2 +-
>  drivers/hid/Kconfig            |  2 +-
>  drivers/hv/Kconfig             | 11 +++++++++--
>  drivers/hv/Makefile            |  2 +-
>  drivers/input/serio/Kconfig    |  4 ++--
>  drivers/net/hyperv/Kconfig     |  2 +-
>  drivers/pci/Kconfig            |  2 +-
>  drivers/scsi/Kconfig           |  2 +-
>  drivers/uio/Kconfig            |  2 +-
>  drivers/video/fbdev/Kconfig    |  2 +-
>  include/asm-generic/mshyperv.h |  8 +++++---
>  net/vmw_vsock/Kconfig          |  2 +-
>  12 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f7ea8e895c0c..58f34da061c6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -398,7 +398,7 @@ source "drivers/gpu/drm/imagination/Kconfig"
>  
>  config DRM_HYPERV
>  	tristate "DRM Support for Hyper-V synthetic video device"
> -	depends on DRM && PCI && HYPERV
> +	depends on DRM && PCI && HYPERV_VMBUS
>  	select DRM_CLIENT_SELECTION
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a57901203aeb..fe3dc8c0db99 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1162,7 +1162,7 @@ config GREENASIA_FF
>  
>  config HID_HYPERV_MOUSE
>  	tristate "Microsoft Hyper-V mouse driver"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	help
>  	Select this option to enable the Hyper-V mouse driver.
>  
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index e24f6299c376..29f8637f441a 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -45,18 +45,25 @@ config HYPERV_TIMER
>  
>  config HYPERV_UTILS
>  	tristate "Microsoft Hyper-V Utilities driver"
> -	depends on HYPERV && CONNECTOR && NLS
> +	depends on HYPERV_VMBUS && CONNECTOR && NLS
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  Select this option to enable the Hyper-V Utilities.
>  
>  config HYPERV_BALLOON
>  	tristate "Microsoft Hyper-V Balloon driver"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	select PAGE_REPORTING
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> +config HYPERV_VMBUS
> +	tristate "Microsoft Hyper-V VMBus driver"
> +	depends on HYPERV
> +	default HYPERV
> +	help
> +	  Select this option to enable Hyper-V Vmbus driver.
> +
>  config MSHV_ROOT
>  	tristate "Microsoft Hyper-V root partition support"
>  	depends on HYPERV && (X86_64 || ARM64)
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 976189c725dc..4bb41663767d 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
> +obj-$(CONFIG_HYPERV_VMBUS)	+= hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
>  obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 17edc1597446..c7ef347a4dff 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -276,8 +276,8 @@ config SERIO_OLPC_APSP
>  
>  config HYPERV_KEYBOARD
>  	tristate "Microsoft Synthetic Keyboard driver"
> -	depends on HYPERV
> -	default HYPERV
> +	depends on HYPERV_VMBUS
> +	default HYPERV_VMBUS
>  	help
>  	  Select this option to enable the Hyper-V Keyboard driver.
>  
> diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
> index c8cbd85adcf9..982964c1a9fb 100644
> --- a/drivers/net/hyperv/Kconfig
> +++ b/drivers/net/hyperv/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config HYPERV_NET
>  	tristate "Microsoft Hyper-V virtual network driver"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	select UCS2_STRING
>  	select NLS
>  	help
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9a249c65aedc..7065a8e5f9b1 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -221,7 +221,7 @@ config PCI_LABEL
>  
>  config PCI_HYPERV
>  	tristate "Hyper-V PCI Frontend"
> -	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
> +	depends on ((X86 && X86_64) || ARM64) && HYPERV_VMBUS && PCI_MSI && SYSFS
>  	select PCI_HYPERV_INTERFACE
>  	select IRQ_MSI_LIB
>  	help
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 5522310bab8d..19d0884479a2 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -589,7 +589,7 @@ config XEN_SCSI_FRONTEND
>  
>  config HYPERV_STORAGE
>  	tristate "Microsoft Hyper-V virtual storage driver"
> -	depends on SCSI && HYPERV
> +	depends on SCSI && HYPERV_VMBUS
>  	depends on m || SCSI_FC_ATTRS != m
>  	default HYPERV
>  	help
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index b060dcd7c635..6f86a61231e6 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -140,7 +140,7 @@ config UIO_MF624
>  
>  config UIO_HV_GENERIC
>  	tristate "Generic driver for Hyper-V VMBus"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	help
>  	  Generic driver that you can bind, dynamically, to any
>  	  Hyper-V VMBus device. It is useful to provide direct access
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c21484d15f0c..72c63eaeb983 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1774,7 +1774,7 @@ config FB_BROADSHEET
>  
>  config FB_HYPERV
>  	tristate "Microsoft Hyper-V Synthetic Video support"
> -	depends on FB && HYPERV
> +	depends on FB && HYPERV_VMBUS
>  	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
>  	select FB_IOMEM_HELPERS_DEFERRED
>  	help
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index dbd4c2f3aee3..64ba6bc807d9 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -163,6 +163,7 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
>  	return guest_id;
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
>  /* Free the message slot and signal end-of-message if required */
>  static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  {
> @@ -198,6 +199,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  	}
>  }
>  
> +extern int vmbus_interrupt;
> +extern int vmbus_irq;
> +#endif /* CONFIG_HYPERV_VMBUS */
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>  
>  void hv_setup_vmbus_handler(void (*handler)(void));
> @@ -211,9 +216,6 @@ void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
>  void hv_remove_crash_handler(void);
>  void hv_setup_mshv_handler(void (*handler)(void));
>  
> -extern int vmbus_interrupt;
> -extern int vmbus_irq;
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
>   * Hypervisor's notion of virtual processor ID is different from
> diff --git a/net/vmw_vsock/Kconfig b/net/vmw_vsock/Kconfig
> index 56356d2980c8..8e803c4828c4 100644
> --- a/net/vmw_vsock/Kconfig
> +++ b/net/vmw_vsock/Kconfig
> @@ -72,7 +72,7 @@ config VIRTIO_VSOCKETS_COMMON
>  
>  config HYPERV_VSOCKETS
>  	tristate "Hyper-V transport for Virtual Sockets"
> -	depends on VSOCKETS && HYPERV
> +	depends on VSOCKETS && HYPERV_VMBUS
>  	help
>  	  This module implements a Hyper-V transport for Virtual Sockets.
>  
> -- 
> 2.36.1.vfs.0.0
> 

