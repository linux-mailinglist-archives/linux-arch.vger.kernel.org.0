Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F61F6ED
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfEOOvv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 10:51:51 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:60552 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfEOOvv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 May 2019 10:51:51 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 36D13A1145;
        Wed, 15 May 2019 16:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id X8vroVdtsNp3; Wed, 15 May 2019 16:51:23 +0200 (CEST)
Date:   Thu, 16 May 2019 00:51:05 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Yann Droneaud <ydroneaud@opteya.com>, jannh@google.com,
        oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515145105.t7u6v5wxsq2tnbwj@yavin>
References: <20190515100400.3450-1-christian@brauner.io>
 <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
 <20190515141634.lrc5ynllcmjr64mn@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zvewrqzesizclxu"
Content-Disposition: inline
In-Reply-To: <20190515141634.lrc5ynllcmjr64mn@brauner.io>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--2zvewrqzesizclxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-15, Christian Brauner <christian@brauner.io> wrote:
> On Wed, May 15, 2019 at 04:00:20PM +0200, Yann Droneaud wrote:
> > Would it be possible to create file descriptor with "restricted"
> > operation ?
> >=20
> > - O_RDONLY: waiting for process completion allowed (for example)
> > - O_WRONLY: sending process signal allowed
>=20
> Yes, something like this is likely going to be possible in the future.
> We had discussion around this. But mapping this to O_RDONLY and O_WRONLY
> is not the right model. It makes more sense to have specialized flags
> that restrict actions.

Not to mention that the O_* flags have silly values which we shouldn't
replicate in new syscalls IMHO.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2zvewrqzesizclxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzcJ1kACgkQSnvnv3De
m5+m3g//R5zkvJNpR/uERo7fQzZ+8FbxYCxRtilFUHcBIdsgV/Lx50jsUxWug4Zl
9r3C4jToLLKtMADwKihJR+E1ftE2STZ85hvLL0wpKX2kUqQcby7sU+XqgAFDuFXe
eJLnHxTbErqrqcU8Qz1+0nTAxiPcekV2c7jB1+jQtFvakcqlxaT2CtK2/7P3sw2P
G8mLXOL8uRx2WQ4z94SwfQ4kFwx14SIfWOA3kXVCDsuOoisQBqFsq9WhTwVsTb1X
H9KRNF58YIjBkWTVe3VcJZiVKXfqZxYbZDhHSQiibqyFZ3JkBjeo+FS9xoGqCNkl
I1M/BRHkyfhy1fIA8sIq82Bf1XXj4gaunsAk26xJqdpNnwUzXLT9IqXB/cD+D0+/
v6SzkNckMf/igucg6Ev9n8Z+Asst7aTfDLkrtPubFrYsD8FjgsU7xqMlN5lnVMx3
ovXX+xt0yRgVaczFTA0oWlc316Cje3SfchGc5dYce1BdsM98UaveoFKqsZ2QFyA7
sHNClAFebnAGwYAcOAWgz4dU+B2YmDv1Z1xJ52IyGcPo4KGXYBfY9X3J+rIXTLhc
0qp7vr8JIII/pSDquixjtG+aI+eLtl0g72mUM1KlOGDJZhQG14VRasjEI1M098Fk
GRGn0Y2fOWPigwhq0zRKpIIp2d3YXZY8TamkTEMXPY3azLq50Jk=
=+Ix9
-----END PGP SIGNATURE-----

--2zvewrqzesizclxu--
