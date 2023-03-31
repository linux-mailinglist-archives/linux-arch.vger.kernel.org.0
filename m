Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B86D15EF
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCaDUn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 23:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCaDUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 23:20:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C312CF9;
        Thu, 30 Mar 2023 20:20:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pnlss3bpcz4x4r;
        Fri, 31 Mar 2023 14:20:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680232835;
        bh=c+UpRqtLtJjH1YHoCACFoAIHY5iVBRszZsfkpgLUE+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M7fcPnB3dE2KM90oKkIukvz9N7sAlomE1Au4/nGefjjXFuWnioz1itXKx3+uAZ00w
         ae+y1w91A41yYmm+CmNbtmIh3XPlFxlu1GMwHkdb1jZS5ywFlo8OQnsMUSJPRHcSda
         YrE+fIgo2rPRLwddGSjB5aBxKwLPWiCxVJnc016H0c7D2UMFbITvUfk6IdrUEeUsgA
         IBen9RDZSTVqYOO4EPOCOh3278HCNqSg3xfIGXH05P3nNGX+/fN1D2gBX5sw2UPHmi
         pOW+Kryuzb7+Ydxg6qWii9Rh8PLNQOi3MW7xz8Pob81P8JeJLK0m6tk8KQCWOpoQEQ
         mDz0ma5dSTSaQ==
Date:   Fri, 31 Mar 2023 14:20:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/2] Begin reorganizing the arch documentation
Message-ID: <20230331142016.0a6f8f6b@canb.auug.org.au>
In-Reply-To: <87a5zuf4w7.fsf@meer.lwn.net>
References: <20230315211523.108836-1-corbet@lwn.net>
        <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
        <87cz4zb8xu.fsf@meer.lwn.net>
        <498938d3-60a4-6219-a02c-a03e490103c3@intel.com>
        <87v8ir9rz6.fsf@meer.lwn.net>
        <87a5zuf4w7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K+Hq9txQzz_pMH.gpuqUwza";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/K+Hq9txQzz_pMH.gpuqUwza
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Thu, 30 Mar 2023 12:52:40 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
>
> Jonathan Corbet <corbet@lwn.net> writes:
>=20
> > Now that I look...the only thing in linux-next currently that conflicts
> > is the shadow-stack series; if that continues, it might not be necessary
> > to do anything special. =20
>=20
> There's an FPU patch now too.  Git seems to handle the conflicts *almost*
> seamlessly, though.  So, FYI, I think I'll go ahead and drop this change
> into docs-next, which will probably get us a cheery note from Stephen in
> the near future.
>=20
> (Stephen: the change is simply:
>=20
>   mv Documentation/x86 Documentation/arch/x86
>=20
> the only fix I had to do in my test merge was to add the new
> shadow-stack document in the new directory).

Thanks for the heads up.  Git moved the file and I just had to "git add"
it in the new place.
--=20
Cheers,
Stephen Rothwell

--Sig_/K+Hq9txQzz_pMH.gpuqUwza
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmUXAACgkQAVBC80lX
0Gz5Xwf8CNPx8jJDlR5Ne71z21R72QmEAuRJ5EZPlilGwneN1s7oQsTZnQoNbY84
uSq3hvpW6SAE6/hZcS1MVwM+jLNUYLevtWXjPnb44xR9uMVF+S/VxcnMZLrI/T8Y
63/TDd0loDfQn903uJGYKA+hYlDwIjMj12xwiC3RKxXASyyLj0iwQMYlFANuyMgp
fNWWhwnDA8xDJKwmQ1dPJpIvfL3+hWSvmLgn6wtIeOxMXr4z14jdWqPlYiw1BjF0
NrSfk0o9/LzO+drw8hx9mMmhFoovIoKGagIOBAU/TnDBKlI4+/5w+DliJBMS8NCH
jPUYS9ZG5iLn+h6oDDUfi2eWQDvHMQ==
=zAyy
-----END PGP SIGNATURE-----

--Sig_/K+Hq9txQzz_pMH.gpuqUwza--
