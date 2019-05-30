Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43430268
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE3SzS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 14:55:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbfE3SzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 14:55:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UIq8Fp032216
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 14:55:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stkat3h71-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 14:55:17 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 19:55:15 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 19:55:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UIrv4l35127356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 18:53:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1F2DB2064;
        Thu, 30 May 2019 18:53:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D50BCB205F;
        Thu, 30 May 2019 18:53:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 18:53:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D760016C2D27; Thu, 30 May 2019 11:53:58 -0700 (PDT)
Date:   Thu, 30 May 2019 11:53:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053018-2213-0000-0000-00000398092F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011186; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210864; UDB=6.00636205; IPR=6.00991898;
 MB=3.00027122; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 18:55:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053018-2214-0000-0000-00005EA377A9
Message-Id: <20190530185358.GG28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300132
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 11:22:42AM -0700, Vineet Gupta wrote:
> Hi Peter,
> 
> Had an interesting lunch time discussion with our hardware architects pertinent to
> "minimal guarantees expected of a CPU" section of memory-barriers.txt
> 
> 
> |  (*) These guarantees apply only to properly aligned and sized scalar
> |     variables.  "Properly sized" currently means variables that are
> |     the same size as "char", "short", "int" and "long".  "Properly
> |     aligned" means the natural alignment, thus no constraints for
> |     "char", two-byte alignment for "short", four-byte alignment for
> |     "int", and either four-byte or eight-byte alignment for "long",
> |     on 32-bit and 64-bit systems, respectively.
> 
> 
> I'm not sure how to interpret "natural alignment" for the case of double
> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> 
> I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> be atomic unless 8-byte aligned

I would not expect 8-byte accesses to be atomic on 32-bit systems unless
some special instruction was in use.  But that usually means special
intrinsics or assembly code.

> ARMv7 arch ref manual seems to confirm this. Quoting
> 
> | LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR,
> | VSTM, and VSTR instructions are executed as a sequence of word-aligned word
> | accesses. Each 32-bit word access is guaranteed to be single-copy atomic. A
> | subsequence of two or more word accesses from the sequence might not exhibit
> | single-copy atomicity
> 
> While it seems reasonable form hardware pov to not implement such atomicity by
> default it seems there's an additional burden on application writers. They could
> be happily using a lockless algorithm with just a shared flag between 2 threads
> w/o need for any explicit synchronization. But upgrade to a new compiler which
> aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
> causing the code to suddenly stop working. Is the onus on them to declare such
> memory as c11 atomic or some such.

There are also GCC extensions that allow specifying the alignment of
structure fields.

								Thanx, Paul

