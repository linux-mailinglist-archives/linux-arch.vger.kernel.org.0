Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1358615518E
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 05:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGEjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 23:39:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGEjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 23:39:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0174aZ5r067573;
        Thu, 6 Feb 2020 23:39:03 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3kakyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 23:39:03 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0174cG6a071209;
        Thu, 6 Feb 2020 23:39:03 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3kakxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 23:39:02 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0174WqqW021683;
        Fri, 7 Feb 2020 04:39:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 2xykc9y2ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 04:39:02 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0174d1Vm14681016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 04:39:01 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3538EAC05E;
        Fri,  7 Feb 2020 04:39:01 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B835AC059;
        Fri,  7 Feb 2020 04:38:46 +0000 (GMT)
Received: from LeoBras (unknown [9.85.188.217])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 04:38:45 +0000 (GMT)
Message-ID: <efcf780cee767d0f4b06b56e216725c6bd8d60d4.camel@linux.ibm.com>
Subject: Re: [PATCH v6 03/11] powerpc/mm: Adds arch-specificic functions to
 track lockless pgtable walks
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
Date:   Fri, 07 Feb 2020 01:38:39 -0300
In-Reply-To: <1311ce1c-7e5a-f7c4-2ab2-c03e124ca1c1@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-4-leonardo@linux.ibm.com>
         <1311ce1c-7e5a-f7c4-2ab2-c03e124ca1c1@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UC8uoiQ28kN0VTj/dQ2v"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070029
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-UC8uoiQ28kN0VTj/dQ2v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-06 at 06:46 +0100, Christophe Leroy wrote:
>=20
> Le 06/02/2020 =C3=A0 04:08, Leonardo Bras a =C3=A9crit :
> > On powerpc, we need to do some lockless pagetable walks from functions
> > that already have disabled interrupts, specially from real mode with
> > MSR[EE=3D0].
> >=20
> > In these contexts, disabling/enabling interrupts can be very troubling.
>=20
> When interrupts are already disabled, the flag returned when disabling=
=20
> it will be such that when we restore it later, interrupts remain=20
> disabled, so what's the problem ?

There are places in code, like patch 8, where it explicitly avoids
doing irq_save/restore by using a function parameter (realmode).
http://patchwork.ozlabs.org/patch/1234130/

I am not sure why it's that way, but I decided to keep it as is.=20
It was introduced by Aneesh Kumar in 2015
(691e95fd7396905a38d98919e9c150dbc3ea21a3).=20

> > So, this arch-specific implementation features functions with an extra
> > argument that allows interrupt enable/disable to be skipped:
> > __begin_lockless_pgtbl_walk() and __end_lockless_pgtbl_walk().
> >=20
> > Functions similar to the generic ones are also exported, by calling
> > the above functions with parameter {en,dis}able_irq =3D true.
> >=20
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> > ---
> >   arch/powerpc/include/asm/book3s/64/pgtable.h |  6 ++
> >   arch/powerpc/mm/book3s64/pgtable.c           | 86 +++++++++++++++++++=
-
> >   2 files changed, 91 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerp=
c/include/asm/book3s/64/pgtable.h
> > index 201a69e6a355..78f6ffb1bb3e 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -1375,5 +1375,11 @@ static inline bool pgd_is_leaf(pgd_t pgd)
> >   	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
> >   }
> >  =20
> > +#define __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> > +unsigned long begin_lockless_pgtbl_walk(void);
> > +unsigned long __begin_lockless_pgtbl_walk(bool disable_irq);
> > +void end_lockless_pgtbl_walk(unsigned long irq_mask);
> > +void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq=
);
> > +
>=20
> Why not make them static inline just like the generic ones ?
>=20

Sure, can be done.  It would save some function calls.
For that I will define the per-cpu variable in .c and declare it in .h
All new function can be moved to .h, while changing adding the inline
modifier.

> >   #endif /* __ASSEMBLY__ */
> >   #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> > diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3=
s64/pgtable.c
> > index 2bf7e1b4fd82..535613030363 100644
> > --- a/arch/powerpc/mm/book3s64/pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/pgtable.c
> > @@ -82,6 +82,7 @@ static void do_nothing(void *unused)
> >   {
> >  =20
> >   }
> > +
>=20
> Is this blank line related to the patch ?
>=20

Nope, just something I 'fixed' while reading, and gone past my pre-send=20
patch reviewing. If it bothers, I can remove.

> >   /*
> >    * Serialize against find_current_mm_pte which does lock-less
> >    * lookup in page tables with local interrupts disabled. For huge pag=
es
> > @@ -98,6 +99,89 @@ void serialize_against_pte_lookup(struct mm_struct *=
mm)
> >   	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
> >   }
> >  =20
> > +/* begin_lockless_pgtbl_walk: Must be inserted before a function call =
that does
> > + *   lockless pagetable walks, such as __find_linux_pte().
> > + * This version allows setting disable_irq=3Dfalse, so irqs are not to=
uched, which
> > + *   is quite useful for running when ints are already disabled (like =
real-mode)
> > + */
> > +inline
> > +unsigned long __begin_lockless_pgtbl_walk(bool disable_irq)
> > +{
> > +	unsigned long irq_mask =3D 0;
> > +
> > +	/*
> > +	 * Interrupts must be disabled during the lockless page table walk.
> > +	 * That's because the deleting or splitting involves flushing TLBs,
> > +	 * which in turn issues interrupts, that will block when disabled.
> > +	 *
> > +	 * When this function is called from realmode with MSR[EE=3D0],
> > +	 * it's not needed to touch irq, since it's already disabled.
> > +	 */
> > +	if (disable_irq)
> > +		local_irq_save(irq_mask);
> > +
> > +	/*
> > +	 * This memory barrier pairs with any code that is either trying to
> > +	 * delete page tables, or split huge pages. Without this barrier,
> > +	 * the page tables could be read speculatively outside of interrupt
> > +	 * disabling or reference counting.
> > +	 */
> > +	smp_mb();
> > +
> > +	return irq_mask;
> > +}
> > +EXPORT_SYMBOL(__begin_lockless_pgtbl_walk);
> > +
> > +/* begin_lockless_pgtbl_walk: Must be inserted before a function call =
that does
> > + *   lockless pagetable walks, such as __find_linux_pte().
> > + * This version is used by generic code, and always assume irqs will b=
e disabled
> > + */
> > +unsigned long begin_lockless_pgtbl_walk(void)
> > +{
> > +	return __begin_lockless_pgtbl_walk(true);
> > +}
> > +EXPORT_SYMBOL(begin_lockless_pgtbl_walk);
>=20
> Even more than begin_lockless_pgtbl_walk(), this one is worth being=20
> static inline in the H file.

