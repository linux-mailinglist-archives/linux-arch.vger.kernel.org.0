Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0F421E57
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhJEFos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhJEFoM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:44:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B0C0617BA;
        Mon,  4 Oct 2021 22:41:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa6-20020a17090b1bc600b0019ffc4b9c51so1053210pjb.2;
        Mon, 04 Oct 2021 22:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVIr7fAkmnLGTRIKArO4HwVYW8hhJ6BbGtxi7VDtm5A=;
        b=hOVRsOlT8XPHEFn7u90zG8kykUcqD1ypQHJ/k9TmiKzTRKuEbC/SAMidDKAKRuWDyf
         ONXZiigSr00bSFhT96Jcn0Zlj9HZB/o5fFhESjadfXMDEU5C5pZwwGMvrRD5rnhy1fuy
         9UKf1jM/PPWmBFKY1hJx9mC5gO1MTACgmo6W1ZcR6J0IIClqU3RsXMXNgZJcBTFrHIBT
         eNMhetVQBRFqh0ZeNqX4I+PgrAIYpp+pfi5pXDjCnFLWOLr836YhHNSepcvhUK3aN9Ln
         l5nIWn+NZBNc6ZeMAF3gQGdkctCVYwr2nZPG9Wg9rnt5Zvp3zKpEWjGsgaIcY4c8SPOS
         WnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVIr7fAkmnLGTRIKArO4HwVYW8hhJ6BbGtxi7VDtm5A=;
        b=TCwLs3j0xaiO+AesVos7Idk19vO/ZZmIfx/ccrP/A2DFLsv0ILyKc/jj3m4GnAPVT1
         79gvhCmdjcE0U8TGaCUH6iN2lYnRVCPk7ZWFOaoBKj4zxGaWTbhOZJobgVAlALcNp43e
         qhlft8HXkOdFLywlW37Qd8XmnF2EoR9p2z5M4u1s9aU5TdtbYGhTzSOwrSC2KyepiFNH
         u7T7G3DjonvqtcmHpA5F+j+Qhvjnvi17mlkwjkiYZtdGKaUJBPm0tgn70+hTFFEqsR/c
         VneHkD4V5rapeUxFOw7a570w1DPxMLQMiX+tRnW/qyJlU/tqvPIbAKZ3SVrrKmIwXOz2
         rM9g==
X-Gm-Message-State: AOAM533Ij8HNWxxe6IM45/tVBqjLBxsodv5CyMeal4qBzdZ41zt5jdsK
        8CpLu+xyicAIEl5Bjj/Pbi0=
X-Google-Smtp-Source: ABdhPJwduIIdB4dTL8t+flaozTGh6Eae8ekpp/242AL8xC7zBroB9475SOuRVteNcwlN153uZIeuIg==
X-Received: by 2002:a17:90b:4c86:: with SMTP id my6mr1521844pjb.77.1633412504391;
        Mon, 04 Oct 2021 22:41:44 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 65sm16122052pfu.187.2021.10.04.22.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:44 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 15/16] lib: bitmap: add performance test for bitmap_print_to_pagebuf
Date:   Mon,  4 Oct 2021 22:40:58 -0700
Message-Id: <20211005054059.475634-16-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Functional tests for bitmap_print_to_pagebuf() are provided
in lib/test_printf.c. This patch adds performance test for
a case of fully set bitmap.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 lib/test_bitmap.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index d33fa5a61b95..0c82f07f74fc 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -446,6 +446,42 @@ static void __init test_bitmap_parselist(void)
 	}
 }
 
+static void __init test_bitmap_printlist(void)
+{
+	unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char expected[256];
+	int ret, slen;
+	ktime_t time;
+
+	if (!buf || !bmap)
+		goto out;
+
+	memset(bmap, -1, PAGE_SIZE);
+	slen = snprintf(expected, 256, "0-%ld", PAGE_SIZE * 8 - 1);
+	if (slen < 0)
+		goto out;
+
+	time = ktime_get();
+	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
+	time = ktime_get() - time;
+
+	if (ret != slen + 1) {
+		pr_err("bitmap_print_to_pagebuf: result is %d, expected %d\n", ret, slen);
+		goto out;
+	}
+
+	if (strncmp(buf, expected, slen)) {
+		pr_err("bitmap_print_to_pagebuf: result is %s, expected %s\n", buf, expected);
+		goto out;
+	}
+
+	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+out:
+	kfree(buf);
+	kfree(bmap);
+}
+
 static const unsigned long parse_test[] __initconst = {
 	BITMAP_FROM_U64(0),
 	BITMAP_FROM_U64(1),
@@ -818,6 +854,7 @@ static void __init selftest(void)
 	test_bitmap_arr32();
 	test_bitmap_parse();
 	test_bitmap_parselist();
+	test_bitmap_printlist();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
 	test_bitmap_cut();
-- 
2.30.2

