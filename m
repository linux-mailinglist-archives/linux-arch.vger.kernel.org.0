Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D817CC0EA
	for <lists+linux-arch@lfdr.de>; Tue, 17 Oct 2023 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjJQKqk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Oct 2023 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjJQKqk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Oct 2023 06:46:40 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4117A2;
        Tue, 17 Oct 2023 03:46:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 59C431C006A; Tue, 17 Oct 2023 12:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1697539597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m671g35jVHurr8wOcj+WlvlYKhYnYhlvUxsN6VNvRGY=;
        b=r0HGqmvvNd5g7CMrbD4jPXD4pgEr6r1Gm6it6Yn8e+jW1rZb4R31EB/0rxa/Ub2tjKQADj
        GRrPxQw0JGiR3agauWaIPg7A95d06Vso54rp2fJU8pY/eMGv2az94kcMMbS3XZrbhFkUm0
        Vw2I4WKWfM46jsXvzxoxKX1AHMG8KR0=
Date:   Tue, 17 Oct 2023 12:46:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, quic_jhugo@quicinc.com,
        snitzer@kernel.org, dm <dm-devel@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix confusion around MAX_ORDER
Message-ID: <ZS5mDNCRkp/RGm45@duo.ucw.cz>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <3c25ec6f-cd33-9445-a76f-6ec2c30755f5@redhat.com>
 <86e7f97a-ac6b-873d-93b2-1121a464989a@redhat.com>
 <b3ed3da7-ffa3-0d35-34c1-27b159af43bb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="U9ipWO248TbRr+D3"
Content-Disposition: inline
In-Reply-To: <b3ed3da7-ffa3-0d35-34c1-27b159af43bb@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--U9ipWO248TbRr+D3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2023-09-28 18:57:18, Paolo Bonzini wrote:
> On 9/28/23 09:50, Mikulas Patocka wrote:
> > > > Fix the bugs and then change the definition of MAX_ORDER to be
> > > > inclusive: the range of orders user can ask from buddy allocator is
> > > > 0..MAX_ORDER now.
> > I think that exclusive MAX_ORDER is more intuitive in the C language -
> > i.e. if you write "for (i =3D 0; i < MAX_ORDER; i++)", you are supposed=
 to
> > loop over all allowed values. If you declare an array "void
> > *array[MAX_ORDER];" you are supposed to hold a value for each allowed
> > order.
> >=20
> > Pascal has for loops and array dimensions with inclusive ranges - and it
> > is more prone to off-by-one errors.
>=20
> I agree it's somewhat confusing either way but the ship has sailed, the
> patch has been included in Linux for several months.

Just make sure people don't backport it to stable. Fixes: (the commit
that causes the semantic change) should do the trick.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--U9ipWO248TbRr+D3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZS5mDAAKCRAw5/Bqldv6
8tIGAJsFJix/mB5VZ3yp+Ypy6TLK4hgW0QCfcfJ3sDGET1Vosz3XWgzgTqljj6A=
=mKaU
-----END PGP SIGNATURE-----

--U9ipWO248TbRr+D3--
