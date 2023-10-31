Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935017DC7BD
	for <lists+linux-arch@lfdr.de>; Tue, 31 Oct 2023 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjJaH5w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjJaH5v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 03:57:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B79F;
        Tue, 31 Oct 2023 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698739069; x=1730275069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eiDnUW4Kn/odss8/DbdMU36YzLZTMzt2HhmARUpQoCE=;
  b=nL0YLl38fK87H00c2OlSpo/RC4VGZLb97MzfQ9siON+2wvjJewueN9/+
   0nkYJJmNGgGDAQLlT49gpLsJvVcNm3URQhsX0+/nxdBWjGKHfnTSlVL0A
   NDXulnmUkFE2NreUcloeQHWM9ffcPBJiT9g4plWXPCV4srIubHs+Um3YT
   GqxwewCd+o8qgpetks/pgEvX05VumjjjmfCcPlSEC914O374ILJUcj7vh
   CLMhcwhhvzG0E/nR2lR/LnVhWyOZkfefqcSTU3Ufjzag0Agv6vGgGHiCa
   ZemQXwc/auyIbJZbeUJrTwuieQo+nZesGnG2e8so6InqIZKDD/sdWzHSc
   A==;
X-CSE-ConnectionGUID: oOYSTJdaShisXPhp1E4W2A==
X-CSE-MsgGUID: 9QGEiL/2TtG25dQLEbKR6A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="asc'?scan'208";a="241617896"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2023 00:57:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 31 Oct 2023 00:57:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 31 Oct 2023 00:57:43 -0700
Date:   Tue, 31 Oct 2023 07:57:19 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 0/5] riscv: Add fine-tuned checksum functions
Message-ID: <20231031-shrouded-simmering-e60d23d17fa3@wendy>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qRR1lRF7FS8U2Elp"
Content-Disposition: inline
In-Reply-To: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--qRR1lRF7FS8U2Elp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 03:43:50PM -0700, Charlie Jenkins wrote:
> Each architecture generally implements fine-tuned checksum functions to
> leverage the instruction set. This patch adds the main checksum
> functions that are used in networking.
>=20
> This patch takes heavy use of the Zbb extension using alternatives
> patching.
>=20
> To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
> and RISCV_CHECKSUM_KUNIT.
>=20
> I have attempted to make these functions as optimal as possible, but I
> have not ran anything on actual riscv hardware. My performance testing
> has been limited to inspecting the assembly, running the algorithms on
> x86 hardware, and running in QEMU.
>=20
> ip_fast_csum is a relatively small function so even though it is
> possible to read 64 bits at a time on compatible hardware, the
> bottleneck becomes the clean up and setup code so loading 32 bits at a
> time is actually faster.
>=20
> Relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@rivo=
sinc.com/

Not sure if the dep here is related, but the series is back to failing
to build properly. Patch 3's build is broken everywhere pretty much, and
patch 4's allmodconfigs don't build:

https://patchwork.kernel.org/project/linux-riscv/list/?series=3D797256

Cheers,
Conor.

--qRR1lRF7FS8U2Elp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUCzXwAKCRB4tDGHoIJi
0gTuAQCn9o4GuOxKhaiu5W8NOQuoO/gxx0KouCaKxas8K9dn4wEA1y5FNvh1iWAg
XUdMgxRn+G362ufQfEH3gDx1oLZImgE=
=YvhH
-----END PGP SIGNATURE-----

--qRR1lRF7FS8U2Elp--
