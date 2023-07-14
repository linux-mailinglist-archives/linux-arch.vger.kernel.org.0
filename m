Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE575452B
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jul 2023 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGNW51 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 18:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGNW50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 18:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B063593;
        Fri, 14 Jul 2023 15:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D4A61E07;
        Fri, 14 Jul 2023 22:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C28C433C8;
        Fri, 14 Jul 2023 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689375444;
        bh=P8clI5KtqQRzgFfns22g81I3g6E4+6MLCwEqWyZYU68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjATGNeW2AnMB8iSVCidFlZhH9OfkN7bAt2p7ldacOlxk00MBC0K43n0wGgdC/kES
         5er615dq9DLL0q9cE1VNLaWlbFSi2IfYsicV7umDzTZyH4W2s60ky3l5tGI2zapesZ
         a6IFRb5wsW2IyAbgdPu3qj324ZAqxXKa5uD5MSOHkbg0ycP0RX1WKos7Wx9s9h14c7
         mr09nK6DvKTxBa912H2K859rBf/1exfAJQyuctMgVjw5UcRvPGqHIzg/7kZ1W2WHDS
         fPdS6OedIvs2Ff2PDWFgTKxBrTglm+398FEIc7xd983iXS7+gUDgWarryvZetDtEg3
         d1Xp1VJIV7NTA==
Date:   Fri, 14 Jul 2023 23:57:06 +0100
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
        torvalds@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Message-ID: <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Om+vkuYZS0OLKEiC"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Om+vkuYZS0OLKEiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:27PM -0700, Rick Edgecombe wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requires
> some core mm changes to function properly.

This seems to break sparc64_defconfig when applied on top of v6.5-rc1:

In file included from /home/broonie/git/bisect/include/linux/mm.h:29,
                 from /home/broonie/git/bisect/net/core/skbuff.c:40:
/home/broonie/git/bisect/include/linux/pgtable.h: In function 'pmd_mkwrite':
/home/broonie/git/bisect/include/linux/pgtable.h:528:9: error: implicit declaration of function 'pmd_mkwrite_novma'; did you mean 'pte_mkwrite_novma'? [-Werror=implicit-function-declaration]
  return pmd_mkwrite_novma(pmd);
         ^~~~~~~~~~~~~~~~~
         pte_mkwrite_novma
/home/broonie/git/bisect/include/linux/pgtable.h:528:9: error: incompatible types when returning type 'int' but 'pmd_t' {aka 'struct <anonymous>'} was expected
  return pmd_mkwrite_novma(pmd);
         ^~~~~~~~~~~~~~~~~~~~~~

The same issue seems to apply with the version that was in -next based
on v6.4-rc4 too.

--Om+vkuYZS0OLKEiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSx0sEACgkQJNaLcl1U
h9Cgsgf+I5DDysBO4SJ+jmxeXww6HYCycJsoc6oA/wVf/wO7aTv89RFcAPpwMOoq
jZKiD/xiUtCMUcNE+ZtCQIYVymIrK1BBcNPzgflt5fa50gm53Hp2mcNFaUeriWjC
x2DfyH1wsfgAjwv14aKu1m59Y7xdhIQWZ4HTezaEFND/3GQTrvGy8tHMDL07GKWz
qL1gMkJ7kYVKEAf86IsSwbDBcSa/SV5cLbsL4S5GEm5K/hQcLwUqSw4WYuMLfNip
Eb4Napl5JYGKJcb/IQIm/PGQbmnKgijPg7mR0lvF6RWZk39wCFxKQizahf6cRCwv
HSMmlXJHILeOK57vaStYZJvapWZzdg==
=/plS
-----END PGP SIGNATURE-----

--Om+vkuYZS0OLKEiC--
