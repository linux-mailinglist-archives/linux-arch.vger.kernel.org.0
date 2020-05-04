Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A01C3D36
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgEDOgx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgEDOgx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2020 10:36:53 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF98C061A0E;
        Mon,  4 May 2020 07:36:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k12so14147310qtm.4;
        Mon, 04 May 2020 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNaisMDGArpGlPRfLRKQpHWPsiqYB+mHRPWMY51uCAQ=;
        b=qtGPFaTG60O8J34EhvZpk3924NedCpipS+FUIhDlhb2/hR5StrKGg+2eW4b25LUI0S
         fB53RVN6vCa3AFyJtksjKuks5c+u5SOD1Y3ZzJ+U5GAOhzJheV+mU1otV8fXFa6poXMS
         jJRa/YSIFLA1vVNjzwpwvO7MzNsMoZEyp5MsZafMflN3s7AYH6+oIFTZzMgapW1dWCge
         VQeojOux9J4fpxrYGcZ7ZSo1FaSoPHAklU18oGkGIes1Bg/IbQlZn6jRzNe93uQbcEHd
         sx7g2GZHWwjJKGzSDjNtzGv128eWFZH8ME+nYwyXUzklmBwxlxrPv7upVb6FI+VJIc8L
         mPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNaisMDGArpGlPRfLRKQpHWPsiqYB+mHRPWMY51uCAQ=;
        b=ODcfquzVhMc1uoVTQjpktxVkxE+F5ZCjv0ZIxpz5LvXSKTHX2CMtdUX3evZjTE9sBr
         rTLqbkbRIfXwWhsF6iws47taigMoXxoE84zeaOFBLCoSAJ8NGmGdehwrysQv7YsY4UZL
         LVQ8Kl/7E+EXUGcgxHvt+cu6CnAxc8n6XNLjcQoZY+YNq4mP3qcI0T1CWjH01WoLDZ5i
         e+YtM+iBbnqYYUFU8s5tVa6qsf2WCyHaqNb/2raBWxARoTihTbXG9XqnF/nDDM0JYkRy
         FOkaALny2eBneP2f/SxS+LgXyAMmPoQ6O4jF9sn9x00TIrIiB/LTnrWAXc+LGlRhUL6O
         yQHQ==
X-Gm-Message-State: AGi0PubTPID33DZdWJcrVnOwWhb1fzzMtvo0guwYYkzMJkC4VuICUnOK
        yEq/2qmjT5gxYM9dyVPIunGIqtJWxf0yNQ==
X-Google-Smtp-Source: APiQypIbJPPwO/DmtFYahHsceOEOsov12ceFH6yGUL37oEyLSYTRwG1BzJLG1K8UCUpwOT373WaocA==
X-Received: by 2002:ac8:794b:: with SMTP id r11mr7962248qtt.155.1588603012401;
        Mon, 04 May 2020 07:36:52 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id x124sm8132801qkd.32.2020.05.04.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:36:51 -0700 (PDT)
Date:   Mon, 4 May 2020 10:36:38 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        akpm@linux-foundation.org, michal.simek@xilinx.com, arnd@arndb.de,
        rrichter@marvell.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, yamada.masahiro@socionext.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
Message-ID: <20200504143638.GA4635@shinobu>
References: <cover.1588460322.git.syednwaris@gmail.com>
 <20200504114109.GE185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20200504114109.GE185537@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 02:41:09PM +0300, Andy Shevchenko wrote:
