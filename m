Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95765730B9E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 01:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFNXfS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 19:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjFNXfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 19:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5F1BD4;
        Wed, 14 Jun 2023 16:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841FF61274;
        Wed, 14 Jun 2023 23:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8900AC433C8;
        Wed, 14 Jun 2023 23:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686785712;
        bh=vacjCPiU5N8qvuuprIt6J0bOdVwOCc4CraBBI0wBsjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCc3lU9QvRreg8CWsym97621Y1HdoB5z0BuzFeiN07u9LL/m9q37r2V5D4RRnOW84
         wjDU5qd+v0wR6BUZOEJO1LP6ZB3iJ2PGQTUCUrDtEUCo4kplur+s+ce1ytQwa0CYL0
         3PsoGx+B4VeF2QCFMI33lfUN48CkkNS8MssSv/CGaV2YmN22V3495CK5i0X0cGe4jD
         OOAlXyMYeRPIWk6DwaTGG5NXmUPGRljP+ep0lFLLVAe6utCSVBno0fer/rzrxtPP5w
         4PsPrpZNYwrAXe1AgFqm2GKUVkAmpWSY4VeYue4CyAkSRdtT5vZx77zeg9rvfEOBqf
         505cofmZyOrhg==
Date:   Thu, 15 Jun 2023 00:35:01 +0100
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
        torvalds@linux-foundation.org, Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 17/42] mm: Warn on shadow stack memory in wrong vma
Message-ID: <9583dff0-08aa-40e2-943f-f046f0402058@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-18-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BSjLtFoBpX+dhkhM"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-18-rick.p.edgecombe@intel.com>
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


--BSjLtFoBpX+dhkhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:43PM -0700, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.

Reviewed-by: Mark Brown <broonie@kernel.org>

--BSjLtFoBpX+dhkhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKTqQACgkQJNaLcl1U
h9DuIwf/UNc+nTY+UZmszCtFLLJzZY0v0k0woxLukAJtCYOMzWbzgUU3HMn/am0V
y6ZoQODYns2OC5PQ1aHhORTs/srWbZDqABYUr4+Rg4tNPosfLoidutRExFLGvd1P
tUU2Gkp+mCwzUbJN5KyUU0J1LSxWHzoJAqgomJGzhc2vSVtoF+KS2X9R5UdnfIE9
T8DSw5VeYuzKGVPMQVzRs4cVNIuj5/94wEEyGHXEO/dOos8ECuoPkzkfLmDTtb50
dylLaW7InFIA/HIXTPE1JwkFSomJePTZSlmngmAA91Andk6pvQ1PkKQayGqbqyXW
kXqXqHJKtZE5tF1vFNHCKQJMNHQl6A==
=Zsa+
-----END PGP SIGNATURE-----

--BSjLtFoBpX+dhkhM--
