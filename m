Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF60730B97
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 01:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjFNXee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNXee (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 19:34:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1901BD4;
        Wed, 14 Jun 2023 16:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCDB960DFC;
        Wed, 14 Jun 2023 23:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75ABC433C0;
        Wed, 14 Jun 2023 23:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686785672;
        bh=9vAVA0vgFk7ZYI1wt4Vl5FRDTi/wrA+OF5wp7ML/pow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiI6WTDAzKwrOxtz6nWJfROnB1o1cyZzVocJOvEv8rNr3DjJoaRxjnyl6KI1/azc7
         dnNjrbFqUc9BNT3gfLjxvYgGEoa/q8LZv/7/yKnnmFDxWDSmY81UsfknYZaSh0lC/p
         vTSl1mqWphg9hn6sB7tlbwNgjyoaf9+/fdlO0P8lH9PLRI1rvbRYSumKTyrNsiz887
         zbFYdFN05Yy8WyzQ6HIUAMRSOGfEyPmVf1zlx4UM3La5NgbKBGrF30zc40THSrsbDC
         sSqEi0WaYlSbqhSMQPcV8yqqyxelVF2OWZp+dG+Qv50nvA8Qfi9Ju1mVwxbpCJLNWM
         4H9tyl1pq2taw==
Date:   Thu, 15 Jun 2023 00:34:20 +0100
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
        torvalds@linux-foundation.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Message-ID: <6e2cd47f-f541-4a94-87f8-79204144fc8d@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtj6G0y/iCDsSROv"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--vtj6G0y/iCDsSROv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:42PM -0700, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.

Reviewed-by: Mark Brown <broonie@kernel.org>

--vtj6G0y/iCDsSROv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKTnsACgkQJNaLcl1U
h9CzQQf+PdMiX9VT9eldMSx+qFLvi4hp6EiOa28TOPpP8QZF5bcajoksvMbUkcbb
gExx3xen7iFsntlX0l5r+UPsRz2CyKJz/fxmINrDCb1hqMfNVe96DRfuGgeOY8jh
MvmdWEzlta5AvmXAS9FhfMHscsbTJY3gZI4UHPrA2utcPHxqvi5fAjpLR1k/mIW6
gEyaNn/fOdNDsKp4SGpK5y+QpErsKT0MKFRkjI7wqgksLWthdtVKCVZu5rErCh9l
Gtaiw+fFOI844jDoRBfzMyC01XmM0MSNMa/oARvenJ7VbE987k/Wr43yhXeUv8uC
CELrSSB6sp2FNqnFX7cMVEwMKcGe9w==
=ND6N
-----END PGP SIGNATURE-----

--vtj6G0y/iCDsSROv--
