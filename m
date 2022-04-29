Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354D514E02
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377770AbiD2Otj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377963AbiD2Ot3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:49:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DDC84EF4;
        Fri, 29 Apr 2022 07:46:11 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEUbfq019124;
        Fri, 29 Apr 2022 14:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+e0OS0jdwM0ste0CCTZic6/ixhDPnmAaqxN6Co5MrLM=;
 b=oH96y0DFo5ryBziODc8t13MjfzAcy8bISyG+R3DIfm1nTyqsgHGkN8dLoVCo0a76TqZV
 rNmmP3QIKtEd9Sx3598ujmp9RLfxeR5Ti2RZrDAKTAFHIwohFSlP1/wTFte57X9PbFjy
 mexOZRTCacr7Dyb7kag1VXci6h+mQKDUVws6nMryCi3+yN8isFETvH/qZTWd/uVjlU8Z
 Oi9NPnkruc4y7SNRbst/WUmLpHVH6RxESuG5wJVJkr8Q2w6HedzemstuKRO0g+SsNYiz
 wDJezV1e36vo2i4qxNwiY+v2/2q9MYx4UmwUhzCdn/xjKXOv2uhbmGGENBKipClKOb8i Pg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fr27h2eva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:46:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TEhmCC030518;
        Fri, 29 Apr 2022 14:46:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938yc6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:46:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TEk13O42336612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:46:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9542AE053;
        Fri, 29 Apr 2022 14:46:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28965AE04D;
        Fri, 29 Apr 2022 14:46:01 +0000 (GMT)
Received: from sig-9-145-61-57.uk.ibm.com (unknown [9.145.61.57])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 14:46:00 +0000 (GMT)
Message-ID: <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Date:   Fri, 29 Apr 2022 16:46:00 +0200
In-Reply-To: <Ymv3DnS1vPMY8QIg@fedora>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-19-schnelle@linux.ibm.com>
         <Ymv3DnS1vPMY8QIg@fedora>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4tyF1YQXcKzZEbdTsAgzd5uvwySxGP6J
X-Proofpoint-GUID: 4tyF1YQXcKzZEbdTsAgzd5uvwySxGP6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_07,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=512
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 10:32 -0400, William Breathitt Gray wrote:
> On Fri, Apr 29, 2022 at 03:50:16PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/gpio/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 45764ec3b2eb..14e5998ee95c 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -697,7 +697,7 @@ config GPIO_VR41XX
> >  
> >  config GPIO_VX855
> >  	tristate "VIA VX855/VX875 GPIO"
> > -	depends on (X86 || COMPILE_TEST) && PCI
> > +	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
> >  	select MFD_CORE
> >  	select MFD_VX855
> >  	help
> > -- 
> > 2.32.0
> 
> I noticed a number of other GPIO drivers make use of inb()/outb() -- for
> example the PC104 drivers -- should the respective Kconfigs for those
> drivers also be adjusted here?
> 
> William Breathitt Gray

Good question. As far as I can see most (all?) of these have "select
ISA_BUS_API" which is "def_bool ISA". Now "config ISA" seems to
currently be repeated in architectures and doesn't have an explicit
HAS_IOPORT dependency (it maybe should have one). But it does only make
sense on architectures with HAS_IOPORT set.

