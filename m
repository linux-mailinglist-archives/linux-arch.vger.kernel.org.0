Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78F730B8C
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 01:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFNXa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 19:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNXa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 19:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E51BC3;
        Wed, 14 Jun 2023 16:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393A0615A3;
        Wed, 14 Jun 2023 23:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A951FC433C0;
        Wed, 14 Jun 2023 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686785455;
        bh=f7m/k4m/SzTcQEKr9Wills9wPUmF4MEp7tvV5JdprYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxnNy/PTwivnZmnoA0n9FUmkdB18azckUI31v358TTIJLRtOuaUS62OE+GYL9uaw0
         LLKYo1BhMHqpeSyLli0o/58B1fUwQ0FWJETiE4eIoMOa1PvWHGcFg4uy2O+0z9+wAk
         QivKdAIG55/YXelf2xnFVfaBXfJW+yC5zCJhPkcnPluODE5H5caY3Ae0xixR2123RX
         b2gF2pZz04shEMtNYrkwHm5FDUUWeGxpo9F4866l5ZvvwggwGtxelmT6GpZ9n1A1mf
         LqLQARdF8tT+5j+qi5wTZo/Y875JQNIM+B5e6dHZusrdDpQ4ipdzmOKGJl2VONWYhg
         3qre3dOoYsl9Q==
Date:   Thu, 15 Jun 2023 00:30:43 +0100
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
        Peter Collingbourne <pcc@google.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 04/42] mm: Re-introduce vm_flags to do_mmap()
Message-ID: <f939a796-b04f-4e44-be16-be243c6a250e@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o+sRcL1+mT+ugmLs"
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-5-rick.p.edgecombe@intel.com>
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


--o+sRcL1+mT+ugmLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 05:10:30PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>=20
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
>=20
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap=
_pgoff()").
>=20
> There is a new user now.  Shadow stack allocation passes VM_SHADOW_STACK =
to
> do_mmap().  Thus, re-introduce vm_flags to do_mmap().

Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>

--o+sRcL1+mT+ugmLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKTaIACgkQJNaLcl1U
h9A5IAf+P39LmrqSebKqcPED1RRnsd8N6hWOJJ5CLMb8xh2UB35SggOsMBO9xg93
QKWxl/4SCzh0LwkbavIvr/pUjHB8n6yOOJTcJyo5P8YgCdgBnLlPdIswYQ8hhA7W
HOFWSkZjo2y/EcbfMabs/vXFASf2vd8qbTko9u+6P660y4nuvtoW53fgA9jkkNJV
o7UfVTq47yy53evUsMPDVeWYU71G0cja2Kf1xkrCs1tB4+Wjw4+AZsl45bmMnWI1
Yh6mYKNhAS1P+e9ZhcMUExbKM0RBwXIFkMNk9Z8L97MFr7ATmh++ww0cKYC4kqKP
HST8fG626N/FXw8qykkdh7ChIsExGg==
=CJwi
-----END PGP SIGNATURE-----

--o+sRcL1+mT+ugmLs--
