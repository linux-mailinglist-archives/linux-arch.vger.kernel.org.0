Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304150A7A7
	for <lists+linux-arch@lfdr.de>; Thu, 21 Apr 2022 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379708AbiDUSB7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348891AbiDUSB6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 14:01:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174F4AE16
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 10:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DA4DB822B6
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 17:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04CAC385A1;
        Thu, 21 Apr 2022 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650563944;
        bh=zZ6iahhKD1V1II6VvAjOnWgLjjv3sTcvXy4h3KvxXfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFMBByso7lprhIPZqf7CJV3hKNAsVj57Y3PwLYThccKkEDtaxIB9TI6MarReGpS/T
         TxIs9qdMFYVhxQ+Z0JWpT37UeVDay+elVTkkvMZZT1d8m85Y52DgPYQE9/UnOhKj8e
         XUCfARXmNW1V6dG6D6sSn1OxtRRtWk7Yp/o3F8tIynQlzuyUufrZQHC7VnZZfYb1d/
         9JOQ8XTV+ACnwDcM5OqI6N6PjIhMnhEvPswtpTwQUWFe6I9uPXjlXi907l3BGhxBLX
         qEdRmRQCwf9qCsEUxa4/2+a8xuBvNgSbguKVFEZU12DicAxBmTvxVh5PR2fHZM5TMF
         wGv85/HHMwS4Q==
Date:   Thu, 21 Apr 2022 18:58:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, szabolcs.nagy@arm.com,
        yu-cheng.yu@intel.com, ebiederm@xmission.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YmGbYsZVsQMoM9xR@sirena.org.uk>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck>
 <Yl/ZCvPB2Qx98+OG@arm.com>
 <Yl/1KertC3/UtwR4@sirena.org.uk>
 <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com>
 <YmElD5AghKP4Zgdd@arm.com>
 <52a79b24-deec-108e-4b7f-5bc33500c802@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zY7P2cSeDhvk3jaq"
Content-Disposition: inline
In-Reply-To: <52a79b24-deec-108e-4b7f-5bc33500c802@arm.com>
X-Cookie: Two percent of zero is almost nothing.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--zY7P2cSeDhvk3jaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2022 at 10:52:52AM -0500, Jeremy Linton wrote:

> Or maybe simpler yet, we provide a tool which wipes out the gnu BTI note on
> binaries that are found to have BTI bugs, thereby (correctly) fixing the
> problem at its source. This is at least presumably doable if we are also
> assuming we can update glibc/etc in any environment with the problem.

This seems like the most sensible thing if we do find we're running into
BTI executables that are incorrectly annotated and difficult to fix - it
avoids having to manage any new permissions for bypassing BTI.

--zY7P2cSeDhvk3jaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJhm2EACgkQJNaLcl1U
h9D22Qf/bUhryTD+1wfEMb4NyHbQxFkOHPHvqtaRR1jHrV1Vv/uWpgokevT1PDHJ
MV9lWmacUNvzqn3Vj3jNaJxZcfPHhRS2kUa2kpLa5VF+GnXxRQgie9JKlicSEor7
EJLQqVpA6YYS2F0ywDaBRu/O1B00nf/aSI/Vpcgl5yHjcvdOymnhwUES8qXFTkCU
5UnIIouImngnDo0UczLiEfOKn7bO1B1KhtpYDBk9Q1QwZowVyyPK5bFQe7ezsSZ1
MKyGTlaroN/Jq91wohwhJlYmhrd3U/ok2Q7tKH+cosapOoWu968dbFDFGNoIDe5U
MnwWNuS1BVkpxUYC95b70ScwItDStw==
=qeXh
-----END PGP SIGNATURE-----

--zY7P2cSeDhvk3jaq--