Same as above, can be done.=20

>=20
> > +
> > +/*
> > + * __end_lockless_pgtbl_walk: Must be inserted after the last use of a=
 pointer
> > + *   returned by a lockless pagetable walk, such as __find_linux_pte()
> > + * This version allows setting enable_irq=3Dfalse, so irqs are not tou=
ched, which
> > + *   is quite useful for running when ints are already disabled (like =
real-mode)
> > + */
> > +inline void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool ena=
ble_irq)
> > +{
> > +	/*
> > +	 * This memory barrier pairs with any code that is either trying to
> > +	 * delete page tables, or split huge pages. Without this barrier,
> > +	 * the page tables could be read speculatively outside of interrupt
> > +	 * disabling or reference counting.
> > +	 */
> > +	smp_mb();
> > +
> > +	/*
> > +	 * Interrupts must be disabled during the lockless page table walk.
> > +	 * That's because the deleting or splitting involves flushing TLBs,
> > +	 * which in turn issues interrupts, that will block when disabled.
> > +	 *
> > +	 * When this function is called from realmode with MSR[EE=3D0],
> > +	 * it's not needed to touch irq, since it's already disabled.
> > +	 */
> > +	if (enable_irq)
> > +		local_irq_restore(irq_mask);
> > +}
> > +EXPORT_SYMBOL(__end_lockless_pgtbl_walk);
> > +
> > +/*
> > + * end_lockless_pgtbl_walk: Must be inserted after the last use of a p=
ointer
> > + *   returned by a lockless pagetable walk, such as __find_linux_pte()
> > + * This version is used by generic code, and always assume irqs will b=
e enabled
> > + */
> > +void end_lockless_pgtbl_walk(unsigned long irq_mask)
> > +{
> > +	__end_lockless_pgtbl_walk(irq_mask, true);
> > +}
> > +EXPORT_SYMBOL(end_lockless_pgtbl_walk);
> > +
> >   /*
> >    * We use this to invalidate a pmdp entry before switching from a
> >    * hugepte to regular pmd entry.
> > @@ -487,7 +571,7 @@ static int __init setup_disable_tlbie(char *str)
> >   	tlbie_capable =3D false;
> >   	tlbie_enabled =3D false;
> >  =20
> > -        return 1;
> > +	return 1;
>=20
> Is that related to this patch at all ?

Nope, just another something I 'fixed' while reading, and gone past my
pre-send patch reviewing. If it bothers, I can remove.

>=20
> >   }
> >   __setup("disable_tlbie", setup_disable_tlbie);
> >  =20
> >=20
>=20
> Christophe

Found other unbalanced begin/end in kvmppc_do_h_enter(). I will change
that too.

Thanks for the feedback,

Leonardo Bras

--=-UC8uoiQ28kN0VTj/dQ2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl486c8ACgkQlQYWtz9S
ttQwig/+L8KRZQKo7NXOe5gH/AwOQd6bRKWidBHmMQZiD5zSMa87FrDmDn1+UdEc
+qVNzt6nogDEP+XRXL0ogdPhznDiv9WCMojrcjFpgrneNwrqKK5Cwmq2NjLFgL3w
Vn6QO3eJAn7WbEuI4qZbwzCMZSTaz+A18rGHUEcA12Wd8OVLHFOpjX12WemzM+il
Mp35MF8xbvklVgNBe/rjVK+TjowIhNKsEvmLDS7+tJJBw4+hdcGf+Y8rrPWRz2lw
8UY3xzI+9CUmPongSWlbjbnNrdV0HRLU1TMfH2NB7cU68r/pTEWHWP+U1fLRYzl5
4sJOB6vWOaBiiVjft6iPNBsoTh/x1jP+/9C18rBcWZ5EZ33YPea9r4IHEJDBGdYb
IJdLrVPgXSZ7M5pUgTHC4QYnkgkKjwHXj5XFKlPgVaadf3qFnXqncga1tV+W6pPW
5nLI/KVF5wYSntJshmJUiJBV11WROmuTMzUneNzVj5SwFuv4Uwzz2Tm5PgGK9cOt
PsXHTZn3M8aqgymcyGzfJlyeh2BNGpVqBkdD2sQ22LFKFRMCA3d534qaqiZOHB/6
kEvTUpYv/D6tRmLS1MviCyVpaLTP2JtvLjgm7mhpyi/1/jlhYFZOjkLKHII0pmGu
QF33TdhmUMhhh0cvEVbWxebc9GcXa5L+YXEe+zWKrfPnqIcuRos=
=M25Q
-----END PGP SIGNATURE-----

--=-UC8uoiQ28kN0VTj/dQ2v--

