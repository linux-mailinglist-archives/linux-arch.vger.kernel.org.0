Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCD1F5821
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jun 2020 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgFJPsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jun 2020 11:48:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728075AbgFJPsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jun 2020 11:48:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AFWZNE136637;
        Wed, 10 Jun 2020 11:48:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31k2800emm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 11:48:18 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05AFX7Rh138244;
        Wed, 10 Jun 2020 11:48:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31k2800ekw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 11:48:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05AFlSns025914;
        Wed, 10 Jun 2020 15:48:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7yyge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 15:48:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05AFkw2D393944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 15:46:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48E3F52051;
        Wed, 10 Jun 2020 15:48:14 +0000 (GMT)
Received: from thinkpad (unknown [9.171.55.252])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 739E752054;
        Wed, 10 Jun 2020 15:48:13 +0000 (GMT)
Date:   Wed, 10 Jun 2020 17:48:11 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>, linux-xtensa@linux-xtensa.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Possible duplicate page fault accounting on some archs after commit
 4064b9827063
Message-ID: <20200610174811.44b94525@thinkpad>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_09:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 cotscore=-2147483648 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100115
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Some architectures have their page fault accounting code inside the fault
retry loop, and rely on only going through that code once. Before commit
4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times"), that was
ensured by testing for and clearing FAULT_FLAG_ALLOW_RETRY.

That commit had to remove the clearing of FAULT_FLAG_ALLOW_RETRY for all
architectures, and introduced a subtle change to page fault accounting
logic in the affected archs. It is now possible to go through the retry
loop multiple times, and the affected archs would then account multiple
page faults instead of just one.

This was found by coincidence in s390 code, and a quick check showed that
there are quite a lot of other architectures that seem to be affected in a
similar way. I'm preparing a fix for s390, by moving the accounting behind
the retry loop, similar to x86. It is not completely straight-forward, so
I leave the fix for other archs to the respective maintainers.

Added the lists for possibly affected archs on cc, but no guarantee for
completeness.

Regards,
Gerald
