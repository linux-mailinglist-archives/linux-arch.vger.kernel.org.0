Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B6704DE5
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjEPMhK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjEPMhJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 08:37:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC3170E;
        Tue, 16 May 2023 05:37:08 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GCZ3xX028839;
        Tue, 16 May 2023 12:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=w5b3ImIf3nnbcFTz7oY9tOlzKERrU5xMQAvYBJ7V30U=;
 b=Icja5l/SBdvgM29tsNdD3O2EnFVMt6EmCmmESudlbRcD3QARDv1geZ7kSO+FJ390xdQw
 eJRRSTb6UjfHUbvnzoPSGTdz1Ut56958qyd78rXAdy+O1IuQTqZoQ9ijFkSJdbDvF8ij
 +fF0zksPSg8fw8QqraSKAax0omuFuJw60xizUM1RU9X+r/YdalQK/cSe3Y9GvvtfxQtq
 LjRLtVKc0aprvpy9X4nll2m5mtrvfz1greOgvATHoKY/QgfdFpyOoTf62RxtPh/7QUVM
 j3R//Pgil2L0E/YsK293YbbdOto6GrmL7YfKUnaK/I5Xq3vcflKFM9DzIM8qTpErRBkI fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm9ak9dbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:36:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GCZJC8029892;
        Tue, 16 May 2023 12:35:53 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm9ak9d16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:35:53 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G4Zsop017459;
        Tue, 16 May 2023 12:35:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264smq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:35:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GCZjJ124642064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 12:35:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24CB420040;
        Tue, 16 May 2023 12:35:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B96F220043;
        Tue, 16 May 2023 12:35:44 +0000 (GMT)
Received: from [9.152.212.232] (unknown [9.152.212.232])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 12:35:44 +0000 (GMT)
Message-ID: <85b69a87c1e6b5a682e2164c9abdc9e2f2cea0a4.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/41] char: impi, tpm: depend on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>,
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
Date:   Tue, 16 May 2023 14:35:44 +0200
In-Reply-To: <2023051656-mammary-cobweb-7265@gregkh>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-4-schnelle@linux.ibm.com>
         <2023051656-mammary-cobweb-7265@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2S-2uTjJBK46yrksP0f_WG1gkEOt6GI
X-Proofpoint-ORIG-GUID: xn7Tbo_9c4JcWlF-ZDe50MR9XhH82cSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 13:46 +0200, Greg Kroah-Hartman wrote:
> On Tue, May 16, 2023 at 12:59:59PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add this dependency and ifdef
> > sections of code using inb()/outb() as alternative access methods.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Acked-by: Corey Minyard <cminyard@mvista.com> # IPMI
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
> >       per-subsystem patches may be applied independently
> >=20
> >  drivers/char/Kconfig             |  3 ++-
> >  drivers/char/ipmi/Makefile       | 11 ++++-------
> >  drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
> >  drivers/char/ipmi/ipmi_si_pci.c  |  3 +++
> >  drivers/char/tpm/Kconfig         |  1 +
> >  drivers/char/tpm/tpm_infineon.c  | 16 ++++++++++++----
> >  drivers/char/tpm/tpm_tis_core.c  | 19 ++++++++-----------
> >  7 files changed, 32 insertions(+), 24 deletions(-)
>=20
> TPM and IPMI patches go through different git trees, so odds are you are
> going to have to split this patch in 2.
>=20
> thanks,
>=20
> greg k-h

Ah right sorry about that. I'll split this into 3 patches between the
drivers/char/{Kconfig, ipmi/, and tpm/} changes.

Thanks,
Niklas
