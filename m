Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042D9161C81
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgBQU4e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 15:56:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbgBQU4e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 15:56:34 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HKs5qa128250;
        Mon, 17 Feb 2020 15:55:58 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2eksny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 15:55:58 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01HKtvTY131496;
        Mon, 17 Feb 2020 15:55:57 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2eksnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 15:55:57 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01HKtuKf019357;
        Mon, 17 Feb 2020 20:55:56 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 2y6896cn7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 20:55:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HKtuc442664230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 20:55:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 070CA112061;
        Mon, 17 Feb 2020 20:55:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7D81112063;
        Mon, 17 Feb 2020 20:55:52 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 17 Feb 2020 20:55:52 +0000 (GMT)
Message-ID: <d0789485cc353a99e19c2d2ca4b5a628a33a312d.camel@linux.ibm.com>
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
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
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Date:   Mon, 17 Feb 2020 17:55:49 -0300
In-Reply-To: <0c2f5a89-4890-fd84-6a6d-e470ba110399@nvidia.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-3-leonardo@linux.ibm.com>
         <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
         <0c2f5a89-4890-fd84-6a6d-e470ba110399@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KK5vvDthaVYFFka5IIPv"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_12:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170170
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-KK5vvDthaVYFFka5IIPv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello John, comments inline;

On Fri, 2020-02-07 at 14:54 -0800, John Hubbard wrote:
> On 2/5/20 7:25 PM, Leonardo Bras wrote:
> > On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
> > >                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
> > > -               local_irq_enable();
> > > +               end_lockless_pgtbl_walk(IRQS_ENABLED);
> > >                 ret =3D nr;
> > >         }
> > > =20
> >=20
> > Just noticed IRQS_ENABLED is not available on other archs than ppc64.
> > I will fix this for v7.
> >=20
>=20
> What's the fix going to look like, approximately?

I am not sure what is the best approach yet.=20

1. On irq_mask =3D=3D 0, always enable irq on end_lockless_pgtbl_walk().
   Not sure how bat would that affect other archs.

2. Add another function like end_lockless_pgtbl_walk_irqen() that
always enables IRQ.

3. Add another parameter in end_lockless_pgtbl_walk(), so that caller
can choose ii IRQ must be enabled.

Also, not sure if internal_get_user_pages_fast() can possibly be called
with IRQ disabled, and then return with it enabled. Maybe just
saving/restoring should be fine.

Other suggestions are welcome.

>=20
>=20
> thanks,

Best regards,

Leonardo Bras

--=-KK5vvDthaVYFFka5IIPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5K/dUACgkQlQYWtz9S
ttSomhAAti45bC0hpcyFr3ix4l0vnXi071xBs+ZLvF+V2qK1wpmBPe1ke3hfm45y
7rd5whdeNR8cPfsXPKwerT1oB7rJXhiGQa5Vt1pNlvFXVKs+IBZr+S7JAJjIFxW+
nPHLV4LaOnkRgg8p1tusLTJXXkPD/PYBqVu5vwWk4cI/uXmO6MjQ9ARPpc0bQYUY
Ds8v/GoaVuGn1kf2YVIUtJlQSF2gdKAxUnTh6hmUXcwpB0Ao3tKeE+4bESkipSRg
vlJ3aJpi72K160R3b+UwGjHLAixSsRr3pSvkqKU/B2lUEaJO99mu01NWR/X4OtVc
8h1+tgjwjZSiIa0DJfwn44beonO8oHFTE1VpmZMxpwVMoRxVUvzIrhuDaLfKlSIE
dlbKs43NjTvwQu5RScWqDR5u2w6q7LLXtCoLbq9JDDOf8kt9GX6SOp3NLopWqY4x
/BSh0UYIkBlBCAY/LXdNL1C0D8g/h8MpoOyxyKzsmZQmgLJPEtDq/Gqkdsf4jtBq
E3Ma6KYyl0wTfbQtp7iNERDukt0R2j8+meZ5ad2WUJ7GujVCp/S8ky+88jLB8eNx
o96tDhPvhT0VBcfIrGsnAnE1CyJFgFiBF4k7Xwi7To6z5teTWfhc5z6mDfBgVH1l
lhtHrLkT3aJxP48InKKPe7TMb2ghIzHMy9bSC1AaIgEW5zxzr8A=
=UpXg
-----END PGP SIGNATURE-----

--=-KK5vvDthaVYFFka5IIPv--

