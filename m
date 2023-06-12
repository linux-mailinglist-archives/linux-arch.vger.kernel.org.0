Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C645472B9B1
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 10:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFLIFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFLIEl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 04:04:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BCB2712;
        Mon, 12 Jun 2023 01:03:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42A6D66058B2;
        Mon, 12 Jun 2023 09:02:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686556939;
        bh=+Kz9FdKEAFZlZj5XHqHtenKsDHyiRL5vhXgqLs0UwxY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AypTttf2AQpkX7dg6uYrkGtGV3f8vwNCCTepbh8uxVTtD14/FSbndE4EcDJ0Misiz
         MZWQhtlGeA03/QFnG86C+LD864VwaSgTbNNP2TRqaPC/K6xyEwV7cNQaYw/No+S7Tu
         +lb3kU2+SMt8ScjEV9lTqfImNX/mmfCgBfn4WMxr0Y4ZyiN/gs7nWEa/UuhrquBAhf
         HtNJwX0dQqVMNi/8HCfgciGDky7K/qttNFnUnIun8LKdKb0ml+fcneJvkxrOj+/XZK
         /7dh6vxtHwZq2gMgfZR4RlevcuV7Asvtfx4UHOgNFHZKD7Pyt/lY1mH0lG4MWgSqYg
         jeFcwhz9kRqrQ==
Message-ID: <9a39cfa4-1142-4d06-319b-fd5d17c71e06@collabora.com>
Date:   Mon, 12 Jun 2023 10:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 8/9] virt: geniezone: Add dtb config support
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
 <20230609085214.31071-9-yi-de.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609085214.31071-9-yi-de.wu@mediatek.com>
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
> From: "Jerry Wang" <ze-yu.wang@mediatek.com>
> 
> Hypervisor might need to know the accurate address and size of dtb
> passed from userspace. And then hypervisor would parse the dtb and get
> vm information.
> 
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
>   arch/arm64/geniezone/vm.c               |  8 ++++++++
>   drivers/virt/geniezone/gzvm_vm.c        |  8 ++++++++
>   include/linux/gzvm_drv.h                |  1 +
>   include/uapi/linux/gzvm.h               | 10 ++++++++++
>   5 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> index 5cfeb4df84c5..ccd2a7516eeb 100644
> --- a/arch/arm64/geniezone/gzvm_arch_common.h
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -24,6 +24,7 @@ enum {
>   	GZVM_FUNC_PROBE,
>   	GZVM_FUNC_ENABLE_CAP,
>   	GZVM_FUNC_MEMREGION_PURPOSE,
> +	GZVM_FUNC_SET_DTB_CONFIG,
>   	NR_GZVM_FUNC
>   };
>   
> @@ -48,6 +49,7 @@ enum {
>   #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
>   #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
>   #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
> +#define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
>   #define GIC_V3_NR_LRS			16
>   
>   /**
> diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
> index e19a66d6a75d..6062fe85c70e 100644
> --- a/arch/arm64/geniezone/vm.c
> +++ b/arch/arm64/geniezone/vm.c
> @@ -106,6 +106,14 @@ int gzvm_arch_memregion_purpose(struct gzvm *gzvm, struct gzvm_userspace_memory_
>   				    mem->flags, 0, 0, 0, &res);
>   }
>   
> +int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *cfg)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_DTB_CONFIG, gzvm->vm_id, cfg->dtb_addr,
> +				    cfg->dtb_size, 0, 0, 0, 0, &res);
> +}
> +
>   static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm, struct gzvm_enable_cap *cap,
>   				   struct arm_smccc_res *res)
>   {
> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
> index 3b1cb715ef34..d379793deace 100644
> --- a/drivers/virt/geniezone/gzvm_vm.c
> +++ b/drivers/virt/geniezone/gzvm_vm.c
> @@ -390,6 +390,14 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
>   		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
>   		break;
>   	}
> +	case GZVM_SET_DTB_CONFIG: {
> +		struct gzvm_dtb_config cfg;
> +
> +		if (copy_from_user(&cfg, argp, sizeof(cfg)))
> +			goto out;
> +		ret = gzvm_arch_set_dtb_config(gzvm, &cfg);
> +		break;
> +	}
>   	default:
>   		ret = -ENOTTY;
>   	}
> diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
> index 288a339bf382..e920397e83d3 100644
> --- a/include/linux/gzvm_drv.h
> +++ b/include/linux/gzvm_drv.h
> @@ -146,6 +146,7 @@ void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu);
>   extern struct miscdevice *gzvm_debug_dev;
>   
>   int gzvm_arch_memregion_purpose(struct gzvm *gzvm, struct gzvm_userspace_memory_region *mem);
> +int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *args);
>   
>   int gzvm_init_ioeventfd(struct gzvm *gzvm);
>   int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
> diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
> index 2af1b068947c..28354c17ed9c 100644
> --- a/include/uapi/linux/gzvm.h
> +++ b/include/uapi/linux/gzvm.h
> @@ -265,4 +265,14 @@ struct gzvm_ioeventfd {
>   
>   #define GZVM_IOEVENTFD	_IOW(GZVM_IOC_MAGIC, 0x79, struct gzvm_ioeventfd)
>   
> +struct gzvm_dtb_config {

kerneldoc please.

> +	/* dtb address set by VMM (guset memory) */
> +	__u64 dtb_addr;
> +	/* dtb size */
> +	__u64 dtb_size;
> +};
> +
> +#define GZVM_SET_DTB_CONFIG       _IOW(GZVM_IOC_MAGIC, 0xff, \
> +				       struct gzvm_dtb_config)
> +
>   #endif /* __GZVM_H__ */

