Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41AB678A70
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 23:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjAWWLs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 17:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjAWWLo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 17:11:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D58938E9A;
        Mon, 23 Jan 2023 14:11:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD4D2CE1784;
        Mon, 23 Jan 2023 22:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4EC433D2;
        Mon, 23 Jan 2023 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674511864;
        bh=B2Hun8fx94ummgXxtdvJvI9tjawF7V9UEMWQUtT0mcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcgdVb7N420MXjiaT3Cy4xcVCA8Z39ghV+wDLAJdklaXRi0qcZdUgMyp5Bz27Eo6K
         0Q7zvjVefDXPlafRBzutpafZFdPkAaa8GAp0dSiHQnOgVdJ4M7RSlkk7S5PZaDozLV
         Zm+Jsb+LanQD1pEa/jGiIrWQINaF9LtUsGPmEN51MNTC8nM5F8Bn0Puj7Zgy8DKghN
         6Z3okEYMedCreg8+2+l/5bGCJeOMYsA23VZzG37W9ep4OaJx96i+yYienRaLUP4aEK
         3WbTlYFge3XFCEnj9ncyN4wPRE1UH++foFM7s5dpzFG0AMRf/p9UUz7SbvljzlLvAg
         qMbc/WPWrLj4Q==
Date:   Mon, 23 Jan 2023 22:10:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <Y88F808GULoKFOVJ@spud>
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AjN4nqWVveMYgtD1"
Content-Disposition: inline
In-Reply-To: <20230123112803.817534-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--AjN4nqWVveMYgtD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 12:28:02PM +0100, Alexandre Ghiti wrote:
> During the early page table creation, we used to set the mapping for
> PAGE_OFFSET to the kernel load address: but the kernel load address is
> always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> PAGE_OFFSET is).
>=20
> But actually we don't have to establish this mapping (ie set va_pa_offset)
> that early in the boot process because:
>=20
> - first, setup_vm installs a temporary kernel mapping and among other
>   things, discovers the system memory,
> - then, setup_vm_final creates the final kernel mapping and takes
>   advantage of the discovered system memory to create the linear
>   mapping.
>=20
> During the first phase, we don't know the start of the system memory and
> then until the second phase is finished, we can't use the linear mapping =
at
> all and phys_to_virt/virt_to_phys translations must not be used because it
> would result in a different translation from the 'real' one once the final
> mapping is installed.
>=20
> So here we simply delay the initialization of va_pa_offset to after the
> system memory discovery. But to make sure noone uses the linear mapping
> before, we add some guard in the DEBUG_VIRTUAL config.
>=20
> Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> in a better TLB utilization.
>=20
> Note that we rely on the firmware to protect itself using PMP.
>=20
> Acked-by: Rob Herring <robh@kernel.org> # DT bits
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

No good on !MMU unfortunately Alex:
=2E./arch/riscv/mm/init.c:222:2: error: use of undeclared identifier 'riscv=
_pfn_base'
        riscv_pfn_base =3D PFN_DOWN(phys_ram_base);
        ^

Reproduces with nommu_virt_defconfig.

Thanks,
Conor.

--AjN4nqWVveMYgtD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY88F8gAKCRB4tDGHoIJi
0sk5AP9e/+SB3pTIKzfQPMgtXZkuV5QgIeCGqK1UjjQhd6QjXAD+KMMwHzheEBnp
V9mWrQAFGU8u6vVcNVc9I1zxH4pt8gg=
=XTYk
-----END PGP SIGNATURE-----

--AjN4nqWVveMYgtD1--
