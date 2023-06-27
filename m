Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E186740205
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjF0RUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjF0RUg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 13:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D249198;
        Tue, 27 Jun 2023 10:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85125611EE;
        Tue, 27 Jun 2023 17:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E19DC433C9;
        Tue, 27 Jun 2023 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687886433;
        bh=yG+a22abZ9SzUNQMe+8vtxSHNs6hg3hQ7bJmtKEfq6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyU4+sm92oSYzUVPRTJlX+Fe8+ttP3U+br5Qu6kTbNbf5lZfR+LqFTbGiYEKIV8Q+
         5RtK9Vqc8+8DspI54cUVWQ4w14eVSy2+Rv5XCiYaU6R+cA3pp+bjTUBvPBsuxG8/R+
         5XDChTIqMS7+mQbhSiOPUMCfEr82Rp5khktKM6IqzLhSB7J7tunqkGu8E55EYQkF3+
         mRES0K7flwKd7TMmFAgchyy7qWWCZpdIVYnU15tNXlY1LFxI8enQ8GdFiHvchx76Fp
         B6X9WIMAwaBYF4kJZrpLfqjsBEN5q10onKUXCktEh8nnAM3zv8+2mKEcK5AetxE/4j
         uk99KdZ6KzwgA==
Date:   Tue, 27 Jun 2023 18:20:21 +0100
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
Subject: Re: [PATCH v9 28/42] x86/shstk: Add user-mode shadow stack support
Message-ID: <76a87cdf-4d4f-4b3f-b01f-0540eab71ac7@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-29-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5kInKYAEl4EdyhTr"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-29-rick.p.edgecombe@intel.com>
X-Cookie: Money is the root of all wealth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--5kInKYAEl4EdyhTr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:54PM -0700, Rick Edgecombe wrote:

> +static void unmap_shadow_stack(u64 base, u64 size)
> +{
> +	while (1) {
> +		int r;
> +
> +		r = vm_munmap(base, size);
> +
> +		/*
> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
> +		 * something else, and that lock should not be held for a
> +		 * long time.  Retry it for the case.
> +		 */
> +		if (r == -EINTR) {
> +			cond_resched();
> +			continue;
> +		}

This looks generic, not even shadow stack specific - was there any
discussion of making it a vm_munmap_retry() (that's not a great name...)
or similar?  I didn't see any in old versions of the thread but I
might've missed something.

--5kInKYAEl4EdyhTr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSbGlUACgkQJNaLcl1U
h9BqNQf9HqQNIAUg29S+cA0RcGv/d0uACrgRR/Ug+8CHXDUGAdslLvPRGSp8km6O
OA3sMI3JNRbsr4+QP5B8PduPbTiiePjlyNOfMrxz2oSChLugzh8gH+q7a4GtFc+T
1AsfYswcEu8GMSy7zWw//Wq8JPfNX51jxYggMohGwEtFjgZmvT1RZAaKyZwf3UKd
kYYChaAWrKWCe9lREGDuscGs1Udhg5nbpLJMgcKNDuBTJRn5UUZoMNY84TvuvNqm
hy/IpJZ8m7d/utTLzzbJS3nPy6oQoFIo2riYi2hCRNZPtDvjko8UJ9uNJCbZOp3i
gswqwIVtf/sJIXp0+Zi+a0WuiSOwdg==
=nPJT
-----END PGP SIGNATURE-----

--5kInKYAEl4EdyhTr--
