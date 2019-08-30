Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59662A3CF2
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3RYb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 13:24:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:35906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfH3RYa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 13:24:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DC6FAEAE;
        Fri, 30 Aug 2019 17:24:28 +0000 (UTC)
Message-ID: <bdeda2206b751a1c6a8d2e0732186792282633c6.camel@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        will@kernel.org, m.szyprowski@samsung.com,
        linux-arch@vger.kernel.org, f.fainelli@gmail.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
        mbrugger@suse.com, eric@anholt.net, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, wahrenst@gmx.net,
        akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
Date:   Fri, 30 Aug 2019 19:24:25 +0200
In-Reply-To: <20190830144536.GJ36992@arrakis.emea.arm.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
         <20190820145821.27214-2-nsaenzjulienne@suse.de>
         <20190826070939.GD11331@lst.de>
         <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
         <20190830144536.GJ36992@arrakis.emea.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VseoIlC7OSxnfDPpE7cN"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-VseoIlC7OSxnfDPpE7cN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-30 at 15:45 +0100, Catalin Marinas wrote:
> On Mon, Aug 26, 2019 at 03:46:52PM +0200, Nicolas Saenz Julienne wrote:
> > On Mon, 2019-08-26 at 09:09 +0200, Christoph Hellwig wrote:
> > > On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > Some architectures have platform specific DMA addressing limitation=
s.
> > > > This will allow for hardware description code to provide the constr=
aints
> > > > in a generic manner, so as for arch code to properly setup it's mem=
ory
> > > > zones and DMA mask.
> > >=20
> > > I know this just spreads the arm code, but I still kinda hate it.
> >=20
> > Rob's main concern was finding a way to pass the constraint from HW
> > definition
> > to arch without widening fdt's architecture specific function surface. =
I'd
> > say
> > it's fair to argue that having a generic mechanism makes sense as it'll=
 now
> > traverse multiple archs and subsystems.
> >=20
> > I get adding globals like this is not very appealing, yet I went with i=
t as
> > it
> > was the easier to integrate with arm's code. Any alternative suggestion=
s?
>=20
> In some discussion with Robin, since it's just RPi4 that we are aware of
> having such requirement on arm64, he suggested that we have a permanent
> ZONE_DMA on arm64 with a default size of 1GB. It should cover all arm64
> SoCs we know of without breaking the single Image binary. The arch/arm
> can use its current mach-* support.
>=20
> I may like this more than the proposed early_init_dt_get_dma_zone_size()
> here which checks for specific SoCs (my preferred way was to build the
> mask from all buses described in DT but I hadn't realised the
> complications).

Hi Catalin, thanks for giving it a thought.

I'll be happy to implement it that way. I agree it's a good compromise.

@Christoph, do you still want the patch where I create 'zone_dma_bits'? Wit=
h a
hardcoded ZONE_DMA it's not absolutely necessary. Though I remember you sai=
d it
was a first step towards being able to initialize dma-direct's min_mask in
meminit.

Regards,
Nicolas


--=-VseoIlC7OSxnfDPpE7cN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1pW8kACgkQlfZmHno8
x/4ltggAgcfG1puKlA5IJJrCySlntixj950TwNq7qMwwKwzxVCTojg/6HtjhOmlp
IRbqq36DEjcQ12ulD0rqU84gMIP6jryt4iVDDutg18liBPSH3eekj9Wf22J+Vq7f
5yw3zuYyCkrTcgWufsIwn4kbH0GRXCCLV8kwfKFRtXE5dtcWTRbOeNPpmh4HxIJW
z0SkTnBc03CvX0VamQYNZ45QvBFVntqKMCExrvinZyOBUs4+/nd68IXfBU+rj9qb
IBbZaZspKLp1NdVxSo/Tmamv2NVTodxnue9KbFzQe8r3n1bak/9VJKO4z3u0R6AK
6x6oAxLccyXIktLiudLXEMdXMar2vw==
=LsVM
-----END PGP SIGNATURE-----

--=-VseoIlC7OSxnfDPpE7cN--

