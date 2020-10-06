Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24BD284B89
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 14:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJFMVF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 08:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgJFMVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 08:21:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D96C0613D2
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 05:21:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so2871706wmj.2
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3LkwJf7/8QhmcT3hOLsXffvH/dghnsDpAfit/51wzXQ=;
        b=BSBu/hXkCC3YXHMWu6O2zl2b1dp50s6lb9wl5j8cAbnVuUEByWMBrXxlwI1/+arpCI
         ob0bDGSZkNY/v1ES93ohvjRopIen6Ihp6RwFiDwRGkm5MQX5gFPOEM6+Lbf/l70OcyGC
         b+Bd5P487zrEUEgaOMRqq4g7eaia9B0uFREyiltNZCKSMn/Rc6Pb0h9u/cZpczyeYrpd
         asPV4kL/1McvD5cbXtfSEtsDbxTMAVu+WHQYNwUpny9g9+yaNjUtBPQVbTHMidi08qZn
         GIliuDNWWYEAWg4LWHhijLCLDlLU9Qa0D0Rm0v5V8Kwz0ePZR/+wlYVveIjKqsL7Z87y
         v1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3LkwJf7/8QhmcT3hOLsXffvH/dghnsDpAfit/51wzXQ=;
        b=qsx9+Y+h6PQNTaobV8VzVgiqVFwFWU8sw/o+6ZSyxEEm1EeZb7tBluh2NVYe0hrAVJ
         QvBAgYUzIRzL/tXI+WYMh1JW1zOCQQrFaG9V/ui1Ukv6gyr1R3wwQI5HvQSs7agaKt3r
         5x4Sj10yaWvts+B3ir++lYdtwY8tzOxp0dEVVzxlTRd2BOZJtalr3XIlQ7ZMo5JEItTG
         9O8g2MU4Pxz3x4sVx/dPB0m8WgE2rfBwGC58XcOsXd8veGLcnT0UuI5YoHfV9pteGq9q
         Cxx9rU8KLSK8ep1QbpRFoad4v0OJR+pUilIhQcxzG/KX6MoQRd8DPYP2tf+ZC73UOZHR
         d1pA==
X-Gm-Message-State: AOAM531mE8Bu/5QK80ZrplcdTcvYCY2MoMYv0+FOTk+KUkXGPpHuxvkZ
        wqwB4GRF2IQsGRqhnXI/sMILtg==
X-Google-Smtp-Source: ABdhPJxjuNltKQw8De00ZDORKuLUL1BKoBr13pUv88wGXfPVhOm/DdkYj4LZwR+wKJAYWxL7LKnpvg==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr4513130wmb.158.1601986863174;
        Tue, 06 Oct 2020 05:21:03 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-130-8.adsl.proxad.net. [82.252.130.8])
        by smtp.gmail.com with ESMTPSA id s19sm3742521wmc.41.2020.10.06.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:21:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH 3/4] powercap/drivers/dtpm: Add API for dynamic thermal power management
Date:   Tue,  6 Oct 2020 14:20:23 +0200
Message-Id: <20201006122024.14539-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006122024.14539-1-daniel.lezcano@linaro.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On the embedded world, the complexity of the SoC leads to an
increasing number of hotspots which need to be monitored and mitigated
as a whole in order to prevent the temperature to go above the
normative and legally stated 'skin temperature'.

Another aspect is to sustain the performance for a given power budget,
for example virtual reality where the user can feel dizziness if the
GPU performance is capped while a big CPU is processing something
else. Or reduce the battery charging because the dissipated power is
too high compared with the power consumed by other devices.

The userspace is the most adequate place to dynamically act on the
different devices by limiting their power given an application
profile: it has the knowledge of the platform.

These userspace daemons are in charge of the Dynamic Thermal Power
Management (DTPM).

Nowadays, the dtpm daemons are abusing the thermal framework as they
act on the cooling device state to force a specific and arbitraty
state without taking care of the governor decisions. Given the closed
loop of some governors that can confuse the logic or directly enter in
a decision conflict.

As the number of cooling device support is limited today to the CPU
and the GPU, the dtpm daemons have little control on the power
dissipation of the system. The out of tree solutions are hacking
around here and there in the drivers, in the frameworks to have
control on the devices. The common solution is to declare them as
cooling devices.

