Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957522A4E00
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgKCSM0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33664 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgKCSMD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id m8so14034569ljj.0;
        Tue, 03 Nov 2020 10:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KBLghtZ420Ru5TtsLIZ3CUl6d4/Pr8c2e31nM972Ds=;
        b=WuVouau6jCuV+zSHVCus1QXbICdcMldRXtQRvQjLfRstmAmMpCtAiZo4VJhoYH33Qx
         fdwl6+uBfpOwX3OClZ448PXv6ZHMkWluXcmKQTjFP93pr1KE/5gbMXi5rBQsiNgU5Ryc
         2kDIQs6CtNmh6p0jjX+HbJqps487IcRKMjFnirERYfl776rr6MP1wW6Y0p2sdKZ9H9qb
         c7t8viqW8lrbYPQkaBB2tuDYnJB5TEnnvQT0wtqx/PxS5RdcG8lrYkYznDk1ClW8BXTd
         UOuGJ29tfs6/ZEj3eS9nqLErrKtzxI3LCmeZSpqkKG5rnpmJkaulycic35pBLTiekYCY
         PG3Q==
X-Gm-Message-State: AOAM5329OUp881GbZ6HZyX7WNVI/daMaDL3ORRtq3CJ32pDjIbuRFHPL
        9gceD31Kq/9I/Uc3lllKaIQ4fnbc2TztGQ==
X-Google-Smtp-Source: ABdhPJwQY8m/cWMaC3eDdLZZZIDEtwzCciIQWmKIp7GpVEiKr0cdfoZUUsLulnMKBfdNiza45agBZw==
X-Received: by 2002:a2e:8143:: with SMTP id t3mr9710944ljg.29.1604427121364;
        Tue, 03 Nov 2020 10:12:01 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f6sm3745346lfk.104.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:11:59 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mn-0002rW-Mx; Tue, 03 Nov 2020 19:12:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/8] earlycon: simplify earlycon-table implementation
Date:   Tue,  3 Nov 2020 18:57:05 +0100
Message-Id: <20201103175711.10731-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
References: <20201103175711.10731-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of using the array-of-pointers trick to avoid having gcc mess up
the earlycon array stride, specify type alignment when declaring entries
to prevent gcc from increasing alignment.

This is essentially an alternative (one-line) fix to the problem
addressed by commit dd709e72cb93 ("earlycon: Use a pointer table to fix
__earlycon_table stride").

Note that we have been relying on this gcc behaviour for kernel
parameters for 16 years and it indeed hasn't changed since the
introduction of the aligned attribute in gcc-3.1.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/of/fdt.c              |  7 ++-----
 drivers/tty/serial/earlycon.c |  6 ++----
 include/linux/serial_core.h   | 20 +++++++-------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4602e467ca8b..feb0f2d67fc5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -906,7 +906,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
 	int offset;
 	const char *p, *q, *options = NULL;
 	int l;
-	const struct earlycon_id **p_match;
+	const struct earlycon_id *match;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -933,10 +933,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
 		return 0;
 	}
 
-	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
-	     p_match++) {
-		const struct earlycon_id *match = *p_match;
-
+	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
 		if (!match->compatible[0])
 			continue;
 
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index b70877932d47..57c70851f22a 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -175,7 +175,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
  */
 int __init setup_earlycon(char *buf)
 {
-	const struct earlycon_id **p_match;
+	const struct earlycon_id *match;
 	bool empty_compatible = true;
 
 	if (!buf || !buf[0])
@@ -185,9 +185,7 @@ int __init setup_earlycon(char *buf)
 		return -EALREADY;
 
 again:
-	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
-	     p_match++) {
-		const struct earlycon_id *match = *p_match;
+	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
 		size_t len = strlen(match->name);
 
 		if (strncmp(buf, match->name, len))
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index ff63c2963359..3e32b788c28d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -357,8 +357,8 @@ struct earlycon_id {
 	int	(*setup)(struct earlycon_device *, const char *options);
 };
 
-extern const struct earlycon_id *__earlycon_table[];
-extern const struct earlycon_id *__earlycon_table_end[];
+extern const struct earlycon_id __earlycon_table[];
+extern const struct earlycon_id __earlycon_table_end[];
 
 #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
 #define EARLYCON_USED_OR_UNUSED	__used
@@ -366,19 +366,13 @@ extern const struct earlycon_id *__earlycon_table_end[];
 #define EARLYCON_USED_OR_UNUSED	__maybe_unused
 #endif
 
-#define _OF_EARLYCON_DECLARE(_name, compat, fn, unique_id)		\
-	static const struct earlycon_id unique_id			\
-	     EARLYCON_USED_OR_UNUSED __initconst			\
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name) \
+		EARLYCON_USED_OR_UNUSED  __section("__earlycon_table")  \
+		__aligned(__alignof__(struct earlycon_id))		\
 		= { .name = __stringify(_name),				\
 		    .compatible = compat,				\
-		    .setup = fn  };					\
-	static const struct earlycon_id EARLYCON_USED_OR_UNUSED		\
-		__section("__earlycon_table")				\
-		* const __PASTE(__p, unique_id) = &unique_id
-
-#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
-	_OF_EARLYCON_DECLARE(_name, compat, fn,				\
-			     __UNIQUE_ID(__earlycon_##_name))
+		    .setup = fn };
 
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
-- 
2.26.2

