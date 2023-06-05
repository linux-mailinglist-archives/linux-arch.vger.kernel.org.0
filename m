Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4F722523
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjFEMC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjFEMCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 08:02:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C7DB;
        Mon,  5 Jun 2023 05:02:22 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355Bl0VS006747;
        Mon, 5 Jun 2023 12:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YBXLDbdum0nES/AHua7drKIgw8eoc5KcQFY9C8Fi6bg=;
 b=eJUpMrRAyTATiyaNYoUW4dwJ6PofdxcdlYnRQRXV4UUw78ubP2rgGE/9VsyH1SNpweVf
 bHPVII7DKckzRHfm+a34QyJoyvcTPruaAOKUMbSekfiSuYYSw9EYNjC6VDKUV3YPiu54
 49jhAd0D9H3Njrl9H26MF6ylnzWUBU0Kd45OMiW2SqzQuYrdlLMVCnIuUdxnqsD/mjzv
 N8pX4gF1NxVvjIkuRLgehDZfSELB3nnqCxdriZ8IavJS/5Rg3Xiz9J/DKG0rV8L64Li0
 MCbfZ+uosN4+2LQwgjizFuggo2HVMz7kstiLwR5Qq819D6dwh3EM+YiMtnkh8ZCFqV5T LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1f4mrae4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:02:00 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BlRou008055;
        Mon, 5 Jun 2023 12:01:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1f4mr9x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:01:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3553wdin006450;
        Mon, 5 Jun 2023 12:01:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qyxmyhb08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:01:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 355C1VdS1311260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jun 2023 12:01:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9989020049;
        Mon,  5 Jun 2023 12:01:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B28320040;
        Mon,  5 Jun 2023 12:01:30 +0000 (GMT)
Received: from [9.171.69.91] (unknown [9.171.69.91])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jun 2023 12:01:30 +0000 (GMT)
Message-ID: <c439a6d6ed33fc25efc292828a102b6d7996da7a.camel@linux.ibm.com>
Subject: Re: [PATCH v4 11/41] i2c: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        linux-i2c@vger.kernel.org
Date:   Mon, 05 Jun 2023 14:01:30 +0200
In-Reply-To: <ZH21E3Obp+YPJHkl@shikoro>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-12-schnelle@linux.ibm.com>
         <ZH21E3Obp+YPJHkl@shikoro>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qxj-50FWu77E-7JY4qh7vXo7z4d2AhMb
X-Proofpoint-ORIG-GUID: zomJw0oGSOHih6N8gkL37CPdHTjTPrQ0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=631 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2023-06-05 at 12:12 +0200, Wolfram Sang wrote:
> On Tue, May 16, 2023 at 01:00:07PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> What has changed since V3? I didn't get the coverletter...
>=20

The series is actually now at v5 that can be found in its entirety
here:
https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/

I believe there were no changes for the i2c portion since v3. Other
that with the HAS_IOPORT Kconfig option merged the per-subsystem
patches are now independent and can be merged directly.

Thanks,
Niklas
