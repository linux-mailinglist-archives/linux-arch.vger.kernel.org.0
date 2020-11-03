Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298642A4DFC
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgKCSMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42194 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgKCSMG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id a7so23439792lfk.9;
        Tue, 03 Nov 2020 10:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S93dby/jp7jv4MUI4mEuwR4ZWuAyJbbXIVViROFzc9E=;
        b=ix8/rtZMrhZXxmXfx7iG0YoSy9Au2kkBk5Jcitcuz3bWEgSBWQuL5/Pk37ad8OOLUH
         DUSS8EnXcwUSkl+6QpCkdC+sRCQYpVYVhyeXF2q160Dkdftl8TJ9uKH770FFAnYb9ibz
         XAsOKHA0t8gxi2kdPTmBrD9p+R02dpNSr3gi1PXfsp/W8OgwqBIIsUk7P3fj7J3ANH2V
         bxbf7F9o/d9KGRa6HU30QXsFfH0GPW738oTez/ovQaAioWHUxtiO4tfw5omA/1Od2ACV
         xef/eu87J2V3+B2EHVw5UiWi6hKQdTEJY6tC6KX3heEXbPn3BtIuaIYTQXaBy4hHcqj+
         d5yA==
X-Gm-Message-State: AOAM5306X58wO1tu7cZVu30SZIqZyotWLeRrwhq2fddrq2lWwhW/J7vm
        wgY4m2bfMIt5+UIFpRvhNJQm5TDwaX0w/A==
X-Google-Smtp-Source: ABdhPJxT8ZggtFKDC1OxlicGZYYGKQRpSeJxIsq/fh4HsdFQHzRVqsL/ZTEAnjpTQFyx1dLmJhOMAA==
X-Received: by 2002:ac2:5de5:: with SMTP id z5mr7271852lfq.232.1604427123837;
        Tue, 03 Nov 2020 10:12:03 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id l20sm4082156lfc.274.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:12:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mo-0002rq-2V; Tue, 03 Nov 2020 19:12:02 +0100
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
Subject: [PATCH 6/8] params: drop redundant "unused" attributes
Date:   Tue,  3 Nov 2020 18:57:09 +0100
Message-Id: <20201103175711.10731-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
References: <20201103175711.10731-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Drop the redundant "unused" attributes from module-parameter structures
already marked "used".

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/moduleparam.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 6388eb9734a5..742074ad9f6e 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -22,7 +22,7 @@
 
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __UNIQUE_ID(name)[]					  \
-  __used __section(".modinfo") __attribute__((unused, aligned(1)))	  \
+  __used __section(".modinfo") __attribute__((aligned(1)))		  \
   = __MODULE_INFO_PREFIX __stringify(tag) "=" info
 
 #define __MODULE_PARM_TYPE(name, _type)					  \
@@ -289,7 +289,7 @@ struct kparam_array
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used								\
-    __section("__param") __attribute__ ((unused, aligned(sizeof(void *)))) \
+	__section("__param") __attribute__ ((aligned(sizeof(void *))))  \
 	= { __param_str_##name, THIS_MODULE, ops,			\
 	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
 
-- 
2.26.2

