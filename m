Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B33421E4F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJEFoW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhJEFnq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D9C0617AA;
        Mon,  4 Oct 2021 22:41:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k26so16431890pfi.5;
        Mon, 04 Oct 2021 22:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nf81eMg0W7fVWw+dS1fRTqTJZj1jgno6nh0Ggg55AFs=;
        b=ItK3sXhsAM1f1ASq5u4DaKGjX0YlsAxopFtfKS5hkUGd2sSnkTU+qaKgXZTN57kjrH
         YyTiguK30n8ixSoHgKeQTHnWXideSR4lXu6Y5AQ1qutTOlTpCfF4vK091PRnFnIemVFq
         IdLl4+cpPVnnyEkM35F/tFy+WN6FWqNQHEoCuIJJdJ07OO/Q8/wG/CUh7W07ELnQf6LA
         Vr259OX/kYoyfHAjZHTpVnA1b0afzM45P5r63b+WD8ltL0vaY5hYThrMKobSsbekeQoA
         FkrL760sIbMTlMuhmcDJ60JMRRgj+4U7jqSsffEqH3hUo3OB+xMEQxsIgIFbn37xPzfn
         +Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nf81eMg0W7fVWw+dS1fRTqTJZj1jgno6nh0Ggg55AFs=;
        b=DNvrV5Uek0CPr+ZZiOcz9k8+rxdaZj6XJBT+M3kSqRFeaEqoZOyMIN1fVu+3zlP3Ad
         iZevV1AFrdUKa3cUQFMPetHKPUra3qbEZVpPRo4rOQJLmX2gu3dFge4vrEsVs0hxvr+f
         j79M1hctL/6ALhuNgmbvAnuNdUYlVQ/o3+HecmgcYuzPHcBrPgGR1+IS+PxXyupATJrj
         FGFKkC8UrNQX4iM/XSiAD1uUPLRmyZuubUoNWewcs3+b3ZAjdxdrCgp+9J+seCj9AeJi
         X0j73XcEi632p7+DE19jt1OWZ92DEa35/hSe9kcI8iyX667DNRvIb+GjbSMBtYjuFhp4
         cqSw==
X-Gm-Message-State: AOAM530+8Ce72thtaIB0v2F4GQSK6Xb6Zkva9H12ZAJazdO4rxxm9D0q
        6sgXM4BXjKm5TX2fvC4nBgg=
X-Google-Smtp-Source: ABdhPJwkGoS5lx+2DFRKSI4puA9sR0Q04TQBSdoQwr4TaY60RgunHwEUf0OU253yIkwHPeX5ysEAEg==
X-Received: by 2002:a63:1a65:: with SMTP id a37mr14296966pgm.338.1633412498651;
        Mon, 04 Oct 2021 22:41:38 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u19sm10821033pfg.18.2021.10.04.22.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:38 -0700 (PDT)
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
Date:   Mon,  4 Oct 2021 22:40:56 -0700
Message-Id: <20211005054059.475634-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
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

