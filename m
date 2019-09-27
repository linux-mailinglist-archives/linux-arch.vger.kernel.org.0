Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389D3C07E2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2019 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfI0OrS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 10:47:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbfI0OrS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 10:47:18 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8REiKbe009586;
        Fri, 27 Sep 2019 10:46:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8y3b53xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 10:46:36 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8REiTGK009898;
        Fri, 27 Sep 2019 10:46:29 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8y3b53s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 10:46:29 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8REhmPi026728;
        Fri, 27 Sep 2019 14:46:19 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2v5bg8f0un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 14:46:19 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8REkHHj40042836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 14:46:18 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF156C6059;
        Fri, 27 Sep 2019 14:46:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23C33C605F;
        Fri, 27 Sep 2019 14:46:09 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.58])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 14:46:09 +0000 (GMT)
Message-ID: <8fe1ee1abf52719e75902dc7d5cd1e91751eaba7.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/11] Introduces new count-based method for
 monitoring lockless pagetable walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     jhubbard@nvidia.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        arnd@arndb.de, aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        npiggin@gmail.com, mahesh@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        ganeshgr@linux.ibm.com, allison@lohutok.net, rppt@linux.ibm.com,
        yuehaibing@huawei.com, ira.weiny@intel.com, jgg@ziepe.ca,
        keith.busch@intel.com
Date:   Fri, 27 Sep 2019 11:46:04 -0300
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0SqJjAld2WmMrSAcbuQn"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270138
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-0SqJjAld2WmMrSAcbuQn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

John Hubbard <jhubbard@nvidia.com> writes:

> Hi Leonardo,
>
> Thanks for adding linux-mm to CC for this next round of reviews. For the =
benefit
> of any new reviewers, I'd like to add that there are some issues that wer=
e discovered
> while reviewing the v2 patchset, that are not (yet) addressed in this v3 =
series.

> Since those issues are not listed in the cover letter above, I'll list th=
em here

Thanks for bringing that.
The cover letter is a great place to put this info, I will keep that in
mind for future patchsets.

>
> 1. The locking model requires a combination of disabling interrupts and
> atomic counting and memory barriers, but
>
> 	a) some memory barriers are missing
> 	(start/end_lockless_pgtbl_walk), and

It seems that it works fine today because of the amount of intructions
executed between the irq_disable / start_lockless_pgtbl_walk and where
the THP collapse/split can happen. (It's very unlikely that it reorders
that much).

But I don't think it would be so bad to put a memory barrier after
irq_disable just in case.

> 	b) some cases (patch #8) fail to disable interrupts

I have done some looking into that, and it seems that some uses of
{start,end}_lockless_pgtbl_walk are unneeded, because they operate in
(nested) guest pgd and I was told it's safe against THP split/collapse.

In other uses, there is no interrupt disable because the function is
called in real mode, with MSR_EE=3D0, and there we have instructions
disabled, so there is no need to disable them again.

>
> ...so the synchronization appears to be inadequate. (And if it *is* adequ=
ate, then
> definitely we need the next item, to explain it.)


>
> 2. Documentation of the synchronization/locking model needs to exist, onc=
e we
> figure out the exact details of (1).

I will add the missing doc in the code, so it may be easier to
understand in the future.

>
> 3. Related to (1), I've asked to change things so that interrupt controls=
 and=20
> atomic inc/dec are in the same start/end calls--assuming, of course, that=
 the
> caller can tolerate that.=20

I am not sure if it would be ok to use irq_{save,restore} in real mode,
I will do some more reading of the docs before addressing this.=20
>
> 4. Please see the v2 series for any other details I've missed.
>
> thanks,
> --=20
> John Hubbard
> NVIDIA
>

Thank you for helping, John!

Best regards,
Leonardo Bras

--=-0SqJjAld2WmMrSAcbuQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2OIKwACgkQlQYWtz9S
ttRybRAArvljWum/p1QDUJofop8oyMMy8mFrtADkUcj7l033ze/c1UL4xVoFGvwQ
JjAv7Cz+5anu8KJ3OQy0RUpdKihQh603Mt5fp7Okt8/D3AnBcMgp3hnGvwBDs8l4
OqU3pEjzAFhQRpi0vFzuDLzY6yZBlHhb7keU8FpY9AOVk1M7nVxAYgY5pWiPUTJB
6bxcElXieVV811efuDvuP2i4HG8tjs0uO4i8l4Z7EhoLRSYo030UJ2lRuO83/eYG
1GXxjhkYulE4V5uHJ3PaWmtzre5wvSMHFniZK7XF777UZ5gDDgbo/FjtmYZQmQPx
vbOAxfZq3yVakztdgQxYi2YN9Lh2rWJzfeISnWhpLzGS+dvFnDqurLCUieyKk4A8
whBV3OCBpfksUToZuStK6cv2FK/TyArYGBTgPTmLRHn8n4AKgh1DzN2M9YxQ28jd
rsAsmal05v6GTWJu8w9fHhwtHUO0HWaygdJGVm483FqVHSCigIShnhqT6QfoZY9q
t4DvkFU6htn7vTEVIsLZaOYdyMFsWIZqoItq3kE+FZdcdCBMuLDjP47IK4g0IFtg
Yo04gfVicc35HAvJpHCluEwIkEH45KWfRwlcN9rArUYDSMHMYeKIu53d4Q5+eit5
AtqqUn9C4uk9TWoz3ksrfi5waujwmUtAvDaiaMH78SaiQ9IhncY=
=tj28
-----END PGP SIGNATURE-----

--=-0SqJjAld2WmMrSAcbuQn--

