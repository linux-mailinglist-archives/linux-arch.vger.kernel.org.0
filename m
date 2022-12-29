Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5A4658A8A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Dec 2022 09:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiL2Iaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Dec 2022 03:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2Iay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Dec 2022 03:30:54 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A2EBF2;
        Thu, 29 Dec 2022 00:30:52 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 31BDD1C09F6; Thu, 29 Dec 2022 09:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1672302650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GMDiP+si500La00phNcMqFDqIk07ZuaffuXl6TOuXZk=;
        b=hreBY2Gq0qPdVV2AreCvib6znrR+veQn1XOcjer0BGSek7nBorfHy6PV3r6geAMyF4RJPR
        GcW1vrsHK6cVVfsIysL8GTR+Gdakje/O8QKG/HSFjWyjMQU1LG3teBsW6NYHF7Bg8R10yH
        RE/j7iwL7oq4Qo381iDimzr4wrPrCyY=
Date:   Thu, 29 Dec 2022 09:30:49 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 04/12] types: Introduce [us]128
Message-ID: <Y61QOe8XG5sUAXoc@duo.ucw.cz>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.087799661@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fTFbN55brR9qMT+p"
Content-Disposition: inline
In-Reply-To: <20221219154119.087799661@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--fTFbN55brR9qMT+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce [us]128 (when available). Unlike [us]64, ensure they are
> always naturally aligned.
>=20
> This also enables 128bit wide atomics (which require natural
> alignment) such as cmpxchg128().
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/types.h      |    5 +++++
>  include/uapi/linux/types.h |    4 ++++
>  2 files changed, 9 insertions(+)
>=20
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -10,6 +10,11 @@
>  #define DECLARE_BITMAP(name,bits) \
>  	unsigned long name[BITS_TO_LONGS(bits)]
> =20
> +#ifdef __SIZEOF_INT128__
> +typedef __s128 s128;
> +typedef __u128 u128;
> +#endif

Should this come as a note here?

> Introduce [us]128 (when available). Unlike [us]64, ensure they are
> always naturally aligned.

BR,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--fTFbN55brR9qMT+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY61QOQAKCRAw5/Bqldv6
8vQtAJ9J9UDlQpqaRV7DVlgZctKi1W8mygCfRehrcFJV2fHBfVb6C4cplLPxxog=
=Yely
-----END PGP SIGNATURE-----

--fTFbN55brR9qMT+p--
