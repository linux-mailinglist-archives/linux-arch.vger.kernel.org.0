Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603996F1A02
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjD1Nvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1Nvo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:51:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32BB171E;
        Fri, 28 Apr 2023 06:51:42 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SDntSR002788;
        Fri, 28 Apr 2023 13:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mhZXU18sF1S9DfTvxmyRD73QBaSwj9QYrtg60YhvJKk=;
 b=kZTnzCEIe4V5A8c3iFXssPyP8i3dLxORhLjk9JyHdX+HC4VD31vraYfZ7bqtbKyvEz3s
 V5cm0SYcOkMwsIwPIxfsdEEqCz1DpGQneMrxmXGc5kMwmk0Tm28EV2NWwyDVTYdOEtZ8
 Q+6eQdvWiqj/4flH4orVee8n3w1oB1Dzl5/xgHEkbqYAcbum/CuHluCHkwhmOaQD3QcD
 mWBMxnySL2uHVeGOMspoFDPUHXnUTH5jOM0G+criqVC63KmFXES1+T/ZHw+/vHVBgOn9
 GZrYXjvb2G1cp3eeSD40abTB037gU/tCaXmX7szCT2Bq9nz4JfWs/i/qZQx9yuGCGC0o uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8fcf00sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:51:23 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SDpAMD007131;
        Fri, 28 Apr 2023 13:51:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8fcf00qt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:51:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33RNvgTA027097;
        Fri, 28 Apr 2023 13:32:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q47773jwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:32:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SDW8wS46727580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:32:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2846720043;
        Fri, 28 Apr 2023 13:32:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 690D120040;
        Fri, 28 Apr 2023 13:32:07 +0000 (GMT)
Received: from [9.171.55.26] (unknown [9.171.55.26])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 13:32:07 +0000 (GMT)
Message-ID: <b2a60102b2e04c535bc16e9220ea00cb314090ab.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
Date:   Fri, 28 Apr 2023 15:32:07 +0200
In-Reply-To: <2f07c421-7f9c-4e53-8bd5-46be07bb5c89@app.fastmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-3-schnelle@linux.ibm.com>
         <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
         <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
         <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
         <9a1c49b0-2271-53c7-7f48-039f83d39e82@opensource.wdc.com>
         <2f07c421-7f9c-4e53-8bd5-46be07bb5c89@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CPPz08EXnUN60d1f48NpNdCNae6y51Ix
X-Proofpoint-GUID: athbEtrdqUdMvqdXsY_qjFhYnnqQxAd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-03-16 at 16:21 +0100, Arnd Bergmann wrote:
> On Thu, Mar 16, 2023, at 00:57, Damien Le Moal wrote:
> > On 2023/03/15 20:36, Geert Uytterhoeven wrote:
>=20
> > Ah. OK. I see now. So indeed, applying the dependency on the entire ATA=
_SFF
> > group of drivers is very coarse.
>=20
>=20
> > Can you change this to apply the dependency per driver ?
>=20
> I think that will fail to build because of this function
> on architectures that drop their non-functional
> inb/outb helpers:
>=20
> int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
> {
>         unsigned long bmdma =3D pci_resource_start(pdev, 4);
>         u8 simplex;
> =20
>         if (bmdma =3D=3D 0)
>                 return -ENOENT;
> =20
>         simplex =3D inb(bmdma + 0x02);=20
>         outb(simplex & 0x60, bmdma + 0x02);
>         simplex =3D inb(bmdma + 0x02);
>         if (simplex & 0x80)
>                 return -EOPNOTSUPP;
>         return 0;
> }
>=20
> This is only called from five pata drivers (ali, amd,
> cmd64x, netcell, serverworks), so an easy workaround
> would be to make sure those depend on HAS_IOPORT
> and enclose the function definition in an #ifdef.
>=20
>         Arnd

There were a few additional inb()/outb() uses so a few more drivers had
to have the dependency added but for v4 it will no longer be on the
ATA_SFF option and I used your suggestion above for this function.
There was another call to it in ata_generic_init_one() that is only
done for PCI_VENDOR_ID_AL so I added an #ifdef CONFIG_PATA_ALI around
that.

Thanks,
Niklas
