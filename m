Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4116E9CDBD
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfHZLI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 07:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:58332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730553AbfHZLI5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 07:08:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9BAEAF23;
        Mon, 26 Aug 2019 11:08:55 +0000 (UTC)
Message-ID: <4d8d18af22d6dcd122bc9b4d9c2bd49e8443c746.camel@suse.de>
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
 dma-direct min mask
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     catalin.marinas@arm.com, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, phill@raspberryi.org,
        f.fainelli@gmail.com, will@kernel.org, eric@anholt.net,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        akpm@linux-foundation.org, frowand.list@gmail.com,
        m.szyprowski@samsung.com
Date:   Mon, 26 Aug 2019 13:08:50 +0200
In-Reply-To: <20190826070633.GB11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
         <20190820145821.27214-11-nsaenzjulienne@suse.de>
         <20190826070633.GB11331@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RvTUUUche1DA67AZeVhb"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-RvTUUUche1DA67AZeVhb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-26 at 09:06 +0200, Christoph Hellwig wrote:
> On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:
> > -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> >  		arm64_dma_phys_limit =3D max_zone_dma_phys();
> > +		zone_dma_bits =3D ilog2((arm64_dma_phys_limit - 1) &
> > GENMASK_ULL(31, 0)) + 1;
>
Hi Christoph,
thanks for the rewiews.

> This adds a way too long line.

I know, I couldn't find a way to split the operation without making it even
harder to read. I'll find a solution.

> I also find the use of GENMASK_ULL
> horribly obsfucating, but I know that opinion is't shared by everyone.

Don't have any preference so I'll happily change it. Any suggestions? Using=
 the
explicit 0xffffffffULL seems hard to read, how about SZ_4GB - 1?


--=-RvTUUUche1DA67AZeVhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1jvcIACgkQlfZmHno8
x/6y/wf/XTe7dlASMoYApyVt+lL6chBcap2r7MVKOVhCbC1oJQb7UdRyW7MVDO6k
gwdo2WmXqD3wUwhY5djX0adczLOJye1iGEdrrQfheRqm1rh07um3quT3TzgCSPat
OuX+vHuNsUE+3GyI+0OoOF0tu/TzOKJjgs4H645cnbuCaXbQFbL94yBctsDTF5hc
m4Bx+nksz99ddodUnw9CF4Ss5DPwkX23I3h7okwMMjvVuegIPUa9edppw3Za0Kby
k8b9QGCiMsGcwyq3+uSXTCq4iIU8reLTfvpZmVZ9QugMn8TkjjIQFyWS0HrXt2pz
r9iNomMe9w20W9Y9jS5Aj8bxByoK+Q==
=nQ/V
-----END PGP SIGNATURE-----

--=-RvTUUUche1DA67AZeVhb--

