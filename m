Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC767DEFDD
	for <lists+linux-arch@lfdr.de>; Thu,  2 Nov 2023 11:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbjKBKWl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Nov 2023 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346515AbjKBKWl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Nov 2023 06:22:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C9112;
        Thu,  2 Nov 2023 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698920556; x=1730456556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QTIJe6fBmHZ5pDGO2297HJQPTJ63MepYsAuffQjdfjA=;
  b=QHqi45Dbvzr6AK7DUY+wpj/871k8GYVEkDPXmZQI/oMO4I2TTSBw5swQ
   1AVxlswINeOFzb7tqhkgOiXMaBiqRX1r79SemgNjfGIzgK8oPTOtpDf1W
   y+JY1F65YotJoMk4+deRpqbtf1syCqQ1eUMbfavMX1dj8ajNHVz1vll3r
   xR3RIn1sleUy0cLvzVr02Fbt4/GySTJZrxgIA9qfs8dVWwZE/ElgeDZ0o
   SfbuyvyiUTE89Meb4WXGHP4h3ZG9oadeOIX/IauMx1qgGkZri8BAFnhqc
   jU/KUv4Pf+mxWdSRMxjPfjSMbWCK6KUWqU5hu+dYslCZbIDYYdSeYQkwN
   g==;
X-CSE-ConnectionGUID: dttG3pA+QG+SpyyA/RvAEA==
X-CSE-MsgGUID: fmLvno0mTHGxaLzBwfDWtA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="asc'?scan'208";a="241755710"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2023 03:22:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Nov 2023 03:22:18 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 2 Nov 2023 03:22:16 -0700
Date:   Thu, 2 Nov 2023 10:21:51 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 0/5] riscv: Add fine-tuned checksum functions
Message-ID: <20231102-express-deplete-4dd19e21a82c@wendy>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
 <20231101-palace-tightly-97a1d35a4597@spud>
 <ZUKFkn/PzOjw129p@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iP257PpdxnYzWyml"
Content-Disposition: inline
In-Reply-To: <ZUKFkn/PzOjw129p@ghost>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--iP257PpdxnYzWyml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 10:06:26AM -0700, Charlie Jenkins wrote:
> On Wed, Nov 01, 2023 at 11:50:46AM +0000, Conor Dooley wrote:
> > On Tue, Oct 31, 2023 at 05:18:50PM -0700, Charlie Jenkins wrote:
> > > Each architecture generally implements fine-tuned checksum functions =
to
> > > leverage the instruction set. This patch adds the main checksum
> > > functions that are used in networking.
> > >=20
> > > This patch takes heavy use of the Zbb extension using alternatives
> > > patching.
> > >=20
> > > To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
> > > and RISCV_CHECKSUM_KUNIT.
> > >=20
> > > I have attempted to make these functions as optimal as possible, but I
> > > have not ran anything on actual riscv hardware. My performance testing
> > > has been limited to inspecting the assembly, running the algorithms on
> > > x86 hardware, and running in QEMU.
> > >=20
> > > ip_fast_csum is a relatively small function so even though it is
> > > possible to read 64 bits at a time on compatible hardware, the
> > > bottleneck becomes the clean up and setup code so loading 32 bits at a
> > > time is actually faster.
> > >=20
> > > Relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@=
rivosinc.com/
> >=20
> > I coulda sworn I reported build issues against the v8 of this series
> > that are still present in this v9. For example:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20231031-optimiz=
e_checksum-v9-3-ea018e69b229@rivosinc.com/

> You did, and I fixed the build issues. This is another instance of how
> Patchwork reports the results of the previous build before the new build
> completes. Patchwork was very far behind so it took around 15 hours for
> the result to be ready.

:clown_face:

> There are some miscellaneous warnings in random
> drivers that I don't think can be attributed to this patch.

Yeah, there sometimes are warnings that seem spurious when you touch a
bunch of header files. I'm not really sure how to improve on that, since
it was newly introduced. My theory is that how we do a build of commit
A, then commit A~1 and then commit A again & take the difference between
the 2nd and 3rd builds (which should both be partial rebuilds) is not as
symmetrical as I might've thought and is the source of those seemingly
unrelated issues that come up from time to time.

--iP257PpdxnYzWyml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUN4PwAKCRB4tDGHoIJi
0jV3AP9c6KociGHuayEHtzK5fniiLEgkWkN9CfAqobQ+jqH0lAEA7HISbiX11E5K
Exvq77KvbRkFrOWUcY+p5/1Ke/8UYwU=
=M/iI
-----END PGP SIGNATURE-----

--iP257PpdxnYzWyml--
