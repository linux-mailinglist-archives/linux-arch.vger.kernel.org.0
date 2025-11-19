Return-Path: <linux-arch+bounces-14944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6694C6FCB2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 825302ED30
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF2327BED;
	Wed, 19 Nov 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5VN9gtA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298035E53D
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567169; cv=none; b=RsFbc/sOqrR4ib6fAV+oszP7BU9qJEOzjJlnBAR150vfs8Oql3qJvWDrwoeQ+0dMe6Lhag2/7DJ2huo5u6dDUsP6GC7D847IWikh5pvMv1WOrr/cjsmhY68CmndI7VkiWjtuDlQWbNOxd9rG1F6xwW0+v4EHYA+duD0qPHylB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567169; c=relaxed/simple;
	bh=Vs8lQW7BawUxmkOmLvkVao/jUHVbMrAhKW0MzITmHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhQJlRa5JfHkUmcIgriChFWVWGkUgVZFOoT9G5SevHG4/D5iyL/gZ/pA8cgoqqBROSX+WQIB8TV7P2o3sOVsVPNXv8CDogZNsrW6LwzhpF4ybuYgKymqYfo/9ko6goWaDqHnMvKrjXKxIDfLr40CCYEE8CWB6y75BPbu908qE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5VN9gtA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47789cd2083so47003765e9.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567161; x=1764171961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plmpXAswm1LBomkuKtBG6pEMvq3kPgWo3F0t41OaVKo=;
        b=s5VN9gtA7BI7QEVyZFA8bNSEEtzGadJpV0n75+YSnEQFbezbHy0V9//G5xZOOBKNy9
         w/dFXLVOJAGqEChl1FE9CuIi3WdPHYT0C7emqe3w5/eAxEPF4lTjCDpCOfPKuM1OxdxG
         VfxOhSXpLpyvUFKSe4R6FXxwFt3xjVEq8fpT8vy3fSk2d0ethXkqeMBhlLKM3gBYnspH
         /WaE3rgjBZi9tX1i2OjQR4fI8Ubqbk3BzV78jghkr3GTr/xiNPoZZNk1NgHpEXrLADPj
         o0K8GM49h6Vz7yGMKgEq8moU5p/xGZwKTyQFzpwXbiDxSIbrsvD/4tAX7dBJ0XU0jvrB
         JqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567161; x=1764171961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plmpXAswm1LBomkuKtBG6pEMvq3kPgWo3F0t41OaVKo=;
        b=w6lb20VwgtgTUBDpTyvgXGUrTqYmGjGhzXzzApOTbB4FNncVrFLDMJJCg2rdrqz2N/
         x64f+zfR5o+HocjTgh0LI3m2pohwdQkj+DCGy9lUbVupN/h2rCqkn8Y5PIMsHfg8l5Tv
         v0UXFsy6jHLItjHT1YZumEPowJ5+3+lqbm6c8ireNWoMv9ZPMZ1ozNKgD+tlo1zv4L9K
         9p1Lzzqf+UWRoiaMBuvRFVa84W5iBspeZZoHRMSy5cgEcBsTOeMFh/H+wyZrm3MibM/u
         QeKlYSQMf5MAU8DrQyyCIQ7zl9/6cOzFmJeBRNDKVO38JJF8MF/8KHTzvUfhNkQXJYIb
         Yz4g==
X-Forwarded-Encrypted: i=1; AJvYcCUhG33toTL1kAvVGazyWG2ULC0k/uM2WHmJnxkXGOn/AfK8LtxKGQLoVfOS9WZTfy+M4vJkcV/v1rLa@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWyLf04p3VzC24Zuvuf/yYNZVyKviZFIvad5+wdmjCH/vzIwI
	geXG9l8RQnmNfq8I0G5GT3PP0IHqyITOS+YZBeHkmRRXmQSAVyt4RvrzO9ifSoNN/Ts=
X-Gm-Gg: ASbGnctsQfVTQRXliqbOlfk7foue6Xt+3unjuWcAwShR0Ydep/jfbDpK/YmlTg1EdgZ
	54K9yNMYb564ChdONVpJDAkxcHLbuMo16ctwjValA5DL3zhp2LwFW+QF9bDl/sNG1o3+t2hPm8W
	pDPmetvqoROCbVGohjixyiy5/Azb+1c1kaVG3uzAPz3e09oaFGqIpIp14T+RfLq3p0ooSZjM7d1
	tWgbJULw7hxFiwnTb3xNBczd8M6g8k7rHiCrBCggo/K43bqMfCZUhwoRS0MufHGH3j02Ph0iNeV
	OCmexlQjQO+JRizXUR0PK41wy/+9Na7b/I7Fo2usbFFM9kmu7no0RIuhEnTdptTp0ANUdx7wPkp
	Dh4d+/Etsvh/4noLl7WSJycOp8tSGcKoZ3vVNmNJx2ageORImyKFADKamRKB2Xm73rMnW7HZMun
	KCU4gJDTarGEI1GoMBlMCyyFxKnmHRcxqUR2ZV0gXs
X-Google-Smtp-Source: AGHT+IE/UWqNyS6htQwPVCsFX9f3Bqg52uzu0v0K2d2YIVRMOF1vqDQaElTCpee5ClbOZybd51PSbw==
X-Received: by 2002:a5d:5d0e:0:b0:428:5673:11e0 with SMTP id ffacd0b85a97d-42b595a4ffbmr19851079f8f.40.1763567160526;
        Wed, 19 Nov 2025 07:46:00 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:46:00 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 25/26] dt-bindings: reserved-memory: Add Google Kinfo Pixel reserved memory
Date: Wed, 19 Nov 2025 17:44:26 +0200
Message-ID: <20251119154427.1033475-26-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for Google Kinfo Pixel reserved memory area.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 .../reserved-memory/google,kinfo.yaml         | 49 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
new file mode 100644
index 000000000000..12d0b2815c02
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/google,kinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Pixel Kinfo reserved memory
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@linaro.org>
+
+description:
+  This binding describes the Google Pixel Kinfo reserved memory, a region
+  of reserved-memory used to store data for firmware/bootloader on the Pixel
+  platform. The data stored is debugging information on the running kernel.
+
+properties:
+  compatible:
+    items:
+      - const: google,kinfo
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the data
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: true
+
+examples:
+  - |
+    reserved-memory {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      kinfo_region: smem@fa00000 {
+          reg = <0xfa00000 0x1000>;
+          no-map;
+      };
+    };
+
+    debug-kinfo {
+        compatible = "google,debug-kinfo";
+
+        memory-region = <&kinfo_region>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2cb2cc427c90..8034940d0b1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16164,6 +16164,11 @@ F:	Documentation/dev-tools/meminspect.rst
 F:	include/linux/meminspect.h
 F:	kernel/meminspect/*
 
+MEMINSPECT KINFO DRIVER
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/google,kinfo.yaml
+
 MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
-- 
2.43.0