There is no unification of the power limitation unit, opaque states
are used.

This patch provides a way to create a hierarchy of constraints using
the powercap framework. The devices which are registered as power
limit-able devices are represented in this hierarchy as a tree. They
are linked together with intermediate nodes which are just there to
propagate the constraint to the children.

The leaves of the tree are the real devices, the intermediate nodes
are virtual, aggregating the children constraints and power
characteristics.

Each node have a weight on a 2^10 basis, in order to reflect the
percentage of power distribution of the children's node. This
percentage is used to dispatch the power limit to the children.

The weight is computed against the max power of the siblings.

This simple approach allows to do a fair distribution of the power
limit.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig          |   6 +
 drivers/powercap/Makefile         |   1 +
 drivers/powercap/dtpm.c           | 430 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  11 +
 include/linux/dtpm.h              |  73 +++++
 5 files changed, 521 insertions(+)
 create mode 100644 drivers/powercap/dtpm.c
 create mode 100644 include/linux/dtpm.h

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index ebc4d4578339..777cf60300b8 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -43,4 +43,10 @@ config IDLE_INJECT
 	  CPUs for power capping. Idle period can be injected
 	  synchronously on a set of specified CPUs or alternatively
 	  on a per CPU basis.
+
+config DTPM
+	bool "Power capping for dynamic thermal power management"
+	help
+	  This enables support for the power capping for the dynamic
+	  thermal management userspace engine.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 7255c94ec61c..6482ac52054d 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_DTPM) += dtpm.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
new file mode 100644
index 000000000000..6df1e51a2c1c
--- /dev/null
+++ b/drivers/powercap/dtpm.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The powercap based Dynamic Thermal Power Management framework
+ * provides to the userspace a consistent API to set the power limit
+ * on some devices.
+ *
+ * DTPM defines the functions to create a tree of constraints. Each
+ * parent node is a virtual description of the aggregation of the
+ * children. It propagates the constraints set at its level to its
+ * children and collect the children power infomation. The leaves of
+ * the tree are the real devices which have the ability to get their
+ * current power consumption and set their power limit.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dtpm.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/powercap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+static const char *constraint_name[] = {
+	"Instantaneous power constraint",
+};
+
+static struct powercap_control_type *pct;
+static struct dtpm *root;
+
+static int get_time_window_us(struct powercap_zone *pcz, int cid, u64 *window)
+{
+	return -ENOSYS;
+}
+
+static int set_time_window_us(struct powercap_zone *pcz, int cid, u64 window)
+{
+	return -ENOSYS;
+}
+
+static int get_max_power_range_uw(struct powercap_zone *pcz, u64 *max_power_uw)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+
+	spin_lock(&dtpm->lock);
+	*max_power_uw = dtpm->power_max - dtpm->power_min;
+	spin_unlock(&dtpm->lock);
+
+	return 0;
+}
+
+static int get_children_power_uw(struct powercap_zone *pcz, u64 *power_uw)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm *child;
+	u64 power;
+	int ret = 0;
+
+	*power_uw = 0;
+
+	spin_lock(&dtpm->lock);
+	list_for_each_entry(child, &dtpm->children, sibling) {
+		ret = child->zone.ops->get_power_uw(&child->zone, &power);
+		if (ret)
+			break;
+		*power_uw += power;
+	}
+	spin_unlock(&dtpm->lock);
+
+	return ret;
+}
+
+static void __dtpm_rebalance_weight(struct dtpm *dtpm)
+{
+	struct dtpm *child;
+
+	spin_lock(&dtpm->lock);
+	list_for_each_entry(child, &dtpm->children, sibling) {
+
+		pr_debug("Setting weight '%d' for '%s'\n",
+			 child->weight, child->zone.name);
+
+		child->weight = DIV_ROUND_CLOSEST(child->power_max * 1024,
+						  dtpm->power_max);
+
+		__dtpm_rebalance_weight(child);
+	}
+	spin_unlock(&dtpm->lock);
+}
+
+static void dtpm_rebalance_weight(void)
+{
+	__dtpm_rebalance_weight(root);
+}
+
+static void dtpm_sub_power(struct dtpm *dtpm)
+{
+	struct dtpm *parent = dtpm->parent;
+
+	while (parent) {
+		spin_lock(&parent->lock);
+		parent->power_min -= dtpm->power_min;
+		parent->power_max -= dtpm->power_max;
+		spin_unlock(&parent->lock);
+		parent = parent->parent;
+	}
+
+	dtpm_rebalance_weight();
+}
+
+static void dtpm_add_power(struct dtpm *dtpm)
+{
+	struct dtpm *parent = dtpm->parent;
+
+	while (parent) {
+		spin_lock(&parent->lock);
+		parent->power_min += dtpm->power_min;
+		parent->power_max += dtpm->power_max;
+		spin_unlock(&parent->lock);
+		parent = parent->parent;
+	}
+
+	dtpm_rebalance_weight();
+}
+
+/**
+ * dtpm_update_power - Update the power on the dtpm
+ * @dtpm: a pointer to a dtpm structure to update
+ * @power_min: a u64 representing the new power_min value
+ * @power_max: a u64 representing the new power_max value
+ *
+ * Function to update the power values of the dtpm node specified in
+ * parameter. These new values will be propagated to the tree.
+ *
+ * Return: zero on success, -EINVAL if the values are inconsistent
+ */
+int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
+{
+	if (power_min == dtpm->power_min && power_max == dtpm->power_max)
+		return 0;
+
+	if (power_max < power_min)
+		return -EINVAL;
+
+	dtpm_sub_power(dtpm);
+	spin_lock(&dtpm->lock);
+	dtpm->power_min = power_min;
+	dtpm->power_max = power_max;
+	spin_unlock(&dtpm->lock);
+	dtpm_add_power(dtpm);
+
+	return 0;
+}
+
+/**
+ * dtpm_release_zone - Cleanup when the node is released
+ * @pcz: a pointer to a powercap_zone structure
+ *
+ * Do some housecleaning and update the weight on the tree. The
+ * release will be denied if the node has children. This function must
+ * be called by the specific release callback of the different
+ * backends.
+ *
+ * Return: 0 on success, -EBUSY if there are children
+ */
+int dtpm_release_zone(struct powercap_zone *pcz)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm *parent = dtpm->parent;
+
+	if (!list_empty(&dtpm->children))
+		return -EBUSY;
+
+	if (parent) {
+		spin_lock(&parent->lock);
+		list_del(&dtpm->sibling);
+		spin_unlock(&parent->lock);
+	}
+
+	dtpm_sub_power(dtpm);
+
+	kfree(dtpm);
+
+	return 0;
+}
+
+/*
+ * Set the power limit on the nodes, the power limit is distributed
+ * given the weight of the children.
+ */
+static int set_children_power_limit(struct powercap_zone *pcz, int cid,
+				    u64 power_limit)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm *child;
+	u64 power;
+	int ret = 0;
+
+	/*
+	 * Don't allow values outside of the power range previously
+	 * set when initiliazing the power numbers.
+	 */
+	power_limit = clamp_val(power_limit, dtpm->power_min, dtpm->power_max);
+
+	spin_lock(&dtpm->lock);
+	list_for_each_entry(child, &dtpm->children, sibling) {
+
+		/*
+		 * Integer division rounding will inevitably lead to a
+		 * different max value when set several times. In
+		 * order to restore the initial value, we force the
+		 * child's max power every time if the constraint is
+		 * removed by setting a value greater or equal to the
+		 * max power.
+		 */
+		if (power_limit == dtpm->power_max)
+			power = child->power_max;
+		else
+			power = DIV_ROUND_CLOSEST(
+				power_limit * child->weight, 1024);
+
+		pr_debug("Setting power limit for '%s': %llu uW\n",
+			 child->zone.name, power);
+
+		ret = child->zone.constraints->ops->set_power_limit_uw(
+			&child->zone, cid, power);
+		if (ret)
+			break;
+	}
+	spin_unlock(&dtpm->lock);
+
+	return ret;
+}
+
+static int get_children_power_limit(struct powercap_zone *pcz, int cid,
+				    u64 *power_limit)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm *child;
+	u64 power;
+	int ret = 0;
+
+	*power_limit = 0;
+
+	spin_lock(&dtpm->lock);
+	list_for_each_entry(child, &dtpm->children, sibling) {
+		ret = child->zone.constraints->ops->get_power_limit_uw(
+			&child->zone, cid, &power);
+		if (ret)
+			break;
+		*power_limit += power;
+	}
+	spin_unlock(&dtpm->lock);
+
+	return ret;
+}
+
+static const char *get_constraint_name(struct powercap_zone *pcz, int cid)
+{
+	return constraint_name[cid];
+}
+
+static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *max_power)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+
+	spin_lock(&dtpm->lock);
+	*max_power = dtpm->power_max;
+	spin_unlock(&dtpm->lock);
+
+	return 0;
+}
+
+static struct powercap_zone_constraint_ops constraint_ops = {
+	.set_power_limit_uw = set_children_power_limit,
+	.get_power_limit_uw = get_children_power_limit,
+	.set_time_window_us = set_time_window_us,
+	.get_time_window_us = get_time_window_us,
+	.get_max_power_uw = get_max_power_uw,
+	.get_name = get_constraint_name,
+};
+
+static struct powercap_zone_ops zone_ops = {
+	.get_max_power_range_uw = get_max_power_range_uw,
+	.get_power_uw = get_children_power_uw,
+	.release = dtpm_release_zone,
+};
+
+/**
+ * dtpm_alloc - Allocate and initialize a dtpm struct
+ * @name: a string specifying the name of the node
+ *
+ * Return: a struct dtpm pointer, NULL in case of error
+ */
+struct dtpm *dtpm_alloc(void)
+{
+	struct dtpm *dtpm;
+
+	dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
+	if (dtpm) {
+		INIT_LIST_HEAD(&dtpm->children);
+		INIT_LIST_HEAD(&dtpm->sibling);
+		spin_lock_init(&dtpm->lock);
+		dtpm->weight = 1024;
+	}
+
+	return dtpm;
+}
+
+/**
+ * dtpm_unregister - Unregister a dtpm node from the hierarchy tree
+ * @dtpm: a pointer to a dtpm structure corresponding to the node to be removed
+ *
+ * Call the underlying powercap unregister function. That will call
+ * the release callback of the powercap zone.
+ */
+void dtpm_unregister(struct dtpm *dtpm)
+{
+	powercap_unregister_zone(pct, &dtpm->zone);
+}
+
+/**
+ * dtpm_register - Register a dtpm node in the hierarchy tree
+ * @name: a string specifying the name of the node
+ * @dtpm: a pointer to a dtpm structure corresponding to the new node
+ * @parent: a pointer to a dtpm structure corresponding to the parent node
+ * @ops: a pointer to a powercap_zone_ops structure
+ * @nr_constraints: a integer giving the number of constraints supported
+ * @const_ops: a pointer to a powercap_zone_constraint_ops structure
+ *
+ * Create a dtpm node in the tree. If no parent is specified, the node
+ * is the root node of the hierarchy. If the root node already exists,
+ * then the registration will fail. The powercap controller must be
+ * initialized before calling this function.
+ *
+ * The dtpm structure must be initialized with the power numbers
+ * before calling this function.
+ *
+ * Return: zero on success, a negative value in case of error:
+ *  -EAGAIN: the function is called before the framework is initialized.
+ *  -EBUSY: the root node is already inserted
+ *  -EINVAL: there is no root node yet and @parent is specified
+ *   Other negative values are reported back from the powercap framework
+ */
+int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent,
+		  struct powercap_zone_ops *ops, int nr_constraints,
+		  struct powercap_zone_constraint_ops *const_ops)
+{
+	struct powercap_zone *pcz;
+
+	if (!pct)
+		return -EAGAIN;
+
+	if (root && !parent)
+		return -EBUSY;
+
+	if (!root && parent)
+		return -EINVAL;
+
+	const_ops->get_name = get_constraint_name;
+	const_ops->get_max_power_uw = get_max_power_uw;
+	const_ops->set_time_window_us = set_time_window_us;
+	const_ops->get_time_window_us = get_time_window_us;
+
+	ops->get_max_power_range_uw = get_max_power_range_uw;
+
+	pcz = powercap_register_zone(&dtpm->zone, pct, name,
+				     parent ? &parent->zone : NULL,
+				     ops, nr_constraints, const_ops);
+	if (IS_ERR(pcz))
+		return PTR_ERR(pcz);
+
+	if (parent) {
+		spin_lock(&parent->lock);
+		list_add_tail(&dtpm->sibling, &parent->children);
+		spin_unlock(&parent->lock);
+		dtpm->parent = parent;
+	} else {
+		root = dtpm;
+	}
+
+	dtpm_add_power(dtpm);
+
+	return 0;
+}
+
+/**
+ * dtpm_register_parent - Register a intermediate node in the tree
+ * @name: a string specifying the name of the node
+ * @dtpm: a pointer to a dtpm structure corresponding to the new node
+ * @parent: a pointer to a dtpm structure corresponding parent's new node
+ *
+ * The function will add an intermediate node corresponding to a
+ * parent to more nodes. Its purpose is to aggregate the children
+ * characteristics and dispatch the constraints. If the @parent
+ * parameter is NULL, then this node becomes the root node of the tree
+ * if there is no root node yet.
+ *
+ * Return: zero on success, a negative value in case of error:
+ *  -EAGAIN: the function is called before the framework is initialized.
+ *  -EBUSY: the root node is already inserted
+ *  -EINVAL: there is not root node yet and @parent is specified
+ *   Other negative values are reported back from the powercap framework
+ */
+int dtpm_register_parent(const char *name, struct dtpm *dtpm,
+			 struct dtpm *parent)
+{
+	return dtpm_register(name, dtpm, parent, &zone_ops,
+			     MAX_DTPM_CONSTRAINTS, &constraint_ops);
+}
+
+static int __init dtpm_init(void)
+{
+	struct dtpm_descr **dtpm_descr;
+
+	pct = powercap_register_control_type(NULL, "dtpm", NULL);
+	if (!pct) {
+		pr_err("Failed to register control type\n");
+		return -EINVAL;
+	}
+
+	for_each_dtpm_table(dtpm_descr)
+		(*dtpm_descr)->init(*dtpm_descr);
+
+	return 0;
+}
+late_initcall(dtpm_init);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430febd34be..29b30976ea02 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -315,6 +315,16 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_DTPM
+#define DTPM_TABLE()							\
+	. = ALIGN(8);							\
+	__dtpm_table = .;						\
+	KEEP(*(__dtpm_table))						\
+	__dtpm_table_end = .;
+#else
+#define DTPM_TABLE()
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -715,6 +725,7 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
+	DTPM_TABLE()							\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
new file mode 100644
index 000000000000..6696bdcfdb87
--- /dev/null
+++ b/include/linux/dtpm.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#ifndef ___DTPM_H__
+#define ___DTPM_H__
+
+#include <linux/of.h>
+#include <linux/powercap.h>
+
+#define MAX_DTPM_DESCR 8
+#define MAX_DTPM_CONSTRAINTS 1
+
+struct dtpm {
+	struct powercap_zone zone;
+	struct dtpm *parent;
+	struct list_head sibling;
+	struct list_head children;
+	spinlock_t lock;
+	u64 power_limit;
+	u64 power_max;
+	u64 power_min;
+	int weight;
+	void *private;
+};
+
+struct dtpm_descr;
+
+typedef int (*dtpm_init_t)(struct dtpm_descr *);
+
+struct dtpm_descr {
+	struct dtpm *parent;
+	const char *name;
+	dtpm_init_t init;
+};
+
+/* Init section thermal table */
+extern struct dtpm_descr *__dtpm_table[];
+extern struct dtpm_descr *__dtpm_table_end[];
+
+#define DTPM_TABLE_ENTRY(name)			\
+	static typeof(name) *__dtpm_table_entry_##name	\
+	__used __section(__dtpm_table) = &name
+
+#define DTPM_DECLARE(name)	DTPM_TABLE_ENTRY(name)
+
+#define for_each_dtpm_table(__dtpm)	\
+	for (__dtpm = __dtpm_table;	\
+	     __dtpm < __dtpm_table_end;	\
+	     __dtpm++)
+
+static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
+{
+	return container_of(zone, struct dtpm, zone);
+}
+
+int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max);
+
+int dtpm_release_zone(struct powercap_zone *pcz);
+
+struct dtpm *dtpm_alloc(void);
+
+void dtpm_unregister(struct dtpm *dtpm);
+
+int dtpm_register_parent(const char *name, struct dtpm *dtpm,
+			 struct dtpm *parent);
+
+int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent,
+		  struct powercap_zone_ops *ops, int nr_constraints,
+		  struct powercap_zone_constraint_ops *const_ops);
+#endif
-- 
2.17.1

