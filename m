Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3032C0330
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgKWKY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:24:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43868 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKWKY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:24:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id d17so22957575lfq.10;
        Mon, 23 Nov 2020 02:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUNXO1DwR5HIzR7mfNr6uLtZahlQ6vLAvdq4FQ2hTds=;
        b=UHRKm9OqjAMARxVzLQFk4xdtLDmgVkls3xrpADwI/xzI/dtFhelym4QWD/uxzBzl2/
         GwCcBIt8XQyXYu/BEQ9+xx4HruIQ81CL61Nh2D4E80tXjQnCz36UPcjoPTepgObBwyrK
         o1wG7JrHdYN8ElJo7rhs4ibbAmi0a/ug0v9U6Zw1VtMkICTI7icgJ1YtliDK7Ox76+YP
         4sCvy6H9zY86P7ON/2gtpw6jcg7Y4MKQ2PK2YRzLuzJexu9TDy1EkL/yM29LM4kCcyUD
         vN33FafDj30h6lbFkxgHsUn80szx0M6HHqwW+1jMsWfZW7sjDQXSY4jfaOzM5w/FrHxA
         YI1Q==
X-Gm-Message-State: AOAM532BHDvVJxjwmxcXUfWl7boUxu2UcLsas4/aQTZiGgnl5zgSnDGc
        LsySUOnFblVGr2DnpN/33/o=
X-Google-Smtp-Source: ABdhPJydEcaFoMaC0KFpHCaN/kBccR3FoV+qEOC8o2Nrg4OdG9QwOfoHGxEGJO1w/Wx4vFwEAZWW9Q==
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr1668875lfp.134.1606127094648;
        Mon, 23 Nov 2020 02:24:54 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id o14sm1335967lfo.258.2020.11.23.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:24:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kh91q-00027r-7O; Mon, 23 Nov 2020 11:25:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
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
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/8] earlycon: simplify earlycon-table implementation
Date:   Mon, 23 Nov 2020 11:23:13 +0100
Message-Id: <20201123102319.8090-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123102319.8090-1-johan@kernel.org>
References: <20201123102319.8090-1-johan@kernel.org>
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

gcc can increase the alignment of larger objects with static extent as
an optimisation, but this can be suppressed by using the aligned
attribute when declaring variables.

Note that we have been relying on this behaviour for kernel parameters
for 16 years and it indeed hasn't changed since the introduction of the
aligned attribute in gcc-3.1.

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

