Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0651700466
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjELJ5v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjELJ5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 05:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B65CA;
        Fri, 12 May 2023 02:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971A665478;
        Fri, 12 May 2023 09:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9CEC433EF;
        Fri, 12 May 2023 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683885438;
        bh=8DTsk65nzftmPloQGhgyIVvnjxc6rGKFraKcYqAzBoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XHWpVGpvScJ+wnFPOzsMLnISW2WY1i2rUko+qPMXnt0buD+d6cYPywna543TP4k19
         P5o/7EPIO7vE1aGbh6sd9Mu1AFCxs7g8cyuemSQ3woOmsJgLRCJdelwmM76WjeLu/V
         rc6FrAN+8nik0LnkIHU2XWS/GnqB5ZfkWwjGAfHUj+W2YTg3P6iTqknW6dUTCMm1hx
         TpVVy99g2LZdtjW9JEYHlhdhewyicJMzh2e6+uohyx7/mNT/0eQy9Di5swJf4A0CZ+
         TEB3fUrdOfI32JMcqr95RbHIkIs5yQd01D375YzFq+ZQtk668BK4Sz+wrjdsS8AH2i
         0VCLrAb11a0Jw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pxPWW-00EX9F-8e;
        Fri, 12 May 2023 10:57:16 +0100
Date:   Fri, 12 May 2023 10:57:15 +0100
Message-ID: <86sfc1na84.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?B?IllpLURlIFd1ICjlkLPkuIDlvrcpIg==?= 
        <Yi-De.Wu@mediatek.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?Ik1ZIENodWFuZyAo6I6K5piO6LqNKSI=?= 
        <MY.Chuang@mediatek.com>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?Ikl2YW4gVHNlbmcgKOabvuW/l+i7kiki?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?B?IlplLXl1IFdhbmcgKOeOi+a+pOWuhyki?= 
        <Ze-yu.Wang@mediatek.com>,
        =?UTF-8?B?IlBlaUx1biBTdWVpICjpmovln7nlgKspIg==?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?B?IkxpanUtY2xyIENoZW4gKOmZs+m6lw==?= =?UTF-8?B?5aaCKSI=?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?B?IkphZGVzIFNo?= =?UTF-8?B?aWggKOaWveWQkeeOqCki?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        =?UTF-8?B?IlNoYXduIEhzaWFvICjola3lv5fnpaUpIg==?= 
        <shawn.hsiao@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?Ik1pbGVzIENoZW4gKA==?= =?UTF-8?B?6Zmz5rCR5qi6KSI=?= 
        <Miles.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?IllpbmdzaGl1?= =?UTF-8?B?YW4gUGFuICjmvZjnqY7ou5IpIg==?= 
        <Yingshiuan.Pan@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual interrupt injection
In-Reply-To: <fa864743c550ecd0a0c8052bfe7fddcc3f9be15c.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
        <20230428103622.18291-6-yi-de.wu@mediatek.com>
        <f1c8c1c1c091be87dfbc27b9178fc3e6@kernel.org>
        <762e3494ed468f0337b1c336615065b154396d23.camel@mediatek.com>
        <86wn1em1hx.wl-maz@kernel.org>
        <fa864743c550ecd0a0c8052bfe7fddcc3f9be15c.camel@mediatek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Yi-De.Wu@mediatek.com, corbet@lwn.net, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, robh+dt@kernel.org, MY.Chuang@mediatek.com, quic_tsoni@quicinc.com, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, ivan.tseng@mediatek.com, Ze-yu.Wang@mediatek.com, PeiLun.Suei@mediatek.com, Liju-clr.Chen@mediatek.com, jades.shih@mediatek.com, catalin.marinas@arm.com, dbrazdil@google.com, shawn.hsiao@mediatek.com, linux-arm-kernel@lists.infradead.org, Miles.Chen@mediatek.com, matthias.bgg@gmail.com, Yingshiuan.Pan@mediatek.com, linux-arch@vger.kernel.org, arnd@arndb.de, angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org, will@kernel.org
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

On Fri, 12 May 2023 09:16:58 +0100,
"Yi-De Wu (=E5=90=B3=E4=B8=80=E5=BE=B7)" <Yi-De.Wu@mediatek.com> wrote:
>=20
> On Fri, 2023-05-12 at 08:51 +0100, Marc Zyngier wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > On Fri, 12 May 2023 08:19:31 +0100,
> > "Yi-De Wu (=E5=90=B3=E4=B8=80=E5=BE=B7)" <Yi-De.Wu@mediatek.com> wrote:
> > >=20
> > > On Fri, 2023-04-28 at 19:59 +0100, Marc Zyngier wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >=20
> > > >=20
> > > > On 2023-04-28 11:36, Yi-De Wu wrote:
> > > > > From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> > > > >=20
> > > > > Enable GenieZone to handle virtual interrupt injection request.
> > > > >=20
> > > > > Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> > > > > Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> > > > > ---
> > > > >  arch/arm64/geniezone/Makefile       |  2 +-
> > > > >  arch/arm64/geniezone/gzvm_arch.c    | 24 ++++++--
> > > > >  arch/arm64/geniezone/gzvm_arch.h    | 11 ++++
> > > > >  arch/arm64/geniezone/gzvm_irqchip.c | 88
> > > > > +++++++++++++++++++++++++++++
> > > > >  drivers/virt/geniezone/gzvm_vm.c    | 75
> > > > > ++++++++++++++++++++++++
> > > > >  include/linux/gzvm_drv.h            |  4 ++
> > > > >  include/uapi/linux/gzvm.h           | 38 ++++++++++++-
> > > > >  7 files changed, 235 insertions(+), 7 deletions(-)
> > > > >  create mode 100644 arch/arm64/geniezone/gzvm_irqchip.c
> > > >=20
> > > > [...]
> > > >=20
> > > > > +++ b/arch/arm64/geniezone/gzvm_irqchip.c
> > > > > @@ -0,0 +1,88 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2023 MediaTek Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/irqchip/arm-gic-v3.h>
> > > > > +#include <kvm/arm_vgic.h>
> > > >=20
> > > > NAK.
> > > >=20
> > > > There is no way you can rely on anything from KVM in
> > > > your own hypervisor code.
> > > >=20
> > >=20
> > > Same with previous discussion, we'd like to copy or rename the
> > > related
> > > part from KVM and keep the maintainance at our own if it's ok.
> >=20
> > Why do you need *ANY* of the KVM stuff? Please fully enumerate these
> > dependencies and why you have them.
> >=20
> > Directly using KVM stuff for something completely unrelated is not
> > OK,
> > and will never be.
> >=20
> >         M.
> >=20
> > --
> > Without deviation from the norm, progress is not possible.
>=20
> The particular part we'd like to leverage from KVM are as followed
> 1. `gfn_to_pfn_memslot` to convert guest physical address(or
> intermediate physical address) to physical address

What is a memslot in your hypervisor? How does it relate to KVM's?
What about the use of struct kvm?

I'm sorry, but your use of *internal* structures and API would make it
impossible for us to make any further change without potentially
affecting your hypervisor. Which is closed source and untestable.

To sum it up, I'm strongly opposed to any use of these data
structures.  If you can spot some commonalities, expose them as a
0-cost abstraction. But don't use them as is your code.

> 2. get ARM's number of interrupt of different types e.g. number of SGI,
> number of PPI...etc

These are architectural constants, and you can define your own. That
will cost you nothing but a handful of #define, and keep the two
subsystem independent.

	M.

--=20
Without deviation from the norm, progress is not possible.
