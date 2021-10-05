Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0D421E42
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhJEFoO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhJEFno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121DC0617A7;
        Mon,  4 Oct 2021 22:41:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u7so16389605pfg.13;
        Mon, 04 Oct 2021 22:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KItrf/8CC1jUWlWikMSRYATLzZeQvXDG/CTBGZDdNyk=;
        b=Bpmn/v6e92t53IrffCbZ0P2wjj7VbUr7WQlZi8GiUWBePeBjmPafz+EEToTVj1KBvg
         g+1rFedFvnacJh4mrh9hXcUEzyebafq+C75uhOg4fQaKYT1tmDSg/iEYFLti0JaW4/4O
         jrwPd5BUXwnbYs9GvRIsLiGET6Z1o+Ihg0omODBRvNGxe8AXKHX29Qvi6IYZIenmeyXF
         ezs8z+AwZcwxvdzzpq33egaQPo2paUoUMU1QbQMa4BCZaNIS5hDjTbozkrPc+Mmpl9Qt
         oIE42KQJCmHBlsQyYmCOdji02opROQBhrkZlFneDM6wltr5rH+l9mYf7Tj/hULJFILE1
         EbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KItrf/8CC1jUWlWikMSRYATLzZeQvXDG/CTBGZDdNyk=;
        b=j4eI5cuNluoFKWMYR2xzQbhpOep/eXIXk7K5+pW8On30rCiEQqLcK6djsQOoHLeSCC
         aPMYnehVLprCvovQoZrKULf/aEASlm6/WkYHrIAqYuG2BPefuaaPOBUw9L1mub00jSgy
         sI0mYt1VdRwmAppzekryfbtJjgx/lOWsxMtlppuLWueT/4otcRSlNz+CnYjpYNW9VM46
         pM78xsjDoulZKcz+iHZXwxbL0UwV8bnmmDom1CJKAJ+Z49VXCeYbeyu7+N32T80ijhSr
         n15/KHRfznMQdVnIw371tR7kOlSJTEqDeVDTWZClOfq7SmRuGNYmXw3P2p3N5XyeHOpF
         /rlQ==
X-Gm-Message-State: AOAM531Ug7mECwgGBet6QNSTmUBFShodZ+vuo9fVyUmQSGSBKo636vP9
        /LokuA9upFR9/Zbb/UKAeHI=
X-Google-Smtp-Source: ABdhPJwIrub99GY0Rct4v0vxz6U9hkhP3mRxBIeZ3EN/OJJZr8q04GkioxJFL7nH8BbuY28FOs/Z9w==
X-Received: by 2002:a62:8f53:0:b0:44c:5d10:9378 with SMTP id n80-20020a628f53000000b0044c5d109378mr10034105pfd.19.1633412492209;
        Mon, 04 Oct 2021 22:41:32 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id e10sm6312603pfd.174.2021.10.04.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:31 -0700 (PDT)
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
Subject: [PATCH 11/16] find: micro-optimize for_each_{set,clear}_bit()
Date:   Mon,  4 Oct 2021 22:40:54 -0700
Message-Id: <20211005054059.475634-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The macros iterate thru all set/clear bits in a bitmap. They search a
first bit using find_first_bit(), and the rest bits using find_next_bit().

Since find_next_bit() is called shortly after find_first_bit(), we can
save few lines of I-cache by not using find_first_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/find.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 4500e8ab93e2..ae9ed52b52b8 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -280,7 +280,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 #endif
 
 #define for_each_set_bit(bit, addr, size) \
-	for ((bit) = find_first_bit((addr), (size));		\
+	for ((bit) = find_next_bit((addr), (size), 0);		\
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
@@ -291,7 +291,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
 #define for_each_clear_bit(bit, addr, size) \
-	for ((bit) = find_first_zero_bit((addr), (size));	\
+	for ((bit) = find_next_zero_bit((addr), (size), 0);	\
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
-- 
2.30.2

