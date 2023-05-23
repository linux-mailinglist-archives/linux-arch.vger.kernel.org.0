Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A270D4E5
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjEWH1b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjEWH1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 03:27:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D44D118;
        Tue, 23 May 2023 00:26:35 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N7KF4m028065;
        Tue, 23 May 2023 07:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pHafteXpIp3R1/304yije+f7UKFOtRSNN2tRQFSYIcI=;
 b=IykSz8DjgDtWcmHa5DPuUBCQb5YXgMbKj/sn16ec0yA/QBfbwjTRLvsp0l4ASTZnqiYA
 8ds50vUezrHRRGDDXE4Y9+IA25IJygVtNyfvm0NGG38nqJiZUoKEtp2bgaoFRJ6slXFB
 gZlu26clj7j7984Toz08tQdz6CZ4bOmA3FIU4ZFym1eK42/+TRTNv7bhoMTcX2BcaC/f
 1wX/RGi0cYoFOTttgQS2LDijN7mD2gaT+HfGBxifpVH9iB+AkP52t8vbvfHT5nLgsOro
 4qblFvaWdT1/Tl3RLl1zzb+pqGxfI6mTNN8ghItYOVARAnn0fD6u7I8kim1xdUkYRGhy Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrs0gr4f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:26:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34N7KpOw029261;
        Tue, 23 May 2023 07:26:15 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrs0gr4e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:26:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6qx5e022642;
        Tue, 23 May 2023 07:26:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qppcs93x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:26:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34N7QAQ514746238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 07:26:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62DFF20040;
        Tue, 23 May 2023 07:26:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38B8F20043;
        Tue, 23 May 2023 07:26:09 +0000 (GMT)
Received: from [9.171.22.235] (unknown [9.171.22.235])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 23 May 2023 07:26:09 +0000 (GMT)
Message-ID: <6aed4e775150097e974076934bb70517664c9cc9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 31/44] scsi: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com
Date:   Tue, 23 May 2023 09:26:08 +0200
In-Reply-To: <yq1jzx0m28g.fsf@ca-mkp.ca.oracle.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
         <20230522105049.1467313-32-schnelle@linux.ibm.com>
         <yq1jzx0m28g.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GxpFZ4VytsOirxzYC4b7iXuDYDPEIn9T
X-Proofpoint-GUID: hdW087PQYiCVB3Ubjsvo9VoWnWWFjm2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=810
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-05-22 at 18:28 -0400, Martin K. Petersen wrote:
> Niklas,
>=20
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
>=20
> Do you intend for me to pick these up?
>=20

Hi Martin,

Yes if you're okay with the changes go ahead and pick them up for the
subsystems you maintain. Our plan is to get as many of these picked up
for v6.5 as possible, then deal with the stragglers and finally merge
the last patch in this series that disables inb()/outb() for
HAS_IOPORT=3Dn.

Thanks,
Niklas
