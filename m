Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9CCC400C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfJASkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 14:40:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbfJASkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 14:40:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91IMMFM051038;
        Tue, 1 Oct 2019 14:40:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc9y5n2y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 14:40:11 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91IO2K5054774;
        Tue, 1 Oct 2019 14:40:10 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc9y5n2xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 14:40:10 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91IdmKj024723;
        Tue, 1 Oct 2019 18:40:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2v9y59d1gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 18:40:09 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91Ie7dl60293438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 18:40:07 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D48EC6055;
        Tue,  1 Oct 2019 18:40:07 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A702C605D;
        Tue,  1 Oct 2019 18:40:03 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.47])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Oct 2019 18:40:02 +0000 (GMT)
Message-ID: <9cd8e83334047b9144133781be9abd25a5678f3d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Date:   Tue, 01 Oct 2019 15:39:59 -0300
In-Reply-To: <8534727b-72ed-b974-219e-02155bcd17a8@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
         <20190927234008.11513-2-leonardo@linux.ibm.com>
         <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
         <2533a13f226a6e1fab387669b6cced2aa8d2e129.camel@linux.ibm.com>
         <48bf32ca-5d3e-5d69-4cd1-6720364a0d81@nvidia.com>
         <673bcb94b7752e086cc4133fb6cceb24394c02c0.camel@linux.ibm.com>
         <8534727b-72ed-b974-219e-02155bcd17a8@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UnsfXxKPo94uksuiKXvu"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010148
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-UnsfXxKPo94uksuiKXvu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 14:47 -0700, John Hubbard wrote:
> On 9/30/19 11:42 AM, Leonardo Bras wrote:
> > On Mon, 2019-09-30 at 10:57 -0700, John Hubbard wrote:
> > > > As I told before, there are cases where this function is called fro=
m
> > > > 'real mode' in powerpc, which doesn't disable irqs and may have a
> > > > tricky behavior if we do. So, encapsulate the irq disable in this
> > > > function can be a bad choice.
> > >=20
> > > You still haven't explained how this works in that case. So far, the
> > > synchronization we've discussed has depended upon interrupt disabling
> > > as part of the solution, in order to hold off page splitting and page
> > > table freeing.
> >=20
> > The irqs are already disabled by another mechanism (hw): MSR_EE=3D0.
> > So, serialize will work as expected.
>=20
> I get that they're disabled. But will this interlock with the code that
> issues IPIs?? Because it's not just disabling interrupts that matters, bu=
t
> rather, synchronizing with the code (TLB flushing) that *happens* to=20
> require issuing IPIs, which in turn interact with disabling interrupts.
>=20
> So I'm still not seeing how that could work here, unless there is somethi=
ng
> interesting about the smp_call_function_many() on ppc with MSR_EE=3D0 mod=
e...?
>=20

I am failing to understand the issue.
I mean, smp_call_function_many() will issue a IPI to each CPU in
CPUmask and wait it to run before returning.=20
If interrupts are disabled (either by MSR_EE=3D0 or local_irq_disable),
the IPI will not run on that CPU, and the wait part will make sure to
lock the thread until the interrupts are enabled again.=20

Could you please point the issue there?

> > > Simply skipping that means that an additional mechanism is required..=
.which
> > > btw might involve a new, ppc-specific routine, so maybe this is going=
 to end
> > > up pretty close to what I pasted in after all...
> > > > Of course, if we really need that, we can add a bool parameter to t=
he
> > > > function to choose about disabling/enabling irqs.
> > > > > * This is really a core mm function, so don't hide it away in arc=
h layers.
> > > > >     (If you're changing mm/ files, that's a big hint.)
> > > >=20
> > > > My idea here is to let the arch decide on how this 'register' is go=
ing
> > > > to work, as archs may have different needs (in powerpc for example,=
 we
> > > > can't always disable irqs, since we may be in realmode).
>=20
> Yes, the tension there is that a) some things are per-arch, and b) it's e=
asy=20
> to get it wrong. The commit below (d9101bfa6adc) is IMHO a perfect exampl=
e of
> that.
>=20
> So, I would like core mm/ functions that guide the way, but the interrupt
> behavior complicates it. I think your original passing of just struct_mm
> is probably the right balance, assuming that I'm wrong about interrupts.
>=20

