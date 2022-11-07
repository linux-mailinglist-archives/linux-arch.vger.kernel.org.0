Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A46203E4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 00:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiKGXoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 18:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKGXoI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 18:44:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D101B9C6;
        Mon,  7 Nov 2022 15:44:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5nr15w3Lz4xG8;
        Tue,  8 Nov 2022 10:44:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667864644;
        bh=6tGnJx4xFcxyi53YuLvDg09sq/vF8JU+F9Dm+Wv/yT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EkQi/F6MmlFzMGPjCK8k60/v04HMpBC/xK/WLRTz36xt8wU7hxzDQvN4GHXSI6S9f
         3BSewDz+BtC48rqrXchFeJXA0yVHze07fdkq8fJvjxZJcV4otWuUZG+kw4W2FtP7fX
         iJGJKE3QQgBy2swlJaF3vBY7Anehx8XXmm6LYvuLjjlY+mmmYwfkrAM8fOJFnKIioa
         XiGf5u6mcM/oUOx9WixVcWTxGCa9mcQBsUhV0eVoEtz9Qhkn8DyNRzJ3jp443VbCjd
         AaC/icJDPZT4Je7wazNR0Cyxfy4yWT7Y2uxggw3xh7350hM3ZqvKtD+0s/j7R2vqdn
         pBUXApnItPycg==
Date:   Tue, 8 Nov 2022 10:44:00 +1100
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
Message-ID: <20221108104400.2b9e1e87@canb.auug.org.au>
In-Reply-To: <20221107150242.722ba8238cab04bf3c6dbc39@linux-foundation.org>
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
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
        <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
        <20221107150242.722ba8238cab04bf3c6dbc39@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mDVDEu_/wXxUJFe4K1OL1rQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/mDVDEu_/wXxUJFe4K1OL1rQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 7 Nov 2022 15:02:42 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> On Mon, 7 Nov 2022 08:19:24 -0800 Linus Torvalds <torvalds@linux-foundati=
on.org> wrote:
>=20
> Done, all pushed out to
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable.

Will be in today's linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/mDVDEu_/wXxUJFe4K1OL1rQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNpmEAACgkQAVBC80lX
0Gx2iwf9G7C0Ujog1oKHiXdDywl9/l0p8fxxuxt4IEmCazjWlttF9OhoYJT2/dd8
WtbBjrnTqi5g/M+G6ryt7xC0P1vKt1aWxldba2VJGrnx6dP3nG5p9rWGSGCIzzCC
IWr+tiLVPf/TnaaCsfDcuiUNq916LuYgcWfTAzu/2m8OEgSlNft75fZPNNJ7yiKo
H/QD8bcN5YgGCPm4jPgW8D/KnvE+/2gAEfxEzV+860AK1qDRjcJAsrotdiWNfC/U
s9NmrerkkNRanhyI+gV32VUCOqwYRvOtFCY8oH+1Wh7//l9XhbjTcSd15kdoXPiT
t4bg4hsFBzHhFGTOJLdMFoMsas0J6A==
=GUew
-----END PGP SIGNATURE-----

--Sig_/mDVDEu_/wXxUJFe4K1OL1rQ--
