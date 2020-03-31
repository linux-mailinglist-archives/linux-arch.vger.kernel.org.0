Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAB1992E0
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgCaJ7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 05:59:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730341AbgCaJ7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 05:59:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V9XG4J026210
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:59:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30206y2dm7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:59:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 31 Mar 2020 10:59:02 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 10:58:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V9vxs735979552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 09:57:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 543D64C04A;
        Tue, 31 Mar 2020 09:59:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B161F4C044;
        Tue, 31 Mar 2020 09:58:59 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 09:58:59 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        shuah@kernel.org
Subject: [PATCH v19 11/24] selftests: vm: pkeys: Use the correct huge page size
Date:   Tue, 31 Mar 2020 15:28:12 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20033109-0012-0000-0000-0000039B8649
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033109-0013-0000-0000-000021D891E1
Message-Id: <66882a5d6e45c73c3a52bc4aef9754e48afa4f88.1585646528.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310081
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The huge page size can vary across architectures. This will
ensure that the correct huge page size is used when accessing
the hugetlb controls under sysfs. Instead of using a hardcoded
page size (i.e. 2MB), this now uses the HPAGE_SIZE macro which
is arch-specific.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 tools/testing/selftests/vm/protection_keys.c | 23 ++++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 9cc82b65f8281..535e464e27e9d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -739,12 +739,15 @@ void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 }
 
 int hugetlb_setup_ok;
+#define SYSFS_FMT_NR_HUGE_PAGES "/sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages"
 #define GET_NR_HUGE_PAGES 10
 void setup_hugetlbfs(void)
 {
 	int err;
 	int fd;
-	char buf[] = "123";
+	char buf[256];
+	long hpagesz_kb;
+	long hpagesz_mb;
 
 	if (geteuid() != 0) {
 		fprintf(stderr, "WARNING: not run as root, can not do hugetlb test\n");
@@ -755,11 +758,16 @@ void setup_hugetlbfs(void)
 
 	/*
 	 * Now go make sure that we got the pages and that they
-	 * are 2M pages.  Someone might have made 1G the default.
+	 * are PMD-level pages. Someone might have made PUD-level
+	 * pages the default.
 	 */
-	fd = open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages", O_RDONLY);
+	hpagesz_kb = HPAGE_SIZE / 1024;
+	hpagesz_mb = hpagesz_kb / 1024;
+	sprintf(buf, SYSFS_FMT_NR_HUGE_PAGES, hpagesz_kb);
+	fd = open(buf, O_RDONLY);
 	if (fd < 0) {
-		perror("opening sysfs 2M hugetlb config");
+		fprintf(stderr, "opening sysfs %ldM hugetlb config: %s\n",
+			hpagesz_mb, strerror(errno));
 		return;
 	}
 
@@ -767,13 +775,14 @@ void setup_hugetlbfs(void)
 	err = read(fd, buf, sizeof(buf)-1);
 	close(fd);
 	if (err <= 0) {
-		perror("reading sysfs 2M hugetlb config");
+		fprintf(stderr, "reading sysfs %ldM hugetlb config: %s\n",
+			hpagesz_mb, strerror(errno));
 		return;
 	}
 
 	if (atoi(buf) != GET_NR_HUGE_PAGES) {
-		fprintf(stderr, "could not confirm 2M pages, got: '%s' expected %d\n",
-			buf, GET_NR_HUGE_PAGES);
+		fprintf(stderr, "could not confirm %ldM pages, got: '%s' expected %d\n",
+			hpagesz_mb, buf, GET_NR_HUGE_PAGES);
 		return;
 	}
 
-- 
2.17.1

