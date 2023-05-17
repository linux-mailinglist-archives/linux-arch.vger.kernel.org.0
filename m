Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59ED70620D
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEQIAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 04:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEQH7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 03:59:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A09E0;
        Wed, 17 May 2023 00:59:05 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H7fJEa012013;
        Wed, 17 May 2023 07:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CMFx+/WSbZOvxzWO4+8ED//sUy5xmbKjuvEcGYhHqCI=;
 b=ZQHZ0+w5kYCbcP21nY+DRFTklLVMi0FRg80N5nlCrRKAo42OmlrJJ2GYZniUYNGeWMyL
 wRoSiIwJY5WvXvDwEqE7mST7cshDy0CeQl+woB5i6cF/SBDDus84dM18bOHcckI4r1Ht
 prCdMuBOJvcv0Sj8HnnNYH4nvQ5m7ey8xYMNRLF7nRk39pFsN6ge/MRCzgR2c7oYrj2a
 hwHPQiaetr8YcjF2aGf2mZUTI7DpY/sWVztopg6N4NsAHW1e0oT4jk9LOddsboM1cn82
 FQkE4hKKLOAp8xBhW27zTxXNDBHj3klPusggdalySyW3zJqWeBXBMLKnYtA7kflUQa6Z Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmt0msjbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 07:58:34 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H7updx004012;
        Wed, 17 May 2023 07:58:33 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmt0msjan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 07:58:33 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H6c4Zh025285;
        Wed, 17 May 2023 07:58:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qj264spkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 07:58:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H7wRRY54919460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 07:58:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEA6420040;
        Wed, 17 May 2023 07:58:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3F8E2004B;
        Wed, 17 May 2023 07:58:26 +0000 (GMT)
Received: from [9.179.22.107] (unknown [9.179.22.107])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 07:58:26 +0000 (GMT)
Message-ID: <6a6f5552fac1427eafbca1288fe5d5cb0cb6a333.camel@linux.ibm.com>
Subject: Re: [PATCH v5 RESEND 10/17] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Wed, 17 May 2023 09:58:26 +0200
In-Reply-To: <ZGR15/aAYufCZ9qV@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
         <20230515090848.833045-11-bhe@redhat.com> <ZGR15/aAYufCZ9qV@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yHkOOiLn5K_XXg82H6WtpYBwMUNzSS4k
X-Proofpoint-GUID: zbqUKTFztHSElm1UI7AZo0AwloZJ5dPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=729
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 23:36 -0700, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 05:08:41PM +0800, Baoquan He wrote:
> > +#define ioremap_wc(addr, size)  \
> > +	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERN=
EL)))
>=20
> I'd move this out of line and just apply mio_wb_bit_mask directly
> instead of the unbox/box/unbox/box dance.
>=20
> > +#define ioremap_wt(addr, size)  \
> > +	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERN=
EL)))
>=20
> and just define this to ioremap_wc.  Note that defining _wt to _wc is
> very odd and seems wrong, but comes from the existing code.  Maybe the
> s390 maintainers can chime on on the background and we can add a comment
> while we're at it.

I'm a bit confused where you see ioremap_wt() defined to ioremap_wc()
in the existing code? Our current definitions are:


void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
{
	return __ioremap(addr, size,
pgprot_writecombine(PAGE_KERNEL));
}

void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
{
	return __ioremap(addr, size,
pgprot_writethrough(PAGE_KERNEL));
}

Now if we don't have support for the enhanced PCI load/store
instructions (memory I/O aka MIO) then yes this gets ignored and both
.._wc() and .._wt() act the same but if we do have them
pgprot_writecombine() / pgprot_writethrough() set respectively clear=20
the mio_wb bit in the PTE. It's a bit odd here because the exact
position of the bit is read from a firmware interface and could in
theory change but other than that it looks fine to me and yes I agree
that it would be odd and broken to define _wt to _wc.

Thanks,
Niklas
