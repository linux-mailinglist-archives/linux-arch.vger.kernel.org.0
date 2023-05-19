Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724207096E7
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjESL4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjESL4O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 07:56:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43608E5E;
        Fri, 19 May 2023 04:56:09 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBegei002873;
        Fri, 19 May 2023 11:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9ZSiz7QfDXxqo0dzVwJRj7KKiMlRRw/MuJmXwWIBDfI=;
 b=QnETb8xjiv6buyLYJxqSkNJrj9ARvyH8aDYzfNQFN02XS2fs7NIL1ZMZ9gGHeLUCMcjd
 KH7fJuxfPibvjc3VGNIpIpZ+qq1/BRVkZB7fou8nUOkkxAKul3+zRJ/gVNXOFgI8T/Yq
 gexnBm4Vf9WXpQOZ/J7zB/ioISazd1lkgDS2V5GAjWULH96DRmRR2gXxZQTCI62bl8Jk
 URmlevGPwQEjr8P7sd9JDruf8CHz0WJhaKxdOPU1HgEPl4KvWxmgwWvT5Q9RdsVGeEJU
 dWPwJwij6MpnxOuzLxsbVFYmYlavgBsM9dveOPt5nkJkCqAHM0c0nmRrCrFcKDZxP8m/ Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp87srps0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:55:50 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34JBf348005807;
        Fri, 19 May 2023 11:55:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp87srprp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:55:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34J68cxA010601;
        Fri, 19 May 2023 11:31:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qj264tkpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:31:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JBVEnD46334256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 11:31:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F6A20049;
        Fri, 19 May 2023 11:31:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC93020040;
        Fri, 19 May 2023 11:31:12 +0000 (GMT)
Received: from [9.171.0.172] (unknown [9.171.0.172])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 11:31:12 +0000 (GMT)
Message-ID: <8d5f62aff02f0043c8f601f24c949c5fe03e132e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Date:   Fri, 19 May 2023 13:31:12 +0200
In-Reply-To: <440855f4-897c-4597-bbe6-7c5f295f616a@app.fastmail.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-36-schnelle@linux.ibm.com>
         <2023051643-overtime-unbridle-7cdd@gregkh>
         <2c03973e-0635-4dbb-a1df-bfda8cbee161@rowland.harvard.edu>
         <440855f4-897c-4597-bbe6-7c5f295f616a@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1T9__fVrFL3mMdOF2NtPZnMYBMkNOv1B
X-Proofpoint-GUID: CRBQV-gzzNZ6dGiIzrHsIfsCIhxyrMw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=562 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2023-05-17 at 14:17 +0200, Arnd Bergmann wrote:
> On Tue, May 16, 2023, at 22:17, Alan Stern wrote:
> > On Tue, May 16, 2023 at 06:29:56PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:
> >=20
> > > I'm confused now.
> > >=20
> > > So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.
> > >=20
> > > But if it isn't, then these are just no-ops that do nothing?  So then
> > > the driver will fail to work?  Why have these stubs at all?
> > >=20
> > > Why not just not build the driver at all if this option is not enable=
d?
> >=20
> > I should add something to my previous email.  This particular section o=
f=20
> > code is protected by:
> >=20
> > #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
> > /* Support PCI only */
> >=20
> > So it gets used only in cases where the driver supports just a PCI bus=
=20
> > -- no other sorts of non-PCI on-chip devices.  But the preceding patch=
=20
> > in this series changes the Kconfig file to say:
> >=20
> >  config USB_UHCI_HCD
> > 	tristate "UHCI HCD (most Intel and VIA) support"
> > 	depends on (USB_PCI && HAS_IOPORT) || USB_UHCI_SUPPORT_NON_PCI_HC
> >=20
> > As a result, when the configuration includes support only for PCI=20
> > controllers the driver won't get built unless HAS_IOPORT is set.  Thus=
=20
> > the no-op case (in this part of the code) can't arise.
>=20
> Indeed, that makes sense.
>=20
> > Which is a long-winded way of saying that you're right; the UHCI_IN()=
=20
> > and UHCI_OUT() wrappers aren't needed in this part of the driver.  I=
=20
> > guess Niklas put them in either for consistency with the rest of the=
=20
> > code or because it didn't occur to him that they could be omitted.  (An=
d=20
> > I didn't spot it either.)
>=20
> It's probably less confusing to leave out the PCI-only part of
> the patch then and only modify the generic portion.
>=20
>       Arnd

Yes I agree that way the UHCI_IN/OUT() macro is also only used directly
in combination with uhci_has_pci_registers(). I've done this for v5.

Thanks,
Niklas

