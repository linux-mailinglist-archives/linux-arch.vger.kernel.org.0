Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B064764EB0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjG0JJU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjG0JIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 05:08:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6C20527;
        Thu, 27 Jul 2023 01:51:35 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0999A66003B2;
        Thu, 27 Jul 2023 09:51:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690447893;
        bh=i2CqZD/R4rWo/cvgriIm+/L7gjqjIRNwD5Nzz6xA/gI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LcELgUg1HalS+7guDTrVlY1xuWnrQQg6du+pIUsb6qxzNMluSWioKxvSEeGooReSL
         5ZgHeumzVK2cI1mWI8CAI97M9VB2LlZAaPSwIBjpCuxwxHJUmGQeVkVPXCfwkCIxS/
         2faAwTGQx/hhLUKflu2aaQa+00PkVe0UuZm7SsXcvbJX7Yl8eDweNisH2U14UBN4cc
         napKqrM2GxOwS66DXChHcJM3VWb9+eBX4PFFLQwXgA9h6iJPYoaTIgoc0aMQTLz8W3
         c5qfsBzU+AidvzIR7MZcu1k07Cu5tfkpjpmSsZZN8rA6Kq553BjFxmQrj/lt1/HQR9
         JlqXUWjTBILVA==
Message-ID: <2c69c479-3f3c-3d8a-8066-af030427927d@collabora.com>
Date:   Thu, 27 Jul 2023 11:51:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
From:   Eugen Hristev <eugen.hristev@collabora.com>
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

Hi Yi-De,

On 7/27/23 10:59, Yi-De Wu wrote:
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

I have a feeling this patch is a bit big, and could help review if it's 
split into chunks of smaller size.

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

I would see the error path as a particular case here, e.g.

if (res.a0)
	return -ENXIO;

and on the usual path return success.

(as you already do below in some functions)...

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

... e.g. here.

> +
> +	return 0;
> +}
> +
> +int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	switch (cap) {
> +	case GZVM_CAP_ARM_PROTECTED_VM: {
> +		__u64 success = 1;
> +
> +		if (copy_to_user(argp, &success, sizeof(__u64)))
> +			return -EFAULT;
> +		ret = 0;
> +		break;
> +	}
> +	case GZVM_CAP_ARM_VM_IPA_SIZE: {
> +		ret = gzvm_cap_arm_vm_ipa_size(argp);
> +		break;
> +	}
> +	default:
> +		ret = -EOPNOTSUPP;

you already initialized ret to -EOPNOTSUPP, why don't you initialize it 
with 0, and just set it as error code here, and avoid setting it to 0 on 
the success case above.

> +	}
> +
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

This initialization appears redundant as you always rewrite ret to a new 
value below

