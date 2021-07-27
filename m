Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C73D7C1F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhG0R3Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 13:29:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229453AbhG0R3Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 13:29:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RH8XT8135522;
        Tue, 27 Jul 2021 13:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6bEhk6CA8+q+IY9gEhnRgyDjoAcMWP97ymU6QSxJwgM=;
 b=Szegunf0HGyFNV2b8yLhhTiTbB2G11ULeAsSAs5IS8IBQ5XC2o9b4a/j9PiJsezf/SKf
 0BOR+eMlWzlDOmqZ9ccsvpqu8Ay0wDblV5m9FD2Uz4WCiTsFvja7DFv+sRM4YLe7/fpg
 9RfojCcPO1OiZi5uQZXTtvondsM0TMO2JY225Dsx1llsyv3lzbT6NiZgMtFn7h0MdwJn
 G0hkj7TK3W6/IYODaFXW6l1VkmrkAOkyGP/SI9NQ2FwZipFi2yxS4r9CQ+fXoVeiEnp8
 F2sTEFx/5xGJlYijzakq3eLf+nz68ZpvM4fxXGg3kfBbMtGCtFJQGYj5F1rM0I0xyfBd tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2p1xs0sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:27:29 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RHLP22195489;
        Tue, 27 Jul 2021 13:27:28 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2p1xs0ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:27:28 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RHRQ0Z015888;
        Tue, 27 Jul 2021 17:27:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3a235prc4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 17:27:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RHOgEM27001256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:24:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666B1A4051;
        Tue, 27 Jul 2021 17:27:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EE6AA404D;
        Tue, 27 Jul 2021 17:27:21 +0000 (GMT)
Received: from osiris (unknown [9.145.19.157])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Jul 2021 17:27:21 +0000 (GMT)
Date:   Tue, 27 Jul 2021 19:27:19 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 4/6] mm: simplify compat numa syscalls
Message-ID: <YQBB9yteAwtG2xyp@osiris>
References: <20210727144859.4150043-1-arnd@kernel.org>
 <20210727144859.4150043-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727144859.4150043-5-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mscltp_EWBx0evJ9yR5nijJF9sLL6ZBk
X-Proofpoint-ORIG-GUID: Zo0_7XKq5kYAI3uc1Uuw3gP06noaQbBO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=911
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270103
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 04:48:57PM +0200, Arnd Bergmann wrote:
> ---
>  include/linux/compat.h |  17 ++--
>  mm/mempolicy.c         | 175 +++++++++++++----------------------------
>  2 files changed, 63 insertions(+), 129 deletions(-)
...
> +static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
> +		      unsigned long maxnode)
> +{
> +	unsigned long nlongs = BITS_TO_LONGS(maxnode);
> +	int ret;
> +
> +	if (in_compat_syscall())
> +		ret = compat_get_bitmap(mask,
> +					(const compat_ulong_t __user *)nmask,
> +					maxnode);

compat_ptr() conversion for e.g. nmask is missing with the next patch
which removes the compat system calls.
Is that intended or am I missing something?
