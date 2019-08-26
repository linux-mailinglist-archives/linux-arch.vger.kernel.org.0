Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243E59D0F7
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfHZNq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 09:46:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:44324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728550AbfHZNq7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 09:46:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C2D6B038;
        Mon, 26 Aug 2019 13:46:57 +0000 (UTC)
Message-ID: <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     catalin.marinas@arm.com, eric@anholt.net,
        linux-riscv@lists.infradead.org, frowand.list@gmail.com,
        m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
        f.fainelli@gmail.com, will@kernel.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
        mbrugger@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        wahrenst@gmx.net, akpm@linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Date:   Mon, 26 Aug 2019 15:46:52 +0200
In-Reply-To: <20190826070939.GD11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
         <20190820145821.27214-2-nsaenzjulienne@suse.de>
         <20190826070939.GD11331@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rvg1En4pB30QD7Cei8XS"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-rvg1En4pB30QD7Cei8XS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-26 at 09:09 +0200, Christoph Hellwig wrote:
> On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrote:
> > Some architectures have platform specific DMA addressing limitations.
> > This will allow for hardware description code to provide the constraint=
s
> > in a generic manner, so as for arch code to properly setup it's memory
> > zones and DMA mask.
>=20
> I know this just spreads the arm code, but I still kinda hate it.

Rob's main concern was finding a way to pass the constraint from HW definit=
ion
to arch without widening fdt's architecture specific function surface. I'd =
say
it's fair to argue that having a generic mechanism makes sense as it'll now
traverse multiple archs and subsystems.

I get adding globals like this is not very appealing, yet I went with it as=
 it
was the easier to integrate with arm's code. Any alternative suggestions?

> MAX_DMA_ADDRESS is such an oddly defined concepts.  We have the mm
> code that uses it to start allocating after the dma zones, but
> I think that would better be done using a function returning
> 1 << max(zone_dma_bits, 32) or so.  Then we have about a handful
> of drivers using it that all seem rather bogus, and one of which
> I think are usable on arm64.

Is it safe to assume DMA limitations will always be a power of 2? I ask as =
RPi4
kinda isn't: ZONE_DMA is 0x3c000000 bytes big, I'm approximating the zone m=
ask
to 30 as [0x3c000000 0x3fffffff] isn't defined as memory so it's unlikely t=
hat
we=C2=B4ll encounter buffers there. But I don't know how it could affect mm
initialization code.

This also rules out 'zone_dma_bits' as a mechanism to pass ZONE_DMA's size =
from
HW definition code to arch's.


--=-rvg1En4pB30QD7Cei8XS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1j4swACgkQlfZmHno8
x/7+5Qf/RG+HHfwkIbvgTeNBR6PGQMv7ZNDSxgeVo0caYiQnN2w01vHWnEXBnsNK
sj6p2ip+d5CQbSOMO2oVO7qS4+BoOjcdnFTNSLH0uN5coZj6sr8u5N/FFdeb2cI+
6B9opO7apUCnnuwaBeV5Ocepk1gr4rNoRnrOWmFwnqoc9dBRBuKV4ejcEB43ySw6
wxwOswOu17wPR3o6969vTlP29cTItzXnrjmlTn+lKyQpR6pOzC0IpU1tmO0KkfHM
+U0Kypzbtb5Z9uCWvbS42mvT9oV3/El8iqrw1mPxbwRDgwDsBf2awc+fNmnQTsRK
4pDSxPGJ5wST3O0WUjysQ9u+RJC+Cg==
=y9Dx
-----END PGP SIGNATURE-----

--=-rvg1En4pB30QD7Cei8XS--

