Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B721D766ECD
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjG1NwP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjG1NwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 09:52:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F32D57;
        Fri, 28 Jul 2023 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690552333; x=1722088333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=13yUOGGfMfswl4RW/YVIRSa8RvBKZJkyMPeM4Uwztbc=;
  b=e6736ybDF52saJEtkI1Nv+VCrxASeBeCyw9HzplhRlqxGy5xKPlO0cgD
   +H2X3xUy6XZE5FI+GaAFa2uNEiJi1OG0zEIjwiRsQhvFguwlwiS3dMpH/
   puXOyQZCWSbBVM1n1mkw5QYHNv2mJFr31rYjeLF4EGX4WSidY3lptM7jX
   JyZZapClJMqb3LW4JoW3o5bYIMXjd+wrjApsqe0Kw3M5bR4EPqDsh7KME
   KwZa+YlCyg38kmJJ1iMuEYAx/BXH1hHaJ3hyx6ovgwSYoQbMRPrWwUV2V
   W90g0BJkMhCw5VgskiH9TvX25kxS00ekyCduniQr3K2bF8W6oy5Qp4cHI
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="asc'?scan'208";a="163744085"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 06:52:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 06:52:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 06:52:06 -0700
Date:   Fri, 28 Jul 2023 14:51:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] riscv: Make __flush_tlb_range() loop over pte
 instead of flushing the whole tlb
Message-ID: <20230728-snout-defiance-082befdeaa51@wendy>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
 <20230727185553.980262-4-alexghiti@rivosinc.com>
 <20230728-f2cd8ddd252c2ece2e438790@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="avaIEXfS61g8yoTO"
Content-Disposition: inline
In-Reply-To: <20230728-f2cd8ddd252c2ece2e438790@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--avaIEXfS61g8yoTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 03:32:35PM +0200, Andrew Jones wrote:
> On Thu, Jul 27, 2023 at 08:55:52PM +0200, Alexandre Ghiti wrote:

> > +	else if (size =3D=3D (unsigned long)-1)
>=20
> The more we scatter this -1 around, especially now that we also need to
> cast it, the more I think we should introduce a #define for it.

Please.

--avaIEXfS61g8yoTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMPH4wAKCRB4tDGHoIJi
0pcKAP98p/ImDQ/uxeHvVZf6GCqG6+uNVE4h+qEzQF4LDzyZJAEAu/5LBu9gRRSH
/J59XOyZqO6G+WA6CW2Eh+46AhRzmwc=
=3/WE
-----END PGP SIGNATURE-----

--avaIEXfS61g8yoTO--
