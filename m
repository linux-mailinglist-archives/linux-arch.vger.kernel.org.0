Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CF76508E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 12:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjG0KIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjG0KIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 06:08:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB98136;
        Thu, 27 Jul 2023 03:08:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF343660702D;
        Thu, 27 Jul 2023 11:08:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690452488;
        bh=Ns9Nqbt6JLsgtvcYmI9quuotyvWpb5szNC6jAiQ30tE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LpWZxftvKuh0aEWQmB47HnWUZay10TSCz50iBM/NPsBcKC8E0j0DDg0HRmgzZsPz8
         /ah5QojFKWyT9ROCLqSGqxQcBEsgc/7lS8te+w2WcM+fe2Ii7WZpXya7l7p/Z2mqOg
         iOJKd1CFjQE5lbcx2lNePA68G1wWewGJVXgCDYEa8yy9MbBmgfrAxU5weHdDVI1sGN
         jbzWirlt3zIxKZSLyrsCJmad8fyFG0uFtSNhnQANb15AqQAK759Li6cn90WSWt4ben
         FWAJUT2teOseeYr3PZWsTpJKuKG4XKvqFK5liPCElC9G0kuVNRsDNNB75HYwGUzcPH
         +DyDpbIljkJsA==
Message-ID: <9e7b8aa6-bbfe-5598-8aae-4903b64d64ad@collabora.com>
Date:   Thu, 27 Jul 2023 12:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 03/12] virt: geniezone: Add GenieZone hypervisor
 support
Content-Language: en-US
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Jade Shih <jades.shih@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
 <20230727080005.14474-4-yi-de.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230727080005.14474-4-yi-de.wu@mediatek.com>
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

