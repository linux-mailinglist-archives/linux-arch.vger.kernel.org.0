Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7E2CD969
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgLCOkS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 09:40:18 -0500
Received: from shelob.surriel.com ([96.67.55.147]:35180 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgLCOkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 09:40:17 -0500
X-Greylist: delayed 780 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 09:40:17 EST
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kkpZ2-00023G-Re; Thu, 03 Dec 2020 09:26:32 -0500
Message-ID: <0239dde7da2d6b6499970f343c7498c711ce14c2.camel@surriel.com>
Subject: Re: [MOCKUP] x86/mm: Lightweight lazy mm refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>
Date:   Thu, 03 Dec 2020 09:26:32 -0500
In-Reply-To: <20201203123129.GH11935@casper.infradead.org>
References: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
         <20201203123129.GH11935@casper.infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-s09L+bRyOvtccCU/oR2v"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-s09L+bRyOvtccCU/oR2v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-03 at 12:31 +0000, Matthew Wilcox wrote:

> And this just makes me think RCU freeing of mm_struct.  I'm sure it's
> more complicated than that (then, or now), but if an anonymous
> process
> is borrowing a freed mm, and the mm is freed by RCU then it will not
> go
> away until the task context switches.  When we context switch back to
> the anon task, it'll borrow some other task's MM and won't even
> notice
> that the MM it was using has gone away.

One major complication here is that most of the
active_mm borrowing is done by the idle task,
but RCU does not wait for idle tasks to context
switch.

That means RCU, as it is today, is not a
mechanism that mm_struct freeing could just
piggyback off.

--=20
All Rights Reversed.

--=-s09L+bRyOvtccCU/oR2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl/I9ZgACgkQznnekoTE
3oM1Xwf7BP5sCqPmSgYX7xGoYDG/xK8xty72ALiZ2ixV5SAzOInMZX7m2nmOLZ9k
0Nu3ycKqeKKdjvuqou4W+DEuiBR0Sy8hkkrlCcrzpmTQ0fv/igXyrRChA4V5u5Ki
SbE5tojr7tuCNj7O7iQF92x36A63PAVpI7k3hKxEvJtemPOYdxdxldF66nXm9/u9
1UJRMYEZHqvLJxWrSHe+NwZxcaYwGTWlnn6G69RJ5uC3leyuyFyKUdKcCLJR8c0/
nD001j/kwgtM+bkieMMCrWOEsKKCkLZGjSrZN0z/mDykDD26ITyCXrLgixXn+reJ
zFtzuMl49QDCB66Xb1d9oMbFcUzlJA==
=yjqa
-----END PGP SIGNATURE-----

--=-s09L+bRyOvtccCU/oR2v--

