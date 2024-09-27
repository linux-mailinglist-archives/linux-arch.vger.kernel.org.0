Return-Path: <linux-arch+bounces-7465-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283AC988062
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE32281E24
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8E18787B;
	Fri, 27 Sep 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YYgDPGAf"
X-Original-To: linux-arch@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AB17A5B2;
	Fri, 27 Sep 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426170; cv=none; b=APfup0w8cc6J4dMgwZocd1VHw8+CiCnKVr5lzfaRuWGjF9WK9GbUDQRQ7GDmEi5Pfm8n13MqamwCXMuwi+GtzmJSIDHu5uD7YMiclyz9w2Kf3lGcJxGot7RI0LpX7OOaw2pRgS1jhPhSEIz7JSmoFmvt8xZ9HjNpdc7JeJ1Z7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426170; c=relaxed/simple;
	bh=EOerY+/hoxQcJSNPQTVk/9w/jYcmVUXtwC+FxDPEd9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCy8M+jdFE12wbstPUaoC17GI/kDFPabBiFKzfNFc3QJ22NcXgFdLB+71Hn1syRM8p2wzAD9uk+nynOrQC/8FvlNeCE7v9NbDCT4OKtBazqhl2XJPckgaNf8sGO6GjILMcHQPGClfIegHIjGGDcAVck4phGb73xpNmb6nJs9XGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YYgDPGAf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727426167; x=1758962167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EOerY+/hoxQcJSNPQTVk/9w/jYcmVUXtwC+FxDPEd9w=;
  b=YYgDPGAfmSE+SkS9MLNmZ1jvFmuvWHKmUiL+wEAl+VhzKEADCptFHP+W
   KBEQOdlv6B2uK1oWMjqwWIyxHHD15w3G3WoYmPVJ1n48Ncs+e223Y6fFr
   NpKcyMOY60F4KYRH7gwA4nnkCaN/YOQegCfusjz8gUG0i1QDy79vF/gcW
   dAa4NfqMuaThM3nqyMJpXobKaUtp6kYVjFEf+Yzw9h1zHh6rwKrhRDp+e
   ybrcA/fXJ127S4qanWNgvdPD4fycRj10dkmuKntqQAYaf8D8UZfQDYR2f
   HXtpdqqSNvPZi/kAaZyCLYVqa5Rdn/rqo5pBb+PF+1X/3aKCmmtnzMkBm
   g==;
X-CSE-ConnectionGUID: s8mN+O17RkShfQyXT9uJug==
X-CSE-MsgGUID: eQvy2OadTP6CbxApd73XYw==
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="32927812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2024 01:36:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 27 Sep 2024 01:35:46 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 27 Sep 2024 01:35:45 -0700
From: <marius.cristea@microchip.com>
To: <arnd@arndb.de>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Date: Fri, 27 Sep 2024 11:35:43 +0300
Message-ID: <20240927083543.80275-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

The PAC194X, IIO driver, is using some unaligned 56 bit registers.
Provide some helper accessors in preparation for the new driver.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 include/asm-generic/unaligned.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index a84c64e5f11e..d171a9f2377a 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -152,4 +152,31 @@ static inline u64 get_unaligned_be48(const void *p)
 	return __get_unaligned_be48(p);
 }
 
+static inline void __put_unaligned_be56(const u64 val, u8 *p)
+{
+	*p++ = (val >> 48) & 0xff;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
+}
+
+static inline void put_unaligned_be56(const u64 val, void *p)
+{
+	__put_unaligned_be56(val, p);
+}
+
+static inline u64 __get_unaligned_be56(const u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+static inline u64 get_unaligned_be56(const void *p)
+{
+	return __get_unaligned_be56(p);
+}
+
 #endif /* __ASM_GENERIC_UNALIGNED_H */

base-commit: b82c1d235a30622177ce10dcb94dfd691a49922f
-- 
2.43.0


