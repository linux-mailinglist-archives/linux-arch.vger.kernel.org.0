Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AC07009B9
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbjELOAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjELN7i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 09:59:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C139C13C2E;
        Fri, 12 May 2023 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683899972; x=1715435972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RgLBvhgm2odiQ2SzAp4nOs61NsPOgBYkIG0oBcKhByU=;
  b=GVSUzRfFY5YYiWXPfcAo6iwrCosOKSgjUkT76TiU9XbpSJiLnbxW6UJ+
   GUzlqgkvcambJp4qB8YS6HJq3fjXs/V71+EaJltxM4+aIOvXawbUlP6Jz
   5hFI4uzrkT2SuXWYoDiLoDMWWj9Y8SCaGy0GHLjwvMVxKNNkGHtE2nHPI
   2r5FeRcJiw9DFSsc4aUkemV4n3rpmIF1A6AC612/6+b9jQ5TyhxMs9H/a
   GI0uxm7dh8Ss7yg01Irv/zeLD0fNqIGvpmPV82iPgd2yJxTWbsEqAbmu9
   6Bzj0H9JOFoJKNV0xwta8lGPX5suFUFZgVrrnMSwgNpIJBoA1hYRVx4rG
   g==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="151755680"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 06:59:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 06:59:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 06:59:10 -0700
Date:   Fri, 12 May 2023 14:58:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 4/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230512-spouse-pang-87f2e579baa2@wendy>
References: <20230511141211.2418-1-jszhang@kernel.org>
 <20230511141211.2418-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aCJ58t5/KMUTtFbc"
Content-Disposition: inline
In-Reply-To: <20230511141211.2418-5-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--aCJ58t5/KMUTtFbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 10:12:11PM +0800, Jisheng Zhang wrote:

> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.=
lds.S
> index e5f9f4677bbf..492dd4b8f3d6 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -85,11 +85,11 @@ SECTIONS
>  	INIT_DATA_SECTION(16)
> =20
>  	.init.pi : {
> -		*(.init.pi*)
> +		KEEP(*(.init.pi*))
>  	}

This section no longer exists in v6.4-rc1, it is now:
	/* Those sections result from the compilation of kernel/pi/string.c */
	.init.pidata : {
		*(.init.srodata.cst8*)
		*(.init__bug_table*)
		*(.init.sdata*)
	}

Cheers,
Conor.

--aCJ58t5/KMUTtFbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF5GGQAKCRB4tDGHoIJi
0qYyAQCRMo5iM+rBTlmU5brSvMFm+H9q1MMggt56ESxJdUM5owEA1Rux0WE9Ky3q
wRiS5v6F7DGyWjBZXjvhP+7kcWDqfQM=
=O/cE
-----END PGP SIGNATURE-----

--aCJ58t5/KMUTtFbc--
