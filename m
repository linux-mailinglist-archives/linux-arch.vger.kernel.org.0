Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDC750F80
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGLRT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLRTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 13:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FA619A6;
        Wed, 12 Jul 2023 10:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1E16184B;
        Wed, 12 Jul 2023 17:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35553C433C8;
        Wed, 12 Jul 2023 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689182393;
        bh=NxFeXC6CtmYi99+d4gGQB6D+Bb2HkPUKwYRt2ccCYQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWosN/cG07XL+NBD9hRPcvNHuIa9Z2RkyHTjLz/YHDehnzNvz/z3P3BBJt1aWu8n9
         BP0okhPpaLzPAmlmVWRMwYiNtgXpr+sTdyWCGWQBDK894nKN78fRU0MKF21RlV8GRj
         pcXfRiAJ7VN384hIbC1zcAzEBCw6CrzoTmaYzC6FGtJ/vzN9C4O299sGNkc1QsRDF5
         lixMCTjInOfxqhtWN/qvydwb2M0Em8xu/MQx+5u9gjQ/iCsRotbfXVSs0qc0bJoFGB
         u2EgewEB3jkW2GO/GZXNfdcXZHnnTkkiQmTQAaNdKq8tweJBxNZ8wjbd2M+I6ZixYa
         fJhWwdVICoeSA==
Date:   Wed, 12 Jul 2023 18:19:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] riscv: tlb flush improvements
Message-ID: <20230712-frying-unaired-e3acb5150e8b@spud>
References: <20230711075434.10936-1-alexghiti@rivosinc.com>
 <20230712-void-sniff-ca1abcbc7783@wendy>
 <bbda29db-644d-ed9b-2894-43f4c2addb52@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DukaoZmy8ISySIVX"
Content-Disposition: inline
In-Reply-To: <bbda29db-644d-ed9b-2894-43f4c2addb52@ghiti.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--DukaoZmy8ISySIVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 05:18:00PM +0200, Alexandre Ghiti wrote:
> On 12/07/2023 09:08, Conor Dooley wrote:
> > On Tue, Jul 11, 2023 at 09:54:30AM +0200, Alexandre Ghiti wrote:
> > > This series optimizes the tlb flushes on riscv which used to simply
> > > flush the whole tlb whatever the size of the range to flush or the si=
ze
> > > of the stride.
> > >=20
> > > Patch 3 introduces a threshold that is microarchitecture specific and
> > > will very likely be modified by vendors, not sure though which mechan=
ism
> > > we'll use to do that (dt? alternatives? vendor initialization code?).
>=20
>=20
> @Conor any idea how to achieve this?

It's in my queue of things to look at, just been prioritising the
extension related stuff the last few days. Hopefully I'll have a chance
to think about this tomorrow.. Famous last words probably.

> > > Next steps would be to implement:
> > > - svinval extension as Mayuresh did here [1]
> > > - BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
> > > - MMU_GATHER_RCU_TABLE_FREE
> > > - MMU_GATHER_MERGE_VMAS
> > >=20
> > > Any other idea welcome.
> > >=20
> > > [1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchi=
tale@ventanamicro.com/
> > >=20
> > > Alexandre Ghiti (4):
> > >    riscv: Improve flush_tlb()
> > >    riscv: Improve flush_tlb_range() for hugetlb pages
> > >    riscv: Make __flush_tlb_range() loop over pte instead of flushing =
the
> > >      whole tlb
> > The whole series does not build on nommu & this one adds a build warning
> > for regular builds:
> > +      1 ../arch/riscv/mm/tlbflush.c:32:15: warning: symbol 'tlb_flush_=
all_threshold' was not declared. Should it be static?
> >=20
> > Cheers,
> > Conor.
>=20
>=20
> I'll fix the nommu build, sorry about that. Weird I missed this warning,
> that's an LLVM build right? That variable will need to overwritten by the
> vendors, so that should not be static (but it will depend on what solution
> we implement).

Just make it static until we actually have a vendor implementation of
this stuff please, since we don't know what that will look like yet.

--DukaoZmy8ISySIVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7gswAKCRB4tDGHoIJi
0sARAP9L9TJFvX4OL1Vu0rUL3dlGaM7MfIeHb3RG1JQ34iSI7QEAo13IMSfJ0aYS
1YYxInR3X7k1leS1v4O0IaTHUsMX5Ak=
=ebMg
-----END PGP SIGNATURE-----

--DukaoZmy8ISySIVX--
