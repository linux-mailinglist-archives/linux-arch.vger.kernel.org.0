Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15344374720
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhEERqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 13:46:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236193AbhEERpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 13:45:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145HXvFC094509;
        Wed, 5 May 2021 13:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ZIAENPqLTvmJ2HIQ8w/kLMQmY7tUYB5RjZI5QAwNIJ4=;
 b=gCFuEPOj44krFCpWjdHjOlujMNqHEz4bi8odyC1rGrrzc01LXPDoyfv5xJlQLe/6Bfwh
 cafcn601fhMRMh1gFa/C1i80PAxdUtWUMeNqtY/8lBS2fqpeOJvW/7+zq3KmIFvu3cNK
 ee+9VU9WZCcqZQCUlRAeSyw48vabRegqoHqFL99LZEjUM+igLHmSu98V+yKWp0y7XLtc
 tBqn4PQyfo4Iknet4XS8+nm19r4Fao4VVDgRuuGKZf7JeJcu4R7NDJvbWiq1SWrFABFf
 5wTDrdcuZ5qhInyLDiuaCVfqPqTHu3Wgv2AiqWX/nr5IWpIa//7CmJmvF/7m1/udb9B/ jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38by559nju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 13:44:23 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 145HY4dY097368;
        Wed, 5 May 2021 13:44:22 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38by559njd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 13:44:22 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145HhAx6019287;
        Wed, 5 May 2021 17:44:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 38bee58ejw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 17:44:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145HhqOd14811400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 17:43:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC7CA4053;
        Wed,  5 May 2021 17:44:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE19A4040;
        Wed,  5 May 2021 17:44:17 +0000 (GMT)
Received: from osiris.fritz.box (unknown [9.171.38.186])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 May 2021 17:44:17 +0000 (GMT)
Date:   Wed, 5 May 2021 19:44:16 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Message-ID: <YJLZcA8eR/JW1HeG@osiris.fritz.box>
References: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
 <CAHk-=wi4Rgo7f17AwYduEPKr6SEVq-mxRJiZ5S5X0hQ9RWmkYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4Rgo7f17AwYduEPKr6SEVq-mxRJiZ5S5X0hQ9RWmkYA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rla9k2N2omQ5JRJxzCwSBDYKKXbWQ4wr
X-Proofpoint-ORIG-GUID: mSfxBHB635twrJfNyZgs9EZYVAKk2JDR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050121
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 03, 2021 at 10:41:45AM -0700, Linus Torvalds wrote:
> It would be lovely if somebody also took a look at some of the other
> zlib code, like inflate.c itself. But some of that code has rather
> subtle changes for things like s390 hardware support, and we have
> thihngs like our fallthrough rules etc, so it gets a bit hairier.
> 
> Which is why I did just this fairly minimal part.
> 
> Note that the commit message has a "Not-yet-signed-off-by:" from me.
> That's purely because I wanted it to be obvious that this needs a lot
> more testing - I'm not comfy with this patch unless somebody takes it
> upon themselves to actually test it under different loads (and
> different architectures).

The patch below is required on top of your patch to make it compile
for s390 as well.
Tested with kernel image decompression, and also btrfs with file
compression; both software and hardware compression.
Everything seems to work.

diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index fb60b5a6a1cb..3bb3e431b79f 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: Zlib
 
+#include <linux/zlib.h>
+#include "../zlib_inflate/inftrees.h"
 #include "../zlib_inflate/inflate.h"
 #include "dfltcc_util.h"
 #include "dfltcc.h"
@@ -122,7 +124,7 @@ dfltcc_inflate_action dfltcc_inflate(
     param->cvt = CVT_ADLER32;
     param->sbb = state->bits;
     param->hl = state->whave; /* Software and hardware history formats match */
-    param->ho = (state->write - state->whave) & ((1 << HB_BITS) - 1);
+    param->ho = (state->wnext - state->whave) & ((1 << HB_BITS) - 1);
     if (param->hl)
         param->nt = 0; /* Honor history for the first block */
     param->cv = state->check;
@@ -137,7 +139,7 @@ dfltcc_inflate_action dfltcc_inflate(
     state->last = cc == DFLTCC_CC_OK;
     state->bits = param->sbb;
     state->whave = param->hl;
-    state->write = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
+    state->wnext = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
     state->check = param->cv;
     if (cc == DFLTCC_CC_OP2_CORRUPT && param->oesc != 0) {
         /* Report an error if stream is corrupted */
diff --git a/lib/zlib_inflate/inflate.h b/lib/zlib_inflate/inflate.h
index 6ece8efd879b..52314b8b28ea 100644
--- a/lib/zlib_inflate/inflate.h
+++ b/lib/zlib_inflate/inflate.h
@@ -1,3 +1,6 @@
+#ifndef __ZLIB_INFLATE_INFLATE_H
+#define __ZLIB_INFLATE_INFLATE_H
+
 /* inflate.h -- internal inflate state definition
  * Copyright (C) 1995-2016 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
@@ -123,3 +126,5 @@ struct inflate_state {
     int back;                   /* bits back of last unprocessed length/lit */
     unsigned was;               /* initial length of match */
 };
+
+#endif /* __ZLIB_INFLATE_INFLATE_H */
diff --git a/lib/zlib_inflate/inftrees.h b/lib/zlib_inflate/inftrees.h
index fe4307fcfbe3..39d5d90d1258 100644
--- a/lib/zlib_inflate/inftrees.h
+++ b/lib/zlib_inflate/inftrees.h
@@ -1,3 +1,6 @@
+#ifndef __ZLIB_INFLATE_INFTREES_H
+#define __ZLIB_INFLATE_INFTREES_H
+
 /* inftrees.h -- header to use inftrees.c
  * Copyright (C) 1995-2005, 2010 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
@@ -60,3 +63,5 @@ typedef enum {
 int zlib_inflate_table (codetype type, unsigned short *lens,
                              unsigned codes, code **table,
                              unsigned *bits, unsigned short *work);
+
+#endif /* __ZLIB_INFLATE_INFTREES_H */
