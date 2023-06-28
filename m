Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3820F74154F
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjF1PfG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 11:35:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232516AbjF1PeO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 11:34:14 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SFW5Am006589;
        Wed, 28 Jun 2023 15:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=5R6fWz7NeMhYJqrWLivqRg6nrHUqw5T7Gu7I0l4O6uc=;
 b=NzZ/22Am/Z8PvkpRpthq6EOSOexGUK1me0QkWRyaKMKfPJIGjWjYop3hRLbwgKg20lk1
 9vWTTdf5x1lh8++PE99xBC4IdkCqORttMx08Lv3aspC1E/Ypzdl/MdjUz98gd17guj6K
 JpkuAUtd3AkjNvtRDm5Beff0Eqh8e9pWEOikTwE23p/VpvM+lMvpl8jGkC+l0ZPIR5a/
 ojo0Ga0yXWLFnw9ZaecmmnZ5MTGIlclSkQz3JuXShYEEgJHfh5yFWpLRZZuNeJNhsHkA
 w1igUwlrTnPHmq2ln3uyGEfczSlVMOQGzsERWhHxfj+3TI+pJyelZ75QymwPdpnvo2fm 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgqkcr3sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:33:49 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SFWFi5007457;
        Wed, 28 Jun 2023 15:33:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgqkcr3ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:33:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7VCZj032460;
        Wed, 28 Jun 2023 15:33:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr452mca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:33:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SFXg3A19399382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 15:33:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBA702004B;
        Wed, 28 Jun 2023 15:33:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D718620040;
        Wed, 28 Jun 2023 15:33:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.28.211])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 15:33:39 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 0/9]  Introduce SMT level and add PowerPC support
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
Date:   Wed, 28 Jun 2023 21:03:28 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch@vger.kernel.org, dave.hansen@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        npiggin@gmail.com, tglx@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <88E208A6-F4E0-4DE9-8752-C9652B978BC6@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0SuO5aQsKNId2TrFkTvw3Dw_4398fEsl
X-Proofpoint-GUID: cMRZ-5voDOJOLfGEUorg_uQQxVWtWu2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280139
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On 28-Jun-2023, at 3:35 PM, Laurent Dufour <ldufour@linux.ibm.com> =
wrote:
>=20
> I'm taking over the series Michael sent previously [1] which is =
smartly
> reviewing the initial series I sent [2].  This series is addressing =
the
> comments sent by Thomas and me on the Michael's one.
>=20
> Here is a short introduction to the issue this series is addressing:
>=20
> When a new CPU is added, the kernel is activating all its threads. =
This
> leads to weird, but functional, result when adding CPU on a SMT 4 =
system
> for instance.
>=20
> Here the newly added CPU 1 has 8 threads while the other one has 4 =
threads
> active (system has been booted with the 'smt-enabled=3D4' kernel =
option):
>=20
> ltcden3-lp12:~ # ppc64_cpu --info
> Core   0:    0*    1*    2*    3*    4     5     6     7
> Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
>=20
> This mixed SMT level may confused end users and/or some applications.
>=20

Thanks for the patches Laurent.

Is the SMT level retained even when dynamically changing SMT values?
I am observing difference in behaviour with and without smt-enabled
kernel command line option.

When smt-enabled=3D option is specified SMT level is retained across=20
cpu core remove and add.

Without this option but changing SMT level during runtime using
ppc64_cpu =E2=80=94smt=3D<level>, the SMT level is not retained after
cpu core add.

[root@ltcden8-lp8 ~]# ppc64_cpu =E2=80=94smt=3D4
[root@ltcden8-lp8 ~]# ppc64_cpu --info
Core   0:    0*    1*    2*    3*    4     5     6     7  =20
Core   1:    8*    9*   10*   11*   12    13    14    15  =20
Core   2:   16*   17*   18*   19*   20    21    22    23  =20
Core   3:   24*   25*   26*   27*   28    29    30    31  =20

Remove a core, SMT level is retained.

[root@ltcden8-lp8 ~]# ppc64_cpu --info
Core   0:    0*    1*    2*    3*    4     5     6     7 =20
Core   1:    8*    9*   10*   11*   12    13    14    15 =20
Core   2:   16*   17*   18*   19*   20    21    22    23 =20
[root@ltcden8-lp8 ~]# =20

Add 3 cores, SMT level is not retained.

[  496.600648] Fallback order for Node 1: 1 0=20
[  496.600655] Built 1 zonelists, mobility grouping on.  Total pages: =
1228159
[  496.600676] Policy zone: Normal
[  496.661173] WARNING: workqueue cpumask: online intersect > possible =
intersect
[  499.530646] Fallback order for Node 3: 3 0=20
[  499.530655] Built 2 zonelists, mobility grouping on.  Total pages: =
1228159
[  499.530675] Policy zone: Normal

ppc64_cpu --info
Core   0:    0*    1*    2*    3*    4     5     6     7 =20
Core   1:    8*    9*   10*   11*   12    13    14    15 =20
Core   2:   16*   17*   18*   19*   20    21    22    23 =20
Core   3:   24*   25*   26*   27*   28*   29*   30*   31*=20
Core   4:   32*   33*   34*   35*   36*   37*   38*   39*=20
Core   5:   40*   41*   42*   43*   44*   45*   46*   47*
 [root@ltcden8-lp8 ~]#=20

- Sachin=
