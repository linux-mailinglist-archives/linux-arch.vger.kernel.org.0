Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56331C9626
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEGQO2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 May 2020 12:14:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40922 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgEGQO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 12:14:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id j21so3010462pgb.7;
        Thu, 07 May 2020 09:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K01c3myVTwjqfRxKpVK6bNm+Qr9pA/B7t1+trJLymis=;
        b=WWV3b/EVnkoNXWxzBtcEpdeJiFWToeVF1t4lbaF6eQV4UN4jEC76qzn0vgROPmxpLz
         46fPU3kkxxfKnw07/RVwW2S61eyVW+lOPicf9VtSRG0Miu7+EIZk3EPwsLLCR7BALxcY
         XYgwbk3NLHmQGZHEFuDXr+zc7ZZ2HQEeWkO+RGnLjBD0UxJSjkabbAWCbW4RImlKEqrq
         AU9IFAnnMIEkZp0xfSTD9B3QnPG6fSr0RBBZBQhv7T9APuM9NIhfn+YWgC77ApKsYeaC
         k4RRmcfXj0pCOFnoO6RuLADmM7lCiKyptETItrR5grAqIV/4NhFc3grCPbWzJD6dymqT
         u/sA==
X-Gm-Message-State: AGi0PuZLEA8PccP4Lq1UNW4PAQKDmC6YD+Qd1hpPjuDhNOnqRChFOgQt
        LXLfxzhtLnWPqm6DFfw6L+MtkfrFUmI=
X-Google-Smtp-Source: APiQypJlK3bEqBCOWQ9A1P7qBNuXOr+1NhJTCNPPunzRaibPtjOJ3Mug/c0efwn5onWc1A+geXg7uQ==
X-Received: by 2002:a62:343:: with SMTP id 64mr14719426pfd.47.1588868067667;
        Thu, 07 May 2020 09:14:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x193sm5626460pfd.54.2020.05.07.09.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:14:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D578A403EA; Thu,  7 May 2020 16:14:25 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     cl@linux.com, akpm@linux-foundation.org
Cc:     arnd@arndb.de, willy@infradead.org, aquini@redhat.com,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] mm: expand documentation over __read_mostly
Date:   Thu,  7 May 2020 16:14:24 +0000
Message-Id: <20200507161424.2584-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

__read_mostly can easily be misused by folks, its not meant for
just read-only data. There are performance reasons for using it, but
we also don't provide any guidance about its use. Provide a bit more
guidance over its use.

Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This v2 just has a few spelling fixes.

 include/linux/cache.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..8106fb304fa7 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -15,8 +15,14 @@
 
 /*
  * __read_mostly is used to keep rarely changing variables out of frequently
- * updated cachelines. If an architecture doesn't support it, ignore the
- * hint.
+ * updated cachelines. Its use should be reserved for data that is used
+ * frequently in hot paths. Performance traces can help decide when to use
+ * this. You want __read_mostly data to be tightly packed, so that in the
+ * best case multiple frequently read variables for a hot path will be next
+ * to each other in order to reduce the number of cachelines needed to
+ * execute a critical path. We should be mindful and selective of its use.
+ * ie: if you're going to use it please supply a *good* justification in your
+ * commit log
  */
 #ifndef __read_mostly
 #define __read_mostly
-- 
2.25.1

