Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B10D3456
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 01:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJJXY0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 19:24:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39112 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfJJXYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 19:24:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so3540954plp.6
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMqmNRh9/WRVuOhxmgeAss8KGdVZEWgP1gvN19lsOqw=;
        b=X2Pgj+AXTV2Ft841aCpOcTDGSCdqRW7jKxi/A0JNfzkCvRnBRTlgiBPSQlnSB+smXf
         KM/0N/YQd1W8z5kju+9JLAHVI1pfeWN/BEzNRrEERIuWwD3BkBcqvXop0Shui4yPMLqZ
         D7f/vZRRKSScbxm9PdqjdsYfiYl9R3gEC2Gak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMqmNRh9/WRVuOhxmgeAss8KGdVZEWgP1gvN19lsOqw=;
        b=SQ9OvE8sYGJ1jRrhvN0tYnt9Sys7x5+vAn1dsZjfkCw/6EeDX7rvFZ+HBNtxSvUn8/
         BsWC/9TTGRSlt87PWfCPhsjlVt7JZs5F1UEoyn4Z4NteJtehCMrh7pubE2onrIIfZ9rY
         47thOMAjW0wT4wSEu7HObrGGVVkEssQdepuOzt4Ij05TIWHRTFVOlrHXAdrcFV15FA7O
         ZzTknRQBxS+4HJRPM4a5CEtzOA0Fkvm1HjlfsyGiA+XZUuE96UjxydtTcwzDIfSorZyS
         b2J+zfuyd3tEasNBh7cNgN+yo4wMnCYLJa5RM8pA4G8eDMwg9b2B988sw1bQvBEfYWC1
         t9JQ==
X-Gm-Message-State: APjAAAWlGpQqPRkYA2/n4c88r/IQY7bKyJnw3HLrXxS9xgtS6QoO+KhZ
        cLxYXthM1brPuEHo2DyAz3WLvQ==
X-Google-Smtp-Source: APXvYqzr5TEKsgP0lOS7AdzCh27u/YbVsT+Ij4ZMEVcIou1HxRIVeL6D9p3wjllIloBGYMby8gU1TQ==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr12067901pll.40.1570749839357;
        Thu, 10 Oct 2019 16:23:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2sm6645331pff.154.2019.10.10.16.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:23:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/4] include: Remove FIELD_SIZEOF() and sizeof_field() macros
Date:   Thu, 10 Oct 2019 16:23:45 -0700
Message-Id: <20191010232345.26594-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010232345.26594-1-keescook@chromium.org>
References: <20191010232345.26594-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

The common function used to find struct member size is sizeof_member().
Remove the now unused FIELD_SIZEOF() and sizeof_field() macros.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-5-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 9 ---------
 include/linux/stddef.h | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d83d403dac2e..d67020250d75 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -79,15 +79,6 @@
  */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
-/**
- * FIELD_SIZEOF - get the size of a struct's field
- * @t: the target struct
- * @f: the target struct's field
- * Return: the size of @f in the struct definition without having a
- * declared instance of @t.
- */
-#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
-
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index ecadb736c853..74b5e644d50a 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -19,14 +19,6 @@ enum {
 #define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
 #endif
 
-/**
- * sizeof_field(TYPE, MEMBER)
- *
- * @TYPE: The structure containing the field of interest
- * @MEMBER: The field to return the size of
- */
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-
 /**
  * sizeof_member(TYPE, MEMBER) - get the size of a struct's member
  *
-- 
2.17.1

