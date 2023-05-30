Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6B715C72
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjE3LAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 07:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjE3LAs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 07:00:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CBD93;
        Tue, 30 May 2023 04:00:46 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U9N1p8009764;
        Tue, 30 May 2023 11:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qPU+YaZDIpmEcX5qsYfSU3/wgZK56EKO1ll/Nw/ejVw=;
 b=DTZxvcrRkPXAG1nvvHiujzLEpnRJkmhpyjmm3PwoZ6/pIlf/bMusRXLeLnggVk19AOfS
 Wb110E23P/0Cj/1XX7hiSyRRGhVRlskUm9l5j/V5XuHK+WH/WIwzu2t0HJY14eHczA14
 glMcJkVii3Zqu78pxI6InKJdFdME/PG7jz9eXFqWfLRsBmQuL0dDtUi65uxb93wmBvY5
 7wL2xGROhlwlFV3Bb2SMfcVORPrtd0jx9O9vpyKhjC2ZGl0Dc/Sgv4UXxyHWPFe4zwWT
 VnTM/Ra/7gcFf5g+Ln78uQVjcqInEyVliXcQc3hp1DJ/oY1y6b4F2sz3Df7pEqlBCPo8 rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwefcj6kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 11:00:31 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UAoNTS010089;
        Tue, 30 May 2023 11:00:30 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwefcj6gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 11:00:30 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U2tkuY019252;
        Tue, 30 May 2023 11:00:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qu9g5176j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 11:00:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UB0PC620316696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 11:00:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE82420043;
        Tue, 30 May 2023 11:00:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8326D20040;
        Tue, 30 May 2023 11:00:23 +0000 (GMT)
Received: from [9.152.212.237] (unknown [9.152.212.237])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 11:00:23 +0000 (GMT)
Message-ID: <99527edd051571d230ddf7a1de38ec604b365403.camel@linux.ibm.com>
Subject: Re: [PATCH v4 36/41] usb: pci-quirks: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-usb@vger.kernel.org
Date:   Tue, 30 May 2023 13:00:22 +0200
In-Reply-To: <20230516110038.2413224-37-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-37-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RoYNAQzfs4hzLWpVSW9QBvJW5-_rdHBb
X-Proofpoint-GUID: 1ioaldtOvqllQeBG5Mhj7Jp0JhIWJd04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=721 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 13:00 +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. In the pci-quirks case the I/O port acceses are
> used in the quirks for several AMD south bridges. Move unrelated
> ASMEDIA quirks out of the way and introduce an additional config option
> for the AMD quirks that depends on HAS_IOPORT.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
>=20
>  drivers/usb/Kconfig           |  10 +++
>  drivers/usb/core/hcd-pci.c    |   2 +
>  drivers/usb/host/pci-quirks.c | 125 ++++++++++++++++++----------------
>  drivers/usb/host/pci-quirks.h |  30 ++++++--
>  4 files changed, 101 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 7f33bcc315f2..765093112ed8 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
>=20
---8<---
> =20
>  static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mas=
k)
>  {
> @@ -723,6 +728,7 @@ static inline int io_type_enabled(struct pci_dev *pde=
v, unsigned int mask)
> =20
>  static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	unsigned long base =3D 0;
>  	int i;
> =20
> @@ -737,6 +743,7 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pd=
ev)
> =20
>  	if (base)
>  		uhci_check_and_reset_hc(pdev, base);

I got a kernel test robot message for the above function call being
undefined on an ARM config. Will have to investigate the details but I
think this is still missing a stub or an #ifdef here.

> +#endif /* CONFIG_HAS_IOPORT */
>  }
> =20
>  static int mmio_resource_enabled(struct pci_dev *pdev, int idx)
---8<---
