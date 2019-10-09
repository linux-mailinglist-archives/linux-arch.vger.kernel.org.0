Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADEFD152F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJIRPb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:31 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37641 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbfJIRPa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:30 -0400
Received: by mail-yb1-f196.google.com with SMTP id z125so985710ybc.4;
        Wed, 09 Oct 2019 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2jCX9HgU8ovLftcoHPoUNghHxtBxjaql0cnB+EV6BQ=;
        b=G0gVsazECpvl8fASpjW+Wmxxxf0YBjZtVgemu/ijKJM0P1s3KYqUpLw3ycGc9/LhnX
         XrLrnvgWb/ZlceynCXvq7wT7KKjAdy2mKQJ4dlCyQ8I3IUrDbugydMBSsMLEMGpzAsqc
         XsDaWvEqEq38O6QPFGU+tvJkUHcUMeCa5TRVJMRd3SeuNNE4dLuyHS5dqZQnTxWxgCcs
         PgGCji1Pj+y3YvYuUOWm+YN56yRPZAi9b0Y1+znRH8Q5sVDgxXMEYuD1QFwvF0I0gIT4
         S0V0psNFzi64XtMaKIPvDUhzPrZahU1WndibxMEyrVfYT5YnhLb2B8XKl9S3dLehXplL
         E/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2jCX9HgU8ovLftcoHPoUNghHxtBxjaql0cnB+EV6BQ=;
        b=Ag+NG+Y0O39cxqtxPgSZZcbVHAEWGru6d3pJ3TH5JNzpu+uoVc18P3DhhzbgLeN0C5
         udiD6FnnsSCvSJYUCLfTbJF/A1UxHfMuyIRIOmBPSsSx2xFOM36ThrzlpICEQZzH8Syt
         aaA2Q+d9I4DcmDQ7zeu2AZjrlyd2Uj4PNf0l91yoa3rce8yP7hYAQevLthF7B3cZrFJJ
         srcfRwUaObyrTKMmnZZqDtUoR9vJ3X4IPkHBCCpzJT9xujow9nMjSyCc9Xr18Pi2ET3/
         7eI3UDnoPnAa5cRWLt+vQ8CCLyCDggCCZPPsJvJKujwaYgGo1AY1KyLtTwmiMqGT/do1
         D+rA==
X-Gm-Message-State: APjAAAVV66jxiitE4SQrrjRdU/BQy3SeTQoLxUVWAD/P7Iw0R41udntu
        A8m4hZ3ugyOOJG/WDB7oqzo=
X-Google-Smtp-Source: APXvYqwcA1BhgvyvSAKo5+llRDxL8dtPONEDeU1F8oMVd0RZa1x5CyTNbEV6aAh/jd++y6y0S57smw==
X-Received: by 2002:a05:6902:510:: with SMTP id x16mr2733858ybs.517.1570641329421;
        Wed, 09 Oct 2019 10:15:29 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:28 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v18 11/14] thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:47 -0400
Message-Id: <2d3c74e9a00a52954f31d19e04623a7f4bc85520.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
bitmap_get_value8 functions, where appropriate. In addition, remove the
now unnecessary temp_mask and temp_shift members of the
intel_soc_dts_sensor_entry structure.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 31 +++++++++++++---------
 drivers/thermal/intel/intel_soc_dts_iosf.h |  2 --
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 5716b62e0f73..f75271b669c6 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -103,6 +104,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 	int status;
 	u32 temp_out;
 	u32 out;
+	unsigned long update_ptps;
 	u32 store_ptps;
 	u32 store_ptmc;
 	u32 store_te_out;
@@ -120,8 +122,10 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 	if (status)
 		return status;
 
-	out = (store_ptps & ~(0xFF << (thres_index * 8)));
-	out |= (temp_out & 0xFF) << (thres_index * 8);
+	update_ptps = store_ptps;
+	bitmap_set_value8(&update_ptps, temp_out & 0xFF, thres_index * 8);
+	out = update_ptps;
+
 	status = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
 				SOC_DTS_OFFSET_PTPS, out);
 	if (status)
@@ -223,6 +227,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 	u32 out;
 	struct intel_soc_dts_sensor_entry *dts;
 	struct intel_soc_dts_sensors *sensors;
+	unsigned long raw;
 
 	dts = tzd->devdata;
 	sensors = dts->sensors;
@@ -231,8 +236,8 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 	if (status)
 		return status;
 
-	out = (out & dts->temp_mask) >> dts->temp_shift;
-	out -= SOC_DTS_TJMAX_ENCODING;
+	raw = out;
+	out = bitmap_get_value8(&raw, dts->id * 8) - SOC_DTS_TJMAX_ENCODING;
 	*temp = sensors->tj_max - out * 1000;
 
 	return 0;
@@ -280,11 +285,14 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 				int read_only_trip_cnt)
 {
 	char name[10];
+	unsigned long trip;
 	int trip_count = 0;
 	int trip_mask = 0;
+	int writable_trip_cnt = 0;
+	unsigned long ptps;
 	u32 store_ptps;
+	unsigned long i;
 	int ret;
-	int i;
 
 	/* Store status to restor on exit */
 	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
@@ -293,11 +301,10 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 		goto err_ret;
 
 	dts->id = id;
-	dts->temp_mask = 0x00FF << (id * 8);
-	dts->temp_shift = id * 8;
 	if (notification_support) {
 		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
-		trip_mask = BIT(trip_count - read_only_trip_cnt) - 1;
+		writable_trip_cnt = trip_count - read_only_trip_cnt;
+		trip_mask = GENMASK(writable_trip_cnt - 1, 0);
 	}
 
 	/* Check if the writable trip we provide is not used by BIOS */
@@ -306,11 +313,9 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 	if (ret)
 		trip_mask = 0;
 	else {
-		for (i = 0; i < trip_count; ++i) {
-			if (trip_mask & BIT(i))
-				if (store_ptps & (0xff << (i * 8)))
-					trip_mask &= ~BIT(i);
-		}
+		ptps = store_ptps;
+		for_each_set_clump8(i, trip, &ptps, writable_trip_cnt * 8)
+			trip_mask &= ~BIT(i / 8);
 	}
 	dts->trip_mask = trip_mask;
 	dts->trip_count = trip_count;
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
index adfb09af33fc..c54945748200 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -24,8 +24,6 @@ struct intel_soc_dts_sensors;
 
 struct intel_soc_dts_sensor_entry {
 	int id;
-	u32 temp_mask;
-	u32 temp_shift;
 	u32 store_status;
 	u32 trip_mask;
 	u32 trip_count;
-- 
2.23.0

