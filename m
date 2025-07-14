Return-Path: <linux-arch+bounces-12761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED626B04A33
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D864A18DC
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809A27F183;
	Mon, 14 Jul 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ht0M3ss7"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C705278753;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531352; cv=none; b=P8yLkTPKy3jKIfnhPoigziTP1dnwKxdZJEdRjcRAfNk/CjF2lVxiqyc0oKntojhjMgS1XgFSzHiy9uthz57bTUpM63RlasZW1sxpNoVzka1SpNjaKDw5VdEpgl7C4lr2/B+vA88H/RQ8YYbZqCNf2SDbnVCE7pIWR91NFioAELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531352; c=relaxed/simple;
	bh=u/KPsb1h5AglUAwekqho240DEYtuoNvGBF+U/5Ha9bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7vlCZ+q+39UyTaLAQ36b240ZNb25LoMnI7PuDCy9C1M6XXwOQ6jHR/qFws1EUfCQGHTLc4UmWTijvL4z1BrdHHZGn+kS8cPN4vGqAi7XExHB2v5cI4mzkuWWiQHjNovXvfU0rQS3bqKd9SVC5JFv8MICuQeF1wJFr14mPmRwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ht0M3ss7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 620B22016596;
	Mon, 14 Jul 2025 15:15:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 620B22016596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531349;
	bh=ANaSeCLcuOpQTrlS/gomE+iBc3WLPtbEx8zr3r2sN/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ht0M3ss7YtAqN2f0e54wCb9XuZKJB5oYA780tB1InvLZ+ROTELDad1U6UroSEFbCW
	 s8b619rf8GbIQtE13F8E1mRCqcB3no5FK/5xrw7u/BIWSqQRihq4ZnUY1rfOkeC90C
	 LobQVx2g5Qyr1I2c+HhWYLm8edvAG3/F5Re163vA=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 09/16] Drivers: hv: Check message and event pages for non-NULL before iounmap()
Date: Mon, 14 Jul 2025 15:15:38 -0700
Message-ID: <20250714221545.5615-10-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It might happen that some hyp SynIC pages aren't allocated.

Check for that and only then call iounmap().

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 820711e954d1..a8669843c56e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -367,8 +367,10 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 */
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->hyp_synic_message_page);
-		hv_cpu->hyp_synic_message_page = NULL;
+		if (hv_cpu->hyp_synic_message_page) {
+			iounmap(hv_cpu->hyp_synic_message_page);
+			hv_cpu->hyp_synic_message_page = NULL;
+		}
 	} else {
 		simp.base_simp_gpa = 0;
 	}
@@ -379,8 +381,10 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		iounmap(hv_cpu->hyp_synic_event_page);
-		hv_cpu->hyp_synic_event_page = NULL;
+		if (hv_cpu->hyp_synic_event_page) {
+			iounmap(hv_cpu->hyp_synic_event_page);
+			hv_cpu->hyp_synic_event_page = NULL;
+		}
 	} else {
 		siefp.base_siefp_gpa = 0;
 	}
-- 
2.43.0


