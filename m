Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFD202F2C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 06:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFVEZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 00:25:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFVEZQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 00:25:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49qxCZ42vcz9sSF;
        Mon, 22 Jun 2020 14:25:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592799914;
        bh=81fk/3JF3x95g9UbYd0X5h2GkzbHPz5gmaEBxnj+jVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVLEF0MfrgFcjT4UopaKCdZqhjZCBkC8sCydLQ9rpzF8hQlysIiUlrEhVRRu1KbPu
         xLQQKCzCgIn7jEHOh3zAUoxbqXhOWaE1C6lD5XEfLw03+d04InVN2f2k0y006OXJZn
         HAXk8fJBbAm74ej4N0yssS0FE5AL5ZVMLQBTsD9Dplb9KDTLp2L82yHtZZ6TiBWn78
         5T9XTcQZ10MiHxXSnmq2zpRJSZevl5teeqK3RrmfwwRAOD8e1q2qbtg64iMMDAP5s8
         61qgMbTW9OJ1zi7aCJkktsNpFWKpuBsKC2Rc7yuytFLhL7fMCUeBZXEv8bYOmM7vit
         uyoJrcO9LIIIw==
Date:   Mon, 22 Jun 2020 14:25:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Message-ID: <20200622142512.702bdc68@canb.auug.org.au>
In-Reply-To: <20200617161810.256ff93f@canb.auug.org.au>
References: <20200617092614.7897ccb2@canb.auug.org.au>
        <20200617092747.0cadb2de@canb.auug.org.au>
        <20200617055843.GB25631@kroah.com>
        <20200617161810.256ff93f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4E7sxZ+o7+5.7k+KqzAJoZd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/4E7sxZ+o7+5.7k+KqzAJoZd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 17 Jun 2020 16:18:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> w=
rote:
> >
> > On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote: =20
> > > This is in preparation for removing the include of major.h where it is
> > > not needed.
> > >=20
> > > These files were found using
> > >=20
> > > 	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> > >=20
> > > where /tmp/xx contains all the symbols defined in major.h.  There were
> > > a couple of files in that list that did not need the include since the
> > > references are in comments.
> > >=20
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>   =20
> >=20
> > Any reason this had an RFC, but patch 2/2 did not? =20
>=20
> I forgot :-)  I added RFC just to hopefully get some attention as this
> is just the start of a long slow use of my "spare" time.
>=20
> > They look good to me, I will be glad to take these, but do you still
> > want reviews from others for this?  It seems simple enough to me... =20
>=20
> Yeah, well, we all know the simplest patches usually cause the most pain =
:-)
>=20
> However, I have been fairly careful and it is an easy include file to
> work with.  And I have done my usual build checks, so the linux-next
> maintainer won't complain about build problems :-)
>=20
> I would like to hear from Arnd, at least, as I don't want to step on
> his toes (he is having a larger look at our include files).

Any comment?

--=20
Cheers,
Stephen Rothwell

--Sig_/4E7sxZ+o7+5.7k+KqzAJoZd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7wMqgACgkQAVBC80lX
0GxoIAf+KqJYIQ6vTc/0E/3RWnBpf5RrYu0GH9BW7ka5MpfFK4pMfzJzcpt2TWeL
O6efiNJ/SyHHA5BpeNsO/PLaYQH1uuXrOndVYqDzgC+9tOXzNNcg/QMbjV6R1krq
VzdB0kRGcNvEO2dvHPVJeon6/CYuQsG4+TJKX80scHRRF0ASD6xE9WeiT9pIUlUB
NUnjCkkVvYZnBJ+xkgwObQDlwCyODwQd0pgwQnsv/JC8+mOBvK79bxzWAoVQILai
5mZOAn6Y/dyQyt8IITo4s3bcSLRr/W3bGFcS90h8aKdBc4xp3olDQAMnxJrUp+gn
FAFRytt45UvyyiVGypIKzFMcHadQAg==
=dZlI
-----END PGP SIGNATURE-----

--Sig_/4E7sxZ+o7+5.7k+KqzAJoZd--
