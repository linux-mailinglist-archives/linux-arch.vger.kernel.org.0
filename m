Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4820AD6
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEPPMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 11:12:31 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:64364 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfEPPMb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 11:12:31 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id EE3654ECCC;
        Thu, 16 May 2019 17:12:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id XV0bnWpzQT6y; Thu, 16 May 2019 17:12:21 +0200 (CEST)
Date:   Fri, 17 May 2019 01:12:02 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>, jannh@google.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        dancol@google.com, serge@hallyn.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516151202.hrawrx7hxllmz2di@yavin>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
 <20190516145607.j43xyj26k6l5vmbd@yavin>
 <20190516150611.GC22564@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ndso2fpbrge26y3v"
Content-Disposition: inline
In-Reply-To: <20190516150611.GC22564@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ndso2fpbrge26y3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/17, Aleksa Sarai wrote:
> > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > On 05/16, Christian Brauner wrote:
> > > > With the introduction of pidfds through CLONE_PIDFD it is possible =
to
> > > > created pidfds at process creation time.
> > >
> > > Now I am wondering why do we need CLONE_PIDFD, you can just do
> > >
> > > 	pid =3D fork();
> > > 	pidfd_open(pid);
> >
> > While the race window would be exceptionally short, there is the
> > possibility that the child will die
>=20
> Yes,
>=20
> > and their pid will be recycled
> > before you do pidfd_open().
>=20
> No.
>=20
> Unless the caller's sub-thread does wait() before pidfd_open(), of course.
> Or unless you do signal(SIGCHILD, SIG_IGN).

What about CLONE_PARENT?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ndso2fpbrge26y3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzdfcIACgkQSnvnv3De
m5+LBg//TwYfNfdVTd12qfs8hOPFa2sx2DG90Wu3gEQ0F/cxogi+efP+RY/o+vPT
i0FYUiX+aGQ5bpWOfMVytL5PElsRY03f8GZSbweGW0m2y7Kb2cH+wx6qxe2s4RKI
JiNQ6UEIZcAHybLLKlbSaiIYMO1xmZxALchF/Nopq4lVDxpEKhOd8tJaZ5MWTQpi
WCGuVct2Mq+z2FVkdRZl0CXoSf4usXm/bGe/3P1Z/6ZllIwheasZP5whVSybpQa/
oDYZPJOHaPtKJ1DrXO3Qx5j17hltS97pT4DPWi/ad3AqMgHTdFoeuJOSLJzYZ3/d
XFiu4svN/b+dzLj75k+ki4HwbUln+Zz0mnHkgLRYUWC9a7j3bOf2qBxx3eWCIhbz
rRnc+kSy0Qu44pli5inNmPJF66MxVgMkvJtq1fmderaaywkBDjcgrsc7M9ScxUbW
CfPKBIhSZgmfUYqG+NCGXcgJEv4iI3xkFwWfOXGnCjYSoQkgIcJvszd3cVwacLX9
KImzTDjcb50CuNFbYtL5nOHjXl5cHDtsvASzSFZ1FIBZAwiXXnqQE2/byust72VY
WpysP1WuZmkwYLs13DebotUCbSQsvFvyZO6DXuY7JgYXz+rSCdTF4+vG7mjqg3Uo
UZk1XcunD1in53UE3nG2qfE9ayfhvwq6wQ+iSDdyfhDa9ocBjg8=
=utbj
-----END PGP SIGNATURE-----

--ndso2fpbrge26y3v--
