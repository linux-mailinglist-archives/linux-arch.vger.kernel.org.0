Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E28C0E4E
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2019 01:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfI0X0c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 19:26:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37718 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbfI0X0b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:26:31 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RNMM8a117362;
        Fri, 27 Sep 2019 19:25:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w27efrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:25:24 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RNN1oe118011;
        Fri, 27 Sep 2019 19:25:23 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w27efrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:25:23 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RNOwfV014224;
        Fri, 27 Sep 2019 23:25:23 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 2v5bg7v3r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 23:25:23 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RNPMFX53871064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 23:25:22 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FDDDAE062;
        Fri, 27 Sep 2019 23:25:22 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAB83AE05C;
        Fri, 27 Sep 2019 23:25:18 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.58])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 23:25:18 +0000 (GMT)
Message-ID: <ed1a954a67de3b1fa66e921883153622f3446813.camel@linux.ibm.com>
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
Date:   Fri, 27 Sep 2019 20:25:15 -0300
In-Reply-To: <8fe1ee1abf52719e75902dc7d5cd1e91751eaba7.camel@linux.ibm.com>
References: <8fe1ee1abf52719e75902dc7d5cd1e91751eaba7.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MbHwrL3A6S40tAt0oPvi"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270202
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-MbHwrL3A6S40tAt0oPvi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-27 at 11:46 -0300, Leonardo Bras wrote:
> I am not sure if it would be ok to use irq_{save,restore} in real mode,
> I will do some more reading of the docs before addressing this.=20

It looks like it's unsafe to merge irq_{save,restore} in
{start,end}_lockless_pgtbl_walk(), due to a possible access of code
that is not accessible in real mode.

I am sending a v4 for the changes so far.
I will look forward for your feedback.

--=-MbHwrL3A6S40tAt0oPvi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2OmlsACgkQlQYWtz9S
ttQSdxAAxb2vcaIJh6GyRJa4P3h6d85JpvByKZBBiNvOp5Lol0AgvQ0skrphW2hM
0COavBu2j4C8+n6NhwOH1gbCZpup8sGrXc7bpMg7+WZ5uE4NyyeIlvUVgerTxrAI
MmHKILew1y5IqmcIGzea+AynytNb20c98joR2EbZ/7S3lruP93C5WLTgb586eHGi
oAtukVuDfOeeM4QzQh8OuT7pJLASLfUE+wBh4ZF25jlIx22TBKiP2k7yAIxOHCSM
bCUxHPinYhxA7IMKgJM98MWd4RsXRH8sQ5j0fajUwrWXqY3DzDu12OYd6KbgiBjG
J+L/UztjLHU0qrlvVwYYzz+y5e8ZbLro1hNlnbT9wsAhKmty0VkOlY1Ml6VH909g
2MTmldoUju1SAE61pMtCBnhGBhdXAU6H4M+H8Ry4Tj5C6TwtJlZ/WgVklxRqrdnN
6B4VsI3DumYzbwsX/Nra6rKLWPpFhK2QJ2KUMi303M9AfPEwjH2mu5fNxBauAOry
Frt17kk6bGWBZcehbkpx9jNxrxBisohc13LHz7o75zd8U5wvoYXLeRmTFXGPCY7M
fxo4s8pNXyEYyfFZ8i7HPXRML6RVQ6I8QqZjV/hhRxoVkipnVScFxgCuEUGdhTei
YnKQbPBBOI/lHVy16zst1+eW/fDo5CkAV003jZc4sIuAzvHjR24=
=RxjC
-----END PGP SIGNATURE-----

--=-MbHwrL3A6S40tAt0oPvi--

