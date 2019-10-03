Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DBCB054
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfJCUmd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 16:42:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbfJCUmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 16:42:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x93Kawvo021258;
        Thu, 3 Oct 2019 16:40:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vdqd29pd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 16:40:25 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x93KaxC5021544;
        Thu, 3 Oct 2019 16:40:24 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vdqd29pcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 16:40:24 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x93KYnnu029841;
        Thu, 3 Oct 2019 20:40:23 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 2v9y58q4mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 20:40:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x93KeLcl61341986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Oct 2019 20:40:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377AFBE054;
        Thu,  3 Oct 2019 20:40:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CACBE04F;
        Thu,  3 Oct 2019 20:40:12 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.190])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  3 Oct 2019 20:40:12 +0000 (GMT)
Message-ID: <3598584cc4b829e9c290b6dab89fb148528e4f72.camel@linux.ibm.com>
Subject: Re: [PATCH v5 10/11] mm/Kconfig: Adds config option to track
 lockless pagetable walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        Christoph Lameter <cl@linux.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Reza Arbab <arbab@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 03 Oct 2019 17:40:11 -0300
In-Reply-To: <20191003074432.GO4536@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
         <20191003013325.2614-11-leonardo@linux.ibm.com>
         <20191003074432.GO4536@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cFtUj1Ho01ANPCDPn5bA"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030167
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-cFtUj1Ho01ANPCDPn5bA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 09:44 +0200, Peter Zijlstra wrote:
> This shouldn't be a user visible option at all. Either the arch needs
> it and selects it or not.

You are right. I will do that on v6.
Thanks for the feedback!

--=-cFtUj1Ho01ANPCDPn5bA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2WXKsACgkQlQYWtz9S
ttT0Rw/+O9ro3F+kPIMVu+zxDUbz2AsZH3nFxKIz+44t5QRLd0SVCWEZoL8sXxBl
szuekeDyKqOVi4Uxq0kFBYP79d+/4XthFa9AwDozRXNre5Q0DiNv0j0z9DT0Ng02
nSLeaiuIt8SlD/TRrFOrlt0yFmE0485uR2jQYklJ056mh+629wFa8XJ3NOuOlU3C
wst6saBjYMZXlDg2acZTrI6VY1tpXAzkD1q1yQoEFUoMaLuBNhvLff0kxjxKTm2A
WnfAyv+BNeD/BlUzi8ifmvz/V6tWyhJ3LGwOOPloAKVy+SyJkxhzQoNn0uToodx6
GqeglOW+cnrPkmn3vZpinpSVOoQDzyy1MrurMbpXtV1iiVBxGXflyK7GAa9bpI4l
E45jXUJHTnFB3LOon16oBweT/fM3jVa4RVzPzO7JFfdLQUhnNdWROxdglOVvQxH7
2ZSy6maWC/mwRerDZk23R+usHwJ3kRItE/XT6mfzWcgf16Ph0A0xuZTLYvKJgOX4
8mFMwRkitAKKI/AYeKZ5w1AsVzO6XcG95Fxv78yIHxau479a0LB8FQVbCUySWjlR
6hZvWhqKJpy28cRX9ojp9MEzhABgb3bp8/3N7IKSxC2Gxsf7tVFs6ioEGFyBk/mK
unZ51OqsQ9LvoN4l67gzt238uunxFlb/uQIH4AWX/eO/9iYv5lY=
=uZ4G
-----END PGP SIGNATURE-----

--=-cFtUj1Ho01ANPCDPn5bA--

