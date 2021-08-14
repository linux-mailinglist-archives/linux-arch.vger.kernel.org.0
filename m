Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF53EC5AB
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhHNVVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbhHNVUg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:20:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E027C06122E;
        Sat, 14 Aug 2021 14:19:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a20so16360042plm.0;
        Sat, 14 Aug 2021 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OaNgCZRD4hHUI4tS8xBQiKuxtW8/RbylDXTBHUi27OQ=;
        b=RV62ISfXUBoaKNadbCVlghPZyQ+LHJJZ8dSVyYLeF8iDAUYBt2Lo5nKaM+6NUAiUwV
         ooXkm64XmYElbEd8415cR6Ztf/GlBTG8Pfw2lQY0HtaEY7iW4Ykt3l5aqTg+gPaLLCQj
         pmfOHAXuIgULb6rKaCKDU1rXZKdTVPdHjvaKAMXFkKuxT6DffqYrdpT88lhGiRl87EUh
         rK4y06ZEa6KsZjcv4gRLgXnwOefJ/BRdzS0RcvV9pNj5LWbVaCD36GeihYWz1xVh15rK
         bjhS6zLbvJaM8cmFQBWMbGGzReJVplYiMazH69fPOUHslXGsC0jofgQF6IZCARL6evZn
         g0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaNgCZRD4hHUI4tS8xBQiKuxtW8/RbylDXTBHUi27OQ=;
        b=DTyjB/n/q9cm3kRuPssw1JS2Sw2a6kMDRbDJ7mZRIBhUXw7UmII5RM4yaXjRmUMOr4
         t0oM9eU6yIy4QUJbDrlZmh6v7e/DnfAl8shQu0iyEmk+5TfFmEcABJE8A6UBdzy7OiMr
         n55+nYB5LBqTyjQrFS+WU6aUDW9iFHXThHNckjdWyLQJljqYQQgd92oUWUTOQr7xhnTB
         DD+/whBCCk5osv5iMZd8dogf5xCNieGZz8s9RJZM7NsiC38NB5xAVMx2QQrhkXSsZrXK
         gxdSkdg4eeEcPWJyEABCJOTCzBX+8cQ9j22FRdSuNvE0/Rr7UJsuaDYDW8zMWa7ohvog
         DAlg==
X-Gm-Message-State: AOAM530p8kGHOtZRdMyqUdGFXgnOovKRjOsquckZJBGAw2w5g/9WXilB
        tIwCrgRdGUkPICku/dEPCUI=
X-Google-Smtp-Source: ABdhPJwWOGgPdsAP5xgLQmeuJG7wa9JnuUSFVObAMXt50U32Y2zsf4kDWiVRHM6r3Rl5iZJjQwDNVA==
X-Received: by 2002:a65:6183:: with SMTP id c3mr8232385pgv.73.1628975967602;
        Sat, 14 Aug 2021 14:19:27 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id y4sm5325910pjg.9.2021.08.14.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:19:27 -0700 (PDT)
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
Subject: [PATCH 17/17] vsprintf: rework bitmap_list_string
Date:   Sat, 14 Aug 2021 14:17:13 -0700
Message-Id: <20210814211713.180533-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

bitmap_list_string() is very ineffective when printing bitmaps with long
ranges of set bits because it calls find_next_bit for each bit in the
bitmap.  We can do better by detecting ranges of set bits.

In my environment, before/after is 943008/31008 ns.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 lib/vsprintf.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index dd006adfe853..29a384eee286 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1241,20 +1241,13 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 			 struct printf_spec spec, const char *fmt)
 {
 	int nr_bits = max_t(int, spec.field_width, 0);
-	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
-	int cur, rbot, rtop;
 	bool first = true;
+	int rbot, rtop;
 
 	if (check_pointer(&buf, end, bitmap, spec))
 		return buf;
 
-	rbot = cur = find_first_bit(bitmap, nr_bits);
-	while (cur < nr_bits) {
-		rtop = cur;
-		cur = find_next_bit(bitmap, nr_bits, cur + 1);
-		if (cur < nr_bits && cur <= rtop + 1)
-			continue;
-
+	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
 		if (!first) {
 			if (buf < end)
 				*buf = ',';
@@ -1263,15 +1256,12 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 		first = false;
 
 		buf = number(buf, end, rbot, default_dec_spec);
-		if (rbot < rtop) {
-			if (buf < end)
-				*buf = '-';
-			buf++;
-
-			buf = number(buf, end, rtop, default_dec_spec);
-		}
+		if (rtop == rbot + 1)
+			continue;
 
-		rbot = cur;
+		if (buf < end)
+			*buf = '-';
+		buf = number(++buf, end, rtop - 1, default_dec_spec);
 	}
 	return buf;
 }
-- 
2.30.2

