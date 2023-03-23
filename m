Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C175B6C6A66
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 15:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCWOEo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCWOEm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 10:04:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1012858;
        Thu, 23 Mar 2023 07:03:43 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NDsfoN007435;
        Thu, 23 Mar 2023 14:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Cm6jXCwZY8RCqSdFIPbnheoZ7VaWsoUqrua9XRof6vA=;
 b=Q970siBtWxzM/DjB9jQHnvEd1RcTpRU9Mfo++t/wJYZ/j7yLQnY5rcH+BLbc5zt707yL
 ryFRaojsBs61R3V93mGoUc9WQ1UeT9bypJiffhcgVfjPl+wYUA7eJs62UXkqbPXudVLR
 BSbvAh6LPDyJmlBO3O7vEfBtHDENo5Pzx39Ey1D/K2HVBkP7ZWf0QWGb0X4fZd/uL3tp
 Vp8zP4ZKNPyv3EJNwVloB6Sk14NjmuuPMOh4bDNiKZ1fH84wLWCD8STOJ19NfDzfgBlG
 rZ9u3vWixlrwem9w/TU/i2OLNa8S6mBLzyUCTirGn5G281obNfSfR56QLVheDTaxEWV/ 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgkxuy0mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:02:59 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ND1LmF016255;
        Thu, 23 Mar 2023 14:02:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgkxuy0kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:02:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N9QcL1017248;
        Thu, 23 Mar 2023 14:02:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6feex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:02:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NE2rB226411586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 14:02:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6F2A20040;
        Thu, 23 Mar 2023 14:02:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B54392004D;
        Thu, 23 Mar 2023 14:02:52 +0000 (GMT)
Received: from [9.171.87.16] (unknown [9.171.87.16])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 14:02:52 +0000 (GMT)
Message-ID: <14a5fa1cc6edd9a297b20af779b68d1e58f83419.camel@linux.ibm.com>
Subject: Re: [PATCH v3 15/38] leds: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-leds@vger.kernel.org
Date:   Thu, 23 Mar 2023 15:02:52 +0100
In-Reply-To: <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-16-schnelle@linux.ibm.com>
         <20230316161442.GV9667@google.com>
         <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
         <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NKCV9_NlXK_3y2SKaUWL9MInDvmMkbFG
X-Proofpoint-ORIG-GUID: fOjjC6qIIBP-iEDC1swgPO34WpDHFDV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=762 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230102
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-03-23 at 14:32 +0100, Arnd Bergmann wrote:
> On Thu, Mar 23, 2023, at 13:42, Niklas Schnelle wrote:
> > On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
> > > On Tue, 14 Mar 2023, Niklas Schnelle wrote:
> > >=20
> > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and fr=
iends
> > > > not being declared. We thus need to add HAS_IOPORT as dependency fo=
r
> > > > those drivers using them.
> > > >=20
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >  drivers/leds/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > Applied, thanks
> >=20
> > Sorry should have maybe been more clear, without patch 1 of this series
> > this won't work as the HAS_IOPORT config option is new and will be
> > missing otherwise. There's currently two options of merging this,
> > either all at once or first only patch 1 and then the additional
> > patches per subsystem until finally the last patch can remove
> > inb()/outb() and friends when HAS_IOPORT is unset.
>=20
> It's probably too late now to squeeze patch 1 into linux-6.3
> as a late preparation patch for the rest of the series in 6.4.
>=20
> It would be good if you could respin that patch separately
> anyway, so I can add it to the asm-generic tree and make
> sure we get it ready for the next merge window.
>=20
>      Arnd

Yes, sorry I was traveling Thursday to Monday and then spent some time
catching up and investigating an internal issue. I'm currently going
through the patches one by one incorporating comments. I fear the split
of the USB patch as well as the suggestions for video might take a bit
of time, so if you prefer I could also send just an updated patch 1
separately. How would I do this cleanly? Send as v4 without(?) a cover
letter and add a Note after the '---'?

Thanks,
Niklas
