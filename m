Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C455A41F4CA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355850AbhJASQt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355897AbhJASQ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:16:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D09C0613AA;
        Fri,  1 Oct 2021 11:13:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oj15-20020a17090b4d8f00b0019f8860d6e2so824269pjb.5;
        Fri, 01 Oct 2021 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlSQA/x8Q659lExbJ8x+3pbQGN8nCVePZlCG2RLxniQ=;
        b=dNr9oSu6Qtp0DeQk6DSDUbA9YikKVIz9z6eDiaeb6OMzoEdg9gAFlLLwsOWXLrGG8M
         Tf6ft5iMykzEGrZMsfgyC9QLYxeJZzr9iokrdPNjaxqOaAq2tRkql/LvBg7Oo5bXXM7K
         6j6QD6fvxGLhYzQVks5mwK0mKYnxwzsRZyJ8VPG4lYVlogXWb2FMSaNXHbJRufBdnKqU
         mFgBekVMogPp8ABPAVRABc0Fq2iUE0SzqOLA3wJsXjpr6o45seO512t+JfJ6HU5UQeV0
         qQSgp9y9Gl4LBdLJ7YMJ84T/d4ko6eiEc+Ih+Sz3NT81xaniChwYG66PpEO7KGxtm3kA
         Ozuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlSQA/x8Q659lExbJ8x+3pbQGN8nCVePZlCG2RLxniQ=;
        b=RAGdtbKX8YkTZTyHJpSnqKKpD5s2fXQqsAvEHGJ+T+WxfcZJ5Zps2ZYGg0LgV/NjZo
         goWoeWmPHSrTo3uh7eKPzXegStQ656h4qzzxvo4vO1n3Z3q2twolLf0Y/FjewZWZbW2F
         3iOR/r25853OqFF8zn/dCW3w1IzYHzEFtN/zPqpIaMxBitpdZm/Gw7W34peVSKv0OV8R
         NzWVIWMNPLf+eJeLNUinf4JJWGLYqYU3x1znZZ/Te1jC0B3XiytCamttx3dp3d6flIeX
         uLwJ7BREjFIa33p5SgEoMg+7QGfN5dsALuPk2wTKv6xcN4KR1+EOwyT4MbkMUh4hjnvf
         3XXw==
X-Gm-Message-State: AOAM530tnZYscEsy/BAvm+BSDfGzGXnkqHDHmiNuInVY1qQSUMsNQOhv
        23RBH0KvYla25iDhn276ojc=
X-Google-Smtp-Source: ABdhPJwYukMmWxTyp0ryKmZnt4pz+cTynvNrINevzce5Gbx7dcqhhXEHbxJDQcDzmMx/MR36JOPG5g==
X-Received: by 2002:a17:90a:4815:: with SMTP id a21mr14770802pjh.108.1633112017021;
        Fri, 01 Oct 2021 11:13:37 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id p4sm5778054pjo.0.2021.10.01.11.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:36 -0700 (PDT)
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
Subject: [PATCH 16/16] vsprintf: rework bitmap_list_string
Date:   Fri,  1 Oct 2021 11:12:45 -0700
Message-Id: <20211001181245.228419-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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
index 67a96165e587..d1bbf1d78df3 100644
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

