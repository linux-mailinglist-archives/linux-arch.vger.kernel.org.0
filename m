Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0272B9A5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjFLIDl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFLID1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 04:03:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0814225;
        Mon, 12 Jun 2023 01:01:37 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 507D966056AA;
        Mon, 12 Jun 2023 09:01:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686556895;
        bh=isC+sRbNV9BUr83pa0sHnpd0Kls5ayI8Qkm4CZ8u4Pw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E/iy+iVFGvPWHCoINGvQF2uRuHCfw5+XDUVGvhCyITBMUFcLi3mSNdsa4neq52Rnq
         s5OsYHI9ROLaP5Fqlm9tS1ITnFzYSX112HS5iBrTRQLwlVLSt9mVYjUH84lgBKU58m
         IO6wbSokB33nReRXAv1rjcnEO7CoRirFIOlQm9L0mXg/y8MJ7gwVKG/DRoGHNpTVBr
         r+zT8qTQg92tLrpzjZmXjAaRitht6sdvm6oZj/1UfSBsp8uJDl3NWVUgIhb0IAkSEi
         ouQpgNztTBgr98V1R89cjyPdgvKQA62PS1zKs+ygquKeCuM+5/VWouWOIKYrT1/igV
         HOcUaBRrfpEUw==
Message-ID: <92b1c382-7428-5428-c8b1-e252ad3f81c1@collabora.com>
Date:   Mon, 12 Jun 2023 10:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 7/9] virt: geniezone: Add memory region support
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
 <20230609085214.31071-8-yi-de.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609085214.31071-8-yi-de.wu@mediatek.com>
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
> Hypervisor might need to know the precise purpose of each memory
> region, so that it can provide specific memory protection. We add a new
> uapi to pass address and size of a memory region and its purpose.
> 
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   arch/arm64/geniezone/gzvm_arch_common.h | 2 ++
>   arch/arm64/geniezone/vm.c               | 9 +++++++++
>   drivers/virt/geniezone/gzvm_vm.c        | 1 +
>   include/linux/gzvm_drv.h                | 2 ++
>   4 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> index 5affa28b935a..5cfeb4df84c5 100644
> --- a/arch/arm64/geniezone/gzvm_arch_common.h
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -23,6 +23,7 @@ enum {
>   	GZVM_FUNC_CREATE_DEVICE,
>   	GZVM_FUNC_PROBE,
>   	GZVM_FUNC_ENABLE_CAP,
> +	GZVM_FUNC_MEMREGION_PURPOSE,
>   	NR_GZVM_FUNC
>   };
>   
> @@ -46,6 +47,7 @@ enum {
>   #define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
>   #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
>   #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
> +#define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
>   #define GIC_V3_NR_LRS			16
>   
>   /**
> diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
> index 9f1f14f71b99..e19a66d6a75d 100644
> --- a/arch/arm64/geniezone/vm.c
> +++ b/arch/arm64/geniezone/vm.c
> @@ -97,6 +97,15 @@ int gzvm_arch_destroy_vm(gzvm_id_t vm_id)
>   				    0, 0, &res);
>   }
>   
> +int gzvm_arch_memregion_purpose(struct gzvm *gzvm, struct gzvm_userspace_memory_region *mem)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MEMREGION_PURPOSE, gzvm->vm_id,
> +				    mem->guest_phys_addr, mem->memory_size,
> +				    mem->flags, 0, 0, 0, &res);
> +}
> +
>   static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm, struct gzvm_enable_cap *cap,
>   				   struct arm_smccc_res *res)
>   {
> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
> index ba5412acfa7d..3b1cb715ef34 100644
> --- a/drivers/virt/geniezone/gzvm_vm.c
> +++ b/drivers/virt/geniezone/gzvm_vm.c
> @@ -248,6 +248,7 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
>   	memslot->vma = vma;
>   	memslot->flags = mem->flags;
>   	memslot->slot_id = mem->slot;
> +	gzvm_arch_memregion_purpose(gzvm, mem);

ret = gzvm_arch_memregion_purpose(...)
if (ret)
	......

>   	return register_memslot_addr_range(gzvm, memslot);
>   }
>   

Regards,
Angelo

