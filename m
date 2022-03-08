Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD484D1728
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 13:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiCHMWL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 07:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiCHMWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 07:22:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14884507F
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 04:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B178B8189F
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 12:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A69FC340EB;
        Tue,  8 Mar 2022 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646742072;
        bh=KTP0EyNkT6c0ZeITjTnlyxXXHObFRSLXNLnpc2z3MgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2FsfIoPcq5/HsoYc8XdL7m5Xwaf4NF/D53HgdT7MQz2eNAtuebxlmsXc3aQaPNBc
         PtcVDTProzaM89ezLSi+4to3EYsHiaqvfhuzApGU0swLNpNTgMYB60j63Qoz2JUR1X
         2Rz8zAhaGjGaXu3AQt1I85lOmDhP82Zg00sBDpBUSEEaduYqGJe/sBGOaxSN5YZHsf
         h7upD2tTT6yYCu1gWXb5lKMhdRE6aNX3XBbCjogkjEbTz6OlWlneDRYnmrg+TtFJru
         Nwuhl+2XpfFqb6mXBmBv86BvG6xt6HNtcsvufisjGuASyhFijlOhjh5tb3NdlOzh3H
         uexWR8KAw3QXA==
Date:   Tue, 8 Mar 2022 12:21:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v10 1/2] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <YidKMHDSifdDcnPL@sirena.org.uk>
References: <20220228130606.1070960-1-broonie@kernel.org>
 <20220228130606.1070960-2-broonie@kernel.org>
 <202203071551.DBABE01@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nspsNZs5QU34na1d"
Content-Disposition: inline
In-Reply-To: <202203071551.DBABE01@keescook>
X-Cookie: Dental health is next to mental health.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--nspsNZs5QU34na1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2022 at 04:00:15PM -0800, Kees Cook wrote:
> On Mon, Feb 28, 2022 at 01:06:05PM +0000, Mark Brown wrote:

> >  static inline int arch_parse_elf_property(u32 type, const void *data,
> >  					  size_t datasz, bool compat,
> > +					  bool has_interp, bool is_interp,
> >  					  struct arch_elf_state *arch)

> Adding more and more args to a functions like this gives me the sense
> that some kind of argument structure is needed.

> Once I get enough unit testing written in here, I'm hoping to refactor
> a bunch of this. To the future! :)

Yes, this code is not lovely.  I'll leave cleanups to future work
though, it seems out of scope here and I'm not sure how good an idea it
is to do too much without more solid testing.

--nspsNZs5QU34na1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmInSi8ACgkQJNaLcl1U
h9C0+Qf/VvMWAajMDoxXD1JjLDqmzUdmWkqhXBT0nF0f5AuhUNhzzD903PbsCtSu
X9WgiMARxaf8Iz1dwGOwAg/FKXZqYTId/6UTFAS93DYjbIYA5QRK0NlMF7KzYBLN
2gNAJZ+1QbAaOA5mpYr+KMdsXjl3b9AIMD3Rkc7BbJGViM3I0BhxMyFrqpu3BqAA
fz5L/NzVa6NghfMPWINXL4SuhuxMtzkqZsupo4uhgGVNcWEHViAk64B0XvVUmBOP
qP3e+1JbnMMlKjk2x3L3YxGLzWOW1laSERyVnnxQXHJPWUpIdHn4ytl8X+2/o2g/
wjVQAV7QkWUvfgVut424HnhuZX6Fww==
=6C4G
-----END PGP SIGNATURE-----

--nspsNZs5QU34na1d--
