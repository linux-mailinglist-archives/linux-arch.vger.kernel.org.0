Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80236510B4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiLSQtu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 11:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiLSQts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 11:49:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E312AEF;
        Mon, 19 Dec 2022 08:49:47 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJGgCkw012947;
        Mon, 19 Dec 2022 16:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=X/TCy+np95A3btt+KYPVOzVuzd5nRH3EepKk5/dPBvM=;
 b=Js/kiTBvvm2xw1oUgfBeMmxw836mIfpYmLwOVfwK9/IhsQBOLcdR7/iW2C5PzFewk1Ou
 PEXfPORBVX+EXj+REDuUAt+HL7rcGQr7z6Axq3mw7U8Wh2/Bh2UcCgJYFgpp3z1dIRKw
 rhJTAkqn4SlC5knZh30sF33RBo5fQKW/IcjIVE13uSHE/kt2DZaLiiK8g9lv5VKheZMr
 Ut5riOVi7wFaify6AtSW6zE4QurCH7VAToHKyWjysHcjxnZerFWNyNUBhrdD1qPMSO+9
 xVd5iH3Plp0NfQh5WDd1UYpdb9PpLp/UxGLR7hn4wxafFtJeMwXb51gII/Ib8qanoCrP wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjuq108qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:47:57 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BJGigIl001168;
        Mon, 19 Dec 2022 16:47:56 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjuq108pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:47:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJE7cBC024486;
        Mon, 19 Dec 2022 16:47:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mh6ywjv2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:47:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJGlmPq23921026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 16:47:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9C1420040;
        Mon, 19 Dec 2022 16:47:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D0420043;
        Mon, 19 Dec 2022 16:47:48 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 16:47:48 +0000 (GMT)
Message-ID: <3088ea5ffdfd095ca67265ed711e8d2bc188b362.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 09/12] x86,amd_iommu: Replace cmpxchg_double()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Date:   Mon, 19 Dec 2022 17:47:47 +0100
In-Reply-To: <20221219154119.419176389@infradead.org>
References: <20221219153525.632521981@infradead.org>
         <20221219154119.419176389@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: avK4AaeUvBdFbu_514SfMdG6OTeTMyeK
X-Proofpoint-GUID: MKTubrQvIx2xVgk4vNHOE1U_o7athJpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=721 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212190147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2022-12-19 at 16:35 +0100, Peter Zijlstra wrote:
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |    9 +++++++--
>  drivers/iommu/amd/iommu.c           |   10 ++++------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>=20
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -979,8 +979,13 @@ union irte_ga_hi {
>  };
> =20
>  struct irte_ga {
> -	union irte_ga_lo lo;
> -	union irte_ga_hi hi;
> +	union {
> +		struct {
> +			union irte_ga_lo lo;
> +			union irte_ga_hi hi;
> +		};
> +		u128 irte;
> +	};
>  };
> =20
>  struct irq_2_irte {
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2992,10 +2992,10 @@ static int alloc_irq_index(struct amd_io
>  static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  			  struct irte_ga *irte, struct amd_ir_data *data)
>  {
> -	bool ret;
>  	struct irq_remap_table *table;
> -	unsigned long flags;
>  	struct irte_ga *entry;
> +	unsigned long flags;
> +	u128 old;
> =20
>  	table =3D get_irq_table(iommu, devid);
>  	if (!table)
> @@ -3006,16 +3006,14 @@ static int modify_irte_ga(struct amd_iom
>  	entry =3D (struct irte_ga *)table->table;
>  	entry =3D &entry[index];
> =20
> -	ret =3D cmpxchg_double(&entry->lo.val, &entry->hi.val,
> -			     entry->lo.val, entry->hi.val,
> -			     irte->lo.val, irte->hi.val);
>  	/*
>  	 * We use cmpxchg16 to atomically update the 128-bit IRTE,
>  	 * and it cannot be updated by the hardware or other processors
>  	 * behind us, so the return value of cmpxchg16 should be the
>  	 * same as the old value.

The above comment seems to have already been out of date but could be
updated to say cmpxchg128 instead of cmxchg16 anyway.

>  	 */
> -	WARN_ON(!ret);
> +	old =3D entry->irte;
> +	WARN_ON(!try_cmpxchg128(&entry->irte, &old, irte->irte));
> =20
>  	if (data)
>  		data->ref =3D entry;
>=20
>=20

