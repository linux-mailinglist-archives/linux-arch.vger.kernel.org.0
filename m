Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31873F877
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjF0JNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjF0JNY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 05:13:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8BFD;
        Tue, 27 Jun 2023 02:13:23 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R96B9i008761;
        Tue, 27 Jun 2023 09:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eRYl3tInGhDOkzzXnyLKjP4RygjUjtbP4SrRO0c+vWQ=;
 b=qDMffMBt8L6VJlwG8tURp2ZwilOX9K/rqLsrvTLNcHcNumo5bXR85n2fT0V+E8EjUk5Y
 MlWgFliseuH0ILUWdMKcO74nbfFS/WBE7JHU1CjKECJJGNRi3wHYo6DeppuQ3OdJdQrn
 Vbi1W3l1URgOENUohIs1eHwzBsJ1jkOe8pkB2S/b45Od2XToIs9s3TTdIAJ5lmd7Dpv/
 Kr47XyYy/CdcVx1PLxDAOnJIcagSMolnzSck45iCfK6vIL0+ZJ4rMkjXu9OHE0C6CyVN
 /LX4QweXpJ/o2Jw3gyZosKjZq3kQrz/FcGOCH/SxTFGXM6U/+vnhzy9/MS8svLtRjepB 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfvq8rabp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:13:03 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R96GKB009302;
        Tue, 27 Jun 2023 09:13:03 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfvq8raar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:13:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R3BSQ5025785;
        Tue, 27 Jun 2023 09:13:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rdqre1bqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:13:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35R9CwrH65798408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 09:12:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A85F2004B;
        Tue, 27 Jun 2023 09:12:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F0C20040;
        Tue, 27 Jun 2023 09:12:57 +0000 (GMT)
Received: from [9.152.212.248] (unknown [9.152.212.248])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jun 2023 09:12:57 +0000 (GMT)
Message-ID: <43a1f34a6b1c5a14519f3967dff5eb42e82ee88d.camel@linux.ibm.com>
Subject: Re: [PATCH v5 00/44] treewide: Remove I/O port accessors for
 HAS_IOPORT=n
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Date:   Tue, 27 Jun 2023 11:12:57 +0200
In-Reply-To: <7b5c40f3-d25b-4082-807d-4d75dc38886d@app.fastmail.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
         <7b5c40f3-d25b-4082-807d-4d75dc38886d@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fZujSueKmVHDxjYCpP51RL3hPXVzRXrP
X-Proofpoint-ORIG-GUID: XqQNy_k3bnezF-iSHCzgIlhzyUZTuwmi
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-05-22 at 13:29 +0200, Arnd Bergmann wrote:
> On Mon, May 22, 2023, at 12:50, Niklas Schnelle wrote:
>=20
> > A few patches have already been applied but I've kept those which are n=
ot yet
> > in v6.4-rc3.
> >=20
> > This version is based on v6.4-rc3 and is also available on my kernel.or=
g tree
> > in the has_ioport_v5:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
>=20
> I think it would be best if as many patches as possible get merged
> into v6.5 through the individidual subsystems, though I can take
> whatever is left through the asm-generic tree.
>=20
> Since the goal is to have maintainers pick up part of this, I would
> recommend splitting the series per subsystem, having either a
> separate patch or a small series for each maintainer that should
> pick them up.
>=20
> More importantly, I think you should rebase the series against
> linux-next in order to find and drop the patches that are queued
> up for 6.5 already. The patches will be applied into branches
> that are based on 6.4-rc of course, but basing on linux-next
> is usually the easiest when targeting multiple maintainer
> trees.
>=20
> Maybe let's give it another week to have more maintainers pick
> up stuff from v5, and then send out a v6 as separate submissions.
>=20
>     Arnd

Hi Arnd and All,

I'm sorry there hasn't been an updated in a long time and we're missing
v6.5. I've been quite busy with other work and life. Speaking of, I
will be mostly out for around a month starting some time mid to end
July as, if all goes well, I'm expecting to become a dad. That said, I
haven't forgotten about this and your overall plan of sending per-
subsystem patches sounds good, just haven't had the time to also
incorporate the feedback.

Thanks,
Niklas
