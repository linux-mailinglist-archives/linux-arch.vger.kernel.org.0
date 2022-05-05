Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE251BA2D
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbiEEIZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349126AbiEEIZt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 04:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD31D328;
        Thu,  5 May 2022 01:20:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2457om3f031389;
        Thu, 5 May 2022 08:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7QCZWIKCv0xodO97AD5DPPlIdbYnmHCdNmsjpJ3TKwQ=;
 b=kl0RZqPP01iadYFGo0D/0/XTw2Z4SQsxM1mygceQjuUW+n6fKqTkp8Caa1Hefdcxtla+
 SsMc5SA8g953kMgxQXaU7ACcmwYbVcZbWIbxOtKHsL3L/DJIzBjka3aThiW8P39WfC+T
 ttxLxNGZJjPdrflBmMZQwIpMlw/+6ZQzqDrnt7ncnFCnTab4OK4E0lm5OxyXnnzMrYs7
 peqXY38WnaVQskr+zNSuOs8DP8USfjGgXWnMbnU8TUeATY3idf/mmxuGj63/VRGyB5wd
 bcB/u+1kmErpqwr4RyR0OTWc8G9tXaLzJf/eF0CS48pqksJSRYfMzIewNrHyHkKYRoJ2 qg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvaj4rh0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:20:34 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2458I96q007125;
        Thu, 5 May 2022 08:20:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fttcj2teb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:20:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2458KO1S35324240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 08:20:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A564011C04C;
        Thu,  5 May 2022 08:20:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AF5711C04A;
        Thu,  5 May 2022 08:20:29 +0000 (GMT)
Received: from sig-9-145-85-251.uk.ibm.com (unknown [9.145.85.251])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 May 2022 08:20:29 +0000 (GMT)
Message-ID: <849f53a613b66991c1661799583714fa1883094c.camel@linux.ibm.com>
Subject: Re: [RFC v2 02/39] ACPI: add dependency on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Date:   Thu, 05 May 2022 10:20:28 +0200
In-Reply-To: <CAK8P3a3AddBGnBV=6wK+LZDjZD05k=9tBBWd7LWm6smXLcfREQ@mail.gmail.com>
References: <20220429135108.2781579-3-schnelle@linux.ibm.com>
         <20220504175352.GA456913@bhelgaas>
         <CAK8P3a3AddBGnBV=6wK+LZDjZD05k=9tBBWd7LWm6smXLcfREQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aX9i4giMAEznhRBbGgTq9Z33L_sg2DcL
X-Proofpoint-GUID: aX9i4giMAEznhRBbGgTq9Z33L_sg2DcL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_02,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=863 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-05-04 at 21:58 +0200, Arnd Bergmann wrote:
> On Wed, May 4, 2022 at 7:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 29, 2022 at 03:50:00PM +0200, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. As ACPI always uses I/O port access we simply depend
> > > on HAS_IOPORT.
> > 
> > CONFIG_ACPI depends on ARCH_SUPPORTS_ACPI, which is only set by arm64,
> > ia64, and x86, all of which support I/O port access.  So does this
> > actually solve a problem?  I wouldn't think you'd be able to build
> > ACPI on s390 even without this patch.
> > "ACPI always uses I/O port access" is a pretty broad brush, and it
> > would be useful to know specifically what the dependencies are.
> > 
> > Many ACPI hardware accesses use acpi_hw_read()/acpi_hw_write(), which
> > use either MMIO or I/O port accesses depending on what the firmware
> > told us.
> 
> I think this came from my original prototype of the series where I tested it
> out on arm64 with HAS_IOPORT disabled. I would like to hide the definition
> of inb()/outb() from include/asm-generic/io.h whenever CONFIG_HAS_IOPORT
> is not set, and I was prototyping this on arm64.
> 
> There are uses of inb()/outb() in drivers/acpi/ec.c and drivers/acpi/osl.c,
> which in turn are not optional in ACPI, so it seems that those are
> required.
> 
> If we want to allow building arm64 without HAS_IOPORT for some reason,
> that means either force-disabling ACPI as well, or changin ACPI to not
> rely on port I/O. I think it's fine to leave that as a problem for whoever
> wants to make HAS_IOPORT optional in the future, and drop the
> dependency here.
> 
>        Arnd

I'll improve the commit message to make the dependency on HAS_IOPORT
more clear. I also agree with Arnd that since all architectures where
ACPI is useful have I/O ports making it work without I/O port access
compiled in is for another day.

