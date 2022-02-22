Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DBC4BFAB3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiBVOPt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 09:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiBVOPr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 09:15:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FEC160420
        for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2022 06:15:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F33ACB81754
        for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2022 14:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D010CC340F3;
        Tue, 22 Feb 2022 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645539319;
        bh=sHHdLDoYjS+X7SW4eOp5R6pJ+pWe3Bi0v0TDpRLQLgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLR4fTZohlsw+zWq2LZmwmGbtaX1Zyj5BS0NzD1b8y6K48Xw5h1+16V3ZBJ9tc0AT
         ovkZAFwc6zp6+myxYDQP0e3dG+8CysPM08zGZjqflPeEbQDN7RL9pkPcJ34+HPT+8R
         sF+Vl4BW9zqgViRvSSfgJuLaqWYnebrHvstApXps7V1hf5Znv742fOBozvyw6mIPjl
         HNuJc94sg/gzwlbV2Gfd22vN+9kxIOu/5bPmyIBmt4ycWTQbMVK7p4xreGEUN65aXw
         eBq1CHbiVKePAeglUNpuenRRlUCuwQMzBRInqf3zmr4v4oQz7RcOKxZP6GKCCIJIjX
         5xoI265lq5wHg==
Date:   Tue, 22 Feb 2022 14:15:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YhTv8p5JVPjqW8nE@sirena.org.uk>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njsqzvVrJx5rdbfb"
Content-Disposition: inline
In-Reply-To: <Ygz9YX3jBY0MpepU@arm.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--njsqzvVrJx5rdbfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 16, 2022 at 01:34:25PM +0000, Catalin Marinas wrote:
> On Tue, Feb 15, 2022 at 06:34:56PM +0000, Will Deacon wrote:

> > This appears to be a user-visible change which cannot be detected or
> > disabled from userspace. If there is code out there which does not work
> > when BTI is enabled, won't that now explode when the kernel enables it?
> > How are we supposed to handle such a regression?

> If this ever happens, the only workaround is to disable BTI on the
> kernel command line. If we need a knob closer to user, we could add a
> sysctl option (as we did for the tagged address ABI, though I doubt
> people are even aware that exists). The dynamic loader doesn't do
> anything smart when deciding to map objects with PROT_BTI (like env
> variables), it simply relies on the ELF information.

The dynamic loader is the place where I'd expect to do any
per-executable workarounds, but currently that's not actually
implemented anywhere.  Someone could also make a tool to strip BTI
annotations from executables.

> I think the only difference would be with a BTI-unware dynamic loader
> (e.g. older distro). Here the main executable, if compiled with BTI,
> would be mapped as executable while the rest of the libraries are
> non-BTI. The interworking should be fine but we can't test everything
> since such BTI binaries would not normally be part of the distro.

> If there are dodgy libraries out there that do tricks and branch into
> the middle of a function in the main executable, they will fail with
> this series but also fail if MDWE is disabled and the dynamic linker is
> BTI-aware. So this hardly counts as a use-case.

I'm not aware of any issues we've run into which are due to interworking
between binaries rather than within a binary due to either miscompilation
or doing something in hand coded assembler that needs updating for BTI.
It doesn't mean it can't happen but it's hard to see what people might
be doing.

> For consistency, I think whoever does the initial mapping should also
> set the correct attributes as we do for static binaries. If you think
> another knob is needed other than the cmdline, I'm fine with it.

Might also be worth pointing out that we already map the vDSO with BTI
enabled if it's built with BTI.

--njsqzvVrJx5rdbfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIU7/IACgkQJNaLcl1U
h9ADUwf+OhJEkXOirLj5jU5NaKV0GWE0p7t4zjt8reYjBA9Ktc2GhfBP08nXjZMq
dgSqPCiB7Rh21Krl9h9CNSa/cVXi5ghIws7pOVXhRRjBHezCiGBx6d16XX8luLt3
leGnBo3sHTv6dfO9YaLhvQp+PrDdTLyeZOp1BZiIuEaqWHBdLguSlxOkK9RmFLA1
X6DQ2e6S/sFj6PAWJRhXveK02eniBs+xB1U1Qne5On43GB9xYKSaKKa75xq8RmVb
isiENMQaeaG8y/YkVZx1txN7/uJ9G74mrpm/SqJcpcbJp98D0i4T4s0nlyoxKV/f
Sgr50KRd4xkx51TlmENNLgdtpmW/cw==
=0wYJ
-----END PGP SIGNATURE-----

--njsqzvVrJx5rdbfb--
