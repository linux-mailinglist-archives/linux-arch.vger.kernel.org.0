Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F407A480822
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 10:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhL1J7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 04:59:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhL1J7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 04:59:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BS9DcTl026451;
        Tue, 28 Dec 2021 09:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sKVBHM9+zhXqlfVwt0CIDBzoVhsZDCDhdTs733T50sg=;
 b=G94GTadN2YXf/B7P/XT81RwKnG8ei23z0sCIqHU0IQ0Yl8oTHnfB/jURITJ3N5dzUrZ8
 KIiH0iscA1Z5rIcQZuvcZjY0P562vkqzHkOSmNBoO/KAQF2LDTwpMEgBy/2JpEB/8jOE
 TiAD1Aa05kLmMX/nPuqqnk8hDB+0Gc0Em9Mvz74UnmTXh3BDMHGe1GN3rIzKtmr1d3sf
 Ceiln14InsLLkQwm05lYtkHsqEKPn3RkjO/BXLUiWtKkZJ3FBpbyGPDDS4NTUKo05kgM
 AvvM715RQQ/vE6XTIzNRNN7H2/RjD4qoKNfozk30sBNnXlfYDjlNUlPfgy9cfXDkheI2 zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7vne4mpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 09:58:38 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BS9lo2X006329;
        Tue, 28 Dec 2021 09:58:38 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7vne4mnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 09:58:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BS9spZV021432;
        Tue, 28 Dec 2021 09:58:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3d5tjjekns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 09:58:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BS9o4VS47120732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 09:50:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C53AE057;
        Tue, 28 Dec 2021 09:58:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7111AE053;
        Tue, 28 Dec 2021 09:58:31 +0000 (GMT)
Received: from sig-9-145-12-118.uk.ibm.com (unknown [9.145.12.118])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 09:58:31 +0000 (GMT)
Message-ID: <66cae9eb4fdd0b02a1fe228454f75aecb45802ed.camel@linux.ibm.com>
Subject: Re: [RFC 25/32] watchdog: Kconfig: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-watchdog@vger.kernel.org
Date:   Tue, 28 Dec 2021 10:58:31 +0100
In-Reply-To: <280c0490-3a68-5498-5751-d53162203b5b@roeck-us.net>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-26-schnelle@linux.ibm.com>
         <280c0490-3a68-5498-5751-d53162203b5b@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mt3pHicQhi-XEZzgmX54WvuFYqP1dl7u
X-Proofpoint-GUID: g-fRcGlJyumU_mihzPpxiXNrxmATN5LG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_05,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280043
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-12-27 at 10:03 -0800, Guenter Roeck wrote:
> On 12/27/21 8:43 AM, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> > 
> 
> How is the need for HAS_IOPORT determined, when exactly is it needed,
> and when not ?

I mostly used "make allyesconfig" on s390 with the accessors ifdeffed
out (i.e. patch 32) to find where the I/O port accesses were compiled
in. This means that it doesn't find drivers which pull in a HAS_IOPORT
dependency transitively e.g. by depending on x86 or ACPI. It should get
those that use e.g. "|| COMPILE_TEST" though. This might not be ideal
but on the other hand it should catch all those drivers that currently
built with known broken code.

> 
> $ git grep -E "inb|inw" drivers/watchdog/ | cut -f1 -d: | sort -u
> drivers/watchdog/acquirewdt.c
> drivers/watchdog/advantechwdt.c
> 
---8<---

