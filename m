Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66A65B751
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 22:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjABVIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 16:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjABVIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 16:08:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B179584;
        Mon,  2 Jan 2023 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672693708; x=1704229708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cwb3rk76mKcuAAIqaIEWVNSPLpikCEBD6s7ETGbC0Go=;
  b=F1IE/Pa+bCTfl3aHEez/arlyxZJjqYwTmxDYDB5NVs3JgjDZ8xqUAswd
   zOXXu3RlENMn8TIS311SuVw6lXj589HzuxuPAvja3++yq9h9IDYVLlTZw
   k+aRgZdEX7i2q76o0eBphTxy6pYzRjG+4KlcGhQG2nVbP+5dJ3OBwxoHK
   oM07eqt/+iA+mIouyFs5o1l10tBmNNG+V7U6Dsc5VjMy8+cfrWOUanr+B
   O+eKMpaqi+sVpQvIq3viwW7Gx9ZHcB1z+WdrfivpAMqWtxKvfbDIb9NtK
   IFjaWWLulsk+JEbki/h8n53OxNLR8tHPG5guHwmSaBc9fF0CTAPAQTilB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322774726"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="322774726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 13:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604617569"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="604617569"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Jan 2023 13:08:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 176B4F4; Mon,  2 Jan 2023 23:08:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 1/1] gpio: Remove unused and obsoleted gpio_export_link()
Date:   Mon,  2 Jan 2023 23:08:50 +0200
Message-Id: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

gpio_export_link() is legacy and unused API, remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/legacy.rst                 | 9 ---------
 .../translations/zh_CN/driver-api/gpio/legacy.rst        | 8 --------
 Documentation/translations/zh_TW/gpio.txt                | 9 ---------
 include/asm-generic/gpio.h                               | 6 ------
 include/linux/gpio.h                                     | 8 --------
 5 files changed, 40 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index e17910cc3271..e3e9d26a60ce 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -735,10 +735,6 @@ requested using gpio_request()::
 	/* reverse gpio_export() */
 	void gpio_unexport();
 
-	/* create a sysfs link to an exported GPIO node */
-	int gpio_export_link(struct device *dev, const char *name,
-		unsigned gpio)
-
 After a kernel driver requests a GPIO, it may only be made available in
 the sysfs interface by gpio_export().  The driver can control whether the
 signal direction may change.  This helps drivers prevent userspace code
@@ -748,11 +744,6 @@ This explicit exporting can help with debugging (by making some kinds
 of experiments easier), or can provide an always-there interface that's
 suitable for documenting as part of a board support package.
 
-After the GPIO has been exported, gpio_export_link() allows creating
-symlinks from elsewhere in sysfs to the GPIO sysfs node.  Drivers can
-use this to provide the interface under their own device in sysfs with
-a descriptive name.
-
 
 API Reference
 =============
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index 6399521d0548..8599e253fcc5 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -672,10 +672,6 @@ GPIO 控制器的路径类似 /sys/class/gpio/gpiochip42/ (对于从#42 GPIO
 	/* gpio_export()的逆操作 */
 	void gpio_unexport();
 
-	/* 创建一个 sysfs 连接到已导出的 GPIO 节点 */
-	int gpio_export_link(struct device *dev, const char *name,
-		unsigned gpio)
-
 在一个内核驱动申请一个 GPIO 之后，它可以通过 gpio_export()使其在 sysfs
 接口中可见。该驱动可以控制信号方向是否可修改。这有助于防止用户空间代码无意间
 破坏重要的系统状态。
@@ -683,10 +679,6 @@ GPIO 控制器的路径类似 /sys/class/gpio/gpiochip42/ (对于从#42 GPIO
 这个明确的导出有助于(通过使某些实验更容易来)调试，也可以提供一个始终存在的接口，
 与文档配合作为板级支持包的一部分。
 
-在 GPIO 被导出之后，gpio_export_link()允许在 sysfs 文件系统的任何地方
-创建一个到这个 GPIO sysfs 节点的符号链接。这样驱动就可以通过一个描述性的
-名字，在 sysfs 中他们所拥有的设备下提供一个(到这个 GPIO sysfs 节点的)接口。
-
 
 API参考
 =======
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index e3c076dd75a5..abd8e4c0973e 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -634,18 +634,9 @@ GPIO 控制器的路徑類似 /sys/class/gpio/gpiochip42/ (對於從#42 GPIO
 	/* gpio_export()的逆操作 */
 	void gpio_unexport();
 
-	/* 創建一個 sysfs 連接到已導出的 GPIO 節點 */
-	int gpio_export_link(struct device *dev, const char *name,
-		unsigned gpio)
-
 在一個內核驅動申請一個 GPIO 之後，它可以通過 gpio_export()使其在 sysfs
 接口中可見。該驅動可以控制信號方向是否可修改。這有助於防止用戶空間代碼無意間
 破壞重要的系統狀態。
 
 這個明確的導出有助於(通過使某些實驗更容易來)調試，也可以提供一個始終存在的接口，
 與文檔配合作爲板級支持包的一部分。
-
-在 GPIO 被導出之後，gpio_export_link()允許在 sysfs 文件系統的任何地方
-創建一個到這個 GPIO sysfs 節點的符號連結。這樣驅動就可以通過一個描述性的
-名字，在 sysfs 中他們所擁有的設備下提供一個(到這個 GPIO sysfs 節點的)接口。
-
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index a7752cf152ce..f79220f614aa 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -103,12 +103,6 @@ static inline int gpio_export(unsigned gpio, bool direction_may_change)
 	return gpiod_export(gpio_to_desc(gpio), direction_may_change);
 }
 
-static inline int gpio_export_link(struct device *dev, const char *name,
-				   unsigned gpio)
-{
-	return gpiod_export_link(dev, name, gpio_to_desc(gpio));
-}
-
 static inline void gpio_unexport(unsigned gpio)
 {
 	gpiod_unexport(gpio_to_desc(gpio));
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 346f60bbab30..e94815b3ce1d 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -197,14 +197,6 @@ static inline int gpio_export(unsigned gpio, bool direction_may_change)
 	return -EINVAL;
 }
 
-static inline int gpio_export_link(struct device *dev, const char *name,
-				unsigned gpio)
-{
-	/* GPIO can never have been exported */
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 static inline void gpio_unexport(unsigned gpio)
 {
 	/* GPIO can never have been exported */
-- 
2.35.1

