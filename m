Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175053CFB85
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhGTNVz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 09:21:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237435AbhGTNSy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 09:18:54 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KDpOKR179444;
        Tue, 20 Jul 2021 09:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3lvLu6cinEqw0FGFqRgYpcY/s9Dp4BHVAc9DtIAt19A=;
 b=RbM2fNe5tDmCsKZFLuxlrAzC+lSl2vj+AAbAxujBaC8mj0xT4PCHcA+A9YqTdRe9lg7Y
 DD5t2WT6orj7pZTvXaxrzer9hDm69gC1mCtDdQ2iD8O+7IDgrKzgsNJnzE+lOSBdTNOz
 QSbmvPBinT7VXXedz5sA4b7IUwamod+lIdeWPR31Qr9XxFuKw86mck5aT6uRPyui9+H8
 0Jsn9NX2nvj3aeddcuNoEruHooCwTkSsv3NCAwvCTQmKWMOvg2if7XnaR/RZfHg85z/g
 s53lQT6BhOmGY8IGWFg+lV79i0IPVSdWS4X+fDPKXSIqr0y54qxJbOHgCwHoP3OaHb/O Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wyr60b0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 09:59:15 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16KDpXWw180372;
        Tue, 20 Jul 2021 09:59:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wyr60axt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 09:59:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16KDwrM7017121;
        Tue, 20 Jul 2021 13:59:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 39upu89bu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 13:59:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16KDx9ZM25559458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 13:59:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B85E452073;
        Tue, 20 Jul 2021 13:59:09 +0000 (GMT)
Received: from sig-9-145-150-42.de.ibm.com (unknown [9.145.150.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5BE7F52052;
        Tue, 20 Jul 2021 13:59:09 +0000 (GMT)
Message-ID: <a8fca09bb18174e21d641e9cda0727307ecf9b9d.camel@linux.ibm.com>
Subject: Re: [PATCH v2] PCI: Move pci_dev_is/assign_added() to pci.h
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Jul 2021 15:59:09 +0200
In-Reply-To: <20210720095816.3660813-1-schnelle@linux.ibm.com>
References: <20210720095816.3660813-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HCLyOhtaq8QM3LWcyOg1rI6HxplqFhr9
X-Proofpoint-GUID: OwpqnuiswPMkIsQPmC0YKJQDNIcnHprn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_07:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200087
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-07-20 at 11:58 +0200, Niklas Schnelle wrote:
> The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
> PCI arch code of both s390 and powerpc leading to awkward relative
> includes. Move it to the global include/linux/pci.h and get rid of these
> includes just for that one function.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Since v1:
> - Fixed accidental removal of PCI_DPC_RECOVERED, PCI_DPC_RECOVERING
>   defines and also move these to include/linux/pci.h

Please disregard I actually sent the old patch ;-(

> 
>  arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
>  arch/powerpc/platforms/pseries/setup.c     |  1 -
>  arch/s390/pci/pci_sysfs.c                  |  2 --
>  drivers/pci/hotplug/acpiphp_glue.c         |  1 -
>  drivers/pci/pci.h                          | 15 ---------------
>  include/linux/pci.h                        | 13 +++++++++++++
>  6 files changed, 13 insertions(+), 22 deletions(-)
> 
> 
... snip ..

