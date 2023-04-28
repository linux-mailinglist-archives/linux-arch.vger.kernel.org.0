Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA36F20B6
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjD1WMw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 18:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjD1WMv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 18:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9190469A;
        Fri, 28 Apr 2023 15:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F4C760F83;
        Fri, 28 Apr 2023 22:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1BCC433EF;
        Fri, 28 Apr 2023 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682719968;
        bh=oNgvn++SjCGaoghcsNnZ3RoY6kUPb4GZMImWoU2Gr20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kVjMdfCnMdh7YZR252KnbUdlxLjalWQpuU37hYb+hD4wJSOagdlKoX2G+Vs5wgNzl
         T8uZQxUDb4cmU8hpAlUaFnuagcQVjnlY4NMfNEvP6xf1h56mHOeWDf9FrjyQvz0r9e
         78Z3XjJqkJeTFtguqNzo3eGzBwoHBasyTiHP36HIEqjlLxXpdK9RNpeRehxdFgpkEc
         b9M2cyGxcJarEDUS8I4Yvbi1cWD42Kgp84rli7zu8P7D9RHIJ6+Fh9VeG72FebrTMP
         3NUVagGRLGWEopQMZ4kGBfv2D2NN6Ysbf4iR9ts+lfmOn7m+NEBUVxu1djKOpsvmDu
         oCLJrljF+KDXA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1psWKc-00BwtV-2u;
        Fri, 28 Apr 2023 23:12:46 +0100
