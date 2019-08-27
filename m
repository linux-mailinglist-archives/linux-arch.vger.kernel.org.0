Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5759DE5A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfH0HDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 03:03:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfH0HDr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 03:03:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3D93B0DA;
        Tue, 27 Aug 2019 07:03:45 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:03:41 +0200
From:   Petr Tesarik <ptesarik@suse.cz>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        f.fainelli@gmail.com, will@kernel.org, eric@anholt.net,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, wahrenst@gmx.net, mbrugger@suse.com,
        linux-riscv@lists.infradead.org, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, phill@raspberryi.org
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
 dma-direct min mask
Message-ID: <20190827090341.2bf6b336@ezekiel.suse.cz>
In-Reply-To: <4d8d18af22d6dcd122bc9b4d9c2bd49e8443c746.camel@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
        <20190820145821.27214-11-nsaenzjulienne@suse.de>
        <20190826070633.GB11331@lst.de>
        <4d8d18af22d6dcd122bc9b4d9c2bd49e8443c746.camel@suse.de>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vmjhQR+jY/bQH=VqrrKvOyt"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/vmjhQR+jY/bQH=VqrrKvOyt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Aug 2019 13:08:50 +0200
Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:

> On Mon, 2019-08-26 at 09:06 +0200, Christoph Hellwig wrote:
> > On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:=
 =20
> > > -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > > +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> > >  		arm64_dma_phys_limit =3D max_zone_dma_phys();
> > > +		zone_dma_bits =3D ilog2((arm64_dma_phys_limit - 1) &
> > > GENMASK_ULL(31, 0)) + 1; =20
> > =20
> Hi Christoph,
> thanks for the rewiews.
>=20
> > This adds a way too long line. =20
>=20
> I know, I couldn't find a way to split the operation without making it ev=
en
> harder to read. I'll find a solution.

If all else fails, move the code to an inline function and call it e.g.
phys_limit_to_dma_bits().

Just my two cents,
Petr T

--Sig_/vmjhQR+jY/bQH=VqrrKvOyt
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl1k1c0ACgkQqlA7ya4P
R6ffZggAphWovRbYbJElIMDB+201+43NCpSH8dbZwe3UrJ+1DHzEn4OEldBRpcAv
CuA2/u6GyA8wgnGpCAKj9HNHWSx9VeFoCmf6kPVHFtoC0hnJyJtCCWS1O9B1nqXR
3h1Dw+6F/4wh14vqUucVvfseO/T1VV1QtfsczxBy2xEvcTZGhBjo7LEKeABa2yRm
CoPLGyNtTtNkAhXeSeVJUcuquOjdqrcU+RlCH5EIZZagAvXuNLryEsjjUfD4Lx35
RBeRcO+KmGJvAYuelWr/lqtO5ZUnD4OXoFE6fV7AvvJCD6RIHngLS4EXDIkGAaqd
kWlLtSieXZDEl0mMBdQBfSVcByyzKA==
=RDo8
-----END PGP SIGNATURE-----

--Sig_/vmjhQR+jY/bQH=VqrrKvOyt--
