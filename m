Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E0700D5C
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjELQvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjELQvG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 12:51:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C1235A4;
        Fri, 12 May 2023 09:51:05 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0A01D1C0ABB; Fri, 12 May 2023 18:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1683910264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XM8NBb2coBJF2GqQ8RcwtfKaTsDoZEMiql19jU2Efmw=;
        b=FFVOOe2KbUsF14ijfQM5zGuMlcXbAHuV9ubM3mcFtnsRs9KlzaPRkypol93Ch8an60Do2x
        ttgQ0xh863bm6ta0Z3qhmaj8Hq8Gx3d0CDiduyTB7EAfTNVlOMDWx9o2E76g/fqIbFbzE7
        jCwgbenqj5EI6Fsvi5/1MiksMClco/I=
Date:   Fri, 12 May 2023 18:51:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
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
Subject: Re: [PATCH v2 1/7] docs: geniezone: Introduce GenieZone hypervisor
Message-ID: <ZF5ud9CedwBnWXBN@localhost>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-2-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428103622.18291-2-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

> GenieZone is MediaTek proprietary hypervisor solution, and it is running
> in EL2 stand alone as a type-I hypervisor. It is a pure EL2
> implementation which implies it does not rely any specific host VM, and
> this behavior improves GenieZone's security as it limits its interface.

> +++ b/Documentation/virt/geniezone/introduction.rst
> @@ -0,0 +1,34 @@

> +Platform Virtualization
> +=======================
> +We leverages arm64's timer virtualization and gic virtualization for timer and
> +interrupts controller.

'interrupt'.

> +Device Virtualizaton
> +====================
> +We adopts VMM's virtio devices emulations by passing io trap to
> VMM, and virtio

'adopt', 'device emulation'

> +is a well-known and widely used virtual device implementation.
> +

Plus, I'd expect documentation to be more detailed or have pointer
where
to learn more.

BR,							Pavel

-- 
