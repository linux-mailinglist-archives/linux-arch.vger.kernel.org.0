Return-Path: <linux-arch+bounces-12450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA50AE7B12
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460F23AB21E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865B2868AA;
	Wed, 25 Jun 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPkRTUuU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E528935D
	for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841873; cv=none; b=qV4Hp44ZRB5loyg2plXnmFMClGhVPE+oljLpWHDzKvA/cx+xC22JeuSuPPwuPEM/uJ3WSJ5Tb5KuteDhllumx6VvN1mH1psvO/XjY/qjIc0rGh1gzd4RWkjZZ+23azm+idjaQHb4Z372qkgR2TPs0jx59h0Tu5wJL//mBu5aIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841873; c=relaxed/simple;
	bh=B8VTcpsowDz3sev4yfwaePzneci0l6MQ4WF5zwPGjZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JGBk5KktoLjofnliIdA1BoT1eFXOWNG6Lag8Idv3PNWXqjGtD2E8b4dQYeJl5Bkc3iQqBwy+NnhjjniVsiYJNTWmBk9hcVttvohtBno1EwHlqIYht59y2gno01EedcBfiZVUK29oa6l/LKp+xuw/4d6uFJjROiYhJuMdPXlGrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPkRTUuU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso8635495e9.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750841869; x=1751446669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SADKG0uwMn26DRziP1/OCZLA535poEGj5OLmu5EiSm0=;
        b=aPkRTUuUiOYRsgOtEETbIG+3uIAmckArv+gsDYQgqvflM82jAwvZFCiQNgej0AtRLD
         QVGAC2vYkajfj221nuNUah699iR/l/8dQfiNx2yX/x7xSf5ZQy1BlZWfa2y82BwnHvEl
         P1LkPwCtA4cX1xhepVhAIBa9EL0YG2wMqmlTAn3SbadyGaHGQn9uGO7J8E1ijkDBMPqw
         wXkUBzneXaT9AinHQwLLdeELANn+/dCufYegD8+iq0SqyekfCtKxxdLgE3+rIsyDEP2V
         07qEEVMqTYJ3k39UCJzhc+Jkq4rNpB8T6E3hZM3LsL4B8CA6G0Tag8R1UQ4Du9M2L6zd
         0TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841869; x=1751446669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SADKG0uwMn26DRziP1/OCZLA535poEGj5OLmu5EiSm0=;
        b=vhyDtb6RRGjYmXwZCxk9QXltttbyIBpZktjlunxAy6eECGP8SvfBZZv/2aXonWvI4Q
         XFuB4ASFdVqVRWVfWb5scr0NnyFcDoi5zzvpNMAG3HnwJiflGDcIMJeSdrP9+gtqERW+
         nrh1EfLVqYCvQon77dF6TojVkakOuxvGd8/hzdoyWnCDfbf195ZcYZ25uoaZgcDNi3cK
         UpeHq0kCCft4NLTXBLxvggd672lENaALEY2qma5LP2s9wQWih8v+BxrB9unv5+c254lC
         5LJ9D60fJLvrXgY5juHr9FJ5PZivxA3/6Tw/KlDsrCAoeqpfnmiTEc/CiP7XZyZ2eMuy
         wSQA==
X-Forwarded-Encrypted: i=1; AJvYcCXPP5dxS+AZvcmiUYWm9S3PiWMgnqXqEGd2/0gDGAde/l/bPK8R3MiPtCp5nZPPFdx/eYs57ZjDcVkT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48A7Hhs6jUZI2JlUKH8xR4ldrIJY6PhBgOOCTYOtBEBEpICLj
	O4Pwv0LW8VIBQpFa3flZjseRjkXYW/2mRa+/GhuwCZBJrpEo5pllrQWqaKPOeToco0s=
