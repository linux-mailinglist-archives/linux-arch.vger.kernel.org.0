Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F661E7D0
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 01:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiKGAGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Nov 2022 19:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiKGAGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Nov 2022 19:06:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D49BE39;
        Sun,  6 Nov 2022 16:06:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5BNg6v9Cz4xDK;
        Mon,  7 Nov 2022 11:06:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667779606;
        bh=PEtFVE11aUocVEWH3BRg2hxUlPqEtbP6pNHSK4p3WHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ScVpQ5QGU5/oOCeqNiAlmxRs+0O1+WBCdfkk+kUsu8Lr2oaP/D8T/dfznelRDbljp
         vrG2UjZTUnK4653vqrl51kSihLWFUz6UPq2r+NA9HaaVojWFSjmefAYboVZ3ja4lvr
         fxMp2eMO58LSv30Q6cYZ/dbjD6Oj0KFN9RZwIpFYQDXRPH06M54OffSoqaYCKi2ulA
         5bbgTdjKKKJXJP5LPldGAplZ0yKHPvwAhDGiQcgTImZX2ZX+mQLo9EYXZlNaqUp6P/
         y1idlrBie29pi/mf8TudAtivkNcoRE5NntrhkHvYXMbjeg96QRdaZiPGbPyyT151AR
         yrKI+3BlLm5Ag==
Date:   Mon, 7 Nov 2022 11:06:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: mm: delay rmap removal until after TLB flush
Message-ID: <20221107110642.0f7cf886@canb.auug.org.au>
In-Reply-To: <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
        <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
        <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
        <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
        <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
        <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
        <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
        <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
        <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
        <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
        <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
        <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
        <CAHk-=wgvx5sDaOfCTMkVpZ9+-iFCeh5AOML5aJG1EiR0+e1aBQ@mail.gmail.com>
        <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bAuVKIBtYnHc4hWVhD/GQqd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/bAuVKIBtYnHc4hWVhD/GQqd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 6 Nov 2022 15:14:16 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> Yes, I've removed both serieses and shall push the tree out within half
> an hour from now.

And I have picked up the new version for today's linux-next.  Thanks all.

--=20
Cheers,
Stephen Rothwell

--Sig_/bAuVKIBtYnHc4hWVhD/GQqd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNoTBIACgkQAVBC80lX
0GzqCwgAkzgOwwKSyOvOOPT+9Jvf8ki09kLVKQ795ok8w5kz3sGzCoOMyKSUPUGo
+isMdjE7ctVDXyDyNt38WrkoepLeuiO9G9r0xVLvD7mIMAewNHf8x6oPxUB38fA+
O4wI5ewtQGmWugOj4uGcvqXds9r8k93ByX+9gIxcwbdCQXVkVRwSkyfxabH40fTW
847Kdv6C/giBasAxPyIRBphdDa1m9QUR1xcVI+lROSZ0ouuXzU5lgyor/uk/Gwa2
QQC1zL58LzibCUU1HFmY2SkRSLfRWEB+h++iCv5NvfSNW7ZKJF4dcrPPICH598KN
biLKRWXv9sH8oy6X2RX/369eWh9A9A==
=adI7
-----END PGP SIGNATURE-----

--Sig_/bAuVKIBtYnHc4hWVhD/GQqd--
