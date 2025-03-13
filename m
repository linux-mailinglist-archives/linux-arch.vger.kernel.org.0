Return-Path: <linux-arch+bounces-10714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4709A5F335
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 12:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84E27A7E1C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60926A1A3;
	Thu, 13 Mar 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhFfb65d"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BE26A0B3
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866297; cv=none; b=Bw9+4qc+VHvhmyU5Y5t+Yt/U6KkCCiuuqY8xVkWs42Gbxor+AgWSpdrsSAmlYiQ/qfshlvcFV8G9bVnHi8rQd2AjT6a9af8jk71VDKgHXeApSd1U2OvfF76QZY4PkExX4Tr5hN8zv4gV+XcHOD26SbM5WztMd0RtPb0idohuovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866297; c=relaxed/simple;
	bh=J4X8YZO4x00QVWpFsvAbnTlhyYgUvXZEkg17s47TCi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=iFT5hsfzHmOVPSgG3fKbnFOEsfhyf0mpLTGYs2m9gHM+3ONIlltF/OVb/NQ+zLzVs5WnIpJeUVrFZubHYTX7xRQTBCGRk1tLBLr7WbRETkJQQ7I1xUkvZvrhfBZrRyiAJl0qoiBMCyJwEqKdL8jLgsSAwCSaJUS1+6u6kC2xlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhFfb65d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdALik7flTFVSWTVblU8JKKGGV2JCoENkhxrfjNtUxw=;
	b=JhFfb65dbLIFuTOsmZM5CyAKYRE/nYHwuuMUhfMFJXL71ecgONeVT5sCU0JRbnXWD4mjRw
	lvGo4rzE2KKAHaAR6Sjbaw7cgLxcwbzmlOQn3InlGswLBFVfjH5CFHvADo36gSWlI307hK
	tLxIwCyVHTjMXtBBhaYy7bzTtx3Zz7w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-FUUWzQhFO7GCGad0hGKSPg-1; Thu, 13 Mar 2025 07:44:52 -0400
X-MC-Unique: FUUWzQhFO7GCGad0hGKSPg-1
X-Mimecast-MFC-AGG-ID: FUUWzQhFO7GCGad0hGKSPg_1741866291
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913b2d355fso345426f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 04:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866291; x=1742471091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdALik7flTFVSWTVblU8JKKGGV2JCoENkhxrfjNtUxw=;
        b=WxfhQGTXXIHbVf94upaRZKN/rBvRuhm26MPeKr5TpT960b+jBYX9pXpRBSpF+WFhtJ
         VIcnQpGoJ8YZnV/eIwebOZ3HYKfQRVSVfBU0FtPZByI7ps1JiNw4fFwrCgRcuBaaUGYC
         WLebXqASeQ62wxDaWFmYLg0wLKHOSWKMilPtzyXdfvhnONsgySP6Qo3yoNxuA+hxGWnL
         MgNTQEY7RNrdD/DB+aFh/u7xBP9quKhEDHEcyevUvw5DvQqshrHcRAHdvrrdT4Zi6Q6E
         4xnd+6q0oWmEcqLtD0I2MIY4VEwjhquH6Wlz8kVR4QXXIxdcTux3D5UXWAZyGED1R15U
         AA0A==
X-Forwarded-Encrypted: i=1; AJvYcCUQq4C4AWmTq5jGPwMbO6BmD9tn9x5O+qF73T3CnDCVl/mvkPuy9GAN0CZco2USWWDYc+u46oFSAhD9@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQZB5wENdER/ns0JEfBML6OdYE2PuDtRCYwSItWGXKHgLFH0K
	EdwEGy9tM2/Ix0CNn78jwPDY13PR5GVbPB+XWr8sAtWToywp2s474/oviPG3NOKM3YB2eAwXaF6
	JIdAITIsPkipcOP4YOWUJkCDhMO68HsO1R1ofdaut5K9jF1bqQFmBDcd+BYM=
X-Gm-Gg: ASbGncu7Qe6/RgKFqOPy5i70/pbRipVXUDJCBZgpU1P0McPGuEyY6kjgb9sEXjsVx3E
	hqaLJetpuTil7t38ABFxbF4TB+U2FlWcKol37zN/lx4nWndUqMLn/S2DpHOw2EmEL3IirK3Ztp1
	empTPAN3JeC1Ut5T8EtE74dEDwlPW/ci6EjwLdIo5lcfPwSqO5GxFzVF0itCEi4h1UkkGv4pFEu
	5hzXe3qbbCG8dkxp6yNnj0g4Buly4mUBlxoEPp2zyTIcQQzCXuNpfJz0LjI3fdzXmrJLGHAoeUS
	ygV9dyNwclL8TceT0XMN
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39132db7543mr19148453f8f.50.1741866291570;
        Thu, 13 Mar 2025 04:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc68icOs2UFLsGvYM02K+KaAXrxdUkEYYl5CYIXnV4BsTbvYwzMB6bzWlvY18H1nYSqaV5qQ==
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39132db7543mr19148405f8f.50.1741866291178;
        Thu, 13 Mar 2025 04:44:51 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:50 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 10/14] s390: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:25 +0000
Message-Id: <20250313114329.284104-11-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because
__func__ is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/s390/include/asm/bug.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index c500d45fb465..44d4e9f24ae0 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -8,6 +8,15 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.long	%0-.\n"
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
@@ -17,10 +26,12 @@
 		".section __bug_table,\"aw\"\n"			\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		__BUG_FUNC_PTR					\
+		"	.short	%1,%2\n"			\
+		"	.org	2b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (__BUG_FUNC),				\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.34.1


