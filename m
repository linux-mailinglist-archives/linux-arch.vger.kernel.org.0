Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF70C2410
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfI3PPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 11:15:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730780AbfI3PPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 11:15:21 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UFCi8t044603;
        Mon, 30 Sep 2019 11:14:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2va35s98ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 11:14:42 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8UFCiFI044587;
        Mon, 30 Sep 2019 11:14:40 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2va35s98cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 11:14:40 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8UFAwxE003947;
        Mon, 30 Sep 2019 15:14:36 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2v9y57gp4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 15:14:36 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UFEZmo34537918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 15:14:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB1FAC05E;
        Mon, 30 Sep 2019 15:14:35 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC0EAC059;
        Mon, 30 Sep 2019 15:14:32 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.58])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 15:14:32 +0000 (GMT)
Message-ID: <2533a13f226a6e1fab387669b6cced2aa8d2e129.camel@linux.ibm.com>
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Allison Randal <allison@lohutok.net>
Date:   Mon, 30 Sep 2019 12:14:31 -0300
In-Reply-To: <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
         <20190927234008.11513-2-leonardo@linux.ibm.com>
         <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-z3BiED0HRCK0SvQzWnl4"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300156
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-z3BiED0HRCK0SvQzWnl4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-09-29 at 15:40 -0700, John Hubbard wrote:
> Hi, Leonardo,

Hello John, thanks for the feedback.

> Can we please do it as shown below, instead (compile-tested only)?
>=20
> This addresses all of the comments that I was going to make about structu=
re
> of this patch, which are:
>=20
> * The lockless synch is tricky, so it should be encapsulated in function
>    calls if possible.

As I told before, there are cases where this function is called from
'real mode' in powerpc, which doesn't disable irqs and may have a
tricky behavior if we do. So, encapsulate the irq disable in this
function can be a bad choice.

Of course, if we really need that, we can add a bool parameter to the
function to choose about disabling/enabling irqs.
>=20
> * This is really a core mm function, so don't hide it away in arch layers=
.
>    (If you're changing mm/ files, that's a big hint.)

My idea here is to let the arch decide on how this 'register' is going
to work, as archs may have different needs (in powerpc for example, we
can't always disable irqs, since we may be in realmode).

Maybe we can create a generic function instead of a dummy, and let it
be replaced in case the arch needs to do so.

> * Other things need parts of this: gup.c needs the memory barriers; IMHO =
you'll
>    be fixing a pre-existing, theoretical (we've never seen bug reports) p=
roblem.

Humm, you are right. Here I would suggest adding the barrier to the
generic function.

> * The documentation needs to accurately explain what's going on here.

Yes, my documentation was probably not good enough due to my lack of
experience with memory barriers (I learnt about using them last week,
and tried to come with the best solution.)

> (Not shown: one or more of the PPC Kconfig files should select
> LOCKLESS_PAGE_TABLE_WALK_TRACKING.)

The way it works today is defining it on platform pgtable.h. I agree
that using Kconfig may be a better solution that can make this config
more visible to disable/enable.=20

Thanks for the feedback,

Leonardo Bras

--=-z3BiED0HRCK0SvQzWnl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2SG9cACgkQlQYWtz9S
ttQkeBAAx0Ae0+jxZ1EEdiZHaIu+kj0HWBBAg+YW5DdbPJSTzQYna9TEMmAmBeT0
CQ7BI8sDaz54d/59tm5cNRPc142RU5w/QTRv7OE+0IQJBL1BxLb1XoaCTRqtnnts
gf3fSukTddDt2zm3/8Gx9Q160AZdCLK1I4NtW1rtqFbUH3EFhCaPM4ydwhy9WOzO
jpMacVjvfqJey8NKeo12RCkKLObhAdYwdJlfVM+j7srREfe/e9Hdz/hF+m5XYFt8
PlMTsWAuOpjEJG09E8yttF/Zog2ZRLnaFeY05tRcd9n3jqKXClMcP5En5nyAMl49
vSUr6+RE72lMt6xzK8mkX5V3WfTS6NvR4N95hLjLKwdW3gPAeZrXb+4SJRq/vWbE
24iALWVQZodVwQ44tEBFiVgSfPTSIjzBT6FoQkwqFYebo5gAYf3ObVM+OmFSHhmd
GZ93Mnoj/3k2Em/NOwjGFSYbDZi5H3NHHTL04jJ3gGEqceGvd55OXtHfYIuDs6it
9hFQrU8n265wmsNJmcQGjj8NK62QIqsGcYLfNp1mVpseKVhakpDbLeBiG/PG/w7I
FoSj52zaJVheB7tgSEEMkUxeBLgY7OmywnTedYFVhOFlwD/81wMkZAxz/fgvAmXK
IxXI+ZP410dboTHEija3m4Z+m2BMb6wamF4Q1J5Ys8wWeQ3QhGc=
=+FFG
-----END PGP SIGNATURE-----

--=-z3BiED0HRCK0SvQzWnl4--

