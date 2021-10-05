Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C0421E5D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhJEFov (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhJEFoN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:44:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D14C0617BE;
        Mon,  4 Oct 2021 22:41:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m5so3691446pfk.7;
        Mon, 04 Oct 2021 22:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZNFqZL6Mgo5rwsf7yN4tz0gd8I7XPFY6Ga4YBxagho=;
        b=kU5Y7HnPbgF+Rq+MtA/+UamygPQuNDHOtRvNjoP5AwB4aNWInI+I9OI3kWMvB9OG00
         w/nOUbCy/H/lq2Bs9UsDu6ZVYXMII3SFKrk8sAPK4jF9AVUKTCt/9kazO/wvjbq5kJCx
         75+NTA/EHHqNtci9D5KdfHHX3CNsg5bcz8rKKPiMNn8PiwQPVBDqeb7PzbTJm9VA/h8T
         f6xuMp9rgyeko2lCqmohheESfCVP+XBsReLy+67Xbzf27iDLWfxqqf4qxGxID2zUEges
         qoYCsIpZkF1UPft6kwjC/4fqzTm5buicksIiqtWMYlOVYBHvDSIiabJzt789r3Nsou0b
         sw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZNFqZL6Mgo5rwsf7yN4tz0gd8I7XPFY6Ga4YBxagho=;
        b=BBXrm9qC8qqQsxdcFCJcfYmkT9RCHIfAVSNQ+SC80upD/GGDfdgkxCQ1IEVr1Zh2hh
         998s7P7DZofTRa/InBM7EKio8S0HwFVPffGLBsXAmF699DHDG/RYTi/DZjNSiI82gm/H
         tRjmopaXxwNHqTW8F5ZbBzFl8o1vllH7XbpKEL1qCMRf4BXKEPvT/4aFstLJvgF7xusL
         Rxm2qZxN/nh12RQEbVwyRSrNol6DhtTW7Kc8unyw8OKX54tO1+2e+JMBz7ooeuqy4v/a
         bDXl9VL+ZxE+9geXEq9/31bndIf9+XBUBQ1qyPm/dJOEzMkqOscmPr+B97QuyuBaGnYQ
         nHRQ==
X-Gm-Message-State: AOAM531qWrFhU7ryo4jTnPv49mBlowiL2PiANDUubJ/ZS6Uyd3PdgG2Y
        QTyzj1rKbp8BxVqX1oMP+wI=
X-Google-Smtp-Source: ABdhPJyceY+Tjx2E1vLJ8VOw77txS+bxzlDVR3Dhcj/EVOQXuYONaKvyFMjEqfjvCyKzvGpZH3bvSA==
X-Received: by 2002:a65:400c:: with SMTP id f12mr14150413pgp.296.1633412507236;
        Mon, 04 Oct 2021 22:41:47 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q27sm9268916pfg.125.2021.10.04.22.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:46 -0700 (PDT)
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
Date:   Mon,  4 Oct 2021 22:40:59 -0700
Message-Id: <20211005054059.475634-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
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
index d7ad44f2c8f5..4415bea601fd 100644
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

