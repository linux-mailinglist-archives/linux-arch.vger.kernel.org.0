Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47416766ECB
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjG1Nvb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjG1Nva (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 09:51:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A52D47;
        Fri, 28 Jul 2023 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690552289; x=1722088289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4UOOMLzhEg7Hb9YLlX0MpaOBGLEhWTvCIPPPEtSP78=;
  b=oXEvYuGxCY1dv5TiWF8Mt9rTunAk/s+oaBznXcGpWm7EUhvIaiAFFre9
   RXiFfiOuEDPgBcFd1FfRpN1lvefWWcfGfgSpL1lEbfZJfnGz0o6EZzmOG
   /0Rmqm1UUqJLRxTyj6TNyp49S2bxxhnD8rxZ0b8Ao6mayQt8kQI9yQtKr
   RS5gb3LgbcsSj8Sgt1gg4IIdTAUG7bRV4nmGlHl6TIVNRYd6Z8JzBmQdE
   zhWM91Au4aRQFgJDjzM+HpjMgqx1jNKSoNK3PIyZgQZiqLxVn+5hDlxmA
   mNOAvImwoU/uXOpsnwKdp8zijiRldCF/YIAltO97IzlN4FXom3TVYvaKF
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="asc'?scan'208";a="238439247"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 06:51:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 06:51:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 06:51:25 -0700
Date:   Fri, 28 Jul 2023 14:50:50 +0100
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
Subject: Re: [PATCH v2 3/4] riscv: Make __flush_tlb_range() loop over pte
 instead of flushing the whole tlb
Message-ID: <20230728-fragrant-slogan-c0d5fe419148@wendy>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
 <20230727185553.980262-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jGn+lVFirgFk2Kkr"
Content-Disposition: inline
In-Reply-To: <20230727185553.980262-4-alexghiti@rivosinc.com>
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

--jGn+lVFirgFk2Kkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 08:55:52PM +0200, Alexandre Ghiti wrote:
> Currently, when the range to flush covers more than one page (a 4K page or
> a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whole
> tlb comes with a greater cost than flushing a single entry so we should
> flush single entries up to a certain threshold so that:
> threshold * cost of flushing a single entry < cost of flushing the whole
> tlb.
>=20

> This threshold is microarchitecture dependent and can/should be
> overwritten by vendors.

Please remove the latter part of this, as there is no infrastructure for
this at present, nor likely in the immediate future.

> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 41 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 3e4acef1f6bc..8017d2130e27 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -24,13 +24,48 @@ static inline void local_flush_tlb_page_asid(unsigned=
 long addr,
>  			: "memory");
>  }
> =20
> +/*
> + * Flush entire TLB if number of entries to be flushed is greater
> + * than the threshold below.

>     Platforms may override the threshold
> + * value based on marchid, mvendorid, and mimpid.

And this too, as there is no infrastructure for this the comment is
misleading. This kind of thing should only be added when there is
actually a mechanism for doing so.

I did say I would think about how to do this, but I have not come up
with something. I dislike using the marchid/mvendorid/mimpid stuff if we
can avoid it, as there's no control over what actually gets put in there,
especially if people are going to use the open souce cores.

Do we even, unless under extreme duress, want to allow setting custom
values here via firmware? Sounds like a recipe for 1200 different
alternatives or a big LUT...

--jGn+lVFirgFk2Kkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMPHugAKCRB4tDGHoIJi
0i7gAQD99swFs11GEt+GGumHiBo4DwfAPprUIG6NJwlipUEtTwD8C0Cvcof0M2Cb
j9Yi7Bv2Lc/s1+bLZK+A2sqPkSyzRQ0=
=Z50k
-----END PGP SIGNATURE-----

--jGn+lVFirgFk2Kkr--
