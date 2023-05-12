Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80A700660
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbjELLJ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjELLJz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 07:09:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF6510C;
        Fri, 12 May 2023 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683889794; x=1715425794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxJCDzIA48b//fv9e6rdygKudsP+QYXovUJ5vLhRsUU=;
  b=u8980ssifBnHGiqIV01O8e6weHk1OvwNfrI8T8FSZYeZs/QGhb9w2hT9
   ndXC9V5shifpMc/ygvA5u6tYhD1ylHyR4vx9PgtHP3UzS30Hupa+/CfDf
   c5Z4c7gbXO6CDFTKJgfmwFOq98HpcimYyetO6Rynw8CxOxnSZt1UgSdUS
   5PO/sUTsyewB+9zZb1+5IwBbFP3wOru1FyJUwlU0v8A031O0VgtD4b8Cy
   6aGiV4/XN1OAsCqcwsL2hUBwTcJUgbJtHLqk/zhT0u5MDAOVO5svidrcy
   1cLpP4R5zfqsVYZgJHIoqQIYx3v2e8OejD3mu2MgP83GLNP7MzqrsU6WG
   g==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="213036513"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 04:09:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 04:09:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 04:09:47 -0700
Date:   Fri, 12 May 2023 12:09:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
CC:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Message-ID: <20230512-kudos-stunt-489ee651bdd8@wendy>
References: <20230512080405.12043-1-yi-de.wu@mediatek.com>
 <20230512080405.12043-3-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jm8a6vav6fCrVMuQ"
Content-Disposition: inline
In-Reply-To: <20230512080405.12043-3-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--jm8a6vav6fCrVMuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 04:04:00PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
>=20
> Add documentation for GenieZone(gzvm) node. This node informs gzvm
> driver to start probing if geniezone hypervisor is available and
> able to do virtual machine operations.

Propagated from v2:
> > Why can't the driver just try and do virtual machine operations to
> > see
> > if the hypervisor is there? IOW, make your software interfaces
> > discoverable. DT is for non-discoverable hardware.
>=20
> Can do, our hypervisor is discoverable through invoking probing
> hypercall, and we use the device tree to prevent unnecessary module
> loading on all systems.

Rob is out of office at the moment, but that appears to be a request to
drop the use of devicetree entirely. Mainly re-posting so that that
conversation appears on the latest version of the patchset, given you
only replied to Rob today.

Thanks,
Conor.

--jm8a6vav6fCrVMuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF4eZwAKCRB4tDGHoIJi
0heIAQCuxzD4xO33tzAFrZou3AdawoxEN1YCIboEGZHW1IgEtQEA26XugE38j868
giM/FmO9kzgghTusFmhvQtjaEFFiPww=
=t/9L
-----END PGP SIGNATURE-----

--jm8a6vav6fCrVMuQ--
