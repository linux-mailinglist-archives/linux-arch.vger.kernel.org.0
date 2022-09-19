Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC75BD42F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiISRyT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiISRyJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 13:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582741D1F;
        Mon, 19 Sep 2022 10:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7135861374;
        Mon, 19 Sep 2022 17:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D90C433B5;
        Mon, 19 Sep 2022 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663610046;
        bh=DvqH3q9Hr6/f/KVvc2EIOZwfO4WOQSZ2uFVd/i3sVIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiM4TJBYjwNtLa3BGc3b5nz+cARE0VfszK+QMOLU7mU5ZOCKKRLumi8MwjSWboFxz
         aUR4m4kkt3Mke56WHFBrNId/v48N16/7C+ZzGMSx6SZqruLk8ys7bgoty65XUXwB/0
         pszSPdR1tlwbr5OMLdR1Gb5sb+S7GGKi2JLmOTClbUtZLtL2J2K6WHaGHJTABa5bLC
         rbuJZVkEbfg78opUAhsTctJF4QtnDk3K8YgOJ1JDj88TX6GJZnAuCcnc3OhsWiI+vm
         SkbAMsz7551d4Wfosg/TTr79AoO2whrM+ObrLYispjDJYIVUCVugLxHannI3r8ENAR
         PvoIJL65GRTkw==
Date:   Mon, 19 Sep 2022 18:54:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] Discard .note.gnu.property sections in generic NOTES
Message-ID: <YyisuQk74ux7sC3z@sirena.org.uk>
References: <20200428132105.170886-1-hjl.tools@gmail.com>
 <20200428132105.170886-2-hjl.tools@gmail.com>
 <YyTRM3/9Mm+b+M8N@relinquished.localdomain>
 <e15de60c-8133-3d93-eb1c-c6b1b5389887@csgroup.eu>
 <YyimOW229By98Dn7@relinquished.localdomain>
 <Yyin1FUU7enibeD8@sirena.org.uk>
 <YyiplGhX65Hrkkjw@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EqpzY94vBNwCHWF8"
Content-Disposition: inline
In-Reply-To: <YyiplGhX65Hrkkjw@relinquished.localdomain>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--EqpzY94vBNwCHWF8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2022 at 10:40:36AM -0700, Omar Sandoval wrote:
> On Mon, Sep 19, 2022 at 06:33:40PM +0100, Mark Brown wrote:

> > I don't understand the question, what file are you talking about
> > here?  arch/arm64/include/asm/assembler.h is itself a file and I
> > couldn't find anything nearby in your mail talking about a file...

> Oops, that was a typo, I meant to say "I'm not sure what
> arch/arm64/include/asm/assembler.h is doing with this *note*". To be
> more explicit: does ARM64 need .note.gnu.property/NT_GNU_PROPERTY_TYPE_0
> in vmlinux?

It needs it in at least the vDSO which gets built into vmlinux.
AFAIR we don't use it in normal kernel code.

--EqpzY94vBNwCHWF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMorLgACgkQJNaLcl1U
h9AeAgf+I7vqneefeeQjYjLayNpW3jVr/pFAMKL+V3w+IQjePpTxH3p5lo7JLQYT
FR275uZQdE1cistY2WtHAYQxxJw0jT4VHO5Jte2Ajb6vWv3ouJQWmv1ZVBCqxS2Q
05+Z9v3toO2yg7nPlqme8NAX52VEXzjDtijaRaU7PY5NsxYXluHjkxq5yuaqoMMF
m3dgZdAvRKewtLt/rB6PFqO0v3nkns6aPZ7S/LLCR4IFkpULco7vxmEXqV3oD4ac
arjQLAGqXfn3sbfSy2rQj8/feG7bKWQlaMRZE9fEkfYL25/bx7F2ipfCH2b/9tbF
9kDEpdrUjKqorXGvblX5Ae+pjiXubw==
=fNrU
-----END PGP SIGNATURE-----

--EqpzY94vBNwCHWF8--
