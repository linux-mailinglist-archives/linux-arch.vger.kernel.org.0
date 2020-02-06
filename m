Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654E0153D98
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBFD0G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:26:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727474AbgBFD0G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:26:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0163EM4O118249;
        Wed, 5 Feb 2020 22:25:36 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyphx1566-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:25:36 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0163LKY9016276;
        Wed, 5 Feb 2020 22:25:35 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyphx155m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:25:35 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0163Blmv019116;
        Thu, 6 Feb 2020 03:25:34 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 2xykc9hw66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 03:25:34 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0163PXtR29163848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 03:25:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EA70AE05F;
        Thu,  6 Feb 2020 03:25:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 350F1AE05C;
        Thu,  6 Feb 2020 03:25:24 +0000 (GMT)
Received: from LeoBras (unknown [9.85.163.250])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 03:25:23 +0000 (GMT)
Message-ID: <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Date:   Thu, 06 Feb 2020 00:25:18 -0300
In-Reply-To: <20200206030900.147032-3-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-3-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5TGq9qc6jmgO8SfflYEA"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=918 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060023
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-5TGq9qc6jmgO8SfflYEA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
>                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
> -               local_irq_enable();
> +               end_lockless_pgtbl_walk(IRQS_ENABLED);
>                 ret =3D nr;
>         }
> =20

Just noticed IRQS_ENABLED is not available on other archs than ppc64.
I will fix this for v7.

--=-5TGq9qc6jmgO8SfflYEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl47hx4ACgkQlQYWtz9S
ttTS9w/9E7lK8J1xIstn8wQNOKb6Mpalq1gAoAMSwEKVsxtJCgv5GQoVzfi83uzh
s6Qq+5ydWu172eeRW66NmQaespclUattqesFf5qhvVnLGpwTbGSPlSF0IWzKr7s9
ofzcAbyqaDh6+DTOestPd3ADSlUZ4HWxOKc5XSi5TyHX0RP9JK/gu26hdvr9oHDI
ZU16OrdCAecYyE7/hKY0a+VGRsyZVab3VBWy/6EJdo9Z8bNc/aquHQQ+RkdaB3M/
VtA1A0NUOBcbu+tFKG3Q2yzPQb9/5Ob7m5uG2Oa2f3huyk8FOXySioH4qUHqZAuB
8bZIrD49y3YXZ9sFF4b4eqyDyeutnHAoMa/FBuMPmQW/diiFKhSIvLsiEz4gu1B9
jn04+n0wrnV8wXxe3xUEQ6ooxhCY6UmNSIjlXOewvk/j2E37mZIdaPY5Bx6GlDBM
MSXHfcN2LtpRH1FTqH8tZvwYf7JdkspVbbBipLrr8Ba8fGZ3fKcnfIIaOSRd1tvE
uTHEgfICZKnzXxPM/tpI3n5kx7PbB6hPFDdtvjA1Vyq3tuA295qNF5fkEmTkvzmg
swZfIo4OEGyw3Oh+jsK0PH646dK6jkD17Q7Fe81+BF7uYygxdxBptKUj/GJEnqfU
3ZEFP0bpEMV17eoArkTN5eP4CNvd1VRWagVtnNLWS44WlNvdOxc=
=i1Uf
-----END PGP SIGNATURE-----

--=-5TGq9qc6jmgO8SfflYEA--

