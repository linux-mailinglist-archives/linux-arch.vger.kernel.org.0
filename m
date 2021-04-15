Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217C3615C9
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 01:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhDOXFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhDOXFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 19:05:11 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD2C061574;
        Thu, 15 Apr 2021 16:04:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FLw0C5xDmz9sVv;
        Fri, 16 Apr 2021 09:04:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1618527885;
        bh=ZhL6BpAiTk9FcT+T5DgCqZyNjJQV/rrieoSAtVXb50k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgtjymfRlfy1wmujSuDaVsubNDGDI5cH8Ky3frmMzce1GQ5CKbJkNiSIznaOEpZO4
         vfEk//aaBOnBej919i4EXHnvy7FrEC2yVTdagClMBE4tiLT5Emib4z76kpvl6SZX4s
         DYK5q7kV2Gzt3dgqVCkf161CB2BIpgUvjs+wO7zq/Q7fDzrYAcZLmbAZY32qgDszjJ
         5690y8zA4KpyEnKuQuwNk1PrSkoMWS+M8pv7mMlTGcRV8f8zhml6F9mKtknF7lWwLH
         Oedb+T8o64ZBpog6+Sey6OBFynbC9yywm6vPvZFWA6UGV+UMHYn2jsCLKf7O1qYi4r
         Qv6w4A497We/Q==
Date:   Fri, 16 Apr 2021 09:04:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc
 mappings
Message-ID: <20210416090442.3852817d@canb.auug.org.au>
In-Reply-To: <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
References: <20210317062402.533919-1-npiggin@gmail.com>
        <20210317062402.533919-15-npiggin@gmail.com>
        <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
        <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CoWv8MZ9HFnuCaw0+k+d2WJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/CoWv8MZ9HFnuCaw0+k+d2WJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 15 Apr 2021 11:55:29 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Thu, 15 Apr 2021 12:23:55 +0200 Christophe Leroy <christophe.leroy@csg=
roup.eu> wrote:
> > > +	 * is done. STRICT_MODULE_RWX may require extra work to support this
> > > +	 * too.
> > > +	 */
> > >  =20
> > > -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GF=
P_KERNEL,
> > > -				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, =20
> >=20
> >=20
> > I think you should add the following in <asm/pgtable.h>
> >=20
> > #ifndef MODULES_VADDR
> > #define MODULES_VADDR VMALLOC_START
> > #define MODULES_END VMALLOC_END
> > #endif
> >=20
> > And leave module_alloc() as is (just removing the enclosing #ifdef MODU=
LES_VADDR and adding the=20
> > VM_NO_HUGE_VMAP  flag)
> >=20
> > This would minimise the conflits with the changes I did in powerpc/next=
 reported by Stephen R.
> >  =20
>=20
> I'll drop powerpc-64s-radix-enable-huge-vmalloc-mappings.patch for now,
> make life simpler.

I have dropped that patch from linux-next.
--=20
Cheers,
Stephen Rothwell

--Sig_/CoWv8MZ9HFnuCaw0+k+d2WJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB4xooACgkQAVBC80lX
0GyqrwgAmtxuo7IZ6/S/4r8/v7sJcfEh324RYwwpvHZyWyBU4D0WMZ3u6tLaT08i
8909zACOYf6M/4cLPDrztpz6xfeM1mGyPNhjB/0aplDRtKW5KSQ2a51Q3YBbkK84
rlb8vDTWM0o2a6hffjkcx+0jgEA9QjwXcZ9hzQ1pAu27d7tzix6FjJrcU6/Hx3hS
j/v5q26pEdh7NDF/Fwke1K5dZqucYA7sf4mW2H3/49eD0FOryNLR29URiqjZKJuq
uvDep2QoGIFIzlZxgAmJqphMrVZB/QNmTeyf62QWLCWP/bZUJA+ZBwN+CfZ6V/hG
3DnNR1inpWry4OGBBtKmNzLCfRZluA==
=/HhO
-----END PGP SIGNATURE-----

--Sig_/CoWv8MZ9HFnuCaw0+k+d2WJ--
