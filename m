Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD2480AD2
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 16:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhL1P1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 10:27:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11004 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232237AbhL1P1P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 10:27:15 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSD7W5Q027040;
        Tue, 28 Dec 2021 15:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OPN9EGb1cKoGPioLIRhjXHHm5AxDtIn8DXUn9PWgz5E=;
 b=ZgcXj67lIf9WShWDBL9Fm03vEit0/Ttfs84ECHKmCOPrquKz2uhwpIterbNWRFd0Kxaj
 cnOnOi/q/KqkwZVTur6lgV2Yt4jaVZAU8/iR+1GDCeFPOoHv891n6nPqxfHMxqLHwu7y
 WRUMXuQzVMkmOL/H6vOUXNkenfQTgGM6CmgjD8nVKmpjNNPoSd3KTuvpxgAadVgr9pma
 REDidR1o8qER0LiCt8d7e9DJQazzQqgdX3C3P3AFaFoKOI9w3mYSJel8UW96SIDN83LW
 w7CtQjDiajVkRyPwprxowQ5X/M04Dcp9FepRixmxFdCFLaBCNTIR0vxxb/iNYRswq1ym lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d81g64r2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 15:26:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSE18H8028048;
        Tue, 28 Dec 2021 15:26:46 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d81g64r1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 15:26:46 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSFMmgT014020;
        Tue, 28 Dec 2021 15:26:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3d5tjjg9b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 15:26:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSFPRnj39911848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 15:25:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A3174C040;
        Tue, 28 Dec 2021 15:25:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CE724C046;
        Tue, 28 Dec 2021 15:25:26 +0000 (GMT)
Received: from sig-9-145-12-118.uk.ibm.com (unknown [9.145.12.118])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 15:25:26 +0000 (GMT)
Message-ID: <6b719d661f9ba7a23776b00a2f250d14cb21bafa.camel@linux.ibm.com>
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
Date:   Tue, 28 Dec 2021 16:25:25 +0100
In-Reply-To: <20211227223348.GA1545446@bhelgaas>
References: <20211227223348.GA1545446@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SlzhYlcAKu6htNFJRfi2in5vyXvNgvZ9
X-Proofpoint-GUID: idbkDC718D3c8LYHtdc5XXv9V6EIaWQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_08,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280069
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-12-27 at 16:33 -0600, Bjorn Helgaas wrote:
> On Mon, Dec 27, 2021 at 05:43:13PM +0100, Niklas Schnelle wrote:
> > In the future inw()/outw() and friends will not be compiled on
> > architectures without I/O port support.
> 
> This commit log actually doesn't say what the patch does.
> 
> I'm pretty sure this particular quirk is x86 specific and could
> probably be moved to arch/x86/pci/fixup.c, where the #ifdef probably
> wouldn't be needed.

Will look into it, that does sound like a nicer solution. Thanks!

> 
> If we keep it in drivers/pci, please update the subject line to make
> it more specific and match the convention, e.g.,
> 
>   PCI: Compile quirk_tigerpoint_bm_sts() only when HAS_IOPORT set

Ah yeah I was going back and forth between matching this within the
series vs matching the subsystem. I guess going with the subsystem is
mote important long term.

> 
> BTW, git complains about some whitespace errors in other patches:
> 
>   Applying: char: impi, tpm: depend on HAS_IOPORT
>   .git/rebase-apply/patch:92: trailing whitespace.
> 	    If you have a TPM security chip from Atmel say Yes and it
>   .git/rebase-apply/patch:93: trailing whitespace.
> 	    will be accessible from within Linux.  To compile this driver
>   warning: 2 lines add whitespace errors.
>   Applying: video: handle HAS_IOPORT dependencies
>   .git/rebase-apply/patch:23: trailing whitespace.
> 
>   warning: 1 line adds whitespace errors.

That is very strange. I did run checkpatch before. There are a few
warnings not to touch obsolete code unnecessarily and a check about
using udelay() (pre-existing) plus two missing blank lines in pci-
quirks.h that I ignored because it matches the sorounding style.

I did notice that lore fails to render the subject lines for some of
the patches. But I just tried fetching the patches with b4 on top of
v5.16-rc7 and the resulting tree passes "./scripts/checkpatch.pl --git
v5.16-rc7..HEAD" and has an empty diff to my branch. What tool did you
use to check?

> 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
---8<---

