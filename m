Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2770D3EC5A5
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhHNVUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhHNVUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:20:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD1C0612AD;
        Sat, 14 Aug 2021 14:19:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n5so93466pjt.4;
        Sat, 14 Aug 2021 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cLY/ZyxeNxNsAiXmyv2EWouUSbE2B2rkGNWBEb0HZBE=;
        b=hZhlG89Q+6j/mk80mZ3kWMh7Ztex4n9sfRcozdm7vLK3xe5IgEuYIoHO0qN2+Rgxf6
         QFSINDEfk2V0xP2T5oF53GTCHDaK0GD0v3uaqDhsBnBQ/B2wtEasdfslWzfdMZtHP21I
         gYDkKZ5RnriR1+uKZBwh9ynZC6nIIskVmZzFlU33uP8/rDKWE+moiqaY5xDJtfSozDT0
         Jq9eCKFVOop3BP03+Y2opA88AMHFjXgDtUPIf5Mk2LgWIRA6Ut2AifJhTNhwMqFhfNUq
         cQWPpPMIFMm2DSeF0QUAGaJ1wR4DYuQEmALhr/6iPFAVfTwAyp7KF+o1gKh1KHnOhebh
         Worg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLY/ZyxeNxNsAiXmyv2EWouUSbE2B2rkGNWBEb0HZBE=;
        b=EwuXbitQLM0uDrba+HUUGPkKxQFkvHN4V6GO0Aaqz4y3gqEbX5VAir0XmzHtfbyuSj
         +i2Fx8fOMJ8AS9v73m2rUc/Mnu49bSwmddOzYu6IM9xrXeFeglTxmR3Vjm9VbA/h7fj9
         LlDF4C551DEYTxJVA8bZ3vzpZzHEasRPMNy5M1205KNTCcIqAPjpPDcfaLx2plZ+BAoe
         BbaIzvR5YT/q1aKagZQsx/MSKa4lbbEYBDDyr+FCzQOcr5fP0aXFNxMyEmZiQipV8m9S
         ZD6Fu+kZz+xw78jZbSv8JFKwbJ7vfChtQ5cb5nbmc3bNjEDXnYyuVgiG7yL1UmrA8VJC
         WPnQ==
X-Gm-Message-State: AOAM530zhVJLnCQ8Z6T+oN3HPy/DAEAgMUyWYsRXDjP8lmxNLDu6p4hM
        4QOAiHFZb3Yj3/0JBYn1yIo=
X-Google-Smtp-Source: ABdhPJx4LhYM7MAbGn4+F4WnJIr72PWqItuGnJiXGuRm14emqWbH3bRl2gvGcPqsxaP4VRGf/7gpOA==
X-Received: by 2002:a63:2442:: with SMTP id k63mr5711700pgk.54.1628975960088;
        Sat, 14 Aug 2021 14:19:20 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id pc11sm5461926pjb.17.2021.08.14.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:19:19 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 16/17] lib: bitmap: add performance test for bitmap_print_to_pagebuf
Date:   Sat, 14 Aug 2021 14:17:12 -0700
Message-Id: <20210814211713.180533-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
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
index 4ea73f5aed41..452d525007da 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -430,6 +430,42 @@ static void __init test_bitmap_parselist(void)
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
@@ -669,6 +705,7 @@ static void __init selftest(void)
 	test_bitmap_arr32();
 	test_bitmap_parse();
 	test_bitmap_parselist();
+	test_bitmap_printlist();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
 	test_bitmap_cut();
-- 
2.30.2

