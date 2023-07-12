Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7774FFE5
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGLHJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjGLHJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 03:09:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716A198B;
        Wed, 12 Jul 2023 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689145758; x=1720681758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=duZW+sLs6ycl8qwh4wlYhASDZojoec/KJOE3c/Wl/kA=;
  b=eatUUJmedl/sF5FMB9n8lo6zPh6KcPVS7BB9UzrBSGYdShWZfxjLIbOO
   q6L3AA0tYYm75dDiRPjVcR43CzwKOHdSfPDTJXCGMZq9oaQXXV5V3HdWc
   Xc47sLQEW18TNUc0428j5aohqhTtiZh4KUxJJkewz+bSJ0WCdGxUvNuDO
   26BYmXbUoxzMi0ZKahI6mMmq0BxqzbdorFaQWsgRbZA1HCYTkxH0gyTLc
   DMn3eZfJ3nOXB6B3+3HNgArUIhX7zxdvvwKllZEt3g9NMjk+XRkL4qh0V
   0yI7MjEDY9Zf9DFXQqKnHEAwDRr3Lgm51cXgBjWvvf6vr0T+HqD9vZYZ+
   w==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="222553164"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 00:09:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 00:09:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 00:09:14 -0700
Date:   Wed, 12 Jul 2023 08:08:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH 0/4] riscv: tlb flush improvements
Message-ID: <20230712-void-sniff-ca1abcbc7783@wendy>
References: <20230711075434.10936-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dahEnerN+wZuERnx"
Content-Disposition: inline
In-Reply-To: <20230711075434.10936-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--dahEnerN+wZuERnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Tue, Jul 11, 2023 at 09:54:30AM +0200, Alexandre Ghiti wrote:
> This series optimizes the tlb flushes on riscv which used to simply
> flush the whole tlb whatever the size of the range to flush or the size
> of the stride.
>=20
> Patch 3 introduces a threshold that is microarchitecture specific and
> will very likely be modified by vendors, not sure though which mechanism
> we'll use to do that (dt? alternatives? vendor initialization code?).
>=20
> Next steps would be to implement:
> - svinval extension as Mayuresh did here [1]
> - BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
> - MMU_GATHER_RCU_TABLE_FREE
> - MMU_GATHER_MERGE_VMAS
>=20
> Any other idea welcome.
>=20
> [1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale=
@ventanamicro.com/
>=20
> Alexandre Ghiti (4):
>   riscv: Improve flush_tlb()
>   riscv: Improve flush_tlb_range() for hugetlb pages

>   riscv: Make __flush_tlb_range() loop over pte instead of flushing the
>     whole tlb

The whole series does not build on nommu & this one adds a build warning
for regular builds:
+      1 ../arch/riscv/mm/tlbflush.c:32:15: warning: symbol 'tlb_flush_all_=
threshold' was not declared. Should it be static?

Cheers,
Conor.

--dahEnerN+wZuERnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK5RegAKCRB4tDGHoIJi
0m6sAQCD5bKPD2l+jsEwxjIzFU/98p6cICiV9t7nlfZ8sb8mXAD/UPM/OYJdjWyb
I2qZkkSuaIMYtFOVwZy/StTB2tnmngQ=
=UB9i
-----END PGP SIGNATURE-----

--dahEnerN+wZuERnx--
