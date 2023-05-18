Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3438707BFD
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 10:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjERI2H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 04:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjERI2F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 04:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B014B1BD0;
        Thu, 18 May 2023 01:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37CFD60BED;
        Thu, 18 May 2023 08:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FF8C433D2;
        Thu, 18 May 2023 08:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684398482;
        bh=onUdWwy/Zov/7JnIPbVsr3nMDNBR4bEgLPYL3et5tOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BbzWlF/Z7EepK+tkbIKX/var8RUWYppCL1zsoBgGC/M8R9Vtvt5aVB4gjT6k/ScTp
         E8J2+cTwhq1UkxrvAGHr3/TPln+6V+rCSFp14yTEaa3/z0w2SoHJc5P/N/A9QITwpD
         bh/CHNn2n442xFkSy3PwnnyAa1wJElwJup2q2Onr95Pvk85qw+Q8CIcIdhPcXRoJEi
         jIVk5wpXIpQgk/eaFhSKKyhDMhLi3vEtYtOPK4zHBc7x0ke+WIFdR6h1gN3YVk+mpg
         3ySN5R3ExTDkZlGyPiRLh9ztHTsZv5qHBPLU2O2tgYBqm/+UmnkPBY2lxQgwT711OX
         X68a0U9uQnnug==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pzYzQ-00G5Jx-CB;
        Thu, 18 May 2023 09:28:00 +0100
Date:   Thu, 18 May 2023 09:27:59 +0100
Message-ID: <86h6sakprk.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
Cc:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: Re: [PATCH v3 3/7] virt: geniezone: Introduce GenieZone hypervisor support
In-Reply-To: <20230512080405.12043-4-yi-de.wu@mediatek.com>
References: <20230512080405.12043-1-yi-de.wu@mediatek.com>
        <20230512080405.12043-4-yi-de.wu@mediatek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: yi-de.wu@mediatek.com, yingshiuan.pan@mediatek.com, ze-yu.wang@mediatek.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org, quic_tsoni@quicinc.com, dbrazdil@google.com, jades.shih@mediatek.com, miles.chen@mediatek.com, ivan.tseng@mediatek.com, my.chuang@mediatek.com, shawn.hsiao@mediatek.com, peilun.suei@mediatek.com, liju-clr.chen@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 12 May 2023 09:04:01 +0100,
Yi-De Wu <yi-de.wu@mediatek.com> wrote:
> 
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone is MediaTek hypervisor solution, and it is running in EL2
> stand alone as a type-I hypervisor. This patch exports a set of ioctl
> interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
> lifecycle (creation and destroy) on GenieZone.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

[...]

> +/**
> + * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host pa),
> + *			       result is in @pfn
> + *
> + * Leverage KVM's gfn_to_pfn_memslot(). Because gfn_to_pfn_memslot() needs
> + * kvm_memory_slot as parameter, this function populates necessary fileds
> + * for calling gfn_to_pfn_memslot().
> + *
> + * Return:
> + * * 0			- Succeed
> + * * -EFAULT		- Failed to convert
> + */
> +static int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
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
> +	if (is_error_noslot_pfn(__pfn)) {
> +		*pfn = 0;
> +		return -EFAULT;
> +	}

I have commented on this before: there is absolutely *no way* that you
can use KVM as the unwilling helper for your stuff. You are passing
uninitialised data to the core KVM, completely ignoring the semantics
of all the other fields.

More importantly, you are now holding us responsible for any breakage
that would be caused to your code if we change the internals of this
*PRIVATE FUNCTION*.

Do you see Xen or Hyper-V using KVM's internals as some sort of
backend to make their life easier? No, because they understand that
this is off-limits, and creates an unhealthy dependency for both
hypervisors.

So this is a strong NAK. And you can trust me to keep voicing my
opposition to this sort of horror, wherever I will see these patches.

	M.

-- 
Without deviation from the norm, progress is not possible.
