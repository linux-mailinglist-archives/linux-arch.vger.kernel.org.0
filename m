Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634BC3ABE54
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 23:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFQVqJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 17:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231365AbhFQVqF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jun 2021 17:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623966236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4/8ZsrnV9kT518dUAoy2KJrq344KI7QjcpIIYk0eZg=;
        b=QmPH11wyidqMxdZSuSJbjZ//b9qDoRBkzKYPasUONtsIQqaSMgNXppK+wbutr3WtDiNADf
        QbS0Zs2+zgMUDqTXlPNYIHBd9ivgkoOTJe+webgeeaLv25jDHDwi90fLsr7G40fQovaFfl
        DB5xtUgltIFqrG9z9hHHrePfffLY6FQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-O71J_Fk_NQOUpZRVE7w-jQ-1; Thu, 17 Jun 2021 17:43:55 -0400
X-MC-Unique: O71J_Fk_NQOUpZRVE7w-jQ-1
Received: by mail-oi1-f200.google.com with SMTP id u6-20020aca47060000b02901ff152f8393so3057112oia.4
        for <linux-arch@vger.kernel.org>; Thu, 17 Jun 2021 14:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4/8ZsrnV9kT518dUAoy2KJrq344KI7QjcpIIYk0eZg=;
        b=QK8Zmvn2/IBk+obLxAnJkjJb8lies4UBj8vm0o09toU/awLcNM2WK4KEWAfhTRci0B
         1OLVOIL338In/EtuYSUSnVUv8uvG5uaeGeevXySeDSd10i7Eb4kW97XsUxPfW7RCoINx
         sVjwPDTMtjnYjQSF0QXqxFNytowHr8OMNIWzZ2D2NVsRom5jcoIJk0+ejWmQZEQDPBv3
         R/r46mIhqIWY26oFKmYP7ghP839Fa0LnfgsppZhShhfYCbgOL9I5QNH0VKQ+r0ugeNUy
         IAZrRMfFpl+pM0r5ZhDE88uObPaExPTRZ6v6PXL5AQgJ9kPmJf9X/P5j6e6RKzFSvlVB
         0wYQ==
X-Gm-Message-State: AOAM5338k3s677FT0p2Z5pUPQdyTHLf3L6Vy0bhlceiogVs1988gELFQ
        lnG2MkHY75/g4KbLCt6E3wKQJ3yaMKvsMT+tg+lPL48MIymvjN24cCYRFMwHKyDEvv6p5odQZI7
        s+OS/UPPzjBHitzNCYrynXg==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr6810616otg.114.1623966234748;
        Thu, 17 Jun 2021 14:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/MpfIdnRaMMuXLpXImcZSfOF2dMx/96uo+/FPPE6d05WXuSqepKcSIyq07IAiSgtXhdFX7Q==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr6810607otg.114.1623966234593;
        Thu, 17 Jun 2021 14:43:54 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm1366313oij.26.2021.06.17.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:43:54 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] bug: mark generic BUG() as unreachable
Date:   Thu, 17 Jun 2021 14:43:28 -0700
Message-Id: <20210617214328.3501174-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210617214328.3501174-1-trix@redhat.com>
References: <20210617214328.3501174-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This spurious error is reported for powerpc64, CONFIG_BUG=n

fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
fs/afs/dir.c:51:1: error: no return statement in
  function returning non-void [-Werror=return-type]
   51 | }
      | ^

When CONFIG_BUG=y is BUG is expanded from
  #define BUG() do {
 	BUG_ENTRY("twi 31, 0, 0", 0);
 	unreachable();
   } while (0)

to

static int afs_dir_set_page_dirty(struct page *page)
{
 do { __asm__ __volatile__( "1:	" "twi 31, 0, 0"  ...
   do { ; asm volatile(""); __builtin_unreachable(); } while (0);
 } while (0);
}

When CONFIG_BUG=n, the generic BUG() is used which
expands out to

static int afs_dir_set_page_dirty(struct page *page)
{
 do {} while (1);
}

Without the __builtin_unreachable(), gcc reports the
warning

ref: gcc docs https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
" ... without the __builtin_unreachable, GCC issues a
  warning that control reaches the end of a non-void function."

So add an unreachable() to the generic BUG(), the resulting
expansiion will be

static int afs_dir_set_page_dirty(struct page *page)
{
 do {
   do {} while (1);
   do { ; asm volatile(""); __builtin_unreachable(); } while (0);
 } while (0);
}

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/asm-generic/bug.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index f152b9bb916fc..b250e06d7de26 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -177,7 +177,10 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {						\
+		do {} while (1);				\
+		unreachable();					\
+	} while (0)
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-- 
2.26.3

