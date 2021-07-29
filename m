Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58233DA472
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhG2Nh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 09:37:57 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:12225 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhG2Nh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1627565875; x=1659101875;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=W8x69J6Q09I5gZNXo9ZYxmS76YuV1xVnU5m8ij7pP8E=;
  b=DA/R4+ivRRUBpi/GbJS/qOXt6GM09Av6NvTj4S/kPy5Nze2cGHSXEP4o
   Gjer0bUCKLkolr2viJNkUadg8HStssynuBy7rudQl+D33q5IVNLlanZiK
   wA7NroVoOxAvTBBudtoJaUhAs2MwxVK8+TmKuqAXnXEQJNUVkVe/7zdIp
   g=;
X-IronPort-AV: E=Sophos;i="5.84,278,1620691200"; 
   d="scan'208";a="128788947"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 29 Jul 2021 13:37:45 +0000
Received: from EX13D28EUC003.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id DAB04A0379;
        Thu, 29 Jul 2021 13:37:43 +0000 (UTC)
Received: from uc8bbc9586ea454.ant.amazon.com (10.43.161.175) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 29 Jul 2021 13:37:38 +0000
From:   Siddharth Chandrasekaran <sidcha@amazon.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        <linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Siddharth Chandrasekaran <sidcha@amazon.de>
Subject: [PATCH] asm-generic/hyperv: Fix struct hv_message_header ordering
Date:   Thu, 29 Jul 2021 15:37:02 +0200
Message-ID: <20210729133702.11383-1-sidcha@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.175]
X-ClientProxiedBy: EX13D15UWA003.ant.amazon.com (10.43.160.182) To
 EX13D28EUC003.ant.amazon.com (10.43.164.43)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

According to Hyper-V TLFS Version 6.0b, struct hv_message_header members
should be defined in the order:

	message_type, reserved, message_flags, payload_size

but we have it defined in the order:

	message_type, payload_size, message_flags, reserved

that is, the payload_size and reserved members swapped. Due to this mix
up, we were inadvertently causing two issues:

    - The payload_size field has invalid data; it didn't cause an issue
      so far because we are delivering only timer messages which has fixed
      size payloads the guest probably did a sizeof(payload) instead
      relying on the value of payload_size member.

    - The message_flags was always delivered as 0 to the guest;
      fortunately, according to section 13.3.1 message_flags is also
      treated as a reserved field.

Although this is not causing an issue now, it might in future (we are
adding more message types in our VSM implementation) so fix it to
reflect the specification.

Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
---
 include/asm-generic/hyperv-tlfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 56348a541c50..a5540e9b171f 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -284,9 +284,9 @@ union hv_port_id {
 /* Define synthetic interrupt controller message header. */
 struct hv_message_header {
 	__u32 message_type;
-	__u8 payload_size;
-	union hv_message_flags message_flags;
 	__u8 reserved[2];
+	union hv_message_flags message_flags;
+	__u8 payload_size;
 	union {
 		__u64 sender;
 		union hv_port_id port;
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



