Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC9282422
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJCM4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJCM4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 08:56:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37851C0613D0;
        Sat,  3 Oct 2020 05:56:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c2so6388987qkf.10;
        Sat, 03 Oct 2020 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tBhayu6otLmu5lubwgk7z2M5i2Hi61mYRYv6QN//oIE=;
        b=RaeN5PVplUgqj36ANCHJrwZoahySage7N3MgUG8LJNsFdlyDrXf31EkvYfDF2h7R2A
         Ovd7GuCeNCJ0an3MX8mlJnklMptgytugOfsnjG6JGG/PztVBdeZM/RUrHc4ncD35otnY
         Oqmr9T6Qm/T8k2sNxxEqcxpdqEOdv5UMkHTDxEs2EqRmMEks8XQ4YRyRykfgV6syAQcg
         w1CoU5+DpXVmyrk8V8rt52N4AQqheiVLBkeFfkjjzdcdWTPn8inxrz/1gczpNKJeNy4I
         MY/rkWd8Z//A4+YzUEBmj8MRfDPZwjJZW52VN7gUDImCRiWS/BXvDp6m4uwjgXNTbHgq
         xFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tBhayu6otLmu5lubwgk7z2M5i2Hi61mYRYv6QN//oIE=;
        b=LFeBCfpbGCHmPNOTVj4m8dmXs8B4XO/NXCNbCI8H4ZZSGApDNgjTOuC3hlkaLpwM+8
         as0cjioQvx+XId9AWx0k3FqpQYucfEFu5xiNBZhHCclNwOkliXDtK2FRIW9y97+flglv
         1Xl0jtu5vpda12F5mItfUGGfj85+CtWARVp7v3/vTAf3OcwiVDnBSjS1eMNanOPnEKkj
         OQWYy11i9CbZpVhmapV6DE7xzLCcvnpiO43+ANq/37h5UaXgE1OtYhr43CIo2ktqces8
         uEgAsjxBYVObpBhrwL9WSBfqWpi115LXZsymoemB69YnOYTbaSPlfo0vdkzkUlPSO09K
         HXcw==
X-Gm-Message-State: AOAM533wLR96eLq2q+aYSo+PXqiBJpzJWVNMbeparb/CDkz/jZ9CB4ru
        DVWscrVWLdDFpV16J+lFmRs=
X-Google-Smtp-Source: ABdhPJzagz6Aoh9D2U9bg3fpyuzlNyv5uFtKpNv1Ff5TEd4L1UJDValDSB0zYg6h39kqQP1uWjYLCQ==
X-Received: by 2002:a37:84f:: with SMTP id 76mr6444461qki.251.1601729802184;
        Sat, 03 Oct 2020 05:56:42 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o28sm3388405qtl.62.2020.10.03.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 05:56:41 -0700 (PDT)
Date:   Sat, 3 Oct 2020 08:56:26 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <20201003125626.GA3732@shinobu>
References: <cover.1601679791.git.syednwaris@gmail.com>
 <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
 <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
 <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
 <CAHp75VdC+eH0ScksdAVp==HnDMTMY3vVUZM5NZy6mfVSR0YoLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <CAHp75VdC+eH0ScksdAVp==HnDMTMY3vVUZM5NZy6mfVSR0YoLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2020 at 03:45:04PM +0300, Andy Shevchenko wrote:
> On Sat, Oct 3, 2020 at 2:37 PM Syed Nayyar Waris <syednwaris@gmail.com> w=
rote:
> > On Sat, Oct 3, 2020 at 2:14 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.co=
m> wrote:
>=20
> ...
>=20
> > > > +/**
> > > > + * bitmap_get_value - get a value of n-bits from the memory region
> > > > + * @map: address to the bitmap memory region
> > > > + * @start: bit offset of the n-bit value
> > > > + * @nbits: size of value in bits
> > > > + *
> > > > + * Returns value of nbits located at the @start bit offset within =
the @map
> > > > + * memory region.
> > > > + */
>=20
> ...
>=20
> > > > +               return (map[index] >> offset) & GENMASK(nbits - 1, =
0);
> > >
> > > This is UB in GENMASK() when nbits =3D=3D 0.
> >
> > 'nbits' actually specifies the width of clump value. Basically 'nbits'
> > denotes how-many-bits wide the clump value is.
> > 'nbits' having a value of '0' means zero-width-sized clump, meaning
> > nothing. 'nbits' can take valid values from '1' to BITS_PER_LONG.
> > The minimum value the 'nbits' can have is 1 because the smallest sized
> > clump can be 1-bit-wide. It can't be smaller than that.
> >
> > Let me know if I have misunderstood something?
>=20
> It's still possible to call with an nbits parameter be equal to 0.
> If code is optimized to allow it, it should be documented that 0
> parameter is not valid and behaviour is undefined.

