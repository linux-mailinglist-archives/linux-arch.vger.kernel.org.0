Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8D155166
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGEB6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 23:01:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGEB6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 23:01:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01740FH5114690;
        Thu, 6 Feb 2020 23:01:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmpxg3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 23:01:18 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01740FAl114711;
        Thu, 6 Feb 2020 23:01:18 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmpxg3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 23:01:18 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0173uIwE010927;
        Fri, 7 Feb 2020 04:01:17 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 2xykc9xtyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 04:01:17 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01741Fvm51183952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 04:01:15 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FC91BE056;
        Fri,  7 Feb 2020 04:01:15 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80A1EBE053;
        Fri,  7 Feb 2020 04:00:58 +0000 (GMT)
Received: from LeoBras (unknown [9.85.188.217])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 04:00:57 +0000 (GMT)
Message-ID: <77e224d460d004fd918aae1b4e9237cd3a935f78.camel@linux.ibm.com>
Subject: Re: [PATCH v6 04/11] powerpc/mce_power: Use functions to track
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
Date:   Fri, 07 Feb 2020 01:00:53 -0300
In-Reply-To: <e8a5db5a-d1a5-ef25-af46-c44949750e8a@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-5-leonardo@linux.ibm.com>
         <e8a5db5a-d1a5-ef25-af46-c44949750e8a@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JGXt/RswUQhQyg+jmosY"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002070024
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-JGXt/RswUQhQyg+jmosY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-06 at 06:48 +0100, Christophe Leroy wrote:
> > --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -29,7 +29,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsig=
ned long addr)
> >   {
> >   	pte_t *ptep;
> >   	unsigned int shift;
> > -	unsigned long pfn, flags;
> > +	unsigned long pfn, irq_mask;
>=20
> Why change the name ? flags is a well known historical name.

Oh, this commit missed the reasoning for flags name change.

For local_irq_{save,restore} a parameter named flags makes sense, for
the reader, as it could only be flags regarding irq.

I thougt passing flags to {begin,end}_lockless_pgtbl_walk would lose
it's meaning, given that it would only mean "flags for these functions"

So, changing it to irq_mask would make the reader more aware of what it
does mean.

For other commits, I added:

"Variable that saves the irq mask was renamed from flags to irq_mask so
it doesn't lose meaning now it's not directly passed to local_irq_*
functions."=20

I can add it to this commit message.

Thanks for the feedback,

Leonardo Bras




--=-JGXt/RswUQhQyg+jmosY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl484PUACgkQlQYWtz9S
ttQxfg//QLE5uOYft+0dYS7Fn7jA1rJi9M6IT4QpqXdPYxPpiXrXtosRdobLCfEd
FORoKWLRYuBXPWSR2Z7ZQsXUaJVLRF7bt04gatvV94xYzVE+1AKagv3PuKJoCL52
Utx9nThSXjTUkU3zj+7txmBpwRRpzbbG/phpT2mpOLk1f9gkKfK2XCXxY+aOFOqd
n/o6eU48rxmmnVKbri+LmKIPMt+XE32bwj/NnTBcODqdFX3g4c5NQycirWwq3NSj
DPiskun8O4jfT3K/QPDTS8TJnmumOPMNt30gk7bV5D4MR8oYkm67UHFwEEyGnSHS
Ch3ohT7PVg7FFaqXhqM6C+xVLQM425qXRB+0nKZBBRTf7EoADfSssc4yspcY7v37
Byyj0SYqT3Qp9JIv3pgEi60uwTqdWFqhMxaWxZodnpBhW2OwQp9WWYGzOJekTkR8
iY2StuZT2ytFfp+qWTstllNylY98iw33uYayicx1xgJ2Ni3ktGF7a72acOFfW93B
HiDGeEMgATvKGaDorxC3o8UpPIChZp946Y9RwZzqJAjLkEzeEd5yygYeStAny8UV
Z0bNwY4EuCdAiy07hPEhdpEdBPJzGrknLCGsejNBjNvWpOmDXi1RvX8kDRglW8Vo
fOMw6BbIDXPAxWgy1VxXkFJtJXRwaXsUbAlPmFRbd6QI3nLpcF0=
=db7A
-----END PGP SIGNATURE-----

--=-JGXt/RswUQhQyg+jmosY--

