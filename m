Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9054D9B01
	for <lists+linux-arch@lfdr.de>; Tue, 15 Mar 2022 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiCOMUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Mar 2022 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbiCOMUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Mar 2022 08:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423352B3D
        for <linux-arch@vger.kernel.org>; Tue, 15 Mar 2022 05:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4ABF6151A
        for <linux-arch@vger.kernel.org>; Tue, 15 Mar 2022 12:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CFCC340E8;
        Tue, 15 Mar 2022 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647346780;
        bh=4wckTH9rL/UfOFGnbxCUk89TVPAfVswVZ7b0/oiTD+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWx3wghITTwAsxs+Lyj3fN40nVm4X4ocNQhfvPUteNViSR+AVeG6tx39yIc3J7fzs
         3l1Zt1bB3H9B2wkjXp+dXOzot5FSkYfUzkOCD4SKxiSEXmUnBFe5DGDOkF1c0E10n5
         lAaoeZTJ4oD7OoaacN865+jgrVAdc25c2fixTvfexxRnY+h+KEogSFbon8vajibqB7
         1ue7ThTyGbgwJ0nh7mCnGeuDo7iNDVqrCMqKb6cw9+mxj8HZkjEwfLAVrtAvuZTHNk
         qQI7P1P5kGSdKzFB0LOzHlp8FbxrAVsnRBUJP/XGiOkTfTL1jWfhCSW0onQ/lXob5G
         Vf0NpxYWqQJMw==
Date:   Tue, 15 Mar 2022 12:19:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v11 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <YjCEVt/nC5ik23Q/@sirena.org.uk>
References: <20220308132240.1697784-1-broonie@kernel.org>
 <20220308132240.1697784-3-broonie@kernel.org>
 <59fc8a58-5013-606b-f544-8277cda18e50@arm.com>
 <Yi8DjeTU1xzX9iSv@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zn5OOgOYreyhG/5Y"
Content-Disposition: inline
In-Reply-To: <Yi8DjeTU1xzX9iSv@arm.com>
X-Cookie: Tax and title extra.
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Zn5OOgOYreyhG/5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 14, 2022 at 08:57:49AM +0000, Catalin Marinas wrote:
> On Tue, Mar 08, 2022 at 12:01:17PM -0600, Jeremy Linton wrote:

> > > Resolve this by adding a sysctl abi.bti_main which causes the kernel to
> > > checking the BTI property for the main executable and enable BTI if it
> > > is present when doing the initial mapping. This sysctl is disabled by
> > > default.

> > This seems less than ideal, maybe the default can be flipped with a CONFIG
> > option?

> I'm not keen on config options changing the ABI. If there's a good
> chance that this feature won't be turned on (via sysfs) in distros with
> MDWE, I'd rather drop the whole series than maintain unused code in the
> kernel.

I think it's more just that it's a pain to have to also update userspace
for something fairly low risk than that it's an insurmountable obstacle.

--Zn5OOgOYreyhG/5Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIwhFUACgkQJNaLcl1U
h9B+EQf/e5kbNpMgB2L6fsV1GSv1FEr+TMcObpZSeO0ZOhP8ji1gCLy/CUwnf+8p
0IQBQEJ8kpHsgmrtH8DXZeDcpy284Z4ST1fYfzI4sS7nj3U5Af71+n0zjMxtNvSN
9tywEji0AovV8vnFZo1CbwfshCVn9SwaJQR8dVWhIy9c9ju8268HqQ66qHEYNx79
97p6elUKnpdLi/1AeuGF9NgndWfnt27mD1ZSq0K/DUEWel4pLCl0I3kogH1Z49/j
Vnzp+2rpjXiP1tc0hJScmTv1goIANTELAW/O6P0pq4Sv9pBx68BWTaWfwfhy6wQ3
1D9ZKticmaF2rEyq3LBNXhrIrk7XFA==
=a1ze
-----END PGP SIGNATURE-----

--Zn5OOgOYreyhG/5Y--
