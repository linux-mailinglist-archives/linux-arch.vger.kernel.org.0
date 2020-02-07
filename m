Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6331155159
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 04:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGDvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 22:51:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgBGDvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 22:51:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0173iPCu012192;
        Thu, 6 Feb 2020 22:50:24 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3k9m36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 22:50:24 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0173jp7w014848;
        Thu, 6 Feb 2020 22:50:23 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3k9m2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 22:50:23 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0173muEP023176;
        Fri, 7 Feb 2020 03:50:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2xykc9xrhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 03:50:22 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0173oKbg30998926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 03:50:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD64C6059;
        Fri,  7 Feb 2020 03:50:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A722CC605A;
        Fri,  7 Feb 2020 03:50:01 +0000 (GMT)
Received: from LeoBras (unknown [9.85.188.217])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 03:50:00 +0000 (GMT)
Message-ID: <31b7229b979da2b0bdec041724dd1698cf76298c.camel@linux.ibm.com>
Subject: Re: [PATCH v6 06/11] powerpc/mm/book3s64/hash: Use functions to
 track lockless pgtbl walks
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
Date:   Fri, 07 Feb 2020 00:49:56 -0300
In-Reply-To: <1b65f1a8-42a8-6ffc-3a06-08fbb34edab5@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-7-leonardo@linux.ibm.com>
         <1b65f1a8-42a8-6ffc-3a06-08fbb34edab5@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CBJiDJxhT4An72p6WJMR"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070021
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-CBJiDJxhT4An72p6WJMR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-06 at 07:06 +0100, Christophe Leroy wrote:
> > -	/* Get PTE and page size from page tables */
> > +	/* Get PTE and page size from page tables :
> > +	 * Called in from DataAccess interrupt (data_access_common: 0x300),
> > +	 * interrupts are disabled here.
> > +	 */
>=20
> Comments formatting is not in line with Linux kernel rules. Should be no=
=20
> text on the first /* line.

My mistake. Will be corrected in v7.

> > +	__begin_lockless_pgtbl_walk(false);
>=20
> I think it would be better to not use __begin_lockless_pgtbl_walk()=20
> directly but keep it in a single place, and define something like=20
> begin_lockless_pgtbl_walk_noirq() similar to begin_lockless_pgtbl_walk()

There are places where touching irq is decided by a boolean, like in
patch 8: http://patchwork.ozlabs.org/patch/1234130/

If I were to change this, I would have to place ifs and decide to call
either normal or *_noirq() versions in every function.

What you suggest?

> >   	ptep =3D find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
> >   	if (ptep =3D=3D NULL || !pte_present(*ptep)) {
> >   		DBG_LOW(" no PTE !\n");
> >   		rc =3D 1;
> > -		goto bail;
> > +		goto bail_pgtbl_walk;
>=20
> What's the point in changing the name of this label ? There is only one=
=20
> label, why polute the function with so huge name ?
>=20
> For me, everyone understand what 'bail' means. Unneccessary changes=20
> should be avoided. If you really really want to do it, it should be=20
> another patch.
>=20
> See kernel codying style, chapter 'naming':
> "LOCAL variable names should be short". This also applies to labels.
>=20
> "C is a Spartan language, and so should your naming be. Unlike Modula-2=
=20
> and Pascal programmers, C programmers do not use cute names like=20
> ThisVariableIsATemporaryCounter. A C programmer would call that variable=
=20
> tmp, which is much easier to write, and not the least more difficult to=
=20
> understand."
>=20

It's not label name changing. There are two possible bails in
hash_page_mm(): one for before __begin_lockless_pagetable_walk() and
other for after it. The new one also runs __end_lockless_pgtbl_walk()
before running what the previous did:

> > +bail_pgtbl_walk:
> > +	__end_lockless_pgtbl_walk(0, false);
> >   bail:
> >   	exception_exit(prev_state);
> >   	return rc;

As for the label name lengh, I see no problem changing it to something
like bail_ptw.=20


> > @@ -1545,7 +1551,7 @@ static void hash_preload(struct mm_struct *mm, un=
signed long ea,
> >   	unsigned long vsid;
> >   	pgd_t *pgdir;
> >   	pte_t *ptep;
> > -	unsigned long flags;
> > +	unsigned long irq_mask;
> >   	int rc, ssize, update_flags =3D 0;
> >   	unsigned long access =3D _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PA=
GE_EXEC : 0);
> >  =20
> > @@ -1567,11 +1573,12 @@ static void hash_preload(struct mm_struct *mm, =
unsigned long ea,
> >   	vsid =3D get_user_vsid(&mm->context, ea, ssize);
> >   	if (!vsid)
> >   		return;
> > +
>=20
> Is this new line related to the patch ?

Nope. I have added while reading code and it just went trough my pre-
sending revision. I can remove it, if it bothers.

>=20
> >   	/*
> >   	 * Hash doesn't like irqs. Walking linux page table with irq disable=
d
> >   	 * saves us from holding multiple locks.
> >   	 */
> > -	local_irq_save(flags);
> > +	irq_mask =3D begin_lockless_pgtbl_walk();
> >  =20
> >   	/*
> >   	 * THP pages use update_mmu_cache_pmd. We don't do
> > @@ -1616,7 +1623,7 @@ static void hash_preload(struct mm_struct *mm, un=
signed long ea,
> >   				   mm_ctx_user_psize(&mm->context),
> >   				   pte_val(*ptep));
> >   out_exit:
> > -	local_irq_restore(flags);
> > +	end_lockless_pgtbl_walk(irq_mask);
> >   }
> >  =20
> >   /*
> > @@ -1679,16 +1686,16 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsig=
ned long address)
> >   {
> >   	pte_t *ptep;
> >   	u16 pkey =3D 0;
> > -	unsigned long flags;
> > +	unsigned long irq_mask;
> >  =20
> >   	if (!mm || !mm->pgd)
> >   		return 0;
> >  =20
> > -	local_irq_save(flags);
> > +	irq_mask =3D begin_lockless_pgtbl_walk();
> >   	ptep =3D find_linux_pte(mm->pgd, address, NULL, NULL);
> >   	if (ptep)
> >   		pkey =3D pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
> > -	local_irq_restore(flags);
> > +	end_lockless_pgtbl_walk(irq_mask);
> >  =20
> >   	return pkey;
> >   }
> >=20
>=20
> Christophe

Thanks for giving feedback,

Leonardo Bras

--=-CBJiDJxhT4An72p6WJMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl483mQACgkQlQYWtz9S
ttT0RhAA0oKi/2XxY/SIX1F2r5GCR1RED6qxY0qr3xnxzpM3v721Eauf6gu1qqn+
mLHWCjePDMZExodUEzcikEKxWX8xKJremMeTtKb9NsWunyDeBJsc/DZYjfgrbV06
gIolgdRivEhBdPxuy1PuDVgkw1wbtWXIcbOV38cZUK5nPplruTem+BgpHUey7B9P
X4FMTaZS4I4FLTxW21HLzr8finjGCD/Te4UeStnFaf5CWDb1rHhYmfVS6d0sVs7d
yX97lrw9TkiQdwiCVv7ubcdyyJzP7ZJvhYvikVx2R+S2QZU2sSy9omWp14kAmmDS
fBou25w24OyCphm2MD+cHl+i51aCOVhRwM4SmxFtUhDdoSTzSwJpLr4W+iyTOQGE
DghnMCnPNN8f+zdJG+cofT0SxIPq8M2qvUyppRximtgc8C2mlLNgrm1dmcDj+/He
cR0V5zvcCUNpGEQFZ7McZYh3iYkyKOOgWDbnf9NCWCO7wxKaFJm/OuRE3QnI1R1L
wK/1YkmxJYw+e2ighyOrsIc95aezgjWO1ErqrbUr8slXMu7cj26MAFHCwa/2apCO
gbieqVCJc80O47JXNXW9hTiTcyly25oGR98Mowr8k+C4tcRtFwFwaG8yEz1nyoUV
54GtadMwB6OFVlSJdalc+p/GPxVPFwYyWVXGs15Y6g0DdXVkQbc=
=D0Zg
-----END PGP SIGNATURE-----

--=-CBJiDJxhT4An72p6WJMR--

