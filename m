Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF68D77953F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjHKQwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjHKQwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 12:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC130D0;
        Fri, 11 Aug 2023 09:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9FB867732;
        Fri, 11 Aug 2023 16:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF7EC433C8;
        Fri, 11 Aug 2023 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772743;
        bh=vdQ+VbOk0WXAqkeu5hhMiFqWiP0BvXxpd1MCJU3hfYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/BNsIRPuQtwLLYF4Dd+iwrfrqPmcNqllqq3xN06Uvfm0viioyARouTP43LNjeGB8
         UhOuXInH4w/7nD/y/azYPSBVxxeOOHAp6w3kqJkeLZkGYko6s+OKGTq5OEZ4E8gmkk
         31iWq0SLarEWFY4DX7jv8FYVXY+txo3p/7c0sRdL6/SYtlY5bvgswHwrLfVbGPtbKS
         Y1uyWu8IQmEtry2UhEYAObF8fsZIl4sPDp4k/KJ+OFgVTbOSEdd3Wwpq75h8Xby6Wi
         CrVyMT6oh39QKpTB1WqKnWoSdh+zJTozsRegdCFmnFqpUCKh4A/0KpDXz8JtvM5AwP
         XABhDoVjvQoJQ==
Received: (nullmailer pid 3596930 invoked by uid 1000);
        Fri, 11 Aug 2023 16:52:19 -0000
Date:   Fri, 11 Aug 2023 10:52:19 -0600
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
Subject: Re: [PATCH v5 00/12] GenieZone hypervisor drivers
Message-ID: <20230811165219.GA3593414-robh@kernel.org>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727080005.14474-1-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 03:59:53PM +0800, Yi-De Wu wrote:
> This series is based on linux-next, tag: next-20230726.
> 
> GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various virtual
> machine types and provides security features such as TEE-like scenarios and
> secure boot. It can create guest VMs for security use cases and has
> virtualization capabilities for both platform and interrupt. Although the
> hypervisor can be booted independently, it requires the assistance of GenieZone
> hypervisor kernel driver(gzvm-ko) to leverage the ability of Linux kernel for
> vCPU scheduling, memory management, inter-VM communication and virtio backend
> support.
> 
> Changes in v5:
> - Add dt solution back for device initialization

Why? It's a software interface that you define and control. Make that 
interface discoverable.

Rob
