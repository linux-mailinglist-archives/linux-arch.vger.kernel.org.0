Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73E0779579
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjHKRA7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 13:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjHKRA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 13:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484B30C1;
        Fri, 11 Aug 2023 10:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09EC160B79;
        Fri, 11 Aug 2023 17:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691AFC433C9;
        Fri, 11 Aug 2023 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773257;
        bh=l1aOISgHLyF1tS0E6wyiBR8uld1+gi5jofN8WS08bZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIZh4+l26+bumdjG+bZVToiZ3djsVl+GVTghFsSnjne6ExjsxrYrltO5Q9rsFIMfd
         YeEVvJjZ7VWTWcFvjz5ZWsXfWmyZwO9/S2Cos7G1qdSmXXfUXr4ezYXmclymHemksB
         5RFlZYC17AaJ2AokgHCtO+4iWICrLv85UxAsiDY+VMnBlMn7JdtD8KyceES26UHWtB
         3rycLa8T0et++fte67RueG4SLZA1Sy7pwfaRsRPopgKwSgl9vdhlKBP+mh+LoGmPNR
         0Ng37vhFG53uXvjrDeO0XHuxojFC+5AOpF4IWCoOJU6YnkDHvmVCN7s8T4TeaCiaFz
         UEc566dSW2TyQ==
Received: (nullmailer pid 3606791 invoked by uid 1000);
        Fri, 11 Aug 2023 17:00:54 -0000
Date:   Fri, 11 Aug 2023 11:00:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
Cc:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Jade Shih <jades.shih@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
Subject: Re: [PATCH v5 04/12] virt: geniezone: Add vcpu support
Message-ID: <20230811170054.GB3593414-robh@kernel.org>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
 <20230727080005.14474-5-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727080005.14474-5-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 03:59:57PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> VMM use this interface to create vcpu instance which is a fd, and this
> fd will be for any vcpu operations, such as setting vcpu registers and
> accepts the most important ioctl GZVM_VCPU_RUN which requests GenieZone
> hypervisor to do context switch to execute VM's vcpu context.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>  arch/arm64/geniezone/Makefile           |   2 +-
>  arch/arm64/geniezone/gzvm_arch_common.h |  20 ++
>  arch/arm64/geniezone/vcpu.c             |  88 +++++++++
>  arch/arm64/geniezone/vm.c               |  11 ++
>  arch/arm64/include/uapi/asm/gzvm_arch.h |  30 +++

I'm almost certain that the arm64 maintainers will reject putting this 
here. What is the purpose of the split with drivers/virt/? Do you plan 
to support another arch in the near future?

Yes, there's KVM stuff in arch/arm64, but that is multi-arch.

>  drivers/virt/geniezone/Makefile         |   3 +-
>  drivers/virt/geniezone/gzvm_vcpu.c      | 250 ++++++++++++++++++++++++
>  drivers/virt/geniezone/gzvm_vm.c        |   5 +
>  include/linux/gzvm_drv.h                |  21 ++
>  include/uapi/linux/gzvm.h               | 136 +++++++++++++
>  10 files changed, 564 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/geniezone/vcpu.c
>  create mode 100644 drivers/virt/geniezone/gzvm_vcpu.c