Il 27/07/23 09:59, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone is MediaTek hypervisor solution, and it is running in EL2
> stand alone as a type-I hypervisor. This patch exports a set of ioctl
> interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
> lifecycle (creation and destroy) on GenieZone.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   MAINTAINERS                             |   6 +
>   arch/arm64/Kbuild                       |   1 +
>   arch/arm64/geniezone/Makefile           |   9 +
>   arch/arm64/geniezone/gzvm_arch_common.h |  68 ++++
>   arch/arm64/geniezone/vm.c               | 212 +++++++++++++
>   arch/arm64/include/uapi/asm/gzvm_arch.h |  20 ++
>   drivers/virt/Kconfig                    |   2 +
>   drivers/virt/geniezone/Kconfig          |  16 +
>   drivers/virt/geniezone/Makefile         |  10 +
>   drivers/virt/geniezone/gzvm_main.c      | 143 +++++++++
>   drivers/virt/geniezone/gzvm_vm.c        | 400 ++++++++++++++++++++++++
>   include/linux/gzvm_drv.h                |  90 ++++++
>   include/uapi/asm-generic/Kbuild         |   1 +
>   include/uapi/asm-generic/gzvm_arch.h    |  10 +
>   include/uapi/linux/gzvm.h               |  76 +++++
>   15 files changed, 1064 insertions(+)
>   create mode 100644 arch/arm64/geniezone/Makefile
>   create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
>   create mode 100644 arch/arm64/geniezone/vm.c
>   create mode 100644 arch/arm64/include/uapi/asm/gzvm_arch.h
>   create mode 100644 drivers/virt/geniezone/Kconfig
>   create mode 100644 drivers/virt/geniezone/Makefile
>   create mode 100644 drivers/virt/geniezone/gzvm_main.c
>   create mode 100644 drivers/virt/geniezone/gzvm_vm.c
>   create mode 100644 include/linux/gzvm_drv.h
>   create mode 100644 include/uapi/asm-generic/gzvm_arch.h
>   create mode 100644 include/uapi/linux/gzvm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bfbfdb790446..b91d41dd2f2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8747,6 +8747,12 @@ M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
>   M:	Yi-De Wu <yi-de.wu@mediatek.com>
>   F:	Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
>   F:	Documentation/virt/geniezone/
> +F:	arch/arm64/geniezone/
> +F:	arch/arm64/include/uapi/asm/gzvm_arch.h
> +F:	drivers/virt/geniezone/
> +F:	include/linux/gzvm_drv.h
> +F	include/uapi/asm-generic/gzvm_arch.h
> +F:	include/uapi/linux/gzvm.h
>   
>   GENWQE (IBM Generic Workqueue Card)
>   M:	Frank Haverkamp <haver@linux.ibm.com>
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index 5bfbf7d79c99..0c3cca572919 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -4,6 +4,7 @@ obj-$(CONFIG_KVM)	+= kvm/
>   obj-$(CONFIG_XEN)	+= xen/
>   obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
>   obj-$(CONFIG_CRYPTO)	+= crypto/
> +obj-$(CONFIG_MTK_GZVM)	+= geniezone/
>   
>   # for cleaning
>   subdir- += boot
> diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
> new file mode 100644
> index 000000000000..2957898cdd05
> --- /dev/null
> +++ b/arch/arm64/geniezone/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Main Makefile for gzvm, this one includes drivers/virt/geniezone/Makefile
> +#
> +include $(srctree)/drivers/virt/geniezone/Makefile
> +
> +gzvm-y += vm.o
> +
> +obj-$(CONFIG_MTK_GZVM) += gzvm.o
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> new file mode 100644
> index 000000000000..fdb95d619102
> --- /dev/null
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_ARCH_COMMON_H__
> +#define __GZVM_ARCH_COMMON_H__
> +
> +#include <linux/arm-smccc.h>
> +
> +enum {
> +	GZVM_FUNC_CREATE_VM = 0,
> +	GZVM_FUNC_DESTROY_VM = 1,
> +	GZVM_FUNC_CREATE_VCPU = 2,
> +	GZVM_FUNC_DESTROY_VCPU = 3,
> +	GZVM_FUNC_SET_MEMREGION = 4,
> +	GZVM_FUNC_RUN = 5,
> +	GZVM_FUNC_GET_ONE_REG = 8,
> +	GZVM_FUNC_SET_ONE_REG = 9,
> +	GZVM_FUNC_IRQ_LINE = 10,
> +	GZVM_FUNC_CREATE_DEVICE = 11,
> +	GZVM_FUNC_PROBE = 12,
> +	GZVM_FUNC_ENABLE_CAP = 13,
> +	NR_GZVM_FUNC,
> +};
> +
> +#define SMC_ENTITY_MTK			59
> +#define GZVM_FUNCID_START		(0x1000)
> +#define GZVM_HCALL_ID(func)						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,	\
> +			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
> +
> +#define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
> +#define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
> +#define MT_HVC_GZVM_CREATE_VCPU		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VCPU)
> +#define MT_HVC_GZVM_DESTROY_VCPU	GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VCPU)
> +#define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
> +#define MT_HVC_GZVM_RUN			GZVM_HCALL_ID(GZVM_FUNC_RUN)
> +#define MT_HVC_GZVM_GET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_GET_ONE_REG)
> +#define MT_HVC_GZVM_SET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_SET_ONE_REG)
> +#define MT_HVC_GZVM_IRQ_LINE		GZVM_HCALL_ID(GZVM_FUNC_IRQ_LINE)
> +#define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
> +#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
> +#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
> +
> +/**
> + * gzvm_hypcall_wrapper() - the wrapper for hvc calls
> + * @a0-a7: arguments passed in registers 0 to 7
> + * @res: result values from registers 0 to 3
> + *
> + * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
> + */
> +static inline int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
> +				       unsigned long a2, unsigned long a3,
> +				       unsigned long a4, unsigned long a5,
> +				       unsigned long a6, unsigned long a7,
> +				       struct arm_smccc_res *res)
> +{
> +	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +	return gzvm_err_to_errno(res->a0);
> +}
> +
> +static inline u16 get_vmid_from_tuple(unsigned int tuple)
> +{
> +	return (u16)(tuple >> 16);
> +}
> +
> +#endif /* __GZVM_ARCH_COMMON_H__ */
> diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
> new file mode 100644
> index 000000000000..e35751b21821
> --- /dev/null
> +++ b/arch/arm64/geniezone/vm.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <asm/sysreg.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/err.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/gzvm.h>
> +#include <linux/gzvm_drv.h>
> +#include "gzvm_arch_common.h"
> +
> +#define PAR_PA47_MASK ((((1UL << 48) - 1) >> 12) << 12)
> +
> +int gzvm_arch_probe(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 == 0)
> +		return 0;
> +
> +	return -ENXIO;
> +}
> +
> +int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
> +			    phys_addr_t region)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_MEMREGION, vm_id,
> +				    buf_size, region, 0, 0, 0, 0, &res);
> +}
> +
> +static int gzvm_cap_arm_vm_ipa_size(void __user *argp)
> +{
> +	__u64 value = CONFIG_ARM64_PA_BITS;
> +
> +	if (copy_to_user(argp, &value, sizeof(__u64)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp)
> +{
> +	int ret = -EOPNOTSUPP;

int ret;

> +
> +	switch (cap) {
> +	case GZVM_CAP_ARM_PROTECTED_VM: {
> +		__u64 success = 1;
> +
> +		if (copy_to_user(argp, &success, sizeof(__u64)))
> +			return -EFAULT;
> +		ret = 0;

here, instead of ret = 0...

		return 0;

> +		break;
> +	}
> +	case GZVM_CAP_ARM_VM_IPA_SIZE: {
> +		ret = gzvm_cap_arm_vm_ipa_size(argp);

and here
		return ret;

> +		break;
> +	}
> +	default:
> +		ret = -EOPNOTSUPP;

	break;

> +	}
> +

return -EOPNOTSUPP;

> +	return ret;
> +}
> +
> +/**
> + * gzvm_arch_create_vm() - create vm
> + * @vm_type: VM type. Only supports Linux VM now.
> + *
> + * Return:
> + * * positive value	- VM ID
> + * * -ENOMEM		- Memory not enough for storing VM data
> + */
> +int gzvm_arch_create_vm(unsigned long vm_type)
> +{
> +	struct arm_smccc_res res;
> +	int ret;
> +
> +	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, vm_type, 0, 0, 0, 0,
> +				   0, 0, &res);
> +

return ret ? ret : res.a1;

> +	if (ret == 0)
> +		return res.a1;
> +	else
> +		return ret;
> +}
> +
> +int gzvm_arch_destroy_vm(u16 vm_id)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
> +				    0, 0, &res);
> +}
> +
> +static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
> +				   struct gzvm_enable_cap *cap,
> +				   struct arm_smccc_res *res)
> +{
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
> +				    cap->cap, cap->args[0], cap->args[1],
> +				    cap->args[2], cap->args[3], cap->args[4],
> +				    res);
> +}
> +
> +/**
> + * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, return
> + *				    in x1, and return to userspace in args
> + * @gzvm: Pointer to struct gzvm.
> + * @cap: Pointer to struct gzvm_enable_cap.
> + * @argp: Pointer to struct gzvm_enable_cap in user space.
> + *
> + * Return:
> + * * 0			- Succeed
> + * * -EINVAL		- Hypervisor return invalid results
> + * * -EFAULT		- Fail to copy back to userspace buffer
> + */
> +static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
> +					struct gzvm_enable_cap *cap,
> +					void __user *argp)
> +{
> +	struct arm_smccc_res res = {0};
> +
> +	if (gzvm_vm_arch_enable_cap(gzvm, cap, &res) != 0)
> +		return -EINVAL;
> +
> +	cap->args[1] = res.a1;
> +	if (copy_to_user(argp, cap, sizeof(*cap)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/**
> + * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_ARM_PROTECTED_VM's subcommands
> + * @gzvm: Pointer to struct gzvm.
> + * @cap: Pointer to struct gzvm_enable_cap.
> + * @argp: Pointer to struct gzvm_enable_cap in user space.
> + *
> + * Return:
> + * * 0			- Succeed
> + * * -EINVAL		- Invalid subcommand or arguments
> + */
> +static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
> +				 struct gzvm_enable_cap *cap,
> +				 void __user *argp)
> +{
> +	int ret = -EINVAL;
> +	struct arm_smccc_res res = {0};

Invert for readability; struct arm_smccc_res res first, ret last...
also, you don't need to initialize ret to -EINVAL, because:

> +
> +	switch (cap->args[0]) {
> +	case GZVM_CAP_ARM_PVM_SET_PVMFW_IPA:
> +		fallthrough;
> +	case GZVM_CAP_ARM_PVM_SET_PROTECTED_VM:
> +		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);

return ret;

> +		break;
> +	case GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE:
> +		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);

return ret;

> +		break;
> +	default:

just break here

> +		ret = -EINVAL;
> +		break;
> +	}
> +

return -EINVAL;

> +	return ret;
> +}
> +
> +int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
> +				  struct gzvm_enable_cap *cap,
> +				  void __user *argp)
> +{
> +	int ret = -EINVAL;

same comments here

> +
> +	switch (cap->cap) {
> +	case GZVM_CAP_ARM_PROTECTED_VM:
> +		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * gzvm_hva_to_pa_arch() - converts hva to pa with arch-specific way
> + * @hva: Host virtual address.
> + *
> + * Return: 0 if translation error
> + */
> +u64 gzvm_hva_to_pa_arch(u64 hva)
> +{
> +	u64 par;
> +	unsigned long flags;

unsigned long flags;
u64 par;

> +
> +	local_irq_save(flags);
> +	asm volatile("at s1e1r, %0" :: "r" (hva));
> +	isb();
> +	par = read_sysreg_par();
> +	local_irq_restore(flags);
> +
> +	if (par & SYS_PAR_EL1_F)
> +		return 0;
> +
> +	return par & PAR_PA47_MASK;
> +}

..snip..

> diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
> new file mode 100644
> index 000000000000..b629b41a0cd9
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_main.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/device.h>
> +#include <linux/file.h>
> +#include <linux/kdev_t.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/gzvm_drv.h>
> +

..snip..

> +
> +static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long user_args)
> +{
> +	long ret = -ENOTTY;

long ret;

> +
> +	switch (cmd) {
> +	case GZVM_CREATE_VM:
> +		ret = gzvm_dev_ioctl_create_vm(user_args);

you may even do just

		return gzvm_dev_ioctl_create_vm(user_args);

> +		break;
> +	case GZVM_CHECK_EXTENSION:
> +		if (!user_args)
> +			return -EINVAL;
> +		ret = gzvm_dev_ioctl_check_extension(NULL, user_args);

return ....

> +		break;
> +	default:

break...

> +		ret = -ENOTTY;
> +	}

...return

> +
> +	return ret;
> +}
> +
> +static const struct file_operations gzvm_chardev_ops = {
> +	.unlocked_ioctl = gzvm_dev_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct miscdevice gzvm_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = KBUILD_MODNAME,
> +	.fops = &gzvm_chardev_ops,
> +};
> +
> +static int gzvm_drv_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	if (gzvm_arch_probe() != 0) {
> +		dev_err(&pdev->dev, "Not found available conduit\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = misc_register(&gzvm_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int gzvm_drv_remove(struct platform_device *pdev)
> +{
> +	gzvm_destroy_all_vms();
> +	misc_deregister(&gzvm_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id gzvm_of_match[] = {
> +	{ .compatible = "mediatek,geniezone-hyp", },

Remove the comma after "mediatek,geniezone-hyp" as it's not needed.

> +	{/* sentinel */},
> +};
> +
> +static struct platform_driver gzvm_driver = {
> +	.probe = gzvm_drv_probe,
> +	.remove = gzvm_drv_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = gzvm_of_match,
> +	},
> +};
> +
> +module_platform_driver(gzvm_driver);
> +
> +MODULE_DEVICE_TABLE(of, gzvm_of_match);
> +MODULE_AUTHOR("MediaTek");
> +MODULE_DESCRIPTION("GenieZone interface for VMM");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
> new file mode 100644
> index 000000000000..ee751369fd4b
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_vm.c
> @@ -0,0 +1,400 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/file.h>
> +#include <linux/kdev_t.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/gzvm_drv.h>
> +
> +static DEFINE_MUTEX(gzvm_list_lock);
> +static LIST_HEAD(gzvm_list);
> +
> +/**
> + * hva_to_pa_fast() - converts hva to pa in generic fast way
> + * @hva: Host virtual address.
> + *
> + * Return: 0 if translation error
> + */
> +static u64 hva_to_pa_fast(u64 hva)
> +{
> +	struct page *page[1];
> +

Remove extra blank line

> +	u64 pfn;
> +
> +	if (get_user_page_fast_only(hva, 0, page)) {
> +		pfn = page_to_phys(page[0]);
> +		put_page((struct page *)page);
> +		return pfn;

why the else branch? just do...

	if (get_user_page_fast_only(.....)) {
		do_something; return pfn;
	}

	return 0;
}

> +	} else {
> +		return 0;
> +	}
> +}
> +
> +/**
> + * hva_to_pa_slow() - note that this function may sleep

/**
* hva_to_pa_slow() - converts hva to pa in a slow way
* @hva: Host virtual address
*
* This function converts HVA to PA in a slow way (because......)
*
* Context: This function may sleep
* Return: PA or 0 for translation error
*/

> + * @hva: Host virtual address.
> + *
> + * Return: 0 if translation error
> + */
> +static u64 hva_to_pa_slow(u64 hva)
> +{
> +	struct page *page;
> +	int npages;
> +	u64 pfn;
> +
> +	npages = get_user_pages_unlocked(hva, 1, &page, 0);
> +	if (npages != 1)
> +		return 0;
> +
> +	pfn = page_to_phys(page);
> +	put_page(page);
> +
> +	return pfn;
> +}
> +

..snip..

> +
> +/* register_memslot_addr_range() - Register memory region to GZ */

/**
  * register_memslot_addr_range() - Register memory region to GenieZone
  * @gzvm: xxxx
  * @memslot: xxxx
  *
  * Return: something
  */

> +static int
> +register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
> +{
> +	struct gzvm_memory_region_ranges *region;
> +	u32 buf_size;

u32 buf_size = PAGE_SIZE * 2;

> +	int max_nr_consti, remain_pages;
> +	u64 gfn, gfn_end;
> +
> +	buf_size = PAGE_SIZE * 2;
> +	region = alloc_pages_exact(buf_size, GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +	max_nr_consti = (buf_size - sizeof(*region)) /
> +			sizeof(struct mem_region_addr_range);
> +
> +	region->slot = memslot->slot_id;
> +	remain_pages = memslot->npages;
> +	gfn = memslot->base_gfn;
> +	gfn_end = gfn + remain_pages;
> +	while (gfn < gfn_end) {
> +		int nr_pages;

int nr_pages = fill_constituents(...)

> +
> +		nr_pages = fill_constituents(region->constituents,
> +					     &region->constituent_cnt,
> +					     max_nr_consti, gfn,
> +					     remain_pages, memslot);
> +		if (nr_pages < 0) {
> +			pr_err("Failed to fill constituents\n");
> +			free_pages_exact(region, buf_size);
> +			return nr_pages;
> +		}
> +		region->gpa = PFN_PHYS(gfn);
> +		region->total_pages = nr_pages;
> +
> +		remain_pages -= nr_pages;
> +		gfn += nr_pages;
> +
> +		if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
> +					    virt_to_phys(region))) {
> +			pr_err("Failed to register memregion to hypervisor\n");
> +			free_pages_exact(region, buf_size);
> +			return -EFAULT;
> +		}
> +	}
> +	free_pages_exact(region, buf_size);
> +	return 0;
> +}
> +
> +/**
> + * gzvm_vm_ioctl_set_memory_region() - Set memory region of guest
> + * @gzvm: Pointer to struct gzvm.
> + * @mem: Input memory region from user.
> + *
> + * Return:

* Return: 0 for success, negative number for error
*
* -EXIO     - The memslot is out-of-range
* -EFAULT   - Cannot find corresponding vma
* -EINVAL   - Region size and VMA size mismatch
*/

> + * * -EXIO		- memslot is out-of-range
> + * * -EFAULT		- Cannot find corresponding vma
> + * * -EINVAL		- region size and vma size does not match
> + */
> +static int
> +gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
> +				struct gzvm_userspace_memory_region *mem)
> +{
> +	struct vm_area_struct *vma;
> +	struct gzvm_memslot *memslot;
> +	unsigned long size;
> +	__u32 slot;
> +
> +	slot = mem->slot;
> +	if (slot >= GZVM_MAX_MEM_REGION)
> +		return -ENXIO;
> +	memslot = &gzvm->memslot[slot];
> +
> +	vma = vma_lookup(gzvm->mm, mem->userspace_addr);
> +	if (!vma)
> +		return -EFAULT;
> +
> +	size = vma->vm_end - vma->vm_start;
> +	if (size != mem->memory_size)
> +		return -EINVAL;
> +
> +	memslot->base_gfn = __phys_to_pfn(mem->guest_phys_addr);
> +	memslot->npages = size >> PAGE_SHIFT;
> +	memslot->userspace_addr = mem->userspace_addr;
> +	memslot->vma = vma;
> +	memslot->flags = mem->flags;
> +	memslot->slot_id = mem->slot;
> +	return register_memslot_addr_range(gzvm, memslot);
> +}
> +

There are other instances of the same for all comments in this review, so
fix accordingly everywhere else.

Regards,
Angelo