MIME-Version: 1.0
Date:   Fri, 28 Apr 2023 23:12:45 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
Cc:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: Re: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
In-Reply-To: <20230428103622.18291-4-yi-de.wu@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-4-yi-de.wu@mediatek.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <904abf67ec4ba7d37fc1e500e8a2dbd1@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: yi-de.wu@mediatek.com, yingshiuan.pan@mediatek.com, ze-yu.wang@mediatek.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org, dbrazdil@google.com, quic_tsoni@quicinc.com, jades.shih@mediatek.com, miles.chen@mediatek.com, ivan.tseng@mediatek.com, my.chuang@mediatek.com, shawn.hsiao@mediatek.com, peilun.suei@mediatek.com, liju-clr.chen@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-04-28 11:36, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone is MediaTek hypervisor solution, and it is running in EL2
> stand alone as a type-I hypervisor. This patch exports a set of ioctl
> interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
> lifecycle (creation and destroy) on GenieZone.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>  MAINTAINERS                             |   6 +
>  arch/arm64/Kbuild                       |   1 +
>  arch/arm64/geniezone/Makefile           |   9 +
>  arch/arm64/geniezone/gzvm_arch.c        | 189 +++++++++++++
>  arch/arm64/geniezone/gzvm_arch.h        |  50 ++++
>  arch/arm64/include/uapi/asm/gzvm_arch.h |  18 ++
>  drivers/virt/Kconfig                    |   2 +
>  drivers/virt/geniezone/Kconfig          |  17 ++
>  drivers/virt/geniezone/Makefile         |  10 +
>  drivers/virt/geniezone/gzvm_main.c      | 146 ++++++++++
>  drivers/virt/geniezone/gzvm_vm.c        | 336 ++++++++++++++++++++++++
>  include/linux/gzvm_drv.h                |  98 +++++++
>  include/uapi/asm-generic/gzvm_arch.h    |  10 +
>  include/uapi/linux/gzvm.h               |  99 +++++++
>  14 files changed, 991 insertions(+)
>  create mode 100644 arch/arm64/geniezone/Makefile
>  create mode 100644 arch/arm64/geniezone/gzvm_arch.c
>  create mode 100644 arch/arm64/geniezone/gzvm_arch.h
>  create mode 100644 arch/arm64/include/uapi/asm/gzvm_arch.h
>  create mode 100644 drivers/virt/geniezone/Kconfig
>  create mode 100644 drivers/virt/geniezone/Makefile
>  create mode 100644 drivers/virt/geniezone/gzvm_main.c
>  create mode 100644 drivers/virt/geniezone/gzvm_vm.c
>  create mode 100644 include/linux/gzvm_drv.h
>  create mode 100644 include/uapi/asm-generic/gzvm_arch.h
>  create mode 100644 include/uapi/linux/gzvm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e911d1d9741..09a8ccf77b01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8700,6 +8700,12 @@ M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
>  M:	Yi-De Wu <yi-de.wu@mediatek.com>
>  
> F:	Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
>  F:	Documentation/virt/geniezone/
> +F:	arch/arm64/geniezone/
> +F:	arch/arm64/include/uapi/asm/gzvm_arch.h
> +F:	drivers/virt/geniezone/
> +F:	include/linux/gzvm_drv.h
> +F	include/uapi/asm-generic/gzvm_arch.h
> +F:	include/uapi/linux/gzvm.h
> 
>  GENWQE (IBM Generic Workqueue Card)
>  M:	Frank Haverkamp <haver@linux.ibm.com>
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index 5bfbf7d79c99..0c3cca572919 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -4,6 +4,7 @@ obj-$(CONFIG_KVM)	+= kvm/
>  obj-$(CONFIG_XEN)	+= xen/
>  obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
>  obj-$(CONFIG_CRYPTO)	+= crypto/
> +obj-$(CONFIG_MTK_GZVM)	+= geniezone/
> 
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/arm64/geniezone/Makefile 
> b/arch/arm64/geniezone/Makefile
> new file mode 100644
> index 000000000000..5720c076d73c
> --- /dev/null
> +++ b/arch/arm64/geniezone/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Main Makefile for gzvm, this one includes 
> drivers/virt/geniezone/Makefile
> +#
> +include $(srctree)/drivers/virt/geniezone/Makefile
> +
> +gzvm-y += gzvm_arch.o
> +
> +obj-$(CONFIG_MTK_GZVM) += gzvm.o
> diff --git a/arch/arm64/geniezone/gzvm_arch.c 
> b/arch/arm64/geniezone/gzvm_arch.c
> new file mode 100644
> index 000000000000..2fc76f7d440f
> --- /dev/null
> +++ b/arch/arm64/geniezone/gzvm_arch.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/err.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/gzvm.h>
> +#include <linux/gzvm_drv.h>
> +#include "gzvm_arch.h"
> +
> +/**
> + * geniezone_hypercall_wrapper()
> + *
> + * Return: The wrapper helps caller to convert geniezone errno to 
> Linux errno.
> + */
> +static int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
> +				unsigned long a2, unsigned long a3,
> +				unsigned long a4, unsigned long a5,
> +				unsigned long a6, unsigned long a7,
> +				struct arm_smccc_res *res)
> +{
> +	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +	return gz_err_to_errno(res->a0);
> +}
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
> +int gzvm_arch_set_memregion(gzvm_id_t vm_id, size_t buf_size,
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
> +int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void 
> __user *argp)
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
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * gzvm_arch_create_vm()
> + *
> + * Return:
> + * * positive value	- VM ID
> + * * -ENOMEM		- Memory not enough for storing VM data
> + */
> +int gzvm_arch_create_vm(void)
> +{
> +	struct arm_smccc_res res;
> +	int ret;
> +
> +	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, 0, 0, 0, 0, 0, 0, 
> 0,
> +				   &res);
> +
> +	if (ret == 0)
> +		return res.a1;
> +	else
> +		return ret;
> +}
> +
> +int gzvm_arch_destroy_vm(gzvm_id_t vm_id)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 
> 0,
> +				    0, 0, &res);
> +}
> +
> +int gzvm_vm_arch_enable_cap(struct gzvm *gzvm, struct gzvm_enable_cap 
> *cap,
> +			    struct arm_smccc_res *res)
> +{
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
> +				   cap->cap, cap->args[0], cap->args[1],
> +				   cap->args[2], cap->args[3], cap->args[4],
> +				   res);
> +}
> +
> +/**
> + * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, 
> return
> + *				    in x1, and return to userspace in args.
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
> + * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_ARM_PROTECTED_VM's 
> subcommands
> + *
> + * Return:
> + * * 0			- Succeed
> + * * -EINVAL		- Invalid subcommand or arguments
> + */
> +static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm, struct
> gzvm_enable_cap *cap,
> +				 void __user *argp)
> +{
> +	int ret = -EINVAL;
> +	struct arm_smccc_res res = {0};
> +
> +	switch (cap->args[0]) {
> +	case GZVM_CAP_ARM_PVM_SET_PVMFW_IPA:
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
> +int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm, struct
> gzvm_enable_cap *cap,
> +				  void __user *argp)
> +{
> +	int ret = -EINVAL;
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
> diff --git a/arch/arm64/geniezone/gzvm_arch.h 
> b/arch/arm64/geniezone/gzvm_arch.h
> new file mode 100644
> index 000000000000..dd0b7b5f7c65
> --- /dev/null
> +++ b/arch/arm64/geniezone/gzvm_arch.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZ_ARCH_H__
> +#define __GZ_ARCH_H__
> +
> +#include <linux/arm-smccc.h>
> +
> +enum {
> +	GZVM_FUNC_CREATE_VM = 0,
> +	GZVM_FUNC_DESTROY_VM,
> +	GZVM_FUNC_CREATE_VCPU,
> +	GZVM_FUNC_DESTROY_VCPU,
> +	GZVM_FUNC_SET_MEMREGION,
> +	GZVM_FUNC_RUN,
> +	GZVM_FUNC_GET_REGS,
> +	GZVM_FUNC_SET_REGS,
> +	GZVM_FUNC_GET_ONE_REG,
> +	GZVM_FUNC_SET_ONE_REG,
> +	GZVM_FUNC_IRQ_LINE,
> +	GZVM_FUNC_CREATE_DEVICE,
> +	GZVM_FUNC_PROBE,
> +	GZVM_FUNC_ENABLE_CAP,
> +	NR_GZVM_FUNC
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
> +#define 
> MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
> +#define MT_HVC_GZVM_RUN			GZVM_HCALL_ID(GZVM_FUNC_RUN)
> +#define MT_HVC_GZVM_GET_REGS		GZVM_HCALL_ID(GZVM_FUNC_GET_REGS)
> +#define MT_HVC_GZVM_SET_REGS		GZVM_HCALL_ID(GZVM_FUNC_SET_REGS)
> +#define MT_HVC_GZVM_GET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_GET_ONE_REG)
> +#define MT_HVC_GZVM_SET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_SET_ONE_REG)
> +#define MT_HVC_GZVM_IRQ_LINE		GZVM_HCALL_ID(GZVM_FUNC_IRQ_LINE)
> +#define 
> MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
> +#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
> +#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
> +
> +#endif /* __GZVM_ARCH_H__ */
> diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h
> b/arch/arm64/include/uapi/asm/gzvm_arch.h
> new file mode 100644
> index 000000000000..e7927f3dcb11
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
> @@ -0,0 +1,18 @@
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
> +
> +#endif /* __GZVM_ARCH_H__ */
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index f79ab13a5c28..9bbf0bdf672c 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -54,4 +54,6 @@ source "drivers/virt/coco/sev-guest/Kconfig"
> 
>  source "drivers/virt/coco/tdx-guest/Kconfig"
> 
> +source "drivers/virt/geniezone/Kconfig"
> +
>  endif
> diff --git a/drivers/virt/geniezone/Kconfig 
> b/drivers/virt/geniezone/Kconfig
> new file mode 100644
> index 000000000000..6fad3c30f8d9
> --- /dev/null
> +++ b/drivers/virt/geniezone/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config MTK_GZVM
> +	tristate "GenieZone Hypervisor driver for guest VM operation"
> +	depends on ARM64
> +	depends on KVM

NAK.

Either this is KVM, and this code serves no purpose, or it is a 
standalone
hypervisor, and it *cannot* have a dependency on KVM.

[...]

> +/**
> + * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host 
> pa),
> + *			       result is in @pfn
> + *
> + * Leverage KVM's gfn_to_pfn_memslot(). Because gfn_to_pfn_memslot() 
> needs
> + * kvm_memory_slot as parameter, this function populates necessary 
> fileds
> + * for calling gfn_to_pfn_memslot().
> + *
> + * Return:
> + * * 0			- Succeed
> + * * -EFAULT		- Failed to convert
> + */
> +static int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64
> gfn, u64 *pfn)
> +{
> +	hfn_t __pfn;
> +	struct kvm_memory_slot kvm_slot = {0};
> +
> +	kvm_slot.base_gfn = memslot->base_gfn;
> +	kvm_slot.npages = memslot->npages;
> +	kvm_slot.dirty_bitmap = NULL;
> +	kvm_slot.userspace_addr = memslot->userspace_addr;
> +	kvm_slot.flags = memslot->flags;
> +	kvm_slot.id = memslot->slot_id;
> +	kvm_slot.as_id = 0;
> +
> +	__pfn = gfn_to_pfn_memslot(&kvm_slot, gfn);

Again, I absolutely oppose this horror. This is internal to KVM,
and we want to be able to change this without having to mess
with your own code that we cannot test anyway.

What if we start using the extra fields that you don't populate
as they mean nothing to you? Or add a backpointer to the kvm
structure to do fancy accounting?

You have your own hypervisor, that's well and good. Since your
main argument is that it is supposed to be standalone, make it
*really* standalone and don't use KVM as a prop.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
