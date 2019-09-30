Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CBC2341
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfI3O3P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 10:29:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731686AbfI3O3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 10:29:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UES0XW067295;
        Mon, 30 Sep 2019 10:28:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbjvysrus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 10:28:04 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8UENktC053801;
        Mon, 30 Sep 2019 10:27:18 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbjvysru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 10:27:18 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8UEOthJ009512;
        Mon, 30 Sep 2019 14:27:17 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 2v9y57kc4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 14:27:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UERGfb60031398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 14:27:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 684CCC6055;
        Mon, 30 Sep 2019 14:27:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE02C605A;
        Mon, 30 Sep 2019 14:27:11 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.58])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 14:27:11 +0000 (GMT)
Message-ID: <5d3ad682f5ef3a7f16fdda9bcd30fbf53194b393.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Date:   Mon, 30 Sep 2019 11:27:10 -0300
In-Reply-To: <20190930110927.nanq2wynvfmq7dhc@box>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
         <20190927234008.11513-4-leonardo@linux.ibm.com>
         <20190930110927.nanq2wynvfmq7dhc@box>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5QWWSZPLD+oFKjYyk88w"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300151
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-5QWWSZPLD+oFKjYyk88w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 14:09 +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 27, 2019 at 08:40:00PM -0300, Leonardo Bras wrote:
> > As decribed, gup_pgd_range is a lockless pagetable walk. So, in order t=
o
>      ^ typo
>=20
Fixed, thanks!

--=-5QWWSZPLD+oFKjYyk88w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2SEL4ACgkQlQYWtz9S
ttRgkRAAlYimCAeVA9cvc5HGNEVbfibfjFEgDVu7fY/HjI44ZGaauFSEvLDnnTcz
M4WLEbD8cZ/LBPDP06Q8FuNtSZi1Ov1xVCXB404DodiPDkJG/TyVfO5/E5MsT7tf
1qvSg8n53RfUxpN2WHNKg2eXLStcVwKmoS0otMxkIOPxTRGFk9PchNJ3F3QEQLYE
3JwfwBa8q1d79DY19qiJ2VyqQm5nAAojm1i5JcHEUdMcA/INJgamhRpa5R6vx6Ge
LZHOthO7x+H28Ip32KAmw5ISf8Q0AKEb0rLmIwkCUD0ecO0bp5D7F9KM/J5oBjKO
pkVyqy61ZSdeArRc1M5HoOdI+evIGKSNtDJglyKckC3/KiUfkALvrjNe/USc9j3s
DxvgKE2FNP+I6n2z0C2weHITU9EjKdqPSpVRzRBowUE8rw2o1d+oCurRiGI+Tgm8
z3NEGoIdJFEkmNIvmbDPrRsz6E9viESfOGju8U9Um2Cxr14FJ6xGjGCeGylfgDED
/L7nMZ12gv4DZoJp9UaLlau8hItsneS9ZVgvIEivPDWW+MmB3nN0SNhWjeP7VlMU
jfa8kXlgp+gtsUn+jdwqgSrWDmAN4K4QSrtl0QmWN5GjNSQMEWkm5Jdb3Dk2etmx
JgYiX4UH8m9pdwN6ILWOPT7RnqL1IuV39OvC5Uay30/nlL5roTM=
=65+f
-----END PGP SIGNATURE-----

--=-5QWWSZPLD+oFKjYyk88w--