> +	struct arm_smccc_res res = {0};
> +
> +	switch (cap->args[0]) {
> +	case GZVM_CAP_ARM_PVM_SET_PVMFW_IPA:
> +		fallthrough;
> +	case GZVM_CAP_ARM_PVM_SET_PROTECTED_VM:
> +		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
> +		break;
> +	case GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE:
> +		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
> +				  struct gzvm_enable_cap *cap,
> +				  void __user *argp)
> +{
> +	int ret = -EINVAL;
same here
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

This is a bit misleading, if you look at the code, you return 0 if the 
bit SYS_PAR_EL1_F is present, but also return 0 if bit PAR_PA47_MASK is 
not present. Are those situations identical ?

Also, it's a bit strange to return 0 for an error case.

> + */
> +u64 gzvm_hva_to_pa_arch(u64 hva)
> +{
> +	u64 par;
> +	unsigned long flags;
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
> diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
> new file mode 100644
> index 000000000000..847bb627a65d
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_ARCH_H__
> +#define __GZVM_ARCH_H__
> +
> +#include <linux/types.h>
> +
> +#define GZVM_CAP_ARM_VM_IPA_SIZE	165
> +#define GZVM_CAP_ARM_PROTECTED_VM	0xffbadab1
> +
> +/* sub-commands put in args[0] for GZVM_CAP_ARM_PROTECTED_VM */
> +#define GZVM_CAP_ARM_PVM_SET_PVMFW_IPA		0
> +#define GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE		1
> +/* GZVM_CAP_ARM_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
> +#define GZVM_CAP_ARM_PVM_SET_PROTECTED_VM	2
> +
> +#endif /* __GZVM_ARCH_H__ */
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index f79ab13a5c28..9bbf0bdf672c 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -54,4 +54,6 @@ source "drivers/virt/coco/sev-guest/Kconfig"
>   
>   source "drivers/virt/coco/tdx-guest/Kconfig"
>   
> +source "drivers/virt/geniezone/Kconfig"
> +
>   endif
> diff --git a/drivers/virt/geniezone/Kconfig b/drivers/virt/geniezone/Kconfig
> new file mode 100644
> index 000000000000..2643fb8913cc
> --- /dev/null
> +++ b/drivers/virt/geniezone/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config MTK_GZVM
> +	tristate "GenieZone Hypervisor driver for guest VM operation"
> +	depends on ARM64

if only mediatek SoC is supported, should it depend on it here ?

> +	help
> +	  This driver, gzvm, enables to run guest VMs on MTK GenieZone
> +	  hypervisor. It exports kvm-like interfaces for VMM (e.g., crosvm) in
> +	  order to operate guest VMs on GenieZone hypervisor.
> +
> +	  GenieZone hypervisor now only supports MediaTek SoC and arm64
> +	  architecture.
> +
> +	  Select M if you want it be built as a module (gzvm.ko).
> +
> +	  If unsure, say N.
> diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
> new file mode 100644
> index 000000000000..066efddc0b9c
> --- /dev/null
> +++ b/drivers/virt/geniezone/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for GenieZone driver, this file should be include in arch's
> +# to avoid two ko being generated.
> +#
> +
> +GZVM_DIR ?= ../../../drivers/virt/geniezone
> +
> +gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
> +
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
> +/**
> + * gzvm_err_to_errno() - Convert geniezone return value to standard errno
> + *
> + * @err: Return value from geniezone function return
> + *
> + * Return: Standard errno
> + */
> +int gzvm_err_to_errno(unsigned long err)
> +{
> +	int gz_err = (int)err;
> +
> +	switch (gz_err) {
> +	case 0:
> +		return 0;
> +	case ERR_NO_MEMORY:
> +		return -ENOMEM;
> +	case ERR_NOT_SUPPORTED:
> +		return -EOPNOTSUPP;
> +	case ERR_NOT_IMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case ERR_FAULT:
> +		return -EFAULT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * gzvm_dev_ioctl_check_extension() - Check if given capability is support
> + *				      or not
> + *
> + * @gzvm: Pointer to struct gzvm
> + * @args: Pointer in u64 from userspace
> + *
> + * Return:
> + * * 0			- Support, no error
Supported ?

> + * * -EOPNOTSUPP	- Not support
> + * * -EFAULT		- Failed to get data from userspace
> + */
> +long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args)
> +{
> +	__u64 cap;
> +	void __user *argp = (void __user *)args;
> +
> +	if (copy_from_user(&cap, argp, sizeof(uint64_t)))
> +		return -EFAULT;
> +	return gzvm_arch_check_extension(gzvm, cap, argp);
> +}
> +
> +static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long user_args)
> +{
> +	long ret = -ENOTTY;
again redundant initializations
> +
> +	switch (cmd) {
> +	case GZVM_CREATE_VM:
> +		ret = gzvm_dev_ioctl_create_vm(user_args);
> +		break;
> +	case GZVM_CHECK_EXTENSION:
> +		if (!user_args)
> +			return -EINVAL;
> +		ret = gzvm_dev_ioctl_check_extension(NULL, user_args);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
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

return misc_register(...) ?

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
> +	u64 pfn;
> +
> +	if (get_user_page_fast_only(hva, 0, page)) {
> +		pfn = page_to_phys(page[0]);
> +		put_page((struct page *)page);
> +		return pfn;
> +	} else {
you can remove the 'else' and just return 0 here as you return pfn in 
the if(true) case.

> +		return 0;
> +	}
> +}
> +
> +/**
> + * hva_to_pa_slow() - note that this function may sleep
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
> +static u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn)
> +{
> +	u64 offset = gfn - memslot->base_gfn;
> +
> +	return memslot->userspace_addr + offset * PAGE_SIZE;
> +}
> +
> +static u64 __gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn)
> +{
> +	u64 hva, pa;
> +
> +	hva = gzvm_gfn_to_hva_memslot(memslot, gfn);
> +
> +	pa = gzvm_hva_to_pa_arch(hva);
> +	if (pa != 0)
> +		return PHYS_PFN(pa);
> +
> +	pa = hva_to_pa_fast(hva);
> +	if (pa)
> +		return PHYS_PFN(pa);
> +
> +	pa = hva_to_pa_slow(hva);
> +	if (pa)
> +		return PHYS_PFN(pa);
> +
> +	return 0;
> +}
> +
> +/**
> + * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host pa),
> + *			       result is in @pfn
> + * @memslot: Pointer to struct gzvm_memslot.
> + * @gfn: Guest frame number.
> + * @pfn: Host page frame number.
> + *
> + * Return:
> + * * 0			- Succeed
> + * * -EFAULT		- Failed to convert
> + */
> +static int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
> +				   u64 *pfn)
> +{
> +	u64 __pfn;
> +
> +	if (!memslot)
> +		return -EFAULT;
> +
> +	__pfn = __gzvm_gfn_to_pfn_memslot(memslot, gfn);
> +	if (__pfn == 0) {
> +		*pfn = 0;
> +		return -EFAULT;
> +	}
> +
> +	*pfn = __pfn;
> +
> +	return 0;
> +}
> +
> +/**
> + * fill_constituents() - Populate pa to buffer until full
> + * @consti: Pointer to struct mem_region_addr_range.
> + * @consti_cnt: Constituent count.
> + * @max_nr_consti: Maximum number of constituent count.
> + * @gfn: Guest frame number.
> + * @total_pages: Total page numbers.
> + * @slot: Pointer to struct gzvm_memslot.
> + *
> + * Return: how many pages we've fill in, negative if error
> + */
> +static int fill_constituents(struct mem_region_addr_range *consti,
> +			     int *consti_cnt, int max_nr_consti, u64 gfn,
> +			     u32 total_pages, struct gzvm_memslot *slot)
> +{
> +	u64 pfn, prev_pfn, gfn_end;
> +	int nr_pages = 1;
> +	int i = 0;
> +
> +	if (unlikely(total_pages == 0))
> +		return -EINVAL;
> +	gfn_end = gfn + total_pages;
> +
> +	/* entry 0 */
> +	if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
> +		return -EFAULT;
> +	consti[0].address = PFN_PHYS(pfn);
> +	consti[0].pg_cnt = 1;
> +	gfn++;
> +	prev_pfn = pfn;
> +
> +	while (i < max_nr_consti && gfn < gfn_end) {
> +		if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
> +			return -EFAULT;
> +		if (pfn == (prev_pfn + 1)) {
> +			consti[i].pg_cnt++;
> +		} else {
> +			i++;
> +			if (i >= max_nr_consti)
> +				break;
> +			consti[i].address = PFN_PHYS(pfn);
> +			consti[i].pg_cnt = 1;
> +		}
> +		prev_pfn = pfn;
> +		gfn++;
> +		nr_pages++;
> +	}
> +	if (i != max_nr_consti)
> +		i++;
> +	*consti_cnt = i;
> +
> +	return nr_pages;
> +}
> +
> +/* register_memslot_addr_range() - Register memory region to GZ */
> +static int
> +register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
> +{
> +	struct gzvm_memory_region_ranges *region;
> +	u32 buf_size;
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
> + * * -EXIO		- memslot is out-of-range
> + * * -EFAULT		- Cannot find corresponding vma
> + * * -EINVAL		- region size and vma size does not match
I assume 0 for success ?

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
> +static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
> +				    struct gzvm_enable_cap *cap,
> +				    void __user *argp)
> +{
> +	return gzvm_vm_ioctl_arch_enable_cap(gzvm, cap, argp);
> +}
> +
> +/* gzvm_vm_ioctl() - Ioctl handler of VM FD */
> +static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
> +			  unsigned long arg)
> +{
> +	long ret = -ENOTTY;
appears to be redundant

> +	void __user *argp = (void __user *)arg;
> +	struct gzvm *gzvm = filp->private_data;
> +
> +	switch (ioctl) {
> +	case GZVM_CHECK_EXTENSION: {
> +		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
> +		break;
> +	}
> +	case GZVM_SET_USER_MEMORY_REGION: {
> +		struct gzvm_userspace_memory_region userspace_mem;
> +
> +		if (copy_from_user(&userspace_mem, argp, sizeof(userspace_mem))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
> +		break;
> +	}
> +	case GZVM_ENABLE_CAP: {
> +		struct gzvm_enable_cap cap;
> +
> +		if (copy_from_user(&cap, argp, sizeof(cap))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
> +		break;
> +	}
> +	default:
> +		ret = -ENOTTY;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static void gzvm_destroy_vm(struct gzvm *gzvm)
> +{
> +	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
> +
> +	mutex_lock(&gzvm->lock);
> +
> +	gzvm_arch_destroy_vm(gzvm->vm_id);
> +
> +	mutex_lock(&gzvm_list_lock);
> +	list_del(&gzvm->vm_list);
> +	mutex_unlock(&gzvm_list_lock);
> +
> +	mutex_unlock(&gzvm->lock);
> +
> +	kfree(gzvm);
> +}
> +
> +static int gzvm_vm_release(struct inode *inode, struct file *filp)
> +{
> +	struct gzvm *gzvm = filp->private_data;
> +
> +	gzvm_destroy_vm(gzvm);
> +	return 0;
> +}
> +
> +static const struct file_operations gzvm_vm_fops = {
> +	.release        = gzvm_vm_release,
> +	.unlocked_ioctl = gzvm_vm_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct gzvm *gzvm_create_vm(unsigned long vm_type)
> +{
> +	int ret;
> +	struct gzvm *gzvm;
> +
> +	gzvm = kzalloc(sizeof(*gzvm), GFP_KERNEL);
> +	if (!gzvm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = gzvm_arch_create_vm(vm_type);
> +	if (ret < 0) {
> +		kfree(gzvm);
> +		return ERR_PTR(ret);
> +	}
> +
> +	gzvm->vm_id = ret;
> +	gzvm->mm = current->mm;
> +	mutex_init(&gzvm->lock);
> +
> +	mutex_lock(&gzvm_list_lock);
> +	list_add(&gzvm->vm_list, &gzvm_list);
> +	mutex_unlock(&gzvm_list_lock);
> +
> +	pr_debug("VM-%u is created\n", gzvm->vm_id);
> +
> +	return gzvm;
> +}
> +
> +/**
> + * gzvm_dev_ioctl_create_vm - Create vm fd
> + * @vm_type: VM type. Only supports Linux VM now.
> + *
> + * Return: fd of vm, negative if error
> + */
> +int gzvm_dev_ioctl_create_vm(unsigned long vm_type)
> +{
> +	struct gzvm *gzvm;
> +
> +	gzvm = gzvm_create_vm(vm_type);
> +	if (IS_ERR(gzvm))
> +		return PTR_ERR(gzvm);
> +
> +	return anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
> +			       O_RDWR | O_CLOEXEC);
> +}
> +
> +void gzvm_destroy_all_vms(void)
> +{
> +	struct gzvm *gzvm, *tmp;
> +
> +	mutex_lock(&gzvm_list_lock);
> +	if (list_empty(&gzvm_list))
> +		goto out;
> +
> +	list_for_each_entry_safe(gzvm, tmp, &gzvm_list, vm_list)
> +		gzvm_destroy_vm(gzvm);
> +
> +out:
> +	mutex_unlock(&gzvm_list_lock);
> +}
> diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
> new file mode 100644
> index 000000000000..4fd52fcbd5a8
> --- /dev/null
> +++ b/include/linux/gzvm_drv.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_DRV_H__
> +#define __GZVM_DRV_H__
> +
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/gzvm.h>
> +
> +#define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
> +#define INVALID_VM_ID   0xffff
> +
> +/*
> + * These are the efinitions of APIs between GenieZone hypervisor and driver,
typo: definitions

> + * there's no need to be visible to uapi. Furthermore, We need GenieZone
We doesn't have to be capital
> + * specific error code in order to map to Linux errno
> + */
> +#define NO_ERROR                (0)
> +#define ERR_NO_MEMORY           (-5)
> +#define ERR_NOT_SUPPORTED       (-24)
> +#define ERR_NOT_IMPLEMENTED     (-27)
> +#define ERR_FAULT               (-40)
> +
> +/*
> + * The following data structures are for data transferring between driver and
> + * hypervisor, and they're aligned with hypervisor definitions
> + */
> +#define GZVM_MAX_VCPUS		 8
> +#define GZVM_MAX_MEM_REGION	10
> +
> +/* struct mem_region_addr_range - Identical to ffa memory constituent */
> +struct mem_region_addr_range {
> +	/* the base IPA of the constituent memory region, aligned to 4 kiB */
> +	__u64 address;
> +	/* the number of 4 kiB pages in the constituent memory region. */
> +	__u32 pg_cnt;
> +	__u32 reserved;
> +};
> +
> +struct gzvm_memory_region_ranges {
> +	__u32 slot;
> +	__u32 constituent_cnt;
> +	__u64 total_pages;
> +	__u64 gpa;
> +	struct mem_region_addr_range constituents[];
> +};
> +
> +/* struct gzvm_memslot - VM's memory slot descriptor */
> +struct gzvm_memslot {
> +	u64 base_gfn;			/* begin of guest page frame */
> +	unsigned long npages;		/* number of pages this slot covers */
> +	unsigned long userspace_addr;	/* corresponding userspace va */
> +	struct vm_area_struct *vma;	/* vma related to this userspace addr */
> +	u32 flags;
> +	u32 slot_id;
> +};
> +
> +struct gzvm {
> +	/* userspace tied to this vm */
> +	struct mm_struct *mm;
> +	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
> +	/* lock for list_add*/
> +	struct mutex lock;
> +	struct list_head vm_list;
> +	u16 vm_id;
> +};
> +
> +long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
> +int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
> +
> +int gzvm_err_to_errno(unsigned long err);
> +
> +void gzvm_destroy_all_vms(void);
> +
> +/* arch-dependant functions */
> +int gzvm_arch_probe(void);
> +int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
> +			    phys_addr_t region);
> +int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
> +int gzvm_arch_create_vm(unsigned long vm_type);
> +int gzvm_arch_destroy_vm(u16 vm_id);
> +int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
> +				  struct gzvm_enable_cap *cap,
> +				  void __user *argp);
> +u64 gzvm_hva_to_pa_arch(u64 hva);
> +
> +#endif /* __GZVM_DRV_H__ */
> diff --git a/include/uapi/asm-generic/Kbuild b/include/uapi/asm-generic/Kbuild
> index ebb180aac74e..5af115a3c1a8 100644
> --- a/include/uapi/asm-generic/Kbuild
> +++ b/include/uapi/asm-generic/Kbuild
> @@ -34,3 +34,4 @@ mandatory-y += termbits.h
>   mandatory-y += termios.h
>   mandatory-y += types.h
>   mandatory-y += unistd.h
> +mandatory-y += gzvm_arch.h
> diff --git a/include/uapi/asm-generic/gzvm_arch.h b/include/uapi/asm-generic/gzvm_arch.h
> new file mode 100644
> index 000000000000..c4cc12716c91
> --- /dev/null
> +++ b/include/uapi/asm-generic/gzvm_arch.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __ASM_GENERIC_GZVM_ARCH_H
> +#define __ASM_GENERIC_GZVM_ARCH_H
> +/* geniezone only supports aarch64 platform for now */
> +
> +#endif /* __ASM_GENERIC_GZVM_ARCH_H */
> diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
> new file mode 100644
> index 000000000000..99730c142b0e
> --- /dev/null
> +++ b/include/uapi/linux/gzvm.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +/**
> + * DOC: UAPI of GenieZone Hypervisor
> + *
> + * This file declares common data structure shared among user space,
> + * kernel space, and GenieZone hypervisor.
> + */
> +#ifndef __GZVM_H__
> +#define __GZVM_H__
> +
> +#include <linux/const.h>
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#include <asm/gzvm_arch.h>
> +
> +/* GZVM ioctls */
> +#define GZVM_IOC_MAGIC			0x92	/* gz */
> +
> +/* ioctls for /dev/gzvm fds */
> +#define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
> +
> +/*
> + * Check if the given capability is supported or not.
> + * The argument is capability. Ex. GZVM_CAP_ARM_PROTECTED_VM or GZVM_CAP_ARM_VM_IPA_SIZE
> + * return is 0 (supported, no error)
> + * return is -EOPNOTSUPP (unsupported)
> + * return is -EFAULT (failed to get the argument from userspace)
> + */
> +#define GZVM_CHECK_EXTENSION       _IO(GZVM_IOC_MAGIC,   0x03)
> +
> +/* ioctls for VM fds */
> +/* for GZVM_SET_MEMORY_REGION */
> +struct gzvm_memory_region {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size; /* bytes */
> +};
> +
> +#define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
> +					struct gzvm_memory_region)
> +
> +/* for GZVM_SET_USER_MEMORY_REGION */
> +struct gzvm_userspace_memory_region {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	/* bytes */
> +	__u64 memory_size;
> +	/* start of the userspace allocated memory */
> +	__u64 userspace_addr;
> +};
> +
> +#define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
> +					 struct gzvm_userspace_memory_region)
> +
> +/* for GZVM_ENABLE_CAP */
> +struct gzvm_enable_cap {
> +	/* in */
> +	__u64 cap;
> +	/**
> +	 * we have total 5 (8 - 3) registers can be used for
which can be used ?

> +	 * additional args
> +	 */
> +	__u64 args[5];
> +};
> +
> +#define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
> +					struct gzvm_enable_cap)
> +
> +#endif /* __GZVM_H__ */


Regards,

Eugen
