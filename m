Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C6704C7F
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjEPLkU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 07:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjEPLkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:40:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9891F2D4C;
        Tue, 16 May 2023 04:40:15 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GBcXVQ020880;
        Tue, 16 May 2023 11:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YkhRQbWj+jTt2Ue3u9TW20D+7Bv+YjDbhfGt4q6glLc=;
 b=cdIxkgcMMZS1xBXzAgbxJRLIs/g6eEN/67NggdAKbmFAU7k6/CYtGXCfmRZS/rZSkG5p
 4MGVz2Qfp1JqT4pL4zBGVEsPODLwNux4CQcUYGkHl555az82/pIpzupitbws8z6fMO8o
 bINaR6tJFhaymVnIWqSnrH5Z9y3L9UwN13xzHrjK3b0I82BN0X7mXDaFFfJZWBLp8VDI
 FX/vH9Xc4oq5I7W0u+T3rNxRPBIjSPBkHvyVJL0yLKYZni34JjPKyvvq2tDe8Ix9IqQ6
 449JNsG95QlxspP308eUDEKPk9hp2E/Isw+FEabZUpuSoSh5l3auzzVrfrREKb4BBRq5 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm7jp2tu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:39:32 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GBcmcb021497;
        Tue, 16 May 2023 11:39:31 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm7jp2tr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:39:31 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G9c7Zi031636;
        Tue, 16 May 2023 11:39:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qj2651b5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:39:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GBdQWU57934228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:39:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A07B20040;
        Tue, 16 May 2023 11:39:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C8A32004B;
        Tue, 16 May 2023 11:39:25 +0000 (GMT)
Received: from [9.152.212.232] (unknown [9.152.212.232])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 11:39:25 +0000 (GMT)
Message-ID: <97b01d4cefb0310c6956bac198e564b212fb93ca.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/41] char: impi, tpm: depend on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
Date:   Tue, 16 May 2023 13:39:25 +0200
In-Reply-To: <60e9d000-0793-1421-3045-fdb74976373c@molgen.mpg.de>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-4-schnelle@linux.ibm.com>
         <60e9d000-0793-1421-3045-fdb74976373c@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NkBegRieKaiZe8tSrIXbhLD0l1pYOvlA
X-Proofpoint-GUID: 8VH3GLGz6RvnThNaF42HrH7TLEJAxoth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=990
 adultscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 13:06 +0200, Paul Menzel wrote:
> Dear Niklas,
>=20
>=20
> Am 16.05.23 um 12:59 schrieb Niklas Schnelle:
>=20
> [=E2=80=A6]
>=20
> There is a small typo in the commit message summary/title: impi =E2=86=92=
 ipmi.
>=20
>=20
> Kind regards
>=20
> Paul
>=20

Good catch. I fixed it locally now. Let's see if we need a v5 anyway or
if this can be changed on applying the patch.

Thanks,
Niklas
