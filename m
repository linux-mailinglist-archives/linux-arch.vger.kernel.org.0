Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0852A4DFA
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgKCSMI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41117 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgKCSMH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id p15so20117628ljj.8;
        Tue, 03 Nov 2020 10:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyGoxRTFxoN3CcXdLX3OQwBVVHqEtKepL93LP6Dv6QA=;
        b=R//HsVHjsHYbrjjn8eGGKKqsHCTgqppovrb59bcrLEcJ28pRP/trqVJ85u/pPh38My
         hjLRCPNFjlfxoEi667GosKFJ0GUaixvK/Ho8zndfUO/BsS6v0/aAKyDv3W3glGJnmlQu
         9O8L19zc0Qj9XfXbfopC6mgoS1yG1ns77PJeiAYwuLh5irsgE8HMsteg8Fk1y0jdhhfQ
         0ebnJiYuftNDv/92m4+nzE3u35D5UeHUilIioeGgNB4syzJf4nxfR7crXN0YcamKcz5c
         esgH7JzXerCszKIJho+mrc2y6+7tIxmXdtTZNiD3I4wq7OLSeLBc/5tjjC7lHcDvHXo5
         aMxg==
X-Gm-Message-State: AOAM530NPlo4hppeMg9dIVIwGSRmEdGy0Gdx+1roM7pGyYFPA5YTzWU3
        iYuJnMPIYVSdMOhurtGcP58d6WmPUhZsoA==
X-Google-Smtp-Source: ABdhPJz/MO3T96ux3lea2nDseTlpodjsFUn7zZD2Ae+pvGCV0PQp49JaKgosvrFzcYrMAizjAgvuaw==
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr8407658lji.338.1604427124922;
        Tue, 03 Nov 2020 10:12:04 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id l14sm3641920ljb.122.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:12:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mo-0002s0-7f; Tue, 03 Nov 2020 19:12:02 +0100
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
Subject: [PATCH 8/8] params: clean up module-param macros
Date:   Tue,  3 Nov 2020 18:57:11 +0100
Message-Id: <20201103175711.10731-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
References: <20201103175711.10731-1-johan@kernel.org>
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

