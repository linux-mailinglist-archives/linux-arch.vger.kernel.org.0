Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD687DE087
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbjKALu5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 07:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKALuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 07:50:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA912109;
        Wed,  1 Nov 2023 04:50:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA00C433C9;
        Wed,  1 Nov 2023 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698839451;
        bh=mF6eg4XvSECsF2HMgNiQoGzvU7I5nf27Gh38oBPoW8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=misf2IeNRgfcUPjvk9oQ48jbkYilldGVOKEo78NWgtyyiJKFDZX40Xwemwf/fBhsx
         s2POZN2NGNfhrFnuf0liu77A/wyhqOUqQdwRs7/TeE998W8lfLrk2mb1idYIWZLR5V
         bFqIamEMC9t+Ys+bamXQFdX03YBbtI4lXscLwfqaEJORAYa2wl4RgMmFVlnP+I3xeu
         sZETzyTkmDMKSOCO7S4JCz205KrJaOvxSlXLeZKvWk71LUVs9jisMPiEARQjfKRwfV
         kDOeRUW/Dd5lHMQrLEIdMdhrouhvMT+xg2ywZQb3YFddMiSdMYHZGcjQLLmMhoei7Y
         RaSvd6gry7SCg==
Date:   Wed, 1 Nov 2023 11:50:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/5] riscv: Add fine-tuned checksum functions
Message-ID: <20231101-palace-tightly-97a1d35a4597@spud>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LjqsyqiDGC45356u"
Content-Disposition: inline
In-Reply-To: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--LjqsyqiDGC45356u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 05:18:50PM -0700, Charlie Jenkins wrote:
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

I coulda sworn I reported build issues against the v8 of this series
that are still present in this v9. For example:
https://patchwork.kernel.org/project/linux-riscv/patch/20231031-optimize_ch=
ecksum-v9-3-ea018e69b229@rivosinc.com/

Cheers,
Conor.

--LjqsyqiDGC45356u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUI7lgAKCRB4tDGHoIJi
0h2sAP0RKjRG5Rpub/HvLIazZUE6vW1OEyWKng47PNLxPT1sUgD/Xz1kJ0si+e+m
myJ1M13eciVOu5bFSEGmDXc/0JMsxgY=
=1Fkh
-----END PGP SIGNATURE-----

--LjqsyqiDGC45356u--
