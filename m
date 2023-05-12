Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB770049B
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjELKCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbjELKCL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102313296;
        Fri, 12 May 2023 03:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD35654AC;
        Fri, 12 May 2023 09:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F35C433D2;
        Fri, 12 May 2023 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683885583;
        bh=H1+kd4w7k1HS9RKH9lnHTTmFpUCehtlt2UQGHny7fDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ssLs55ak/x/IUqC3e9qn8qCSJtoPW4S0z0bUOouC4Dh24aIuI4rTp47LZ+Df6byZt
         FJ3H2JVuI19wu61a/XQ5VzVMx85RaV5yADhe/61c+LOHrZxPWR4ESIWp4rlwCMs9Im
         3erP8ELY9XMoQvWttiDOwy4Ll6mrtSbZAUENapjdu8zSPeNYWIZNNagDG9T4fiPTRY
         v3RstRImhsK9TSMvAhhlXztx9AxR3Lyx9VZJ6Exe/PupPFTzRJdzsZXt2YtchHXzF2
         hgR32LD605782YS0ULqBV3CklXyQWwEWLhGc6Ze+uaXVWdtqSd/8PEOwPM1VpdjuWZ
         MXO2QpHXgnqVg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pxPYr-00EXDA-Ca;
        Fri, 12 May 2023 10:59:41 +0100
Date:   Fri, 12 May 2023 10:59:40 +0100
Message-ID: <86r0rlna43.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?B?IllpLURlIFd1ICjlkLPkuIDlvrcpIg==?= 
        <Yi-De.Wu@mediatek.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        =?UTF-8?B?Ik1Z?= =?UTF-8?B?IENodWFuZyAo6I6K5piO6LqNKSI=?= 
        <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        =?UTF-8?B?IlNoYXduIEhz?= =?UTF-8?B?aWFvICjola3lv5fnpaUpIg==?= 
        <shawn.hsiao@mediatek.com>,
        =?UTF-8?B?Ik1pbGVzIENoZW4gKOmZs+awkeaouiki?= 
        <Miles.Chen@mediatek.com>,
        =?UTF-8?B?IlBlaUx1biBTdWVpICjpmovln7nlgKspIg==?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?B?IkxpanUtY2xyIENoZW4gKOmZs+m6lw==?= =?UTF-8?B?5aaCKSI=?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?B?IkphZGVzIFNo?= =?UTF-8?B?aWggKOaWveWQkeeOqCki?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?IllpbmdzaGl1YW4gUGFu?= =?UTF-8?B?ICjmvZjnqY7ou5IpIg==?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?B?IlplLXl1IFdhbmcgKOeOi+a+pOWuhyki?= 
        <Ze-yu.Wang@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        =?UTF-8?B?Ikl2YW4gVHNlbmcgKOabvg==?= =?UTF-8?B?5b+X6LuSKSI=?= 
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor support
In-Reply-To: <457219eb8c83b35fc8705d80abbf75fc2fd8741c.camel@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
        <20230428103622.18291-4-yi-de.wu@mediatek.com>
        <904abf67ec4ba7d37fc1e500e8a2dbd1@kernel.org>
        <457219eb8c83b35fc8705d80abbf75fc2fd8741c.camel@mediatek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Yi-De.Wu@mediatek.com, corbet@lwn.net, linux-kernel@vger.kernel.org, robh+dt@kernel.org, angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org, linux-arch@vger.kernel.org, MY.Chuang@mediatek.com, devicetree@vger.kernel.org, quic_tsoni@quicinc.com, shawn.hsiao@mediatek.com, Miles.Chen@mediatek.com, PeiLun.Suei@mediatek.com, Liju-clr.Chen@mediatek.com, jades.shih@mediatek.com, catalin.marinas@arm.com, dbrazdil@google.com, linux-arm-kernel@lists.infradead.org, Yingshiuan.Pan@mediatek.com, krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, arnd@arndb.de, linux-doc@vger.kernel.org, Ze-yu.Wang@mediatek.com, will@kernel.org, ivan.tseng@mediatek.com
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

On Fri, 12 May 2023 08:17:58 +0100,
"Yi-De Wu (=E5=90=B3=E4=B8=80=E5=BE=B7)" <Yi-De.Wu@mediatek.com> wrote:
>=20
> On Fri, 2023-04-28 at 23:12 +0100, Marc Zyngier wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > On 2023-04-28 11:36, Yi-De Wu wrote:
> > > From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> > >=20
> > > +config MTK_GZVM
> > > +     tristate "GenieZone Hypervisor driver for guest VM operation"
> > > +     depends on ARM64
> > > +     depends on KVM
> >=20
> > NAK.
> >=20
> > Either this is KVM, and this code serves no purpose, or it is a
> > standalone
> > hypervisor, and it *cannot* have a dependency on KVM.
> >=20
> > [...]
> >=20
>=20
> In order to be self-contained and avoid dependency like with KVM, may
> we leverage KVM's symbol, macro e.g. VGIC_NR_SGIS,
> VGIC_NR_PRIVATE_IRQS...etc, and copy or rename the related part to
> */geniezone/?

Again, these are architected constants. You can have your own. You can
already consider any use of a KVM structure or symbol as a bug.

	M.

--=20
Without deviation from the norm, progress is not possible.
