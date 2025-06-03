Return-Path: <linux-arch+bounces-12186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2808ACD009
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB143A64AD
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jun 2025 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93210253F31;
	Tue,  3 Jun 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mxYJ7tSe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008ED24A07C
	for <linux-arch@vger.kernel.org>; Tue,  3 Jun 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991042; cv=none; b=Ftyo8842dIXBSK5bcVKgMUf7udOEQXSTfcwVWcTa+5I3sJiy3fNKBV4Pz9H4HJjMGeGo2t7lpw/pBFB5KxX7/UuD6/jUBqHH5WFfeQiXTuAufeIv8zZ4Eg06bKEDSg/NBbAL2EBd2hZ5YpC26Pcamdua0gOrUWEgYWPT1Q7Q21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991042; c=relaxed/simple;
	bh=i2lx+JkxNZ+W3TCDZnRYDvhiaw/fRSyKyaRCnDad9K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d0QMgEmfp9MkcrNjImSSd5EsNjLeNqJmcSGa6dg23IvPBf/bdcltN7+FquRALBwXnpwzBpmwzVifpFWnOIW8FyPSWJkXEIj33uqqvVpSo89hN/wGmvJJSrZdR2VD1HTYZdic0VEGpuBrJi33yT2fAbbhdO9NsTAYRYc2HG1Hbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mxYJ7tSe; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Mj8cs017734
	for <linux-arch@vger.kernel.org>; Tue, 3 Jun 2025 18:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps01;
 bh=mnOINAIPGY/Ou83vSuinfWElCEeIzSaRYKDK+hS7UK4=;
 b=mxYJ7tSeNSr/qKkG5dt7HYyNshWTHjvf+KyWfX0UBtJSjA7y8kJfbNxxRwOznIBK5UnF
 QPwD12fVSOVOjv32y4qe0HJzTHVENSyOQM5FwC6U7Fy/NcVS3SBll2lWBu5DaecN31KU
 zQyUSyFUSm73i3zu52EU0F4G5xtqsBfsNOZZ1/HEkYiWllWp0CrjvnmxsRPuuME0t3i9
 kXn/W7eXiAYYsgShQtWV1uTAmVRE/KrR4v4zFh3GtHuOqcmOvqVQeyBqgXv6ZFJ6qFck
 VRzApgAEtG/HeaR8Bs0ZAdxFCRwou0ddbu+sSKCJ8x6bdz+GPhI/ZQral/bpzB0IiaG6 FQ== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 470f2uwbj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 03 Jun 2025 18:50:34 -0400
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5cd0f8961so1225142885a.1
        for <linux-arch@vger.kernel.org>; Tue, 03 Jun 2025 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748991033; x=1749595833;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnOINAIPGY/Ou83vSuinfWElCEeIzSaRYKDK+hS7UK4=;
        b=k0RVDFxSAmpEQvUdWjfbFYrpoZPpT9xreoPE8r/hHIVhKJpv4JFSNKTQAngifQHMRD
         7qbbwch3Of1PtNL9iFnxfFtEtQJiR4xUWq4Ejyejwg6fHJUBDBYbIaO4VmZyZC1+HTxe
         7WnHmQlQPFnxIL3pXewPHmTbEv2db+wzdyQXqEn3mKspLZOs9IlukWfynk33xb+xVTyi
         GfTA9d7HhehdgOCd14X8Jyvn4pYtBK79Jefx1xYOnq44VsdnNFN0Go0U4odQhaIouJDj
         7QSK5P2gepEuwNtJTGjaVWO1UyX/G3wJkBUjXunM32fLrFCj9IRmTchiQ31GQ8m8Ibu4
         tyQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnou2cMie7tKojIlCDZLEOWUbvBQy+M/dlqNwjRikwSAMsOe4BEmF3Z80M6Qvhbg9txZwlWVd7oDTW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bpIphSMMXlk9kktpgC4nX11EV8/Xc4pBUIGVfPbIc3VazXaI
	WjQ3ABaO2JtRBvF1J9n2gzJiIyW3kxb0P6Zs/hD1dXrWMzg7r3czS8KVO06lju219Q2qPabP1wn
	7dhjL6PvWsTD+phWaI0tB4LXamkZy4vJzRsgEcj4+UhFKKOOWLPl5KVBugKM=
