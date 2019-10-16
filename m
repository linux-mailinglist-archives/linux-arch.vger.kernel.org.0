Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9BD8B7C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404118AbfJPIl4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 04:41:56 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:55006 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391741AbfJPIlQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:16 -0400
Received: by mail-wm1-f73.google.com with SMTP id g67so664867wmg.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9SMgLZKRCrUAwZ4Rshpo1HVyP5RqT+TntrXHNZ73xYY=;
        b=FDIPWUL/JwmYB6hACIcWUwuenrffDDAMzGSei/mRdw2EODhUfYubNcKwRfAgNp0DhM
         dtUKG7I75/scKfOkForm7Ld7BuMMDf7BHMR3NlZ5qfVmRtDmpmJc6uB3CuAr91yveAnL
         nGRuVo70brrUGtmp1Ve08DkIzHSi9SVIOYczUBr++j/ObGq2iUw/aBOyKHJ139cBYOgE
         xnfKiRntzrGA96b5jN/E4fIqaZwTsDPzTCU1SZd5nLiOQ3czOfhus2Fq3v2uFkOsxnIq
         s4piFfhm90KHCJPaNgDU6oYlPHFiQUMyTLgNXoJ/09nhO4RdOEdIJ82o/pFsXix8mVoS
         k64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9SMgLZKRCrUAwZ4Rshpo1HVyP5RqT+TntrXHNZ73xYY=;
        b=W/cP2AmPK0mGX+GdV4C4cA/rnlbkrb00CIf8T1PMMiWnyn63a7ewcutJah3RlRZHsl
         ZZoQ9eyeD9YUQB53wTlpBQzMwQ5Uhr4EbrF88thxm/w8iDKhdyHQa2pCnfwO/itdqWu0
         Ggi2cYb3nw7Kta8WmA0VGJfCh2DkepPsgz9sZe8afmIASjL+zd4lbkPRvK4nRZs6tzPl
         LvOasGZVgFgqYnNpJBiYEOwXgD4Jjf9Udg/Nn8Yn6EEnVItGH2/kfoTLrIvxZpJtQ+ZW
         dKWAFlYHjVZ1sWAgbFPGJUis+h8dbymwF3ykTmUhaE1Np2Kn+lxLsDizLTXY47i7m4gT
         UpnA==
X-Gm-Message-State: APjAAAUXCUQLygaoETl8a1tVCR+znPDkYgA1vktrym0D6zW+eviu3pn4
        29hBu6cDWXPTV5BUmnvnv/zWLHPRcA==
X-Google-Smtp-Source: APXvYqwkgvQBQ5yV1eoCrQo14zvvYIx87rvKqZQ+FG5dzvqnKHHgHQFk8ioyGbzu7TlFoxqNUrf9JlniKA==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr1610112wrq.180.1571215274810;
 Wed, 16 Oct 2019 01:41:14 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:53 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-Id: <20191016083959.186860-3-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 2/8] objtool, kcsan: Add KCSAN runtime functions to whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds KCSAN runtime functions to the objtool whitelist.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 044c9a3cb247..d1acc867b43c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -466,6 +466,23 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store4_noabort",
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
+	/* KCSAN */
+	"__kcsan_check_watchpoint",
+	"__kcsan_setup_watchpoint",
+	/* KCSAN/TSAN out-of-line */
+	"__tsan_func_entry",
+	"__tsan_func_exit",
+	"__tsan_read_range",
+	"__tsan_read1",
+	"__tsan_read2",
+	"__tsan_read4",
+	"__tsan_read8",
+	"__tsan_read16",
+	"__tsan_write1",
+	"__tsan_write2",
+	"__tsan_write4",
+	"__tsan_write8",
+	"__tsan_write16",
 	/* KCOV */
 	"write_comp_data",
 	"__sanitizer_cov_trace_pc",
-- 
2.23.0.700.g56cf767bdb-goog

