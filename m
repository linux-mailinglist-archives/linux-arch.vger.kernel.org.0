Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915A52C033E
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKWKZI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:25:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44227 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgKWKZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:25:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id d20so7105035lfe.11;
        Mon, 23 Nov 2020 02:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyGoxRTFxoN3CcXdLX3OQwBVVHqEtKepL93LP6Dv6QA=;
        b=OE+KIeqgCGVJlCOpBED4oW7Ho0krS1kdfAYjCG4J2tTM+dGyH6J50nCrKL9hddNF+A
         bfMqWw5prwWFwq9MmILkyq6z6tAJYyebKHCkCg5uNFv7KHEEoJNboqZ+Kz/cO70IA8et
         6wpcvU3U0NE+JsNoCKzik9pEZRkkcSyLekoJt7C0tJaBLYnXwrajDfVuMzno+7qaIwei
         iPauvfCqBpKNlASI0w4BAnIKsx5PANmNNygE9Jj+6BC9TKk53HxR7V81Skllxws+SHQY
         5FtIvb43YQKEua0CXBu5cQs4CJebzZxwR92e6dXIFgRCLkeNyqEijUZicDTmv/AeBfi6
         +0PA==
X-Gm-Message-State: AOAM5330GtawGKbUnA7ztgGJ1yYnBNr0SyqFKIPoWrK4G2C+QZRphemj
        fIBgdMHRPQ93WBtapVkemvqFiWbWum5Rog==
X-Google-Smtp-Source: ABdhPJwl8WMWawBdVsNJWOHAvxz3cvEnNqeVuuYH2D1bUXik+AgYZGIqav0dRAEa9yNytSMyPFebDg==
X-Received: by 2002:a19:910b:: with SMTP id t11mr1687236lfd.306.1606127097818;
        Mon, 23 Nov 2020 02:24:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y17sm425927ljc.50.2020.11.23.02.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:24:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kh91q-00028L-QS; Mon, 23 Nov 2020 11:25:02 +0100
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
Subject: [PATCH v2 8/8] params: clean up module-param macros
Date:   Mon, 23 Nov 2020 11:23:19 +0100
Message-Id: <20201123102319.8090-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123102319.8090-1-johan@kernel.org>
References: <20201123102319.8090-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Clean up the module-param macros by adding some indentation and using
the __aligned() macro to improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/moduleparam.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 15ecc6cc3a3b..eed280fae433 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -21,12 +21,12 @@
 #define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
 
 #define __MODULE_INFO(tag, name, info)					  \
-static const char __UNIQUE_ID(name)[]					  \
-  __used __section(".modinfo") __attribute__((aligned(1)))		  \
-  = __MODULE_INFO_PREFIX __stringify(tag) "=" info
+	static const char __UNIQUE_ID(name)[]				  \
+		__used __section(".modinfo") __aligned(1)		  \
+		= __MODULE_INFO_PREFIX __stringify(tag) "=" info
 
 #define __MODULE_PARM_TYPE(name, _type)					  \
-  __MODULE_INFO(parmtype, name##type, #name ":" _type)
+	__MODULE_INFO(parmtype, name##type, #name ":" _type)
 
 /* One for each parameter, describing how to use it.  Some files do
    multiple of these per line, so can't just use MODULE_INFO. */
-- 
2.26.2

