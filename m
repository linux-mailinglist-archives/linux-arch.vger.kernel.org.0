Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE54C485E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 16:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiBYPMZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 10:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiBYPMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 10:12:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1266AE0
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2022 07:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E4DB83247
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2022 15:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45960C340E7;
        Fri, 25 Feb 2022 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645801909;
        bh=Zsi0/aqG33r5+G+hlgdfYyiw4dDF/YnpD1VEIoFztmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snveTBp6cvFv5GpNlBUAwfVWpOYAQx4VPG8nPHmjKkPDzB/bmI/1dTSRnmbOFdad1
         q6FVMSK6zOMmGV94g6YuTn/Yl8lSfo/QxVUI7wXPmNOr0xvC9i5NDvd7KSkJMer+0i
         9pYul4pR7KlNg9yLGlHnSOBVCDgVl44G7ufosaQjxA5vC5RCormZT4fjzhcAyHtIYw
         LPBBm0uJ/qccRMoHd6wI7l6QNlk57FP06yYE+MaNLAq89cbqdPNn8S4KTctaa1JDts
         xCpWqgbmdcIdB5cQzotgu00GCK9SBNoGsCHByU1F/tYgKC/cxk0bfS5lZOyuSPg99H
         5xXtdlEO+ABUg==
Date:   Fri, 25 Feb 2022 15:11:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <Yhjxr3+U2qd6b3yK@sirena.org.uk>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
 <20220225135350.GA19698@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6hJfgwb1yMHoRrnk"
Content-Disposition: inline
In-Reply-To: <20220225135350.GA19698@willie-the-truck>
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


--6hJfgwb1yMHoRrnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 25, 2022 at 01:53:51PM +0000, Will Deacon wrote:

> I still think this new behaviour should be opt-in, so adding a sysctl for
> that would be my preference if we proceed with this approach.

I'm happy to have a sysctl but I'd rather it be opt out rather than opt
in since it seems better to default to enabling the security feature
when there is a strong expectation that it would seem better to enable
it by default sine it's not expected to be disruptive and the sysctl is
more of a "what if there's a problem" thing.

--6hJfgwb1yMHoRrnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIY8a8ACgkQJNaLcl1U
h9Bpagf/Qa3XQwrrpcD8o5hL6Hcly0nN3c1oddDQMVn8t95ZxqdVD58AFN2xKULJ
dUJyThV6a83oQT3bzLZB3lCFXKwaIDXPB/i/Q5+i0v7zMryNllxQeBuALWG6Fxru
qPTh4s3kEzMVQZiJmQJqxFw1hw1KIKZtCYIQCdHXe/8nxbYqlWo1CCu7MH88zpMu
lu4DQGel9GA2kMfKKvFc2sV371HfYohcTxuqjZkXIJu6v/3+C8sp/yHArIfRK/aY
4n2AmN8NDTVgFYW+Joy1KzHXUN7AmCyf53bQEu1LlC3NjyXYbnh4vjLG/MDB3gtl
r2wx9Y5Sj2FQwFc7Jywjrf2sF21Bbg==
=ve8P
-----END PGP SIGNATURE-----

--6hJfgwb1yMHoRrnk--
