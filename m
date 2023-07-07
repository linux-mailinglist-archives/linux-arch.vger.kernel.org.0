Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C242274B3C1
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGGPIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjGGPIe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 11:08:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7D1FF9;
        Fri,  7 Jul 2023 08:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7388619EF;
        Fri,  7 Jul 2023 15:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D79DC433C8;
        Fri,  7 Jul 2023 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688742512;
        bh=Kcc5BRyjmQB+Tg/fy6raV5yMIqWxapI/R18lSX23EDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4VTNT0m6XKStzKZRJRuNZgU0aQ/+ItOHdFDq0ELIJwcJczeuDmNbRcSR4opAmgfj
         pX93UNqUpq6kuKnn99yhPPOmHKEQqI8F5xtOjanjdWMvq36pbxp0LIhzGEdNi6/v7m
         FR0dA86d3Te/x61CbmbOKhcS6efgAAQJTrKgg1OuFLMKYWFej2eErlKe7rbZQJglUj
         No0e5aEexz54+ZZrEhRPso1aTNBkSa2OVu37uoewpGLMEr+tVLUmNN3+1i+dS6huyr
         UkuJjnl/90uotHktcCGkUsLZju1h3hj2gkykT8mb+fP82EFx+s4pDy7sP0AdWUqNFU
         ZnD103wnnBfjQ==
Date:   Fri, 7 Jul 2023 16:08:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, andrew.cooper3@citrix.com,
        arnd@arndb.de, bp@alien8.de, bsingharora@gmail.com,
        christina.schimpe@intel.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com, debug@rivosinc.com,
        dethoma@microsoft.com, eranian@google.com, esyr@redhat.com,
        fweimer@redhat.com, gorcunov@gmail.com, hjl.tools@gmail.com,
        hpa@zytor.com, jamorris@linux.microsoft.com, jannh@google.com,
        john.allen@amd.com, kcc@google.com, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@kernel.org,
        szabolcs.nagy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, weijiang.yang@intel.com,
        willy@infradead.org, x86@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH] x86/shstk: Move arch detail comment out of core mm
Message-ID: <9704b6a9-e7c5-4d50-9567-9e23906aafdf@sirena.org.uk>
References: <ad6df14b-1fbd-4136-abcd-314425c28306@sirena.org.uk>
 <20230706233248.445713-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nP9Wo8Ehv/TVMQs"
Content-Disposition: inline
In-Reply-To: <20230706233248.445713-1-rick.p.edgecombe@intel.com>
X-Cookie: Victory or defeat!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--6nP9Wo8Ehv/TVMQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 04:32:48PM -0700, Rick Edgecombe wrote:
> The comment around VM_SHADOW_STACK in mm.h refers to a lot of x86
> specific details that don't belong in a cross arch file. Remove these
> out of core mm, and just leave the non-arch details.
>=20
> Since the comment includes some useful details that would be good to
> retain in the source somewhere, put the arch specifics parts in
> arch/x86/shstk.c near alloc_shstk(), where memory of this type is
> allocated. Include a reference to the existence of the x86 details near
> the VM_SHADOW_STACK definition mm.h.

Reviewed-by: Mark Brown <broonie@kernel.org>

--6nP9Wo8Ehv/TVMQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSoKmMACgkQJNaLcl1U
h9DOVwf/Y0zWXHXNC1vLAm9sKmANgUpp9G9Tqrm1x5ddbXJHfCpcA5GUW5fG4lXa
GYCDJ1gq8Rlt84gcZU+mPC8evLuDsh7gAysYhq0HcNJOqWr7gYi5/5M3JVrdCUfM
iMP11cx6d71lxhKkI3V5TYs6D4sX9UJQlD3ytefHHFmZNyouWx3yRRerWukxyNXY
oEa+zZP8MxfY1YKd6/C9mWisi5F10DqRsxc71IU7uoovWT37E9Qy1Xsx0+DBqyq3
ceF3B+z+tRbd3CFLJfotCxxiFkhOLq3GJlD/3/aAGS5hJPtrQ7Qy+rwhbQ6nGOfr
A5+bDsBsdcVJmhjoXp/75wDbyqj0Jg==
=inrT
-----END PGP SIGNATURE-----

--6nP9Wo8Ehv/TVMQs--
