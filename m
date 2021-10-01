Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2796741F4C5
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355741AbhJASQd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355846AbhJASQF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:16:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273DC0617BB;
        Fri,  1 Oct 2021 11:13:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s16so8697725pfk.0;
        Fri, 01 Oct 2021 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVIr7fAkmnLGTRIKArO4HwVYW8hhJ6BbGtxi7VDtm5A=;
        b=lXUp+9Od6M9S7RMSuyxanM1yWQdtqC/AAe7iCxUfxH5DloVmZDQvD82Sabbs/qyw9R
         ynsF5bWEKRhOTucr2rTKbZQrWUa+3zXZGEfJb04wFCvSuanSqEjvaPL/x7NgydXf1w4D
         sqJr/YEIMA/aki34Oa0SUg5p0Ppo4iyBjEu3WDOlO82iqwIWsHk8Ap8yIrvubxOcX7wG
         kVOYysbel/UUwGrE+M4YEq5uOdfdgJ6QTNnUvKjK5v+HsuNyABf6I92g/BF8HSMRUmib
         eh9kWw/GQs710NIV4/g6xgE2F0P8nXTEjlIZKT14nXMSgLJi/nmaaw3V4UFsHw42zK70
         hFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVIr7fAkmnLGTRIKArO4HwVYW8hhJ6BbGtxi7VDtm5A=;
        b=C1IR3gMBS/1iJRzMqRjz9KSCf0yONd0q/z1thh1TlxJm4vx3OFHVYaGyjZcLBo9yV6
         5SF0bJgVETmgrg7ceXo3KxV4aOP3u8OVJD/RjlHjMCOJbh5AjbT/0nO0JRy36rutALx0
         vZNDt4yHtdAC0cfFC+Bew54WXJ1cRwDqQwWBPagSIBzyVEekHdANiLVmE5Zm2kMdyZWb
         Fgh1k27niEMUF+VnhROTAzEzh/fLYsdM6JnnmM8FqLQ+tieOCHwN7dXigeD/IyVUnAYO
         bryXLSiCnYdgXHS3W1uelBEwKc6HmNhP/8lKMFmIrUz7Jx389a8ayj5x8SveH406t2eb
         KOfg==
X-Gm-Message-State: AOAM530NyjdqtnJcOy+h4XfmYkoBfwdp/0R5A7yn7URZQRnLNmDpB6rw
        aT+P6V2VKE9jtJNR3jg0ezk=
X-Google-Smtp-Source: ABdhPJzWkripl8R4xiRIMids26DEF1LJPZrHGTjf4Zs5yvcfXJTwuCiC6dmRuUe/1X1O9TG0db8Q6g==
X-Received: by 2002:a62:3383:0:b0:438:4b0d:e50e with SMTP id z125-20020a623383000000b004384b0de50emr11501138pfz.9.1633112013623;
        Fri, 01 Oct 2021 11:13:33 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 23sm8562335pjc.37.2021.10.01.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:33 -0700 (PDT)
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
Date:   Fri,  1 Oct 2021 11:12:44 -0700
Message-Id: <20211001181245.228419-16-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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

