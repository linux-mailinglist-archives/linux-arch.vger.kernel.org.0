Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE861742757
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF2N0q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjF2N0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 09:26:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B098C2D4A;
        Thu, 29 Jun 2023 06:26:39 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TDGKLk015851;
        Thu, 29 Jun 2023 13:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QsIE4YvZg+MuKCPLsytxLGBxlXmOrHMoeFDnva0uOEY=;
 b=ELtgLYVfVrWbrHzSUpHP46dmIfUtiIsPOaTfZ/v7RTnGLVViRBe7AZdaRf7qpZiKh19m
 jSbKFimF+R3TTmfzEzM/47DqzdwRKqHtQYEJP3m1fKltkkfPq0SzDFRTM0gAmBvVPjo7
 G21LYQPfzbhqtCmb6VpNBPV+Y3/fcVykD99woxFt74d0fTbnYKfdVVpvZJHshPLA6wMq
 PCDo7akSZcg9x8PYqPv3Aze2NC4jdGf5ZMvBz4D1MgCrhrIowYqmA9F94lAIEbiHUz+q
 a3/j1AHSLhflgYNardOulyKefteNmn1Asu0xJBAKd4A2Ll240unw1VC8domCzeK9tsp1 aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhapqr7mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 13:26:18 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TDGZfU017050;
        Thu, 29 Jun 2023 13:26:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhapqr7kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 13:26:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T3p0UE004735;
        Thu, 29 Jun 2023 13:26:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr453c1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 13:26:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TDQDxd41484622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 13:26:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087F32004B;
        Thu, 29 Jun 2023 13:26:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09C7720040;
        Thu, 29 Jun 2023 13:26:12 +0000 (GMT)
Received: from [9.171.48.121] (unknown [9.171.48.121])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jun 2023 13:26:11 +0000 (GMT)
Message-ID: <cf4f1ec3873b6c4b92ddb347d5bd3c2e2f03bf00.camel@linux.ibm.com>
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
Date:   Thu, 29 Jun 2023 15:26:11 +0200
In-Reply-To: <de4fe7d1-a0ae-40eb-a9d4-434802083e70@app.fastmail.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
         <7b5c40f3-d25b-4082-807d-4d75dc38886d@app.fastmail.com>
         <43a1f34a6b1c5a14519f3967dff5eb42e82ee88d.camel@linux.ibm.com>
         <de4fe7d1-a0ae-40eb-a9d4-434802083e70@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BxIZCkNvLWM-htSxEtD_VuqrJkpEhI2T
X-Proofpoint-GUID: ukF1eiTpCrqXSEgzF4YcIcJY7PrWlXJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-06-27 at 14:53 +0200, Arnd Bergmann wrote:
> On Tue, Jun 27, 2023, at 11:12, Niklas Schnelle wrote:
> > On Mon, 2023-05-22 at 13:29 +0200, Arnd Bergmann wrote:
> > >=20
> > > Maybe let's give it another week to have more maintainers pick
> > > up stuff from v5, and then send out a v6 as separate submissions.
> > >=20
> > >     Arnd
> >=20
> > Hi Arnd and All,
> >=20
> > I'm sorry there hasn't been an updated in a long time and we're missing
> > v6.5. I've been quite busy with other work and life. Speaking of, I
> > will be mostly out for around a month starting some time mid to end
> > July as, if all goes well, I'm expecting to become a dad. That said, I
> > haven't forgotten about this and your overall plan of sending per-
> > subsystem patches sounds good, just haven't had the time to also
> > incorporate the feedback.
>=20
> Ok, thanks for letting us know. I just checked to see that about half
> of your series has already made it into linux-next and is likely to
> be part of v6.5 or already in v6.4.
>=20
> Maybe you can start out by taking a pass at just resending the ones
> that don't need any changes and can just get picked up after -rc1,
> and then I'll try to have a look at whatever remains after that.
>=20
>     Arnd


Oh yeah looks better than I anticipated. I seem to have picked an odd
base commit for "tty: serial: .." because of which Greg couldn't apply
it so res-ending + rebase might be enough for that. By my count it
looks like only "usb: pci-quirksL ..." needs real work and possibly the
"drm: .." part though the discussion around cirrus doesn't look like it
would require much work. So I'll do rebase/re-send of the easy ones
tomorrow/next week.

Thanks,
Niklas
