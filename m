Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92683FFBBE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348243AbhICISy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 04:18:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4674 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348208AbhICISx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2021 04:18:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18383Vjd100391;
        Fri, 3 Sep 2021 04:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EFVcpm4UQneIaCZwZnSBxOJ/+HzC3h8TKoJEJi3ETSI=;
 b=MGSqvMgpFXEblg9c9CXPbECtXn/wV2ytKqQNTjkYQvHKb6pcVAwGZiMz4g9BbgrUYbgi
 46lmZ7x+llhy31bfPqWoTk8Kux+qgFfDzaPhqQ5Q4e1uqWbhV9nC5vuOEo2Phqcv0EwR
 hcJgguCPrT55iqx8x899PV2fBn3zuzYbChqKtlo4XwyVqmi3fnhbQVQVGwf9ddEZERGZ
 WjJLdYZtiP/a3h22AJuBgKRPNZ7rqVr9IY3zQ2BATW9bGT14XLBwMq2+kn0b+GE6LCzI
 ksVovSxusoJAM3y94xehtTgqA4EJ0SQ/idoO0YZEAqKiIITokM/MubnlnapMMU65Ij9r Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3audm3us44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:17:29 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18383mw7101882;
        Fri, 3 Sep 2021 04:17:28 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3audm3us3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:17:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18388Crg010014;
        Fri, 3 Sep 2021 08:17:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3au6q74vxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 08:17:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1838HN0837093702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 08:17:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC2652057;
        Fri,  3 Sep 2021 08:17:23 +0000 (GMT)
Received: from osiris (unknown [9.145.159.114])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 85EF952051;
        Fri,  3 Sep 2021 08:17:22 +0000 (GMT)
Date:   Fri, 3 Sep 2021 10:17:21 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] vmlinux.lds.h: Use regular *RODATA and
 *RO_AFTER_INIT_DATA suffixes
Message-ID: <YTHaEYQz0O+MzpkE@osiris>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-2-keescook@chromium.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v1G7oJQepZwIeoo1eRVbS8zdzxgq0Ecm
X-Proofpoint-GUID: EBwgNgUyLMucUzf3CMsYqy3jTnIpBptl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 adultscore=0 impostorscore=0 mlxlogscore=815 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030048
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:54PM -0700, Kees Cook wrote:
> Rename the various section macros that live in RODATA and
> RO_AFTER_INIT_DATA. Just being called "DATA" implies they are expected
> to be writable.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/kernel/vmlinux.lds.S    |  2 +-
>  include/asm-generic/vmlinux.lds.h | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

For the s390 bit:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
