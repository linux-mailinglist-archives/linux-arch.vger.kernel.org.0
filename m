Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4D70097D
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjELNwU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbjELNwT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 09:52:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE56E4B;
        Fri, 12 May 2023 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683899538; x=1715435538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxliiXbCw/BWsrfyQfSnn4cwbh6x+dsWlLN0pMI+WF8=;
  b=kt2KvS6usyQZOXd6c6p4od9ETbjGdZN5eeP6JEKZYOe1vyLK1qh4L4b8
   f/Yi5cxuDTMD0nucu45DZ5lioH4FZTCiv+zQIxv8KmDkYI85wHh4ds0iJ
   TkP6yFEQb07s4/5SP1Aeis80anqcmPXhMza/xocDgujsLE1WSK6LYkv/e
   4PNbdHqHEyanJq8GXqdvWeWUQDevK8/msBh1MrNJdgI2gsHyBXHm3hw2T
   P+cdVovSaziCvFNLT/IRVmci+ImUz9gzZGV665d1E6MAaJ5VCfaKoEl8/
   nBZ0KbJ6YbvvCecM3vZztnQhynTGg/NfAuKJpJN9N7ffdjeyNtLIl2cxi
   w==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="215095542"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 06:52:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 06:52:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 06:52:16 -0700
Date:   Fri, 12 May 2023 14:51:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/4] riscv: vmlinux-xip.lds.S: remove .alternative section
Message-ID: <20230512-lunar-overbook-e34b468dda65@wendy>
References: <20230511141211.2418-1-jszhang@kernel.org>
 <20230511141211.2418-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KkOtcrj+AD9/k7Ew"
Content-Disposition: inline
In-Reply-To: <20230511141211.2418-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--KkOtcrj+AD9/k7Ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 10:12:08PM +0800, Jisheng Zhang wrote:
> ALTERNATIVE mechanism can't work on XIP, and this is also reflected by
> below Kconfig dependency:
>=20
> RISCV_ALTERNATIVE
> 	...
> 	depends on !XIP_KERNEL
> 	...
>=20
> So there's no .alternative section at all for XIP case, remove it.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Just to note, this series doesn't apply on top of -rc1 - what is the
base that you used?

Cheers,
Conor.

> ---
>  arch/riscv/kernel/vmlinux-xip.lds.S | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmli=
nux-xip.lds.S
> index eab9edc3b631..50767647fbc6 100644
> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -98,12 +98,6 @@ SECTIONS
>  		__soc_builtin_dtb_table_end =3D .;
>  	}
> =20
> -	. =3D ALIGN(8);
> -	.alternative : {
> -		__alt_start =3D .;
> -		*(.alternative)
> -		__alt_end =3D .;
> -	}
>  	__init_end =3D .;
> =20
>  	. =3D ALIGN(16);
> --=20
> 2.40.1
>=20

--KkOtcrj+AD9/k7Ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF5EewAKCRB4tDGHoIJi
0qKNAP9aitzYq7AlSofj+QbNcfXCXhkwYqHc/PfL9wm6T+7L/AEAxM1sVUTR6Q5X
ZQQVS36s/TbfTTqMRH5b95PAfeWIzQo=
=W6hv
-----END PGP SIGNATURE-----

--KkOtcrj+AD9/k7Ew--
