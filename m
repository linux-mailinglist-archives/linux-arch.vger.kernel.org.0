Return-Path: <linux-arch+bounces-12793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7DB06B17
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 03:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE824A7F81
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 01:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55698231A4D;
	Wed, 16 Jul 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HhrqCbzi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8BA7261D;
	Wed, 16 Jul 2025 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629213; cv=none; b=ubuu8gNWz58zw0XqjCX8pFV0vU1zMmw0HVuGki9H7toRD/iu+EpVxE/SssVTh8hx+4OMLqWhlsKmipkKdAcB6C3R7A52U35JvxHYK72VItxXudmN3N+ATPj0f5JMyJeJgXxTvOY4TBVY9bHfQYswCe7xKqRG5PioAfz5t+alPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629213; c=relaxed/simple;
	bh=mBgmho3C2yXj6FS/G2R+iJ65IiJNl0BzIAppXDQywEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORMeezEPIeEqfemd9oP9Tdg3geZtahgCFyS2L6d+AqlEZubvvv1W9gnj4MjlxptF5nltTbD9jGbBbjrlsueK4VMju6cE8stByUc02qhQn1lO2M3H5wLQZaOnb3Wj0NFXgFcSKyktuCS2wFbk3Wr7yhg2Fn/SeEvSNKfryzdSebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HhrqCbzi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0fmm9009551;
	Wed, 16 Jul 2025 01:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=bcigRjTgahlSRPeaFgWTsxblRFuu/
	c5qOL5V4/SaNf4=; b=HhrqCbzi9Q8nmXj7fj8n+Hh//Bf00l25OJn/AL5+Hfc11
	C8Kp5BWP4XuUiSjrkPSVZ7GCzPxFEYKl8KCQ2kiQ3ZzonovyuyZSU11lwk/txiCH
	8cxQ0MJYxC6HCzm52mmV/54SqlMazN0TGyZPwRDILtm7DQ7+T/7vFOiyFdqrrE6T
	O/3nHBaAjYPORT+jME79fO1GZUmmmYnH/i2+p830WFE++yyYL5VmIDSFIXegvUyX
	N03MIEiZgq6n79xkTOcIIKXKW5ahT0GSMCqkPvwoArIFy+fXp8Oa62JLsC2w+XHl
	tfKiHQmdj2jzBMqI9a0kRWDdI5lGNI9CT/GVgd6+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4qvyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0qhSW028912;
	Wed, 16 Jul 2025 01:26:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5afdq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56G1QCRY036586;
	Wed, 16 Jul 2025 01:26:12 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5afdph-1;
	Wed, 16 Jul 2025 01:26:12 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
        muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        agordeev@linux.ibm.com, anshuman.khandual@arm.com,
        christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
Subject: [PATCH 0/3] drop hugetlb_free_pgd_range()
Date: Tue, 15 Jul 2025 18:26:08 -0700
Message-ID: <20250716012611.10369-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=622 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160010
X-Proofpoint-ORIG-GUID: AgBKPn9m3_qL6HAiOrMxXGHg9kVDPIOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAxMSBTYWx0ZWRfXxwAXUBBzM8WE 8bN6iMhvq8VQNcmeYpy7n1hD5x1yRml/PeprWv2oY998EvJW9BaqZpqmDB3OYFgQjUpbNjIeSeb WG8iLxKK77u7K5KJgC90w0dSsy2WZQp3fBKI7F/UsJVccM/aiVmTc0R8dANTZHjtDMfL+3i2KPL
 Nipym8Bk7nkTTJgX6wlUhpbMuVtJKR0nrN6SSBcp2qo6H2UQuva7Or2yQggdBqPao2vMufeJkAc 6Fzy7auvRVgFpSbvRzXzsCKJ0jG6Sg5O1/HJqkYCAW6e/XUMima2QlJc1t8qlb7guYfDt+fGz02 RPjqsL+LCj+n2BhTdZHSEG1oLC/lXN2TZfv6MHWyHFpSC29HwGec4A3zWNxgSNK1CxvojKDiknP
 Q21N8ezSB8Rphz7SNn4vlbBTdtTfXAWrAMb+w2+HIkvT5LGZTt6bRarkitxCzKPkmrqf9MeZ
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6876ffb7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=Wb1JkmetP80A:10 a=OqWGQR8W8kVsT6dWFhgA:9
X-Proofpoint-GUID: AgBKPn9m3_qL6HAiOrMxXGHg9kVDPIOQ

For all architectures that support hugetlb except for sparc,
hugetlb_free_pgd_range() just calls free_pgd_range(). It turns out
the sparc implementation is essentially identical to free_pgd_range()
and can be removed. Remove it and update free_pgtables() to treat
hugetlb VMAs the same as others.

Anthony Yznaga (3):
  sparc64: remove hugetlb_free_pgd_range()
  mm: remove call to hugetlb_free_pgd_range()
  mm: drop hugetlb_free_pgd_range()

 arch/sparc/include/asm/hugetlb.h |   5 --
 arch/sparc/mm/hugetlbpage.c      | 119 -------------------------------
 include/asm-generic/hugetlb.h    |   9 ---
 include/linux/hugetlb.h          |   7 --
 mm/memory.c                      |  42 +++++------
 5 files changed, 18 insertions(+), 164 deletions(-)

-- 
2.47.1


