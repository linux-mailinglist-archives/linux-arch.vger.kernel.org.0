Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C758E654935
	for <lists+linux-arch@lfdr.de>; Fri, 23 Dec 2022 00:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLVXVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Dec 2022 18:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLVXVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Dec 2022 18:21:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D46275;
        Thu, 22 Dec 2022 15:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7070ACE1B8A;
        Thu, 22 Dec 2022 23:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F5C433EF;
        Thu, 22 Dec 2022 23:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671751271;
        bh=l6dL2vDSNcL7oYRW+amc2+4KyYkOXC0ok5zluOYGF/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us100g1wlq6MRpiTXSukcbxWLPU4glMHHxSIsSW5tmgjbU5PUCDDOe7gHmx/riPRo
         11b3JkF/y8fctAVaiDwp48R6YryN86LM3/dakavL6IHhvpaHZQ0b4swv3BOAPr7fvo
         7F+XEEOQFfqZ2QpYVHMkmqSc1cErCWHyB4UGkE5m/op+cMqNmcVhZYSzv9KlAg0M2O
         XDLnfVxGNGLh9i5rSzyJ9JBmA00ooCGEmKLQ00O+dQgtPcDuA2W+m6+U1PEex4dmgK
         G6dpmmNRPupLBgat3Kg2p733GRAlD3B1K0WJrUrAd7FiVb+INZ43xBbz9SbGeAW23k
         6cl5O38+Fl5dg==
Date:   Thu, 22 Dec 2022 23:21:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <Y6TmYjr07W9WJEPn@spud>
References: <20221213060204.27286-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9ftFqcji9/MYD4OZ"
Content-Disposition: inline
In-Reply-To: <20221213060204.27286-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--9ftFqcji9/MYD4OZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 07:02:04AM +0100, Alexandre Ghiti wrote:
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
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>=20
> v3:
> - Change the comment about initrd_start VA conversion so that it fits
>   ARM64 and RISCV64 (and others in the future if needed), as suggested
>   by Rob
>=20
> v2:
> - Add a comment on why RISCV64 does not need to set initrd_start/end that
>   early in the boot process, as asked by Rob
>=20
> Note that this patch is rebased on top of:
> [PATCH v1 1/1] riscv: mm: call best_map_size many times during linear-map=
ping

Hey Alex, unfortunately I could not get this to apply either (I tried a
riscv/for-next & Linus' tree).
The above patch should be in both, so idk:
git am -3 v3_20221213_alexghiti_riscv_use_pud_p4d_pgd_pages_for_the_linear_=
mapping.mbx
Applying: riscv: Use PUD/P4D/PGD pages for the linear mapping
error: sha1 information is lacking or useless (arch/riscv/mm/init.c).
error: could not build fake ancestor
Patch failed at 0001 riscv: Use PUD/P4D/PGD pages for the linear mapping

I assume it'll need a rebase after -rc1?

It's really nice to see someone looking at this early code, from the
bit of digging around that I've done chasing bugs it feels like it needs
it- so thanks!


--9ftFqcji9/MYD4OZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6TmYgAKCRB4tDGHoIJi
0izPAP9karoTeNWFNJMv29u3mPiB5aYGZlbcvx9ezsfRYThJLgEAshJH3WY+pdJL
JZ083PbuMpcDpANbhziGKxUSbknqmQ8=
=Khpa
-----END PGP SIGNATURE-----

--9ftFqcji9/MYD4OZ--
