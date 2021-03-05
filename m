Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50932E781
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCEL6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 06:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEL6I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 06:58:08 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81468C061574;
        Fri,  5 Mar 2021 03:58:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DsR7v2SyLz9sR4;
        Fri,  5 Mar 2021 22:58:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614945485;
        bh=L1NC9GV9BQ+E9+ry/jR63z+hknnTIJGa4fWZ4Daa1hY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RRhqKWCT2ZGCNhqG7CWrydw8rsBkf55ZdiKxlD9W92jlG0zCxTPsjRAO+SZ3/E+Qz
         G1JbEu/m4uxOYAFEVULj86D/q25BtbKfPyyBlJIxG/8j9YdVvjqILwbvttYoAmVss3
         0GkVDCWjLkBPqQiHJaJGzkfJ7Jl7qsPoR0tkpnrF5csXtnnAWzDwcf+6M9nJmDDegx
         dVRI9i5n5TyDn6OQHYmMOW/EgmjAkpeMFmDVRrfd4RvhQk2g6CBiWaJoAqZ6BNcMNd
         ROEx0HJ0zfDvX3FrIFKqtNHBdNylyCFhYy1m+CgFne2H6kkRZ7pPs0pj1d1OeUpazv
         sRtB9CzGrGiKg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command
 line.
In-Reply-To: <20210303181651.GE19713@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303172810.GA19713@willie-the-truck>
 <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu>
 <20210303174627.GC19713@willie-the-truck>
 <dc6576ac-44ff-7db4-d718-7565b83f50b8@csgroup.eu>
 <20210303181651.GE19713@willie-the-truck>
Date:   Fri, 05 Mar 2021 22:58:02 +1100
Message-ID: <87sg59rewl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Will Deacon <will@kernel.org> writes:
> On Wed, Mar 03, 2021 at 06:57:09PM +0100, Christophe Leroy wrote:
>> Le 03/03/2021 =C3=A0 18:46, Will Deacon a =C3=A9crit=C2=A0:
>> > On Wed, Mar 03, 2021 at 06:38:16PM +0100, Christophe Leroy wrote:
>> > > Le 03/03/2021 =C3=A0 18:28, Will Deacon a =C3=A9crit=C2=A0:
>> > > > On Tue, Mar 02, 2021 at 05:25:17PM +0000, Christophe Leroy wrote:
>> > > > > This code provides architectures with a way to build command line
>> > > > > based on what is built in the kernel and what is handed over by =
the
>> > > > > bootloader, based on selected compile-time options.
>> > > > >=20
>> > > > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> > > > > ---
>> > > > >    include/linux/cmdline.h | 62 ++++++++++++++++++++++++++++++++=
+++++++++
>> > > > >    1 file changed, 62 insertions(+)
>> > > > >    create mode 100644 include/linux/cmdline.h
>> > > > >=20
>> > > > > diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
>> > > > > new file mode 100644
>> > > > > index 000000000000..ae3610bb0ee2
>> > > > > --- /dev/null
>> > > > > +++ b/include/linux/cmdline.h
>> > > > > @@ -0,0 +1,62 @@
>> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
>> > > > > +#ifndef _LINUX_CMDLINE_H
>> > > > > +#define _LINUX_CMDLINE_H
>> > > > > +
>> > > > > +static __always_inline size_t cmdline_strlen(const char *s)
>> > > > > +{
>> > > > > +	const char *sc;
>> > > > > +
>> > > > > +	for (sc =3D s; *sc !=3D '\0'; ++sc)
>> > > > > +		; /* nothing */
>> > > > > +	return sc - s;
>> > > > > +}
>> > > > > +
>> > > > > +static __always_inline size_t cmdline_strlcat(char *dest, const=
 char *src, size_t count)
>> > > > > +{
>> > > > > +	size_t dsize =3D cmdline_strlen(dest);
>> > > > > +	size_t len =3D cmdline_strlen(src);
>> > > > > +	size_t res =3D dsize + len;
>> > > > > +
>> > > > > +	/* This would be a bug */
>> > > > > +	if (dsize >=3D count)
>> > > > > +		return count;
>> > > > > +
>> > > > > +	dest +=3D dsize;
>> > > > > +	count -=3D dsize;
>> > > > > +	if (len >=3D count)
>> > > > > +		len =3D count - 1;
>> > > > > +	memcpy(dest, src, len);
>> > > > > +	dest[len] =3D 0;
>> > > > > +	return res;
>> > > > > +}
>> > > >=20
>> > > > Why are these needed instead of using strlen and strlcat directly?
>> > >=20
>> > > Because on powerpc (at least), it will be used in prom_init, it is v=
ery
>> > > early in the boot and KASAN shadow memory is not set up yet so calli=
ng
>> > > generic string functions would crash the board.
>> >=20
>> > Hmm. We deliberately setup a _really_ early shadow on arm64 for this, =
can
>> > you not do something similar? Failing that, I think it would be better=
 to
>> > offer the option for an arch to implement cmdline_*, but have then poi=
nt to
>> > the normal library routines by default.
>>=20
>> I don't think it is possible to setup an earlier early shadow.
>>=20
>> At the point we are in prom_init, the code is not yet relocated at the
>> address it was linked for, and it is running with the MMU set by the
>> bootloader, I can't imagine being able to setup MMU entries for the early
>> shadow KASAN yet without breaking everything.
>
> That's very similar to us; we're not relocated, although we are at least
> in control of the MMU (which is using a temporary set of page-tables).

prom_init runs as an OF client, with the MMU off (except on some Apple
machines), and we don't own the MMU. So there's really nothing we can do :)

Though now that I look at it, I don't think we should be doing this
level of commandline handling in prom_init. It should just grab the
value from firmware and pass it to the kernel proper, and then all the
prepend/append/force etc. logic should happen there.

cheers