I think, for the generic function, that including {en,dis}abling the
interrupt is fine. I mean, if disabling the interrupt is the generic
behavior, it's ok.=20
I will just make sure to explain that the interrupt {en,dis}abling is
part of the sync process. If an arch don't like it, it can write a
specific function that does the sync in a better way. (and defining
__HAVE_ARCH_LOCKLESS_PGTBL_WALK_COUNTER to ignore the generic function)

In this case, the generic function would also include the ifdef'ed
atomic inc and the memory barrier.=20

>=20
> > > > Maybe we can create a generic function instead of a dummy, and let =
it
> > > > be replaced in case the arch needs to do so.
> > >=20
> > > Yes, that might be what we need, if it turns out that ppc can't use t=
his
> > > approach (although let's see about that).
> > >=20
> >=20
> > I initially used the dummy approach because I did not see anything like
> > serialize in other archs.=20
> >=20
> > I mean, even if I put some generic function here, if there is no
> > function to use the 'lockless_pgtbl_walk_count', it becomes only a
> > overhead.
> >=20
>=20
> Not really: the memory barrier is required in all cases, and this code
> would be good I think:
>=20
> +void register_lockless_pgtable_walker(struct mm_struct *mm)
> +{
> +#ifdef LOCKLESS_PAGE_TABLE_WALK_TRACKING
> +       atomic_inc(&mm->lockless_pgtbl_nr_walkers);
> +#endif
> +       /*
> +        * This memory barrier pairs with any code that is either trying =
to
> +        * delete page tables, or split huge pages.
> +        */
> +       smp_mb();
> +}
> +EXPORT_SYMBOL_GPL(gup_fast_lock_acquire);
>=20
> And this is the same as your original patch, with just a minor name chang=
e:
>=20
> @@ -2341,9 +2395,11 @@ int __get_user_pages_fast(unsigned long start, int=
 nr_pages, int write,
> =20
>         if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>             gup_fast_permitted(start, end)) {
> +               register_lockless_pgtable_walker(current->mm);
>                 local_irq_save(flags);
>                 gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, =
&nr);
>                 local_irq_restore(flags);
> +               deregister_lockless_pgtable_walker(current->mm);
>=20
>=20
> Btw, hopefully minor note: it also looks like there's a number of changes=
 in the same=20
> area that conflict, for example:
>=20
>     commit d9101bfa6adc ("powerpc/mm/mce: Keep irqs disabled during lockl=
ess=20
>          page table walk") <Aneesh Kumar K.V> (Thu, 19 Sep 2019)
>=20
> ...so it would be good to rebase this onto 5.4-rc1, now that that's here.
>=20

Yeap, agree. Already rebased on top of v5.4-rc1.

>=20
> thanks,

Thank you!

--=-UnsfXxKPo94uksuiKXvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2TnX8ACgkQlQYWtz9S
ttRifhAAmPtPB1RIc4lme5/Hg5KtBhs6AMuOvwhLnDNb1F/9ArPOgle8lH/3vgzr
kkB5zwbTMbPTqO863MHUfmGe3ySVthmBVWUmFVyPbJ9tLxVYirYc4kXHP6b+Bt+L
eP2uAZzyTiyEgZFqVArmyoTCnjKi/0EpDzKz3HLcNCMf1BrWFShR83zHt2WaGhcg
CSbTAdNSmzHTjzJcp8i68Mm6YXh9EABeAuZBNzkcAiOW6BQR8IETNFXQnI2lGgio
jgGFHC4NhS3FiwX50U7Ks107G64sB78YY79Qws732lNjiBB+wGsOnBnIyAHlQPKL
ZaPDkzuhiXLmS+WbjDc6VwTqSjsvUbpRvPDsFC/fXmv7RZbMliP/OSozsi62O0p8
UnF8mA3+ihr8wYxoZi0qcTfiZRvopxGNCSCdIFeSAa7XBRm8+5bI4CWFsozrLqXC
FK0zBunozKpubMMvgum2ZwBhGx/HL9QgATaDXRdBKRSdjxXfCzFL/CfyB0trmVZA
ioAKjOPBHcAI1DrO5B61rntDk59qlGsapxwMhI+c4TWkx9IMbcp2frRb1MSDDZRY
lxmog/vD/mX2SxCSMnrvg14pKHBjq+6N+p0t/gwPdeKlfx8qW/Zw4Xgbb9hP5VZD
93eqb6MPe1+MKpx7cNAyWQmE6RzoZ0HIX7GQnoCw384Kz2bPmCM=
=ol9F
-----END PGP SIGNATURE-----

--=-UnsfXxKPo94uksuiKXvu--

