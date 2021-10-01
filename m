Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7219E41F4B9
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355962AbhJASQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355899AbhJASPq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:15:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B593C0617B1;
        Fri,  1 Oct 2021 11:13:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v19so7109283pjh.2;
        Fri, 01 Oct 2021 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nf81eMg0W7fVWw+dS1fRTqTJZj1jgno6nh0Ggg55AFs=;
        b=lLZwpryZB98PlGeM8ZanBwznPLR+qj4BAk9K/uf8CR1i4Vr7ohWNGkej3kVUNqXdVG
         1Jz42et237u6yAI2fLT63htNSZHBQhI5hTW5QlTYMfJALg2QS7K341SuCyg4JVoN+kGK
         yOPWlwz1SZqxUrFbg0dAknq0LNE8mNSh0R3dX8vDH2CEQhdIdhjfR7r7zRN3uJrZXcfW
         4oysstkJLDNrmHqITg7OwYcRcURoNhlMq4pNYfSkpvdiR3XB3A3qF8SPFy4Vr8b3LYgh
         GIuCVYH1I8wQMVDx8yJeJME3oPJHo6nsCRdz2f0rkYcuGYqLc+cVhFZggI3dGfdtYMGP
         dgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nf81eMg0W7fVWw+dS1fRTqTJZj1jgno6nh0Ggg55AFs=;
        b=l6HFr1nt7qh0YTsftDmPPReVwkhz4PNG3YiKB/OHM14AV6ANoZbMCRNxw6h+K/rgHE
         zxQd/ekpNvg9LyzqY+u2MBtC5oIBSG1azmSA16U3tS+ZJv30T+bwsPNGeRYMajEsXU89
         WFa9f5vjE6LH+Uvn9pD5DN5VMfabp/Zvgd3RIZWLZ97QIMYkjFKlUX7DXEmWJqeYvDrE
         claKN5qBowbuVZfu+ThuzsuQ6Y/1lgNR1AqMjz72eE5pQCZSlNHA5c4WCYJ2v1L4DzUz
         tB1t65PnjyqKlL94GGYdKy9Ppcc53oTGq5BRu0iTvMdN49s1+mEc8wFgN1s1BkSvg+8P
         HHpw==
X-Gm-Message-State: AOAM5335lupF2e6siSxDYqKRu9XAoZEPPDKMqoL6XzJADckrb3acsjIx
        VT4iy6HLVxXwtu0LvMPQEHo=
X-Google-Smtp-Source: ABdhPJwxSbuZpik63wXkHcsR03oG0P45JgB69KyL2Up8CkB/6v40eakk14TkFHTNdybDdRPkK7Axtg==
X-Received: by 2002:a17:90a:2841:: with SMTP id p1mr15463362pjf.153.1633112006983;
        Fri, 01 Oct 2021 11:13:26 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id o2sm8177868pja.7.2021.10.01.11.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:26 -0700 (PDT)
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
Subject: [PATCH 13/16] mm/percpu: micro-optimize pcpu_is_populated()
Date:   Fri,  1 Oct 2021 11:12:42 -0700
Message-Id: <20211001181245.228419-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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
index e0a986818903..1cf0bb904b1d 100644
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