Documenting that 0 is not valid would be preferred because an additional
conditional check in the code could add a significant latency in a loop.
So perhaps change the documentation line to:

    @nbits: size of value in bits (must be between 1 and BITS_PER_LONG)

>=20
> ...
>=20
> > > > +/**
> > > > + * bitmap_set_value - set n-bit value within a memory region
> > > > + * @map: address to the bitmap memory region
> > > > + * @value: value of nbits
> > > > + * @start: bit offset of the n-bit value
> > > > + * @nbits: size of value in bits
> > > > + */
>=20
> ...
>=20
> > > > +       value &=3D GENMASK(nbits - 1, 0);
> > >
> > > This is UB when nbits =3D=3D 0.
> >
> > Same as above.
> > 'nbits' actually specifies the width of clump value. Basically 'nbits'
> > denotes how-many-bits wide the clump value is.
> > 'nbits' having a value of '0' means zero-width-sized clump, meaning
> > nothing. 'nbits' can take valid values from '1' to BITS_PER_LONG.
> > The minimum value the 'nbits' can have is 1 because the smallest sized
> > clump can be 1-bit-wide. It can't be smaller than that.
>=20
> Same as above.
>=20
> ...
>=20
> > > > +               map[index] &=3D ~BITMAP_FIRST_WORD_MASK(start);
> > > > +               map[index] |=3D value << offset;
>=20
> Side note: I would prefer + 0 here and there, but it's up to you.
>=20
> > > > +               map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + =
nbits);
> > > > +               map[index + 1] |=3D (value >> space);
>=20
> By the way, what about this in the case of start=3D0, nbits > 64?
> space =3D=3D 64 -> UB.
>=20
> (And btw parentheses are redundant here)

I think this is the same situation as before: we should document that
nbits must be between 1 and BITS_PER_LONG.

William Breathitt Gray

>=20
> > > And another LKP finding was among these lines, but I don't remember t=
he details.
> >
> > Yes you are right. There was sparse warning reported for this.
> > sparse: shift too big (64) for type unsigned long
> > The warning was reported in patch [4/4] referring to this patch [1/4].
> >
> > Later it was clarified by the sparse-check maintainer that this
> > warning is to be ignored and no code fix is required.
> >
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2202377.ht=
ml
>=20
> Ah, okay!
> --
> With Best Regards,
> Andy Shevchenko

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl94dPAACgkQhvpINdm7
VJLf1BAAueOIVwbwR8cM7ji/AgVlm8dAQHElt7ou00AOyNdwMt0FuwFpNR5Fkrg9
+5iR+RA2nIJoKtsVxong0+9GF+Q7XVWRW+9J7At+xxJ7oe1N237b0rdFbMSAkS1M
ZrF6F0N7Fzz8VtD9Zj/qzLYp4VMP0Jltu5xKF9g7Ewe6uOTaNG/h64dkm1CklMdr
iJqr830UHQoJ1xgvq3Ng0HTTJuL+L62L6a0uTGuDJU9trRIs92YfmxH9uRLJY5gY
jWF6IB+6YDbEuuSN6KGwmAtO9qEub1EOvnNnNDhd8fPs7+659bJkbFpsD8zGsXlK
uS/9SCskQelBzlk/bfjse2bbIbs7EaTb4zN7N4FH431P3G+ljnW//931vS71gaiO
x1FCkPDl6Fe8kghSXfIqlb6Eu/rlNGlsKnpWOudQyKLQIvXzVl6fLKkSGi2n7ESj
qF13cA2IQTysSAAJ9LKQUdGEJS3+5LmeA9CYmpQ458Uxt6xnhdJqfTBR6r4nXmfb
5jqj8M3XH8Jmf+/aC1xs1sLeSX/mLlhH0sVEU9mglcFkpooTnrvoSHycI6vjUaaf
hGpRb6/pAazH2+c7LBnQGJmoBIPf+JptQta00+7Ws5kO2W8/cuxk3DeEEzizeh5S
NBtxhZtw8pS3V64pyV+ZPwB2V1CCb8PO11XgTVY59Rc5CL2wi6M=
=zC9t
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