X-Gm-Gg: ASbGnctpwlRem6WyApIVXRQy/JwkkPcu+HMnSdmSh33Wvun9V9YmFMxqdsbag3GNLZv
	PhBY2hR5Dv+uh5M2u+u0Tkn7pEr7yppso83dGiQ1LHRc+kyQCrzpWPcGsZGngg2j4l1mDglQycz
	r/Uo/txTu1BdCmNLNLWarhTbKyPhU3fkPteILYF12ga3m0q+rjjkl9P3XT7lOoZkAa1kJ/YBsTs
	ak8T0x7pJD+4t2Or8HF0gNTNanxh2IJsCruZNY0eiZw1aAuZHECaCHZ3no94dcBu6/AWKIHhupS
	6jKOQFIK9Q8ijqS/pRysOp7/AVr3KzPO+EeWxPRlX2Wn/qfjmTuH0SQhJPT6OfZgQwnXsj2BQqc
	fChsCVd/7ia1IUGapXxYhkU0=
X-Google-Smtp-Source: AGHT+IHzMVJfrHXCjXHshtclnrE/v4KUBBCxErF0KOKyfY0QaR4ysz5FmsebbjYtC5zGTYdLAylaCA==
X-Received: by 2002:a05:600c:4594:b0:450:c20d:64c3 with SMTP id 5b1f17b1804b1-45381ae454fmr21365925e9.18.1750841869300;
        Wed, 25 Jun 2025 01:57:49 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234db3bsm13205945e9.16.2025.06.25.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:57:48 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	lorenzo.pieralisi@linaro.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
Subject: [PATCH RFC] timer: of: Create a platform_device before the framework is initialized
Date: Wed, 25 Jun 2025 10:57:15 +0200
Message-ID: <20250625085715.889837-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the context of the time keeping and the timers, some platforms have
timers which need to be initialized very early. It is the case of the
ARM platform which do not have the architected timers.

The macro TIMER_OF_DECLARE adds an entry in the timer init functions
array at compile time and the function timer_probe is called from the
timer_init() function in kernel/time.c

This array contains a t-uple with the init function and the compatible
string.

The init function has a device node pointer parameter.

The timer_probe() function browses the of nodes and find the ones
matching the compatible string given when using the TIMER_OF_DECLARE
macro. It then calls the init function with the device node as a
pointer.

But there are some platforms where there are multiple timers like the
ARM64 with the architected timers. Those are always initialized very
early and the other timers can be initialized later.

For this reason we find timer drivers with the platform_driver
incarnation. Consequently their init functions are different, they
have a platform_device pointer parameter and rely on the devm_
function for rollbacking.

To summarize, we have:
 - TIMER_OF_DECLARE with init function prototype:
   int (*init)(struct device_node *np);

 - module_platform_driver (and variant) with the probe function
   prototype:
   int (*init)(struct platform_device *pdev);

The current situation with the timers is the following:

 - Two platforms can have the same timer hardware, hence the same
   driver but one without alternate timers and the other with multiple
   timers. For example, the Exynos platform has only the Exynos MCT on
   ARM but has the architeched timers in addition on the ARM64.

 - The timer drivers can be modules now which was not the case until
   recently. TIMER_OF_DECLARE do not allow the build as a module.

It results in duplicate init functions (one with rollback and one with
devm_) and different way to declare the driver (TIMER_OF_DECLARE and
module_platform_driver).

This proposed change is to unify the prototyping of the init functions
to receive a platform_device pointer as parameter. Consequently, it
will allow a smoother and nicer module conversion and a huge cleanup
of the init functions by removing all the rollback code from all the
timer drivers. It introduces a TIMER_OF_DECLARE_PDEV macro.

If the macro is used a platform_device is manually allocated and
initialized with the needed information for the probe
function. Otherwise module_platform_driver can be use instead with the
same probe function without the timer_probe() initialization.

