Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380E72B970
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjFLH7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjFLH7O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 03:59:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A3A19B1;
        Mon, 12 Jun 2023 00:58:31 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2389E66058B2;
        Mon, 12 Jun 2023 08:57:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686556658;
        bh=vz7uUdGMnUtmYHi0noVrCfE0pq2WHne4MmJOuPmzMVE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cc2afdusJ6ayycUjAIMZq7hxIQqqNI9OvmCr31QiYdyeXo5dJL/J6Vkc1UUTWufeg
         SDjOwarfkglRAjTpG0Ba+jpM0GoTG0FxegkJHlINDn1+tBJlTH2Sff+9JY+HqjA2Ve
         7d1uIGJOZ894YF7CkjEf8XocuRvhsh5K9iuTMscTE1LWqeGnQE1F1V59VWnsJE24nq
         7Du7FEzrfD1+Uzbq0kJx7zen0hGLu67ZegYcMs+p9GyS8cdKv2H+bRGIcUHmSAgLCO
         gsS90VlJn313Tb/o4T5ZfqXWo2Z2vBgZcLiNMzDytslzm0fNqxgj27/uShxOTxxFCS
         ofTRgRMGZeCdw==
Message-ID: <1a15767c-0518-3763-e8cb-e271df82f87c@collabora.com>
Date:   Mon, 12 Jun 2023 09:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 5/9] virt: geniezone: Add irqfd support
Content-Language: en-US
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
References: <20230609085214.31071-1-yi-de.wu@mediatek.com>
 <20230609085214.31071-6-yi-de.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609085214.31071-6-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Il 09/06/23 10:52, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> irqfd enables other threads than vcpu threads to inject virtual
