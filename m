Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED41C7DC3
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEFXN7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 19:13:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35999 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgEFXN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 19:13:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id d22so1905981pgk.3;
        Wed, 06 May 2020 16:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNC3GM3ywGXGoZzk8/YUTPNRyoicVYswjVnBQiUzaYs=;
        b=gyNHFGXtO+bRy10kSQnOFHiuKnpiqxqI/tir6hskR7d6mMoC1Le41qHBv/7SZRB+qN
         fmoGEE68vFwzQEUdj6atkKL8FGWOsAGoFL9QO8FiO7bSV4TkqjLgfavfVC6GEnyuhlvt
         xr5nJGUwpcLqyteJzA6M1/Fm2l6H89xE/JKCmXjIC5krtEoqtti8FkjgqXwX2d0N6+1f
         c82JVef/3dvAYwxBwuraS05Cf/vNWOrUejZqRKNzJtcngptYuXq1GIjIlmWktPHPRh+i
         gW8Dq1gSRANZRM2hdXtGDap04zXxKXEgP3dtQTOxcBSpFa6jcDLETsy2RWC7edwkM1lc
         PlXA==
X-Gm-Message-State: AGi0PubeZOCAvHwGE4gHE6Ld27/RHpOS1LDv9pvxlM3Qg8Y6hPAQRnrZ
        MxKB28wW87FQu8+a3bqU9kI=
X-Google-Smtp-Source: APiQypI1cZz5e5aUdny1xt+BmLGd0u9WZ/XOxzZEhrSJwWx5Olumva6WOJu2WNhYATPEGbj5pYvHsA==
X-Received: by 2002:a62:1994:: with SMTP id 142mr180656pfz.259.1588806837760;
        Wed, 06 May 2020 16:13:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f6sm2924188pfn.189.2020.05.06.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 16:13:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 505C5403EA; Wed,  6 May 2020 23:13:55 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     cl@linux.com, akpm@linux-foundation.org
Cc:     arnd@arndb.de, willy@infradead.org, aquini@redhat.com,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] mm: expland documentation over __read_mostly
Date:   Wed,  6 May 2020 23:13:53 +0000
Message-Id: <20200506231353.32451-1-mcgrof@kernel.org>
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
guidance over it use.

Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

I sent this 2 years ago, but it fell through the cracks. This time
I'm adding Andrew Morton now, the fix0r-of-falling-through-the-cracks.

Resending as I just saw a patch which doesn't clearly justifiy the
merits of the use of __read_mostly on it.

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
+ * execute a critial path. We should be mindful and selective of its use.
+ * ie: if you're going to use it please supply a *good* justification in your
+ * commit log
  */
 #ifndef __read_mostly
 #define __read_mostly
-- 
2.25.1

