Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EF20A30
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPOyK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 10:54:10 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:33296 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPOyK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 10:54:10 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D2A514E9C7;
        Thu, 16 May 2019 16:54:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id sn3AhIsEBiJY; Thu, 16 May 2019 16:54:00 +0200 (CEST)
Date:   Fri, 17 May 2019 00:53:41 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        elena.reshetova@intel.com, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190516145341.xx7bpyakezvpqujj@yavin>
References: <20190515100400.3450-1-christian@brauner.io>
 <CAKOZuesPF+ftwqsNDMBy1LpwJgWTNuQm9-E=C90sSTBYEEsDww@mail.gmail.com>
 <20190516130813.i66ujfzftbgpqhnh@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rl3rpkoiju4ooj2k"
Content-Disposition: inline
In-Reply-To: <20190516130813.i66ujfzftbgpqhnh@brauner.io>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--rl3rpkoiju4ooj2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-16, Christian Brauner <christian@brauner.io> wrote:
> On Wed, May 15, 2019 at 10:45:06AM -0700, Daniel Colascione wrote:
> > On Wed, May 15, 2019 at 3:04 AM Christian Brauner <christian@brauner.io=
> wrote:
> > > +       if (pid <=3D 0)
> > > +               return -EINVAL;
> >=20
> > WDYT of defining pid =3D=3D 0 to mean "open myself"?
>=20
> I'm torn. It be a nice shortcut of course but pid being 0 is usually an
> indicator for child processes. So unless the getpid() before
> pidfd_open() is an issue I'd say let's leave it as is. If you really
> want the shortcut might -1 be better?

I'd suggest not using negative numbers, and instead reserving them for
PIDTYPE_TGID if we ever want to have that in the future. IMHO, doing

  pfd =3D pidfd_open(getpid(), 0);

is not the end of the world.


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rl3rpkoiju4ooj2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzdeXUACgkQSnvnv3De
m58cOhAArH3Suh66uovI36Cs+UiaKF7pQq8Uj5fLxF9TEp/xA0aglqcZbJKrUIKr
DIaXBIm1GOitsaCBH/+k2puVlhgNpCPaskXKCWTACjS5l6z7NBQ3o4ZDgmy9sS6/
MgIMUnFpdpX+4qRBZPsvsfknvtBO9eI8cVfZIzo4NZnUzs5zRU6qToEKWCjQNscK
RzO+BsCNNkQXXlHBkNrdX4ue058LJyEAYop8gqPAMorepNpbcydpkRq1YWGbd4iS
3F5ZTCHdstprw5ZmFcLUaedwf4O1X9B+eulR82Y2PHSVoOHgidE3KcdouxMEXQlh
8KOVL1cpD2h+AdGu9znbvhKLP87kDoSbTSznKZ3dlFdk6YQQbOMvofXAay/zXRnJ
6GXTZ6r8KDhtoJTNdYRoBQUf+pgzLKLwPdnkzLfu3CFPMy6YpaBMFFt7DwTNG6Du
Q1nI8HIBPe0Sf7VNyv5qaixRR5rfKnqv80FPdQZD0MGsXTU7z7Iv9rZ7/g+/4ZdH
yLhuLIARtcqLd2LSNmHQFuBbuDxODQbtqS/89FmshKn+WHowS3/406NNYsvvdwTY
NGeva57n7Ke7NmdsO1uVsxPmTUHaxp55Vx0BTIQN4+in7mlYdf6I4qD0cVE1TGJQ
3AF3dH8bQrznZvmJUjXZY8dWRD4StRbAp822rBOY4+QyhbySjoY=
=SYyW
-----END PGP SIGNATURE-----

--rl3rpkoiju4ooj2k--
