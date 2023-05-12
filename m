Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E15700630
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbjELLCG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 07:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjELLBy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 07:01:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD91720;
        Fri, 12 May 2023 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683889310; x=1715425310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdr/QboOutQujzta21veyhN/BFRkmZJcWYh0ih36U+Q=;
  b=zIQ/9N2kjPHNNlw+ni2pYeDyfOLGkYik7ImpXU2KqaDjdMo0VeSs9KDe
   ggql0dme7VgPCfO7uZQlv4RDHrHCfv80/4UYb6OQTyGSlUmWiG9YAnJtp
   Vp8SVKG5WkHdD32WTWU+pgLd3gDIxhqzta1InmHTV6GkYQW22SvgtwZRH
   r2iZVkwxObqo1thavJ9gtQWfrctTL1V4pAlpI/f0rxZVilyeDEtngnhvu
   SbAwpHGArzru1XcIeC+T7IhJ1RSvW28JSyQ7gQrAfkalM9cQ/UyPspVg+
   N0oPMpvaXbz1cg1fltZziwwSpK07M80fT71uXaURQUJrLSww7TZzMxEt5
   g==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="215055820"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 04:01:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 04:01:43 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 04:01:39 -0700
Date:   Fri, 12 May 2023 12:01:18 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yi-De Wu =?utf-8?B?KOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        MY Chuang =?utf-8?B?KOiOiuaYjui6jSk=?= <MY.Chuang@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
        Shawn Hsiao =?utf-8?B?KOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        Miles Chen =?utf-8?B?KOmZs+awkeaouik=?= 
        <Miles.Chen@mediatek.com>,
        PeiLun Suei =?utf-8?B?KOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        Liju-clr Chen =?utf-8?B?KOmZs+m6l+Wmgik=?= 
        <Liju-clr.Chen@mediatek.com>,
        Jades Shih =?utf-8?B?KOaWveWQkeeOqCk=?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Yingshiuan Pan =?utf-8?B?KOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ze-yu Wang =?utf-8?B?KOeOi+a+pOWuhyk=?= 
        <Ze-yu.Wang@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        Ivan Tseng =?utf-8?B?KOabvuW/l+i7kik=?= 
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Message-ID: <20230512-marine-kilowatt-44a642124ac7@wendy>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-3-yi-de.wu@mediatek.com>
 <20230428212411.GA292303-robh@kernel.org>
 <ec4cae2e6da4a64bc3983ffdde03f51e185d3609.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SGI1uxhA9flSLqZg"
Content-Disposition: inline
In-Reply-To: <ec4cae2e6da4a64bc3983ffdde03f51e185d3609.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--SGI1uxhA9flSLqZg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 06:42:51AM +0000, Yi-De Wu (=E5=90=B3=E4=B8=80=E5=
=BE=B7) wrote:
> On Fri, 2023-04-28 at 16:24 -0500, Rob Herring wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > On Fri, Apr 28, 2023 at 06:36:17PM +0800, Yi-De Wu wrote:
> > > From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> > >=20
> > > Add documentation for GenieZone(gzvm) node. This node informs gzvm
> > > driver to start probing if geniezone hypervisor is available and
> > > able to do virtual machine operations.
> >=20
> > Why can't the driver just try and do virtual machine operations to
> > see
> > if the hypervisor is there? IOW, make your software interfaces
> > discoverable. DT is for non-discoverable hardware.
> >=20
> > Rob
>=20
> Can do, our hypervisor is discoverable through invoking probing
> hypercall, and we use the device tree to prevent unnecessary module
> loading on all systems.

Please do not wait until immediately prior to submitting version N+1
before replying to any of the comments on version N.
This creates a confusing scenario, where some review comments may be
missed due to parallel discussion.

Thanks,
Conor.


--SGI1uxhA9flSLqZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF4cfgAKCRB4tDGHoIJi
0sIUAQCB81kFCDM+sykANmi0tAinLKojHS+RwXtrVqk3OUoxcAEA06+Iy8V0A75T
x/4Pd33AIh4X9j7/BLZ90YVbOSYWVQ0=
=ydlj
-----END PGP SIGNATURE-----

--SGI1uxhA9flSLqZg--
