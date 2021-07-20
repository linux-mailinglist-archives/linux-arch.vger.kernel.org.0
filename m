Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D323CF62B
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhGTHy0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 03:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234314AbhGTHyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 03:54:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16K8X8nm082229;
        Tue, 20 Jul 2021 04:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kmd0NCneQRO+ciEUF6cKsoYHvG4BwX5CNaYsPFWuCUo=;
 b=EfaApuk3JH7dlqLqYcfhNN6Fz0oJdpSCGrfchAzBOXmhejt/Jyz0+vKgh8OcbFxuxZcS
 0owW5r9cUqsybMwL771Xm9Jquwwf1T84gpe3t8S6igyxfeWflG9VxRpo8yUyLRarrK0+
 c/seHPFzmZijsNALCoOer84jsaIbM3tFfU4u38llLJtA6V7wEZtSrFA6ej+aKLncO6lz
 nyn9moQaQ44RC0LZKAolEk42rQotp64MTyAc1KKL13CHHaU7VVLStieS1LWBJrAEOfYx
 BO5/12RYjQ+b9+q1Qaa+wbHV+4DGi+2112cBh1ITlcMc5QGiiZTiJTzDYnWKNqAbGstd /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wr5d53hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 04:34:54 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16K8YHE9087688;
        Tue, 20 Jul 2021 04:34:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wr5d53gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 04:34:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16K8YThI027499;
        Tue, 20 Jul 2021 08:34:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 39upu88ntg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 08:34:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16K8YnR717105304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 08:34:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 550F8A4051;
        Tue, 20 Jul 2021 08:34:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3509A4040;
        Tue, 20 Jul 2021 08:34:48 +0000 (GMT)
Received: from sig-9-145-150-42.de.ibm.com (unknown [9.145.150.42])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Jul 2021 08:34:48 +0000 (GMT)
Message-ID: <bd731ed627344a3a2eaeffabff21d499c4e2c3fd.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: Move pci_dev_is/assign_added() to pci.h
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Jul 2021 10:34:48 +0200
In-Reply-To: <20210719121148.2403239-1-schnelle@linux.ibm.com>
References: <20210719121148.2403239-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NH8bXqJo4bUpl19zSPOzUDOvoHBldX6w
X-Proofpoint-ORIG-GUID: 5VMbc7ngO_SRBHdTLdoT6EIGkyIDvx33
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_04:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107200051
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-07-19 at 14:11 +0200, Niklas Schnelle wrote:
> The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
> PCI arch code of both s390 and powerpc leading to awkward relative
> includes. Move it to the global include/linux/pci.h and get rid of these
> includes just for that one function.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> 
... snip ...
>  
>  static LIST_HEAD(bridge_list);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 93dcdd431072..a159cd0f6f05 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -383,21 +383,6 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  	return dev->error_state == pci_channel_io_perm_failure;
>  }
>  
> -/* pci_dev priv_flags */
> -#define PCI_DEV_ADDED 0
> -#define PCI_DPC_RECOVERED 1
> -#define PCI_DPC_RECOVERING 2

Sorry, the above two PCI_DPC_* lines should remain in drivers/pci/pci.h
I messed this up on rebasing to v5.14-rc1 and it didn't lead to
problems on either s390x defconfig, nor pp64_defconfig but breaks ppc
allyesconfig. Will resend a fixed version.

> 

.. snip ..

