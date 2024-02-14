Return-Path: <linux-arch+bounces-2382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189785560E
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D971C272DA
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF36145B3C;
	Wed, 14 Feb 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IES6jhft"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521D55E63;
	Wed, 14 Feb 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950068; cv=none; b=DlqeRoCw8hs9QaTjaPqRo62V634ka3ry+GudMhXE4kjmN4DT3LdXjUNCM4ALHVFZixU94nYKhumLmWHUgJcIXpObT7BbEgQUbPYh2WlE4WIZexYwJeuI77U+Id8feO7R4dHRDHIewowhUo8OW5j/r5wxKvrFAK2hXKdsOlvttPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950068; c=relaxed/simple;
	bh=lK16tJ+rA71j9sfNq9u1nc1gFyGNYENJD/MUcT/DOWk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=t2DsLKCy2cFq35bx5UD9JO4Hq7koKqR+1ekvs6vS6yVVAQxoVWf+X0yaTjpc1I1UB8GwIDhiQr8ZqgEbXzsrU7pVFMhoKHNkxjkEQ4dkIFnTU74dyLmmXJAo+Ss4+L5lhBbkVWpFNBPG4yCrjI6BPYXVhdFZQVPZBYVBBf0Iez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IES6jhft; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMLfOc015876;
	Wed, 14 Feb 2024 22:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=YaCnxeC1vZNqMAlZsLhMKvaeenQEHMsIYJyTFNiF+AU=;
 b=IES6jhft/4uq7lMwuENFVDv/krEl3ke4G/iFa69Y00mhR+LGrrjemioUGrGBDrXdx651
 gCIeY5gKLljsxTRhQDAc6dq/WCZt4uCLI3zxZWhAr/2PGVKWbbTyYZBvBW0pcN0bBcsW
 5NcGgUbSaCBHQtAc2TgwJB1YLqw3WsIRjzI2tacS8SE6RKsH9LqjynvC7hb1V8zZKfdg
 W4PgqqrwgrH6Gke8Oa96YvBJxdn94QNBRL2eYLVC5wSuVzXwjeD4uglbWDwtEirsMKyl
 VE7QLUog2vIi9F1DPzYJrh8B+ToUVGsb0bpMsFesTpCynhOTwXuV0/Btzb6Gi1reCnkf NA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w95ew19u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 22:34:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELXHgq024975;
	Wed, 14 Feb 2024 22:34:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpgx64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 22:34:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EMY7hC39059812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:34:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE88A580D3;
	Wed, 14 Feb 2024 22:34:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15CB4580BE;
	Wed, 14 Feb 2024 22:34:07 +0000 (GMT)
Received: from [9.61.99.202] (unknown [9.61.99.202])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 22:34:06 +0000 (GMT)
Message-ID: <a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com>
Date: Wed, 14 Feb 2024 16:34:06 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Nick Piggin <npiggin@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@kernel.org>
From: Peter Bergner <bergner@linux.ibm.com>
Subject: [PATCH v2] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
 entries
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TJPk-bPkib7XFvVei_OFewI8h97C-DRW
X-Proofpoint-ORIG-GUID: TJPk-bPkib7XFvVei_OFewI8h97C-DRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxlogscore=650 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170

Changes from v1:
- Add Acked-by lines.

The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
access by the __builtin_cpu_supports built-in function.  The TCB space for
the HWCAP entries - which are created in pairs - is an ABI extension, so
waiting to create the space for HWCAP3 and HWCAP4 until we need them is
problematical.  Define AT_HWCAP3 and AT_HWCAP4 in the generic uapi header
so they can be used in glibc to reserve space in the powerpc TCB for their
future use.

I scanned through the Linux and GLIBC source codes looking for unused AT_*
values and 29 and 30 did not seem to be used, so they are what I went
with.  This has received Acked-by's from both GLIBC and Linux kernel
developers and no reservations or Nacks from anyone.

Arnd, we seem to have consensus on the patch below.  Is this something
you could take and apply to your tree? 

Peter


Signed-off-by: Peter Bergner <bergner@linux.ibm.com>
Acked-by: Adhemerval Zanella <adhemerval.zanella@linaro.org> (glibc)
Acked-by: Nicholas Piggin <npiggin@gmail.com> (powerpc)
Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com> (arm)

---
 include/uapi/linux/auxvec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index 6991c4b8ab18..cc61cb9b3e9a 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -32,6 +32,8 @@
 #define AT_HWCAP2 26	/* extension of AT_HWCAP */
 #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
 #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
+#define AT_HWCAP3 29	/* extension of AT_HWCAP */
+#define AT_HWCAP4 30	/* extension of AT_HWCAP */
 
 #define AT_EXECFN  31	/* filename of program */
 
-- 
2.39.3


