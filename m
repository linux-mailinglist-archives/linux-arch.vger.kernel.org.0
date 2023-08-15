Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603B77CAC9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Aug 2023 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjHOJyN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjHOJx6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 05:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18201F7;
        Tue, 15 Aug 2023 02:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C70A62B61;
        Tue, 15 Aug 2023 09:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6926DC433C8;
        Tue, 15 Aug 2023 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692093235;
        bh=kvaqJ2sBEkbN7oMgKvzp6aMeCbQ6lN6aEQjyWQJ5X6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uqw5AIwCq5p7sCinwmmp/Lqz+8nGO5myfGcZEaCsclPS+/Dq5OkqZIWvlAsVY8uxR
         FL5dgh/XWOTklxmPq9FDZW5xT31bE/WIg6siTr5DLREiB2Zv7srizXhQIOcqQiDaS4
         PCZjYG6f3/OWUWTxkKEwh7oAlcEAZU/xrZ/iMoTlKvu1SjYYeqP4Uf5CwHYCvOgzjK
         rYulG/3FrqS9u8zCuJPbKQNYtQMWuPv1dS8t0eV05/iK8WzCJTpWThBQjtR4cOKgrU
         qCM6KGWyF2pkR9NkX9uqoHqsfYuQ4rVzrshHKaBe0jrpTTYMdWS100Oykaz9q5eP8k
         GMSfRQ3v6Nhuw==
Date:   Tue, 15 Aug 2023 10:53:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20230815095346.GA11083@willie-the-truck>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
 <20230727080005.14474-5-yi-de.wu@mediatek.com>
 <20230811170054.GB3593414-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811170054.GB3593414-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 11:00:54AM -0600, Rob Herring wrote:
> On Thu, Jul 27, 2023 at 03:59:57PM +0800, Yi-De Wu wrote:
> > From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> > 
> > VMM use this interface to create vcpu instance which is a fd, and this
> > fd will be for any vcpu operations, such as setting vcpu registers and
> > accepts the most important ioctl GZVM_VCPU_RUN which requests GenieZone
> > hypervisor to do context switch to execute VM's vcpu context.
> > 
> > Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> > Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> > Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> > Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> > ---
> >  arch/arm64/geniezone/Makefile           |   2 +-
> >  arch/arm64/geniezone/gzvm_arch_common.h |  20 ++
> >  arch/arm64/geniezone/vcpu.c             |  88 +++++++++
> >  arch/arm64/geniezone/vm.c               |  11 ++
> >  arch/arm64/include/uapi/asm/gzvm_arch.h |  30 +++
> 
> I'm almost certain that the arm64 maintainers will reject putting this 
> here. What is the purpose of the split with drivers/virt/? Do you plan 
> to support another arch in the near future?

Thanks, Rob. You're absolutely right that this doesn't belong in the
architecture code.

Will
