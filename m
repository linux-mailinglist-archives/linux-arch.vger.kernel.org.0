Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA51E8A10
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 23:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgE2Vb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE2Vb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 17:31:29 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C56C03E969;
        Fri, 29 May 2020 14:31:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j32so3174356qte.10;
        Fri, 29 May 2020 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtz+8mLFx+CuTw1KPB8SkhWXd9L/hyK9MKQ9VWq/bH4=;
        b=fJrgKbiWtWgygbhWfMUMUyarBmb8vR7GAXcXVuYBloMuhcse6IH4q8sVH9HGKXfH4j
         QD20a+nq0657GfGXxv8KEh3Sgsmemt6duLHeljrVojEsbvoYuPVbw35QpG4yVMlbtQ42
         CJTZ6r38zthEuWQ0hepOnJlVRc9F/oAzSZeghHxyhz6pD5zmqqi2OKUJTtLzejNkib6v
         u4IkqPxvuiDIHOZM714NqzZ/rJt09RTag6GxhtychlH2Xx5WT66rKVuzZsSKma/EZIYg
         qz8SlP4de5rVSoFfYFy9K86vwMJFQ/bhoDz3AwRewSEGHK2Dcw2NcXFG4Ts8TL5VdRv4
         cNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtz+8mLFx+CuTw1KPB8SkhWXd9L/hyK9MKQ9VWq/bH4=;
        b=XFrX4tk5Pgk+yKf1G5rT20ATtZUKEHLYGIuamae0+AsAWvZ/UFwhldBKZeQJkP1ujf
         9pf/H3QJd1BtmnpSENKyYi5thA4B079bceY+6FP8NPY6ah4mwRFlDopmJ1SKj47gaWw6
         WAMn1sQcdRmSLvIYc3qERf6ZfA68FnzBzIY0T5XM2IDoVcCIs285OJHJyFZGiauN3lv7
         c0EYMbL40HLZeZRH3yh87V+vrkd2GR0rOBAvxtX+SxV8+QkwLE2HFIvilGGPRLVN1ZqP
         9oi19zJkkndKO4iZ58OMt4vVUAuOetLqsXjusdnuk+K5hE8NkAEK89gJCOSfeqHZ7fT+
         cVSw==
X-Gm-Message-State: AOAM531Bed9fZUIDwRb0sECEqTHvsQv4mU+4uNvlPaUQ738ZpyZJTzi8
        azaSbE4eMf+P62aQp6L9JaE=
X-Google-Smtp-Source: ABdhPJwiiGuL+0rqVj/jO7RfqkKb4+Yuu0/c1U0fh7MTX/Zoc7IZSGg1kOS6jwUlL8zgtPmTEn9CVg==
X-Received: by 2002:ac8:7683:: with SMTP id g3mr11215959qtr.240.1590787887111;
        Fri, 29 May 2020 14:31:27 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 5sm8184842qko.14.2020.05.29.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:31:25 -0700 (PDT)
Date:   Fri, 29 May 2020 17:31:11 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200529213111.GA25882@shinobu>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com>
 <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com>
 <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2020 at 01:32:44AM +0530, Syed Nayyar Waris wrote:
> On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wro=
te:
> >
> > ...
> >
> > > >    579  static inline unsigned long bitmap_get_value(const unsigned=
 long *map,
> > > >    580                                                unsigned long=
 start,
> > > >    581                                                unsigned long=
 nbits)
