Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83061D1298
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfJIP1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:54 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46885 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbfJIP1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id l64so836663ywe.13;
        Wed, 09 Oct 2019 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2jCX9HgU8ovLftcoHPoUNghHxtBxjaql0cnB+EV6BQ=;
        b=qahE360uiIlbtDHZddvWm3s+DCPMg0f0FjIx2acAZx6w2aB9a2QbyfW8/W3Uj0ZKW2
         l4uq1B83GvcTULuaKhVC//MEX6vTsNnABxwhAL4e+k3vDHCXt7G0j3BkxbaCIKWX/QwV
         aYo66ZUOWtQHUMRMbAB2jYwY++3O9jozzPI724s08fo1Wg31bS6QWQ0c2dekmLiQZG+b
         VdTvivJlEv8OK0XuNKzUzWWWUXu8WdDNQY75WWMUMPmm/urEG0gvVFmR8fNB8o7Fkzy+
         noAS8kqZI7J90en1EYFoNjVqDYCyF/EmmZO6bWWZs2spZd4CxHxx6EYpltED8pvbQD7S
         6sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2jCX9HgU8ovLftcoHPoUNghHxtBxjaql0cnB+EV6BQ=;
        b=ITPrGcNm2ZJdk94cd6f0K//5Ul6bhWlvoPrhvlMHFGb/SuKpmpLenLBGcRZmaJxPOb
         WldmtTdQP+kGb3UsoWiga6bGJuzST79SoKqfbso9o8YM6uMCM5wimW63r3tHekQgxTgS
         hmebKJPoXbmaTSWJVmkcT/xhW0kmFi/hfyiA5DyA00s5TfKc5U9RNGwGGyGXuukQLhhG
         OHLWnT6MFYL7g8U/1eeERXXx1wn0/QtjRaGXKZHYMe5+Y/gRVJHhia9KciOYf5za4Z1/
         Wl7IfyyiT9SQ2TJOLP+4wogbrQowbmW1sDo9rQWxb9Jlmxo/bEBdngFFdCM19DpZFh8a
         eoCQ==
X-Gm-Message-State: APjAAAVODc+IxWWhJNr/S6XADLwraThkYSfRvIQkSeiUcmktP6AegMDL
        Rh1298vjJo1zIyzkiT2R220=
X-Google-Smtp-Source: APXvYqyzRAZCHF/8ARvFvOUXRKfcnL0Fn63nmJwYfOUDFUzK0Ksa8CbCrOtzJly7RODyg9yBZb7Zsg==
X-Received: by 2002:a81:5ed4:: with SMTP id s203mr3058692ywb.485.1570634872003;
        Wed, 09 Oct 2019 08:27:52 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 11/14] thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:09 -0400
Message-Id: <335f1ce6411902dbe492a6b2a51fe479dd0f48a5.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
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