> interrupt through irqfd asynchronously rather through ioctl interface.
> This interface is necessary for VMM which creates separated thread for
> IO handling or uses vhost devices.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   arch/arm64/geniezone/gzvm_arch_common.h |   6 +
>   drivers/virt/geniezone/Makefile         |   4 +-
>   drivers/virt/geniezone/gzvm_irqfd.c     | 537 ++++++++++++++++++++++++
>   drivers/virt/geniezone/gzvm_main.c      |   3 +-
>   drivers/virt/geniezone/gzvm_vcpu.c      |   1 +
>   drivers/virt/geniezone/gzvm_vm.c        |  18 +
>   include/linux/gzvm_drv.h                |  27 ++
>   include/uapi/linux/gzvm.h               |  18 +
>   8 files changed, 611 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/virt/geniezone/gzvm_irqfd.c
> 
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> index 1b315264bf24..5affa28b935a 100644
> --- a/arch/arm64/geniezone/gzvm_arch_common.h
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -46,6 +46,7 @@ enum {
>   #define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
>   #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
>   #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
> +#define GIC_V3_NR_LRS			16
>   
>   /**
>    * gzvm_hypercall_wrapper()
> @@ -72,6 +73,11 @@ static inline gzvm_vcpu_id_t get_vcpuid_from_tuple(unsigned int tuple)
>   	return (gzvm_vcpu_id_t)(tuple & 0xffff);
>   }
>   
> +struct gzvm_vcpu_hwstate {

No documentation?

> +	__u32 nr_lrs;
> +	__u64 lr[GIC_V3_NR_LRS];
> +};
> +
>   static inline unsigned int
>   assemble_vm_vcpu_tuple(gzvm_id_t vmid, gzvm_vcpu_id_t vcpuid)
>   {
> diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
> index 67ba3ed76ea7..aa52cee3ca8e 100644
> --- a/drivers/virt/geniezone/Makefile
> +++ b/drivers/virt/geniezone/Makefile
> @@ -7,5 +7,5 @@
>   GZVM_DIR ?= ../../../drivers/virt/geniezone
>   
>   gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
> -	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqchip.o
> -
> +	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqchip.o \
> +	  $(GZVM_DIR)/gzvm_irqfd.o
> diff --git a/drivers/virt/geniezone/gzvm_irqfd.c b/drivers/virt/geniezone/gzvm_irqfd.c
> new file mode 100644
> index 000000000000..3a395b972fdf
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_irqfd.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/eventfd.h>
> +#include <linux/syscalls.h>
> +#include <linux/gzvm_drv.h>
> +#include "gzvm_common.h"
> +
> +struct gzvm_irq_ack_notifier {
> +	struct hlist_node link;
> +	unsigned int gsi;
> +	void (*irq_acked)(struct gzvm_irq_ack_notifier *ian);
> +};
> +
> +/**
> + * struct gzvm_kernel_irqfd_resampler - irqfd resampler descriptor.
> + * @gzvm: Poiner to gzvm.
> + * @list_head list: List of resampling struct _irqfd objects sharing this gsi.

This is just `@list`

> + *		    RCU list modified under gzvm->irqfds.resampler_lock.
> + * @notifier: gzvm irq ack notifier.
> + * @list_head link: Entry in list of gzvm->irqfd.resampler_list.

and this is `@link`.

> + *		    Use for sharing esamplers among irqfds on the same gsi.
> + *		    Accessed and modified under gzvm->irqfds.resampler_lock.
> + *
> + * Resampling irqfds are a special variety of irqfds used to emulate
> + * level triggered interrupts.  The interrupt is asserted on eventfd
> + * trigger.  On acknowledgment through the irq ack notifier, the
> + * interrupt is de-asserted and userspace is notified through the
> + * resamplefd.  All resamplers on the same gsi are de-asserted
> + * together, so we don't need to track the state of each individual
> + * user.  We can also therefore share the same irq source ID.
> + */
> +struct gzvm_kernel_irqfd_resampler {
> +	struct gzvm *gzvm;
> +
> +	struct list_head list;
> +	struct gzvm_irq_ack_notifier notifier;
> +
> +	struct list_head link;
> +};
> +
> +/**
> + * struct gzvm_kernel_irqfd: gzvm kernel irqfd descriptor.
> + * @gzvm: Pointer to gzvm.
> + * @wait: Wait queue entry.
> + * @gsi: Used for level IRQ fast-path.
> + * @resampler: The resampler used by this irqfd (resampler-only).
> + * @resamplefd: Eventfd notified on resample (resampler-only).
> + * @resampler_link: Entry in list of irqfds for a resampler (resampler-only).
> + * @eventfd: Used for setup/shutdown.

You're not documenting `list`, `pt`, `shutdown`: that will trigger a kerneldoc
warning. Please fix.

> + */
> +struct gzvm_kernel_irqfd {
> +	struct gzvm *gzvm;
> +	wait_queue_entry_t wait;
> +
> +	int gsi;
> +
> +	struct gzvm_kernel_irqfd_resampler *resampler;
> +
> +	struct eventfd_ctx *resamplefd;
> +
> +	struct list_head resampler_link;
> +
> +	struct eventfd_ctx *eventfd;
> +	struct list_head list;
> +	poll_table pt;
> +	struct work_struct shutdown;
> +};

..snip..

> diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
> index 230970cb0953..e62c046d76b3 100644
> --- a/drivers/virt/geniezone/gzvm_main.c
> +++ b/drivers/virt/geniezone/gzvm_main.c
> @@ -113,11 +113,12 @@ static int gzvm_drv_probe(void)
>   		return ret;
>   	gzvm_debug_dev = &gzvm_dev;
>   
> -	return 0;
> +	return gzvm_drv_irqfd_init();

ret = gzvm_drv_irqfd_init();
if (ret)
	return ret;

return 0;

>   }
>   
>   static int gzvm_drv_remove(void)
>   {
> +	gzvm_drv_irqfd_exit();
>   	destroy_all_vm();
>   	misc_deregister(&gzvm_dev);
>   	return 0;
> diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
> index 5e9d34fcc1ea..94ead15fea3f 100644
> --- a/drivers/virt/geniezone/gzvm_vcpu.c
> +++ b/drivers/virt/geniezone/gzvm_vcpu.c
> @@ -211,6 +211,7 @@ int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
>   		ret = -ENOMEM;
>   		goto free_vcpu;
>   	}
> +	vcpu->hwstate = (void *)vcpu->run + PAGE_SIZE;
>   	vcpu->vcpuid = cpuid;
>   	vcpu->gzvm = gzvm;
>   	mutex_init(&vcpu->lock);
> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
> index 0cab67b0bdf8..eedc2d5c24ad 100644
> --- a/drivers/virt/geniezone/gzvm_vm.c
> +++ b/drivers/virt/geniezone/gzvm_vm.c
> @@ -361,6 +361,15 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
>   		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
>   		break;
>   	}
> +	case GZVM_IRQFD: {
> +		struct gzvm_irqfd data;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&data, argp, sizeof(data)))

if (copy_from_user...) {
		ret = -EFAULT;
		goto out;
}

