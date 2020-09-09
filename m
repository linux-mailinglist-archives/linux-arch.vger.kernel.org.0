Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE72263172
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgIIQNh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 12:13:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730885AbgIIQN0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 12:13:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089G3hGt094150;
        Wed, 9 Sep 2020 12:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=l58yEDHShi5ObMeKXd9i1HaDyPqzpve8oVA61+yeocE=;
 b=MkLV2iGRLrJMnX5uAc0U1tKsI6PtfCpTFLq0ne+qlZoGDxasR0vpXy0ZPQFv53fQioKS
 Njkr3bSJU9cSed7Dznmbo9BmJczRYk4RfUadU7jKzxZzmlvIbclW1mWXcF38rx/3YBHD
 DHGFzRfbHRhULHpR4pMwew+G5+a7cM4wQ8S6KHO0/Vn8+p0qPD1IaNDa27Ys8fdQ7ayu
 mkAPh04ADJ9xzS/1izjRTf5b07VXHfPvqzONbas5SsWm0Wr8YBUObSz63a3/j7CZP7rT
 EXGtrBqSj1ncxxjLbt/3Wb6mGFGOd2DCOaIuQKq8Kp7HtL1bzAl06aqbqtEuMqwEMpQZ BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eyv56ynt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 12:12:20 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089G4E1s096945;
        Wed, 9 Sep 2020 12:12:19 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eyv56yn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 12:12:19 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089GA6XD019174;
        Wed, 9 Sep 2020 16:12:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 33e5gmrvyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 16:12:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089GCEnm26673490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 16:12:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23E2111C054;
        Wed,  9 Sep 2020 16:12:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E726D11C052;
        Wed,  9 Sep 2020 16:12:12 +0000 (GMT)
Received: from thinkpad (unknown [9.171.79.102])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  9 Sep 2020 16:12:12 +0000 (GMT)
Date:   Wed, 9 Sep 2020 18:12:11 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909181211.1cad8d28@thinkpad>
In-Reply-To: <20200908193650.1c1511d0@thinkpad>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907201256.GC1976319@kernel.org>
        <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
        <20200908193650.1c1511d0@thinkpad>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_09:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090139
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Sep 2020 19:36:50 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[..]
> 
> It seems now that the generalization is very well accepted so far,
> apart from some apparent issues on arm. Also, merging 2 + 3 and
> putting them first seems to be acceptable, so we could do that for
> v3, if there are no objections.
> 
> Of course, we first need to address the few remaining issues for
> arm(32?), which do look quite confusing to me so far. BTW, sorry for
> the compile error with patch 3, I guess we did the cross-compile only
> for 1 + 2 applied, to see the bloat-o-meter changes. But I guess
> patch 3 already proved its usefulness by that :-)

Umm, replace "arm" with "power", sorry. No issues on arm so far, but
also no ack I think.

Thanks to Christophe for the power change, and to Mike for volunteering
for some cross compilation and cross-arch testing. Will send v3 with
merged and re-ordered patches after some more testing.
