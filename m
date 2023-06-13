Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6BB72E6DF
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbjFMPP4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjFMPPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 11:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBD118;
        Tue, 13 Jun 2023 08:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44AF662EA4;
        Tue, 13 Jun 2023 15:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDEFC433F0;
        Tue, 13 Jun 2023 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686669344;
        bh=/rl23s8079daMc/L5xKX5HaxFBpVGzkrwZXcRhgrzUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3rTI8P1B/ZQkdGFSOLmBZfHDc0v1qUD5ReW/6vIFrV7gdzkt39bZ2f0RXKWqznCP
         mak7dZUd/dZLoXk+ERH4/Z/OVpJCuCJ7PW860UL+CYqnIPUIQyoC7A3eHZs9TtLQr5
         RAcdJKHXTcUwcaKJtteJrUAQtkyCrHBuDuh0abZfKzX5Kg9LVT8FJEMv7uVGPNXJR/
         NjAx9gqLWqqJe5OVYmp9Z/fs5MfA6nBNw0SBJf4UIrswTkNexThtVewvq7yM5qWje8
         AQzZV7HczX0LzsXj27rMLtOQ5REMxlatnITnkxaqLgbald+Ki8/N1aEqxZnChb+Bp7
         fqdF79Ugiy5uQ==
Date:   Tue, 13 Jun 2023 16:15:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        torvalds@linux-foundation.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
 <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
 <87y1knh729.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CHHivuSQNQZBIb3Y"
Content-Disposition: inline
In-Reply-To: <87y1knh729.fsf@oldenburg.str.redhat.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--CHHivuSQNQZBIb3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 02:37:18PM +0200, Florian Weimer wrote:

> > I appreciate it's very late in the development of this series but given
> > that there are very similar features on both arm64 and riscv would it
> > make sense to make these just regular prctl()s, arch_prctl() isn't used
> > on other architectures and it'd reduce the amount of arch specific work
> > that userspace needs to do if the interface is shared.

> Has the Arm feature been fully disclosed?

Unfortunately no, it's not yet been folded into the ARM.  The system
registers and instructions are in the latest XML releases but that's not
the full story.

> I would expect the integration with stack switching and unwinding
> differs between architectures even if the core mechanism is similar.
> It's probably tempting to handle shadow stack placement differently,
> too.

Yeah, there's likely to be some differences (though given the amount of
discussion on the x86 implementation I'm trying to follow the decisions
there as much as reasonable on the basis that we should hopefully come
to the same conclusions).  It seemed worth mentioning as a needless
bump, OTOH I defninitely don't see it as critical.

--CHHivuSQNQZBIb3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIiBMACgkQJNaLcl1U
h9DYKAf/Vz3wx22uDdLyCBpiG7PQdfsvx6Gsa3OkqligILXiOR/RqMgrq58a10CL
1Y83LNYyJWuUw541NRW64qugDHs9G2NwIpxrgeD3mBQibPyJoJyFsEOia0VFOvB/
jEcMyC/PLUl6W0LBP7P/tyDcf6UyZY5mhI32w4k5JHImx4iNswSTcS5bEMrkbs/J
wcEZi8RTKT6XeWHM1Y7Ky3oQax1I8b1G3pzGa6WK0c5fNstN0QRY6hpMFKknp1sR
yygF1dgoS3kygw4ZeBsmpkmGJKETDGsCpqteh2JQ7XV2i2kEJe8IeOD/NAcPl43V
Sovm7EiMjuwISm0hPggYtQ+vsFGHrg==
=tl5C
-----END PGP SIGNATURE-----

--CHHivuSQNQZBIb3Y--