> +			goto out;
> +		ret = gzvm_irqfd(gzvm, &data);
> +		break;
> +	}
>   	case GZVM_ENABLE_CAP: {
>   		struct gzvm_enable_cap cap;
>   
> @@ -385,6 +394,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
>   
>   	mutex_lock(&gzvm->lock);
>   
> +	gzvm_vm_irqfd_release(gzvm);
>   	gzvm_destroy_vcpus(gzvm);
>   	gzvm_arch_destroy_vm(gzvm->vm_id);
>   
> @@ -430,6 +440,14 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
>   	gzvm->mm = current->mm;
>   	mutex_init(&gzvm->lock);
>   
> +	ret = gzvm_vm_irqfd_init(gzvm);
> +	if (ret) {
> +		dev_err(gzvm_debug_dev->this_device,
> +			"Failed to initialize irqfd\n");
> +		kfree(gzvm);
> +		return ERR_PTR(ret);
> +	}
> +
>   	mutex_lock(&gzvm_list_lock);
>   	list_add(&gzvm->vm_list, &gzvm_list);
>   	mutex_unlock(&gzvm_list_lock);
> diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
> index 842a026df9f3..54b0a3d443c5 100644
> --- a/include/linux/gzvm_drv.h
> +++ b/include/linux/gzvm_drv.h
> @@ -11,6 +11,7 @@
>   #include <linux/mutex.h>
>   #include <linux/platform_device.h>
>   #include <linux/gzvm.h>
> +#include <linux/srcu.h>
>   
>   #define MODULE_NAME	"gzvm"
>   #define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
> @@ -26,6 +27,8 @@
>   #define ERR_NOT_SUPPORTED       (-24)
>   #define ERR_NOT_IMPLEMENTED     (-27)
>   #define ERR_FAULT               (-40)
> +#define GZVM_USERSPACE_IRQ_SOURCE_ID            0
> +#define GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID       1
>   
>   /**
>    * The following data structures are for data transferring between driver and
> @@ -69,6 +72,7 @@ struct gzvm_vcpu {
>   	/* lock of vcpu*/
>   	struct mutex lock;
>   	struct gzvm_vcpu_run *run;
> +	struct gzvm_vcpu_hwstate *hwstate;
>   };
>   
>   struct gzvm {
> @@ -78,8 +82,23 @@ struct gzvm {
>   	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
>   	/* lock for list_add*/
>   	struct mutex lock;
> +
> +	struct {
> +		/* lock for irqfds list operation */
> +		spinlock_t        lock;
> +		struct list_head  items;
> +		struct list_head  resampler_list;
> +		/* lock for irqfds resampler */
> +		struct mutex      resampler_lock;
> +	} irqfds;
> +
>   	struct list_head vm_list;
>   	gzvm_id_t vm_id;
> +
> +	struct hlist_head irq_ack_notifier_list;
> +	struct srcu_struct irq_srcu;
> +	/* lock for irq injection */
> +	struct mutex irq_lock;
>   };
>   
>   long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
> @@ -113,6 +132,14 @@ int gzvm_arch_create_device(gzvm_id_t vm_id, struct gzvm_create_device *gzvm_dev
>   int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
>   			 u32 irq, bool level);
>   
> +void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi);
> +int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args);
> +int gzvm_drv_irqfd_init(void);
> +void gzvm_drv_irqfd_exit(void);
> +int gzvm_vm_irqfd_init(struct gzvm *gzvm);
> +void gzvm_vm_irqfd_release(struct gzvm *gzvm);
> +void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu);
> +
>   extern struct miscdevice *gzvm_debug_dev;
>   
>   #endif /* __GZVM_DRV_H__ */
> diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
> index 279b52192366..3f1e829f855d 100644
> --- a/include/uapi/linux/gzvm.h
> +++ b/include/uapi/linux/gzvm.h
> @@ -224,4 +224,22 @@ struct gzvm_one_reg {
>   
>   #define GZVM_REG_GENERIC	   0x0000000000000000ULL
>   
> +#define GZVM_IRQFD_FLAG_DEASSIGN	(1 << 0)

This is BIT(0)

> +/**
> + * GZVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
> + * the irqfd to operate in resampling mode for level triggered interrupt
> + * emulation.
> + */
> +#define GZVM_IRQFD_FLAG_RESAMPLE	(1 << 1)

...and this is BIT(1).

> +
> +struct gzvm_irqfd {

...no documentation?

> +	__u32 fd;
> +	__u32 gsi;
> +	__u32 flags;
> +	__u32 resamplefd;
> +	__u8  pad[16];
> +};
> +
> +#define GZVM_IRQFD	_IOW(GZVM_IOC_MAGIC, 0x76, struct gzvm_irqfd)
> +
>   #endif /* __GZVM_H__ */

Regards,
Angelo
