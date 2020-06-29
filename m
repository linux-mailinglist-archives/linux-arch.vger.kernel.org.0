Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82420E920
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 01:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgF2XMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 19:12:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgF2XMH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jun 2020 19:12:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49wjtX2TZzz9s6w;
        Tue, 30 Jun 2020 09:12:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593472325;
        bh=941EdfoYDRZUrkZYne4BILEiumD128Dyv5nWhLt38Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sLMbOT6wQ3hn2zT7RtTkfHIS9I9MK5SK0XLE+DE+ooG1LgQcEekhbNTX/JQ5HbaDk
         7QDWgcXu4C9BzGOYD7KcTBRqyvvzpeb/mG4rNK062CMNXwOxAr4rxya7HCsD1fJW4x
         5VC3b+hMVe9whHbjzbd9wlLUpl5r6MjEA0dbfSvFuechCeYEi6VyChxgjb3QK8vSKQ
         3KGHuVr+C8Rio/hfn9CS39Mb0RDYu4QeZWZFUncFwkyOMGeMQJHphXkY6CvDl+whLL
         fu05tmZNgeVyHv1je3224wbTRpP4uacBfsI2PwoNvuDVxNSu9+2QNAL9mN4FP1EmjA
         EAqeE2a9Bmm9g==
Date:   Tue, 30 Jun 2020 09:12:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Message-ID: <20200630091203.55cdd5d9@canb.auug.org.au>
In-Reply-To: <20200617055843.GB25631@kroah.com>
References: <20200617092614.7897ccb2@canb.auug.org.au>
        <20200617092747.0cadb2de@canb.auug.org.au>
        <20200617055843.GB25631@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BCTuQZc6gP7JPm+u0nl1Qal";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/BCTuQZc6gP7JPm+u0nl1Qal
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> wro=
te:
>
> On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> > This is in preparation for removing the include of major.h where it is
> > not needed.
> >=20
> > These files were found using
> >=20
> > 	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> >=20
> > where /tmp/xx contains all the symbols defined in major.h.  There were
> > a couple of files in that list that did not need the include since the
> > references are in comments.
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
>=20
> Any reason this had an RFC, but patch 2/2 did not?
>=20
> They look good to me, I will be glad to take these, but do you still
> want reviews from others for this?  It seems simple enough to me...

I am going to do another round of this patchset splitting out most of
the "safe" removals that can be done anytime so other maintainers can
take them.  Then there will be the left over order dependent changes at
the end.

--=20
Cheers,
Stephen Rothwell

--Sig_/BCTuQZc6gP7JPm+u0nl1Qal
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl76dUMACgkQAVBC80lX
0GwhGQgAhvHebmqV9c+voc8vdC1Luf8C7PWLbdIb6f1iaY+N1bSNKmatpFwTZ1Up
yf4+QbGQUZbKdTwc7VvNADVmLtek6h9aPVEF+hNKSMFPwCiBCOhpMGCSx4bXFRsj
irlLoWruvzaAywFE6Qh8GOYbp+SSnW0T6KGnwfrn965opehsULzWBbBOoWY2euF8
73/adQZJiKUYpTQpvGDKdDBogQRAYs6AFer+7NUxXnH6FN9Zv4wicjMcSpWqss73
apAKvefLfTY0y+HD7JMoui4msRP+oP9AX7szdZQG81Ns7N26Kl6Uz09DsQCxp5mT
s5688o6hb+MACM2k5TVUFdQd+GE74g==
=aVuJ
-----END PGP SIGNATURE-----

--Sig_/BCTuQZc6gP7JPm+u0nl1Qal--
