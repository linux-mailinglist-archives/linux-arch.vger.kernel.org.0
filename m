Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2575155013
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgBGB5u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 20:57:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgBGB5u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 20:57:50 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0171sQ2d078215;
        Thu, 6 Feb 2020 20:57:11 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3k7aay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 20:57:11 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0171sTwQ078428;
        Thu, 6 Feb 2020 20:57:10 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3k7aad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 20:57:10 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0171ugi1000851;
        Fri, 7 Feb 2020 01:57:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 2xykc9sme6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 01:57:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0171v8Il45220132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 01:57:08 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A29F7805E;
        Fri,  7 Feb 2020 01:57:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCBC77805F;
        Fri,  7 Feb 2020 01:56:47 +0000 (GMT)
Received: from LeoBras (unknown [9.85.188.217])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 01:56:47 +0000 (GMT)
Message-ID: <ee81338952c474f2bb4c19055105e906ee89ed8f.camel@linux.ibm.com>
Subject: Re: [PATCH v6 10/11] powerpc/mm: Adds counting method to track
 lockless pagetable walks
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
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Date:   Thu, 06 Feb 2020 22:56:40 -0300
In-Reply-To: <d9bf6878-43d5-b45a-7abb-cdcb712a0d7a@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-11-leonardo@linux.ibm.com>
         <d9bf6878-43d5-b45a-7abb-cdcb712a0d7a@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6qOVo11nuEHoC6blV5gO"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070009
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-6qOVo11nuEHoC6blV5gO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe, thanks for the feedback!

On Thu, 2020-02-06 at 07:23 +0100, Christophe Leroy wrote:
> > Due to not locking nor using atomic variables, the impact on the
> > lockless pagetable walk is intended to be minimum.
>=20
> atomic variables have a lot less impact than preempt_enable/disable.
>=20
> preemt_disable forces a re-scheduling, it really has impact. Why not use=
=20
> atomic variables instead ?

In fact, v5 of this patch used atomic variables. But it seems to cause
contention on a single exclusive cacheline, which had no better
performance than locking.
(discussion here: http://patchwork.ozlabs.org/patch/1171012/)

When I try to understand the effect of preempt_disable(), all I can
see is a barrier() and possibly a preempt_count_inc(), which updates a
member of current thread struct if CONFIG_PREEMPT_COUNT is enabled.

If CONFIG_PREEMPTION is also enabled, preempt_enable() can run a
__preempt_schedule() on unlikely(__preempt_count_dec_and_test()).

On most configs available, CONFIG_PREEMPTION is not set, being replaced
either by CONFIG_PREEMPT_NONE (kernel defconfigs) or
CONFIG_PREEMPT_VOLUNTARY in most supported distros. With that, most
probably CONFIG_PREEMPT_COUNT will also not be set, and
preempt_{en,dis}able() are replaced by a barrier().

Using preempt_disable approach, I intent to get better performance for
most used cases.

What do you think of it?

I am still new on this subject, and I am still trying to better
understand how it works. If you notice something I am missing, please
let me know.

Best regards,
Leonardo Bras



--=-6qOVo11nuEHoC6blV5gO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl48w9kACgkQlQYWtz9S
ttRVsA/8Dyp6k5thnNgsjEEIsLkY9LPRaOu8UrFjwrcO7oL3UX6WdntMOaUnRM+a
GcwoCxR10usCnrU8JYA4k00399p28GWHVFIyaDR5wDt2LicdHh9rZvYGcwaedz72
NKeTy6X9THl2qZMJWg3X3xcGSa60FSXLuSV3e2FKa5pFlDbfm6UNna5Mm073c7Ae
DaPYoGoMlR8zWVAAaQGSTG8ZceJcRN0rME1bEk3neQqpLKuvcCIp579JQrwwQULF
kQkqWjNbgUDG4A4n8Z5vQjXBjNBbQ8Yb3iJuwWGfM5Yx4KmKQe8fbObvkvBSqkd6
c1ySeZ2ovFxg57RRw7qRU/q1BOIM8ZIFr29yFlmxEUuGRqR8YtFcH5QKcWM0d4D4
sSYbzPUS25Ry5uzTsO8Azjs7d+FTTM11Usb6oN6e/Pahw4YQx9BJgtSvWXIDhqR0
vKy/tHkiFbXVM4Bmb4Qn13FQZ2IzsnTSVOBFOlC8J7ZHovmIMv7vL+EAHna8YD62
g7aJzoCtDOm07KIqCwd0E4bP737gq4mNeQIXb+I66cAyMLQ0Z4EawrteB6v6mUFE
3ns0+J2fbKSnNH6wk2gmzyUe+PpBELf+2z8llAN4Q0uLybM2NVRvE3CgPfYedGX3
/8haSfnBXwd5K3TfiV6gurXf3zSvs5hal+tgTDOYRZRpsO6iDq8=
=MmWn
-----END PGP SIGNATURE-----

--=-6qOVo11nuEHoC6blV5gO--

