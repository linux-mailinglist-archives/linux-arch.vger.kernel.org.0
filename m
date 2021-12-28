Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B723A480B92
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhL1Qw7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 11:52:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhL1Qw6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 11:52:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSDBwGe021961;
        Tue, 28 Dec 2021 16:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=a32109lO5hXlV4YcaWf1ox6UFY5Br8kMOoPfJAXHf0E=;
 b=dWY7cJXr/YHov0KQtm1JxI4Q/wwchAF5lqYJuZpzbIzSb5X5FkFFOBGBbuugD66Tyj6W
 eQuJ8GzkofU/EWZHqDUNyaDb3gep7drgFNtQBzAspCi6hu3+N3TrWhVtgZ59oEQdik4Q
 ClxVu69kGqc8GdVDGtsynJFOJYITXnbDFdLQTAPNnoQMEblhdYjZ+ipmo57MXsBcXhxz
 eMekyIdt2vUGKn1w/FAKmCwtbbmxqkCztLktZettPsGEVSYpPtxDxY0AghCouctOkWvx
 /FUsJNcB7OtyheRy7ExLhacXUVdAAUFjpQIRjlvtYFDHglS8WSXkMs3CXMY9Py3j2tjL ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d838g4568-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:52:13 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSGlsTJ012280;
        Tue, 28 Dec 2021 16:52:12 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d838g454x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:52:12 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSGmYOH008235;
        Tue, 28 Dec 2021 16:52:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3d5tx9gt9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:52:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSGhcfn34865614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 16:43:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 592C4A4053;
        Tue, 28 Dec 2021 16:52:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F26A404D;
        Tue, 28 Dec 2021 16:52:06 +0000 (GMT)
Received: from sig-9-145-12-118.uk.ibm.com (unknown [9.145.12.118])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 16:52:06 +0000 (GMT)
Message-ID: <5112a787b635d5d2fc80a7f126c28176ad151098.camel@linux.ibm.com>
Subject: Re: [RFC 28/32] PCI: make quirk using inw() depend on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Date:   Tue, 28 Dec 2021 17:52:05 +0100
In-Reply-To: <20211228163541.GA1599602@bhelgaas>
References: <20211228163541.GA1599602@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5iyGr8ouzv3OWEfchyBH9Sr19Eu51H6j
X-Proofpoint-ORIG-GUID: B-ofO_CZlSIZvoI4iX2rwQs5W2YUfq_C
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_08,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112280075
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-28 at 10:35 -0600, Bjorn Helgaas wrote:
> On Tue, Dec 28, 2021 at 04:25:25PM +0100, Niklas Schnelle wrote:
> > On Mon, 2021-12-27 at 16:33 -0600, Bjorn Helgaas wrote:
> > > On Mon, Dec 27, 2021 at 05:43:13PM +0100, Niklas Schnelle wrote:
> > > If we keep it in drivers/pci, please update the subject line to make
> > > it more specific and match the convention, e.g.,
> > > 
> > >   PCI: Compile quirk_tigerpoint_bm_sts() only when HAS_IOPORT set
> > 
> > Ah yeah I was going back and forth between matching this within the
> > series vs matching the subsystem. I guess going with the subsystem is
> > mote important long term.
> 
> Haha, yes, a little ambiguity there.  I do think the subsystem is more
> important because the identity of the series is mostly lost after it's
> applied.  Thanks for thinking about it!
> 
> > > BTW, git complains about some whitespace errors in other patches:
> > > 
> > >   Applying: char: impi, tpm: depend on HAS_IOPORT
> > >   .git/rebase-apply/patch:92: trailing whitespace.
> > > 	    If you have a TPM security chip from Atmel say Yes and it
> > >   .git/rebase-apply/patch:93: trailing whitespace.
> > > 	    will be accessible from within Linux.  To compile this driver
> > >   warning: 2 lines add whitespace errors.
> > >   Applying: video: handle HAS_IOPORT dependencies
> > >   .git/rebase-apply/patch:23: trailing whitespace.
> > > 
> > >   warning: 1 line adds whitespace errors.
> > 
> > That is very strange. I did run checkpatch before. There are a few
> > warnings not to touch obsolete code unnecessarily and a check about
> > using udelay() (pre-existing) plus two missing blank lines in pci-
> > quirks.h that I ignored because it matches the sorounding style.
> > 
> > I did notice that lore fails to render the subject lines for some of
> > the patches. But I just tried fetching the patches with b4 on top of
> > v5.16-rc7 and the resulting tree passes "./scripts/checkpatch.pl --git
> > v5.16-rc7..HEAD" and has an empty diff to my branch. What tool did you
> > use to check?
> 
> "git am" is what complained.  Here's what I did:
> 
>   $ git checkout -b wip/niklas v5.16-rc1