> > > >    582  {
> > > >    583          const size_t index =3D BIT_WORD(start);
> > > >    584          const unsigned long offset =3D start % BITS_PER_LON=
G;
> > > >    585          const unsigned long ceiling =3D roundup(start + 1, =
BITS_PER_LONG);
> > > >    586          const unsigned long space =3D ceiling - start;
> > > >    587          unsigned long value_low, value_high;
> > > >    588
> > > >    589          if (space >=3D nbits)
> > > >  > 590                  return (map[index] >> offset) & GENMASK(nbi=
ts - 1, 0);
> > > >    591          else {
> > > >    592                  value_low =3D map[index] & BITMAP_FIRST_WOR=
D_MASK(start);
> > > >    593                  value_high =3D map[index + 1] & BITMAP_LAST=
_WORD_MASK(start + nbits);
> > > >    594                  return (value_low >> offset) | (value_high =
<< space);
> > > >    595          }
> > > >    596  }
> >
> > > Regarding the above compilation warnings. All the warnings are because
> > > of GENMASK usage in my patch.
> > > The warnings are coming because of sanity checks present for 'GENMASK'
> > > macro in include/linux/bits.h.
> > >
> > > Taking the example statement (in my patch) where compilation warning
> > > is getting reported:
> > > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > >
> > > 'nbits' is of type 'unsigned long'.
> > > In above, the sanity check is comparing '0' with unsigned value. And
> > > unsigned value can't be less than '0' ever, hence the warning.
> > > But this warning will occur whenever there will be '0' as one of the
> > > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> > >
> > > This warning is getting cleared if I cast the 'nbits' to 'long'.
> > >
> > > Let me know if I should submit a next patch with the casts applied.
> > > What do you guys think?
> >
> > Proper fix is to fix GENMASK(), but allowed workaround is to use
> >         (BIT(nbits) - 1)
> > instead.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
>=20
> Hi Andy. Thank You for your comment.
>=20
> When I used BIT macro (earlier), I had faced a problem. I want to tell
> you about that.
>=20
> Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
> clump size) is BITS_PER_LONG, unexpected calculation happens.
>=20
> Explanation:
> Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my compute=
r),
> (BIT(nbits) - 1)
> gives a value of zero and when this zero is ANDed with any value, it
> makes it full zero. This is unexpected and incorrect calculation happenin=
g.
>=20
> What actually happens is in the macro expansion of BIT(64), that is 1
> << 64, the '1' overflows from leftmost bit position (most significant
> bit) and re-enters at the rightmost bit position (least significant
> bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> subtracted from this, the final result becomes 0.
>=20
> Since this macro is being used in both bitmap_get_value and
> bitmap_set_value functions, it will give unexpected results when nbits or=
 clump
> size is BITS_PER_LONG (32 or 64 depending on arch).
>=20
> William also knows about this issue:
>=20
> "This is undefined behavior in the C standard (section 6.5.7 in the N1124=
)"
>=20
> Andy, William,
> Let me know what do you think ?
>=20
> Regards
> Syed Nayyar Waris

We can't use BIT here because nbits could be equal to BITS_PER_LONG in
some cases. Casting to long should be fine because the nbits will never
be greater than BITS_PER_LONG, so long should be safe to use.

However, I agree with Andy that the proper solution is to fix GENMASK so
that this warning does not come up. What's the actual line of code in
the GENMASK macro that is throwing this warning? I'd like to understand
better the logic of this sanity check.

William Breathitt Gray

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl7RfwsACgkQhvpINdm7
VJJhlw//e+7H6kFZycy9xd7K62j4lqCx7Afz2mOmeY3hJ7X2gZhYUZZFh1e8yXYM
PRGOW738gyQWXWVdHyuhBSQvzfRmWYFxseBzXtOzxrZSUbUXCI1HPOoAP1SobKzW
XhbYgG8r3GgWOnDtidmn1jEEPmzfsG+6AV6sJ5U8KtXAjrn+hSG7PQPAWbTkEHVU
qX9FQsJez4GNARzxIFmOcZpJ8nhiOzhojRMdLrD4t2tdDXmd1ijdeG9FraiMqERw
0M+FzNabBYrmh/rxsc3PG6Yq6QOe94L1jOjrdnRqzaSR6Y1zJ9aZuzwaozryUgke
ZkoQVgn6QIvvTaBa7WtFNYw6LXFFH5Tx2tOv8YWjN52LamW6zTyOhzoQZCyjK+kD
C1w3DMHGqi+V7AjB6EMNQOvCnJgtPw43y0LVxOGugM9S1D/BgcMmZAn0cV0+E7pS
mFeCdBanWrJeZ8xE/dVm4+Y2jOIIsPH2iAr1il8sBgdZXvXqGeRrB4uoF7CJECNQ
vsn2ExxWHDh4jiVWMaDkF7131sdg/ffJApkJkaIpkq2WJAS88RrOJY6yuyTPyhi/
f8HUBq6XBQVQlnnRD+zhIf28oLHvePx6gqyIAtVdHJy9OKj0sSUfWxgZvb1xnwZ7
rQ5lwovxRku8mCoi80TBsDTWMnBUjDLlSZHSLhVNKs2Raa01Akw=
=vqfY
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
