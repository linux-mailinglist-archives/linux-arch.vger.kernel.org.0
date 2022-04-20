Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0011C50878B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378354AbiDTMAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376472AbiDTMAW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 08:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7A1C90B
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 04:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A26D61956
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 11:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E26CC385A0;
        Wed, 20 Apr 2022 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455855;
        bh=PFzGrhShVlpwc/47Ul2T9eeKAeob4VJVNUNJe/ceqzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSZcB9tmeiHxXEcwts06NH/UIeXhLgJS/1BPoo1Af0Wo4AJt0B1wqgRcdvQh1+EwW
         T9oo2I/d1bDBC5hlfB7//GTPcq7A4PfexrzU7pVlibK5G1DGHj9HDznSfL0yEJ4JeK
         HMLCgOnYOHb+M52M/ChU+sr9e5JB5zaDQSpiFoUkRbjGWMw/L0x3yEuTBTz8uCKGQD
         /8gdJ5VS4m5ShADK40rpWQLYG5cjx+8yAWspwFXf6/yBH8EIQGMDehMYM4TOU/Jz2n
         Xw6QGpeh675ZJ11tqoICNi8xllukyx9LSzosY/sfvUAejIfBFhsEvO07IrXnaCNfLk
         DS/Wc6zoUwK9A==
Date:   Wed, 20 Apr 2022 12:57:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        szabolcs.nagy@arm.com, yu-cheng.yu@intel.com,
        ebiederm@xmission.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <Yl/1KertC3/UtwR4@sirena.org.uk>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck>
 <Yl/ZCvPB2Qx98+OG@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zG9v52qNjk+n4FZO"
Content-Disposition: inline
In-Reply-To: <Yl/ZCvPB2Qx98+OG@arm.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--zG9v52qNjk+n4FZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2022 at 10:57:30AM +0100, Catalin Marinas wrote:
> On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:

> > Kees, please can you drop this series while Catalin's alternative solution
> > is under discussion (his Reviewed-by preceded the other patches)?

> > https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com

> > Both series expose new behaviours to userspace and we don't need both.

> I agree. Even though the patches have my reviewed-by, I think we should
> postpone them until we figure out a better W^X solution that does not
> affect BTI (and if we can't, we revisit these patches).

Indeed.  I had been expecting this to follow the pattern of the previous
nine months or so and be mostly ignored for the time being while
Catalin's new series goes forward.  Now that it's applied it might be
worth keeping the first patch still in case someone else needs it but
the second patch can probably wait.

> Arguably, the two approaches are complementary but the way this series
> turned out is for the BTI on main executable to be default off. I have a
> worry that the feature won't get used, so we just carry unnecessary code
> in the kernel. Jeremy also found this approach less than ideal:

> https://lore.kernel.org/r/59fc8a58-5013-606b-f544-8277cda18e50@arm.com

I'm not sure there was a fundamental concern with the approach there but
rather some pushback on the instance on turning it off by default.

--zG9v52qNjk+n4FZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJf9SgACgkQJNaLcl1U
h9AKrwf/dbhZCV9DolWbMGrRvjZ6W88kCdrkBx+QKWt/qcCBTb1yGXjSRwHtT863
pxjPcYsckAsXSWJBV8CcdrHjhpCt+8QSVXP+YNbi7q1pCArXstG6OsmNdp7oN6Bk
pmMnHaUl2sTn3NxLZGcJn4NktyDT2oC3eHFOrcIssITKrWOjwnQuXCGkAIIMs0p9
MbOT+ThUNDK04nUrtPpSAZLbmtEDtQIlNgRuXzwVYKV0vShsBzlSCbHF6dWSlTT6
Ma019h0yrN6tEyeBZGk1EhpOURYHaZQ8CtpHdD9ct4DcDUVaSVwbk3wBxwkcjro9
KcwtCYR6CMY5W/4cxs5F+H8MWFtt7w==
=6YyW
-----END PGP SIGNATURE-----

--zG9v52qNjk+n4FZO--
