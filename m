Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2772C0336
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgKWKZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:25:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43869 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgKWKZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:25:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id d17so22957745lfq.10;
        Mon, 23 Nov 2020 02:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S93dby/jp7jv4MUI4mEuwR4ZWuAyJbbXIVViROFzc9E=;
        b=XPL7/T/ojI+5iIAMJ1a/m/51tO90zbUyrUwGUn780Sfw0ygNysVqYOE1r4l5oqsTa7
         6o85OGXpAug4HGZ27KJdO9zghB2Wkn/T0UGoFwU3xexXgFpJ9tNa9OuzcuoG11BOtY6t
         QYSNd+I/QBQzT/zgUEYM5OPEQbM2COw4mFmMx+YGRmAqvH5CkrtEQWmTEqlEAJsf2Oha
         48odsdaFAahL7R8hAhR8i1W0nMbP7aE+6sI/Yy58EQTmRmLI/7O6ZEKtTYNSO9KJkhB5
         vrlSVk2GiN7dJLPdnK3+ni+yBsuFFVJges0oz8rV9AwfUF9w74rOhWol9vWc6oyhubIP
         UHTQ==
X-Gm-Message-State: AOAM530tQOqFi8i7TDc7GumglYQaJc1SThl4LNK2qVpepatbMNG+Txkg
        AWaT4ByVPoZb9YWXdg/ENyM=
X-Google-Smtp-Source: ABdhPJxf/6p0jGHH0wODj5yk5BOpcAmqRwuv5scv8LhxdZCxpCZKNruHXr+u5rk9NAYdWDVKJLw33g==
X-Received: by 2002:a05:6512:3a6:: with SMTP id v6mr11785861lfp.90.1606127097313;
        Mon, 23 Nov 2020 02:24:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id d12sm1336284lfa.22.2020.11.23.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:24:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kh91q-00028B-Jc; Mon, 23 Nov 2020 11:25:02 +0100
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
Subject: [PATCH v2 6/8] params: drop redundant "unused" attributes
Date:   Mon, 23 Nov 2020 11:23:17 +0100
Message-Id: <20201123102319.8090-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123102319.8090-1-johan@kernel.org>
References: <20201123102319.8090-1-johan@kernel.org>
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

