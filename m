Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926101550DB
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 04:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgBGDLu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 22:11:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBGDLu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 22:11:50 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0173B2Cn091052;
        Thu, 6 Feb 2020 22:11:10 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0nnfscqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 22:11:10 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0173B9o1091762;
        Thu, 6 Feb 2020 22:11:09 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0nnfsch6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 22:11:09 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01738JVU028315;
        Fri, 7 Feb 2020 03:10:30 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 2xykc9t0x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 03:10:30 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0173ATxc53346728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 03:10:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD65EAC059;
        Fri,  7 Feb 2020 03:10:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02534AC05B;
        Fri,  7 Feb 2020 03:10:08 +0000 (GMT)
Received: from LeoBras (unknown [9.85.188.217])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 03:10:08 +0000 (GMT)
Message-ID: <34c67571bf366886aa8298373f3887f476b811a2.camel@linux.ibm.com>
Subject: Re: [PATCH v6 07/11] powerpc/kvm/e500: Use functions to track
 lockless pgtbl walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Date:   Fri, 07 Feb 2020 00:10:02 -0300
In-Reply-To: <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-8-leonardo@linux.ibm.com>
         <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XtWHJcJJjtE0nWIZHITR"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070018
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-XtWHJcJJjtE0nWIZHITR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe,=20

On Thu, 2020-02-06 at 07:18 +0100, Christophe Leroy wrote:
>=20
> I don't really like unbalanced begin/end.
>=20
> Something like the following would be cleaner:
>=20
>=20
> begin_lockless_pgtbl_walk()
> ptep =3D find()
> if (ptep) {
> 	pte =3D READ_ONCE()
> 	if (pte_present(pte))
> 		wing=3D
> 	else
> 		ret =3D -EINVAL;
> }
> end_lockless_pgtbl_walk()
>=20
> if (ret) {
> 	pr_err_rate...()
> 	goto out;
> }
>=20
>=20

Sure, looks better that way. I will change that for v7.

Thanks for the feedback,

Leonardo Bras

--=-XtWHJcJJjtE0nWIZHITR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl481QoACgkQlQYWtz9S
ttTcdA//Xke6/twgyWIan1bRF0vWJ3qSy+yFDyf4csKImVLRQqAa/asW4bIBwGZS
re3EzPV46Nuq6ZAg64yxwOokHEfwY1cdOmSCVmxZf0SUGViqZ2whL/CCED2H+f7f
Lt+hw1ibONlzz8AvDLtplxj18Uc58G9mrXOOxLEz2LzqXrsL1AU/15R+NiDPaK1N
lW5kxUsb8jHHzIOXem9B2aQRFDoCCx0uJzhNJn13ft30PZeaanSUNYqSuEa67tlA
7iFqrtoLCD7KKXLNbvAh+43w+lvpEqRf9MBt7SoCXJQWCVrIXhj4yI3dbRaePyf3
jY3vXrk/TapcfQQceptI47oaOtptRJ2MBntJYdh/kUYhLpy61px3q1mJvy4qZOrO
gm9Y2YfVGf23zkcc9/YzOfOm0t+tf5VKUQj4a0rCIuSj/EgHW2vj3pq85Vt2PUB/
aGp88Aosd2Wz3pqQ7aGsasy7vKlSc/nVOgItr/9Y8q51y3DdYkw+rUqqqZK4JH1h
4qRGpb4jp2mZZdzvxxCklhHdqXNwLdSW+d6ZBYEww0N6T5aNCPp1hAAY16I9ZmYF
AE/ZMZjVc9UNYqA9bHE29IETN0vuv8AIaREvwoK27Oip8cnhLpf8FA2uMWW80AcL
7yw4v3Cojj76UcRoZkMRNCutFnPeIr7EUc5Po2GqKSMXQAYLLu8=
=ZwdP
-----END PGP SIGNATURE-----

--=-XtWHJcJJjtE0nWIZHITR--