X-Gm-Gg: ASbGncsuLRpyDA/F4dcos4cedbO38/IP/LrVv8L7aw+2Sio/FhqqndTZkNJ96Y9b7rQ
	KZuLlY+ObdAHv34WCpjqX8EYrrUkEXLgIdd9UxfG6IvrWQE4a5bg1ycMbgUwZmVm04mBh65i/Yr
	k3mc/G4WsO8KU8LRjGnpdIuAFagdorPeFhv1PMGLSHk42OM78EmYlLLMSzR/ESFyBiqVIj4O35U
	jcKKGaXBlui5Z8kyhOwICLe+ptig4Ip8reUENOuIxmQSUAEkBO56cq1ich7hxRoF9qoK0OjgAUT
	ewMp477x/M7oe8DVntRFmwVnBvtZVFe8ouXxmVEX31ZW0WxHGmc9b4vJxw==
X-Received: by 2002:a05:620a:84ca:b0:7d2:18a1:ce8 with SMTP id af79cd13be357-7d2198ef699mr126686685a.26.1748991033495;
        Tue, 03 Jun 2025 15:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtrJnD/OOKXUtzOLplJe6RJMGdW40f/XS2eC47ExOwD2Rj25DN3kAGNiiVAICHB9OlX7/n1A==
X-Received: by 2002:a05:620a:84ca:b0:7d2:18a1:ce8 with SMTP id af79cd13be357-7d2198ef699mr126683885a.26.1748991033102;
        Tue, 03 Jun 2025 15:50:33 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-95.net.columbia.edu. [128.59.176.95])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f9940sm920370085a.44.2025.06.03.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:50:32 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Jun 2025 18:50:17 -0400
Subject: [PATCH] MAINTAINERS: add tlb trace events to MMU GATHER AND TLB
 INVALIDATION
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-tlb-maintainers-v1-1-726d193c6693@columbia.edu>
X-B4-Tracking: v=1; b=H4sIACh8P2gC/x2MQQqAIBAAvxJ7TjAjxb4SHdS2WigLlQjEvycd5
 jCHmQwRA2GEsckQ8KFIl6/StQ243fgNGS3VQXAxcMl7lg7LTkM+VTBEpqRW1gmlhHZQqzvgSu9
 /nOZSPgZRAihhAAAA
X-Change-ID: 20250603-tlb-maintainers-7697bc27729c
To: Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748991032; l=864;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=i2lx+JkxNZ+W3TCDZnRYDvhiaw/fRSyKyaRCnDad9K4=;
 b=ELGpz4PKz6KnOE0I1m3t5q/WTtlfcOk9x20TCo/QeW2il8vqxP9bLBoLtBHjB5pbEU6k+LyrL
 S8pI1+lZQGnBatK79aCq7nnjr5+uflg0Jc8VvRruDbdEAjeAtiJsEPE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: -E62EGUcznGdxdKO1fsLDMKA7mt-LwHq
X-Proofpoint-GUID: -E62EGUcznGdxdKO1fsLDMKA7mt-LwHq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5NyBTYWx0ZWRfX3EJMchTXi7UX LUxEJlcfvSpIFPAPmk/7ITWv0UWVKFavVokGYtVUegM0u+ZNVVpIb5gObbeOrs5GhuwKfWZuh7R u++e9Q2ozmY+MmzBWPJzinT58FkjhidPYKcN7IqV+Q3NOLRKsLSGEH/Lalztl7KprmcTP6NExDJ
 HloKpT3mjxbr1XsoGnfXQZnugxiQZnW0RHrm5pqkj2286uMOESVGIEC9LJ5Ta/FTThRR8PnLyIn ys3XTDoMKWFz/VlP9NSCxnx30L1Wi8e8WMJ3D2Uf3MjJsXLVJosQDuXtpwUeIy6/5oFxy/96dqk 9T/vYG6GbBXd+D2BSwlgfzj4do7zVkrbfWx4V/fVTUOQirHtXVcboNg1ZbDnULBS8kTisMwAvo+ 30y7iNWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=733 phishscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 mlxscore=0 bulkscore=10 adultscore=0 lowpriorityscore=10
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030197

The MMU GATHER AND TLB INVALIDATION entry lists other TLB-related files.
Add the tlb.h tracepoint file there as well.

Link: https://lore.kernel.org/linux-mm/ce048e11-f79d-44a6-bacc-46e1ebc34b24@redhat.com/
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98201e1f4ab5..678eae27688b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16653,6 +16653,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	arch/*/include/asm/tlb.h
 F:	include/asm-generic/tlb.h
+F:	include/trace/events/tlb.h
 F:	mm/mmu_gather.c
 
 MN88472 MEDIA DRIVER

---
base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
change-id: 20250603-tlb-maintainers-7697bc27729c

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