Ah this seems to be because my patches are against v5.16-rc7. I noted
that in the cover letter but I guess that is easy to miss and might not
match expectations.

>   Switched to a new branch 'wip/niklas'
>   10:30:06 ~/linux (wip/niklas)$ b4 am -om/ 20211227164317.4146918-1-schnelle@linux.ibm.com
>   Looking up https://lore.kernel.org/r/20211227164317.4146918-1-schnelle%40linux.ibm.com
>   Grabbing thread from lore.kernel.org/all/20211227164317.4146918-1-schnelle%40linux.ibm.com/t.mbox.gz
>   Analyzing 70 messages in the thread
>   Checking attestation on all messages, may take a moment...
>   ---
>     ✓ [PATCH RFC 1/32] Kconfig: introduce and depend on LEGACY_PCI
>     ✓ [PATCH RFC 2/32] Kconfig: introduce HAS_IOPORT option and select it as necessary
>     ✓ [PATCH RFC 3/32] ACPI: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 4/32] parport: PC style parport depends on HAS_IOPORT
>     ✓ [PATCH RFC 5/32] char: impi, tpm: depend on HAS_IOPORT
>     ✓ [PATCH RFC 6/32] speakup: Kconfig: add HAS_IOPORT dependencies
>       + Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>     ✓ [PATCH RFC 7/32] Input: gameport: add ISA and HAS_IOPORT dependencies
>     ✓ [PATCH RFC 8/32] comedi: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 9/32] sound: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 10/32] i2c: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 11/32] Input: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 12/32] iio: adc: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 13/32] hwmon: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 14/32] leds: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 15/32] media: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 16/32] misc: handle HAS_IOPORT dependencies
>     ✓ [PATCH RFC 17/32] net: Kconfig: add HAS_IOPORT dependencies
>       + Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>     ✓ [PATCH RFC 18/32] pcmcia: Kconfig: add HAS_IOPORT dependencies
>       + Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>     ✓ [PATCH RFC 19/32] platform: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 20/32] pnp: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 21/32] power: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 22/32] video: handle HAS_IOPORT dependencies
>     ✓ [PATCH RFC 23/32] rtc: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 24/32] scsi: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 25/32] watchdog: Kconfig: add HAS_IOPORT dependencies
>     ✓ [PATCH RFC 26/32] drm: handle HAS_IOPORT dependencies
>     ✓ [PATCH RFC 27/32] PCI/sysfs: make I/O resource depend on HAS_IOPORT
>     ✓ [PATCH RFC 28/32] PCI: make quirk using inw() depend on HAS_IOPORT
>     ✓ [PATCH RFC 29/32] firmware: dmi-sysfs: handle HAS_IOPORT dependencies
>     ✓ [PATCH RFC 30/32] /dev/port: don't compile file operations without CONFIG_DEVPORT
>     ✓ [PATCH RFC 31/32] usb: handle HAS_IOPORT dependencies
>     ✓ [PATCH RFC 32/32] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
>     ---
>     ✓ Signed: DKIM/ibm.com (From: schnelle@linux.ibm.com)
> 

Interesting now I have to figure out why I do get bad DKIM signature
checks with b4 and my mails. Maybe b4 has an endianess bug as I'm
usually working on mainframe.