> On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:
> > This patchset introduces a new generic version of for_each_set_clump.=
=20
> > The previous version of for_each_set_clump8 used a fixed size 8-bit
> > clump, but the new generic version can work with clump of any size but
> > less than or equal to BITS_PER_LONG. The patchset utilizes the new macr=
o=20
> > in several GPIO drivers.
> >=20
> > The earlier 8-bit for_each_set_clump8 facilitated a
> > for-loop syntax that iterates over a memory region entire groups of set
> > bits at a time.
> >=20
> > For example, suppose you would like to iterate over a 32-bit integer 8
> > bits at a time, skipping over 8-bit groups with no set bit, where
> > XXXXXXXX represents the current 8-bit group:
> >=20
> >     Example:        10111110 00000000 11111111 00110011
> >     First loop:     10111110 00000000 11111111 XXXXXXXX
> >     Second loop:    10111110 00000000 XXXXXXXX 00110011
> >     Third loop:     XXXXXXXX 00000000 11111111 00110011
> >=20
> > Each iteration of the loop returns the next 8-bit group that has at
> > least one set bit.
> >=20
> > But with the new for_each_set_clump the clump size can be different fro=
m 8 bits.
> > Moreover, the clump can be split at word boundary in situations where w=
ord=20
> > size is not multiple of clump size. Following are examples showing the =
working=20
> > of new macro for clump sizes of 24 bits and 6 bits.
> >=20
> > Example 1:
> > clump size: 24 bits, Number of clumps (or ports): 10
> > bitmap stores the bit information from where successive clumps are retr=
ieved.
> >=20
> >      /* bitmap memory region */
> >         0x00aa0000ff000000;  /* Most significant bits */
> >         0xaaaaaa0000ff0000;
> >         0x000000aa000000aa;
> >         0xbbbbabcdeffedcba;  /* Least significant bits */
> >=20
> > Different iterations of for_each_set_clump:-
> > 'offset' is the bit position and 'clump' is the 24 bit clump from the
> > above bitmap.
> > Iteration first:        offset: 0 clump: 0xfedcba
> > Iteration second:       offset: 24 clump: 0xabcdef
> > Iteration third:        offset: 48 clump: 0xaabbbb
> > Iteration fourth:       offset: 96 clump: 0xaa
> > Iteration fifth:        offset: 144 clump: 0xff
> > Iteration sixth:        offset: 168 clump: 0xaaaaaa
> > Iteration seventh:      offset: 216 clump: 0xff
> > Loop breaks because in the end the remaining bits (0x00aa) size was less
> > than clump size of 24 bits.
> >=20
> > In above example it can be seen that in iteration third, the 24 bit clu=
mp
> > that was retrieved was split between bitmap[0] and bitmap[1]. This exam=
ple=20
> > also shows that 24 bit zeroes if present in between, were skipped (pres=
erving
> > the previous for_each_set_macro8 behaviour).=20
> >=20
> > Example 2:
> > clump size =3D 6 bits, Number of clumps (or ports) =3D 3.
> >=20
> >      /* bitmap memory region */
> >         0x00aa0000ff000000;  /* Most significant bits */
> >         0xaaaaaa0000ff0000;
> >         0x0f00000000000000;
> >         0x0000000000000ac0;  /* Least significant bits */
> >=20
> > Different iterations of for_each_set_clump:
> > 'offset' is the bit position and 'clump' is the 6 bit clump from the
> > above bitmap.
> > Iteration first:        offset: 6 clump: 0x2b
> > Loop breaks because 6 * 3 =3D 18 bits traversed in bitmap.
> > Here 6 * 3 is clump size * no. of clumps.
>=20
> Looking into the last patches where we have examples I still do not see a
> benefit of variadic clump sizes. power of 2 sizes would make sense (and be
> optimized accordingly (64-bit, 32-bit).
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

There is of course benefit in defining for_each_set_clump with clump
sizes of powers of 2 (we can optimize for 32 and 64 bit sizes and avoid
boundary checks that we know will not occur), but at the very least the
variable size bitmap_set_value and bitmap_get_value provide significant
benefit for the readability of the gpio-xilinx code:

	bitmap_set_value(old, state[0], 0, width[0]);
	bitmap_set_value(old, state[1], width[0], width[1]);
	...
	state[0] =3D bitmap_get_value(new, 0, width[0]);
	state[1] =3D bitmap_get_value(new, width[0], width[1]);

These lines are simple and clear to read: we know immediately what they
do. But if we did not have bitmap_set_value/bitmap_get_value, we'd have
to use several bitwise operations for each line; the obfuscation of the
code would be an obvious hinderance here.

William Breathitt Gray

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6wKGIACgkQhvpINdm7
VJKZaxAA563CCfH6P1WpErURHBsLjHAUFl6mWCySrxGYUSYQqsxhz1w30MzHhckw
kQBx1mik+w14YUypQ7ISU8a8EWdkbHEW2xyKPKb7jnWnz/7SWf69BzkZJJBrzeXP
89IGJNkWXg5sVx2AWPA5aY4aQqita5RAEbZvroQKQr3C264kV5lH86GxG9KRD5+E
O71wWPdZ48+5sM9PXS6DH3F/BJ67g8Ii43WqNLrJ5C7JW370iYsaLiF/wspSFtpZ
a7BNAOPhJB7qkBhl14KwotTAMkv7crq1WLKP8D/0ycsrZNGiMaS7rmYyWM5DSZOb
zWmI082M3v3KL+XLtIHx59kjM3wkE6P1cMdRbh7ba06xn2Sx5Ml45wto1F0eVTwi
Pl+FfnefRZ7GYp5Zi2HfAl7LciWArBiFQTjj+8AJivE5dAXQSkjbB0EjJGsrdBQG
VgynevuG1Ni7wW99wO0LA/zv3EoZd7bqcZRmd/ntLZIUY2pw+llKODzUJYXxz3zh
QIkppvkkaQMv9/0XksRNIRETvzEy5fI3eVD2LFZrndu3fYEHXdHuQiFRZuvjnjao
8CG3LMAzfWjBy8fIApCXtYAScRxFw3lcwAl/G0VsI98rVZ6z1J7LhawStPRfG7FE
NUjbshq/FN/pSVsTKkXCJiSXdgyckbjkeFry5GOyDcrncEzWH5Y=
=mCyx
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
