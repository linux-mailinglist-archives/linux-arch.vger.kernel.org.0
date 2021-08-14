Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9325B3EC59C
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhHNVUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhHNVT4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:19:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0176C061292;
        Sat, 14 Aug 2021 14:19:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e19so16290165pla.10;
        Sat, 14 Aug 2021 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Cln644oA5BtyIgpgaZQiZNhvZEjmPyvVC+lofWod4OE=;
        b=WMJpwYfq3UWrnHQf3XZGnUwN7halllE4Zh6nVwPNP+xHqyTu1DBiwM63+thW+pB61w
         H0lrWah0eBUT5yAxpyUwU0zZt/dibfzOvgTPZaPZH53pRJ2GGERqb95nsamfAPaeHuY8
         sqzjFzro/0HBMvkXu9jCm/lV4KF7sNZeh6a8baeBCXFHzS7iHNCyJW5i/qX3uzmFo54B
         g7tPy2mU45RHZkA0i9xNhHwqc8dvVplUiR58RGDbEQKqJF+gzV8X17g7K3uBUUdxPdYx
         Vw78pu3ui78jXj1e0LRtun92xYYb/T9VWLdB9qFhAf4MkYEHUC8S9wnbW0gnkulz4xF6
         BjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cln644oA5BtyIgpgaZQiZNhvZEjmPyvVC+lofWod4OE=;
        b=lfUos1MCGSa3NlQjUgBBLrEAo2ksuqJlhTG0wKmQignLE8+LAO5wVENE2jWjxGKd2K
         SOl4tSjEfFFYpl+jyhPHKiFDBjNOtpRIC5fZCmJ78laaAO1kQdsm1TO9DfyDdObuC70Z
         ezuXtQcybl+RAOSO4lr3Jkz7gUL8Mco7d5hNmo4am6qc+LOAtrlt9IAHzZXQU6OU4NtL
         471OUkA6EhCgjN9IYSMZGL2RrEtnac0nt0DisHx8kwwJ4bJiwPDzThWNTbnAAoyAgYsS
         E4w1u2o41i2l+T/YV6RauokOnK/Hef2HIEvRKolaFhx7JYI8EPhaVKkYAPcqTclgsQf5
         3M0w==
X-Gm-Message-State: AOAM532KlkoWpNAfRrE2W9aO+cAXcdIDHUP15g5joPm0K30qMrzwSNvz
        0OLFsAFxM87x5aKehP/Fw4c=
X-Google-Smtp-Source: ABdhPJzpRyMzX46v+gpIRpFuXuj44bZVB/U1vao07RTfvftK/oxJua8CT59/WjdrrOo4bVCIWqTwCA==
X-Received: by 2002:aa7:9050:0:b029:3af:7e99:f48f with SMTP id n16-20020aa790500000b02903af7e99f48fmr8626836pfo.2.1628975945341;
        Sat, 14 Aug 2021 14:19:05 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id 26sm7830159pgx.72.2021.08.14.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:19:05 -0700 (PDT)
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
Subject: [PATCH 14/17] mm/percpu: micro-optimize pcpu_is_populated()
Date:   Sat, 14 Aug 2021 14:17:10 -0700
Message-Id: <20210814211713.180533-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

bitmap_next_clear_region() calls find_next_zero_bit() and find_next_bit()
sequentially to find a range of clear bits. In case of pcpu_is_populated()
there's a chance to return earlier if bitmap has all bits set.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a43039629aa4..8bf8b88446d7 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1070,17 +1070,18 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 static bool pcpu_is_populated(struct pcpu_chunk *chunk, int bit_off, int bits,
 			      int *next_off)
 {
-	unsigned int page_start, page_end, rs, re;
+	unsigned int start, end;
 
-	page_start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
-	page_end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
+	start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
+	end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
 
-	rs = page_start;
-	bitmap_next_clear_region(chunk->populated, &rs, &re, page_end);
-	if (rs >= page_end)
+	start = find_next_zero_bit(chunk->populated, end, start);
+	if (start >= end)
 		return true;
 
-	*next_off = re * PAGE_SIZE / PCPU_MIN_ALLOC_SIZE;
+	end = find_next_bit(chunk->populated, end, start + 1);
+
+	*next_off = end * PAGE_SIZE / PCPU_MIN_ALLOC_SIZE;
 	return false;
 }
 
-- 
2.30.2

