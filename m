Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87BE730BBA
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 01:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjFNXpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 19:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFNXpi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 19:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5CC1BDB;
        Wed, 14 Jun 2023 16:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14C0361C5A;
        Wed, 14 Jun 2023 23:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13283C433C8;
        Wed, 14 Jun 2023 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686786336;
        bh=trI7LLllq8UHlu5MUvTW0yx6ZikFRHPzHAgHZbe1sCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qolUUlGyBmaE4PVkaBcn826DfA+jq8LdthVVgyE+MK5ComyO2u0o0nreuy83RjIy0
         O34yQHfbN1r1Hq4jfsY+mqhBUIeIy+z17ePovDXBq+eOb5qQj378M5xaHm2OqbDaTs
         m7/UQ7idkBD+ov7776ghxWcmhcJtxz49l7YzqcPeUKNJFAhOD9Wb/BhBz5+//s9mgw
         U4CA+LnViWgoQ8UsmqmMW1vtrEIxvuwCcjrbd4AJlVQoSgwa4IeZoo4Ib2yfqwnke1
         wHn6/0eOag6RKGtBPQxs2xrsN55pvpxPB/rGXxqt4JnX9976G3D6jmGO+jgp/2+1Cz
         9tJreJzrRBOLA==
Date:   Thu, 15 Jun 2023 00:45:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
Message-ID: <d62b161f-58c4-495a-a5ab-08485df8e0b6@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtFxUl+7EWj84llw"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--wtFxUl+7EWj84llw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 05:10:26PM -0700, Rick Edgecombe wrote:

> This series implements Shadow Stacks for userspace using x86's Control-fl=
ow=20
> Enforcement Technology (CET). CET consists of two related security
> features: shadow stacks and indirect branch tracking. This series
> implements just the  shadow stack part of this feature, and just for
> userspace.

I've been using the generic changes here for the work I've been doing on
arm64's similar GCS feature, while that is still very much WIP and
hasn't been posted anywhere most of the common code here has been
exercised.  I've been through the patches that I've specifically checked
or used.  Thanks for all the work here.

--wtFxUl+7EWj84llw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKURMACgkQJNaLcl1U
h9BUrgf/RAj2KfSHxToCbw83STTQBY7ccQMMqYkrvbMuraS1YwoP+wzOdPReB+WU
b4u9ed/MtMzOK4WGYHtAjS7cGgx/AV82OG0Sj7zsAdCOvWOwbPSakAPRPr1ZvKst
uF4HFhRUSEmpkKfhHw4pDWGpgjNG6YcQOY6PPIPNGt8PRVf436pWu3VEiLidvCbq
bCEpSuaFeOT7BMgmceMMmYDC7w79KvOvfeWXf8ByQdrBMmim29l/lQR08bqsDO1P
SPU5a/fJ0jSj7CGi66aAUqFgKJr5/bpqt/hBrJGncCrQb82q3F0NRbI5+Lj2B/MZ
r4ZUiis3OQnGouoGYCIforObS3/SmQ==
=rReJ
-----END PGP SIGNATURE-----

--wtFxUl+7EWj84llw--