I don't have an expert knowledge of the platform_device internal
subtilitie so I'm not sure if this approach is valid. However, it has
been tested on a Rockchip board with the "rockchip,rk3288-timer" and
verified the macro and the devm_ rollback work correctly.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-probe.c | 61 ++++++++++++++++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 +
 include/linux/clocksource.h       |  3 ++
 include/linux/of.h                |  5 +++
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index b7860bc0db4b..6b2b341b8c95 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -7,13 +7,18 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource.h>
+#include <linux/platform_device.h>
 
 extern struct of_device_id __timer_of_table[];
+extern struct of_device_id __timer_pdev_of_table[];
 
 static const struct of_device_id __timer_of_table_sentinel
 	__used __section("__timer_of_table_end");
 
-void __init timer_probe(void)
+static const struct of_device_id __timer_pdev_of_table_sentinel
+	__used __section("__timer_pdev_of_table_end");
+
+static int __init timer_of_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
@@ -38,6 +43,60 @@ void __init timer_probe(void)
 		timers++;
 	}
 
+	return timers;
+}
+
+static int __init timer_pdev_of_probe(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	const struct of_device_id *match;
+	of_init_fn_pdev init_func;
+	unsigned int timers = 0;
+	int ret;
+
+	for_each_matching_node_and_match(np, __timer_pdev_of_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		init_func = match->data;
+
+		pdev = platform_device_alloc(of_node_full_name(np), -1);
+		if (!pdev)
+			continue;
+
+		ret = device_add_of_node(&pdev->dev, np);
+		if (ret) {
+			platform_device_put(pdev);
+			continue;
+		}
+
+		dev_set_name(&pdev->dev, pdev->name);
+
+		ret = init_func(pdev);
+		if (!ret) {
+			timers++;
+			continue;
+		}
+
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to initialize '%pOF': %d\n", np,
+			       ret);
+
+		device_remove_of_node(&pdev->dev);
+
+		platform_device_put(pdev);
+	}
+
+	return timers;
+}
+
+void __init timer_probe(void)
+{
+	unsigned timers = 0;
+
+	timers += timer_of_probe();
+	timers += timer_pdev_of_probe();
 	timers += acpi_probe_device_table(timer);
 
 	if (!timers)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa5f19b8d53a..97606499c8d7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -318,6 +318,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	KEEP(*(__##name##_of_table_end))
 
 #define TIMER_OF_TABLES()	OF_TABLE(CONFIG_TIMER_OF, timer)
+#define TIMER_PDEV_OF_TABLES()	OF_TABLE(CONFIG_TIMER_OF, timer_pdev)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
@@ -714,6 +715,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	TIMER_OF_TABLES()						\
+	TIMER_PDEV_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c3..0eeabd207040 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -289,6 +289,9 @@ extern int clocksource_i8253_init(void);
 #define TIMER_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1_RET(timer, name, compat, fn)
 
+#define TIMER_OF_DECLARE_PDEV(name, compat, fn) \
+	OF_DECLARE_PDEV(timer_pdev, name, compat, fn)
+
 #ifdef CONFIG_TIMER_PROBE
 extern void timer_probe(void);
 #else
diff --git a/include/linux/of.h b/include/linux/of.h
index a62154aeda1b..a312a6f5ecc1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1540,9 +1540,12 @@ static inline int of_get_available_child_count(const struct device_node *np)
 	_OF_DECLARE_STUB(table, name, compat, fn, fn_type)
 #endif
 
+struct platform_device;
+
 typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
 typedef int (*of_init_fn_1_ret)(struct device_node *);
 typedef void (*of_init_fn_1)(struct device_node *);
+typedef int (*of_init_fn_pdev)(struct platform_device *);
 
 #define OF_DECLARE_1(table, name, compat, fn) \
 		_OF_DECLARE(table, name, compat, fn, of_init_fn_1)
@@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
 		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
 #define OF_DECLARE_2(table, name, compat, fn) \
 		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
+#define OF_DECLARE_PDEV(table, name, compat, fn) \
+		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
 
 /**
  * struct of_changeset_entry	- Holds a changeset entry
-- 
2.43.0


