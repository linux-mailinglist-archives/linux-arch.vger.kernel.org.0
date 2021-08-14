Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271883EC55A
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhHNVSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhHNVR6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:17:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE4C061764;
        Sat, 14 Aug 2021 14:17:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u15so864535plg.13;
        Sat, 14 Aug 2021 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW0jJ5BzCWKEZDvFC9cMEYLIv2cIm64unRMGWihrNWQ=;
        b=uErIx4JmQ76cCCVPx5CCKW2Mj3AD2fjDWWnuh0GNL9v46FURJRmrpdoQfoGj6/b3qN
         jTSZFekWthrYQHMgmxEHxeC9W+nvXnAQ/eSBkyikvooiYv0PNTCj65It9BdCVou31xo7
         poXO8Mt3Lh6koIW1t95Lc3lbPnKVB4TTWh9pBOhkabnpgMdXzwUmxcutki295pt/5Cd6
         Ta9PaSmUC4FZrm7JQWm9TLjWnfyoIOczhxva+/Q2JHro9K/s/8Or3BV/aXMTnFEdhZX1
         +Sq0s6ZpuJ82VVpwSWNxotRAlj2vToBAJ+wSOdgj4VYtu6Bhv1Ane3qLZ04Hyn0oFg+I
         02YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW0jJ5BzCWKEZDvFC9cMEYLIv2cIm64unRMGWihrNWQ=;
        b=Y0iV8UkQp+ztf68P/9P68XUQx9XxFGWZCjj01jMLS24ly9ewf9vGK9tuY4QtT6QKhz
         yEQaQOSex1bvbOYZeyhh6GXBZ5CGJugVgcM+C/JhZEpx3x+Zo2KA1ZgPuyCUimmuXWFn
         Pn5LX3kTEVe/lixzTOY35WaVIRwvnxWgA8E0jLStVKgarorcmfCK2lN02rNCROHLjk4b
         O4MTAXTOXXhLRV6d/tcjIJlka8MeM11AIwH1kcfTVpc6uHLpb0BTl3GvXnISZ1PcBkP0
         rUyIpREoK5aFqGCOscVbm0/f5LCuTd45yG+2SGr3eB7bSSVXef9QkMIURsDVPZR8eOZO
         K6Yg==
X-Gm-Message-State: AOAM533yCGknhnV40fxxsLlXpWdghsAbgEaJm2RTCrCKGn252K1zV806
        ggqQvR50s2PdfYKUufJXC9I=
X-Google-Smtp-Source: ABdhPJzVZ5bHEr1/RrNfwAETbYe2CB/HsbRwMbDkIcRaF0YVQ1BpIBuyWPB4OY1UB35YRShRY1kJAQ==
X-Received: by 2002:a62:dd57:0:b029:3cd:c96e:625e with SMTP id w84-20020a62dd570000b02903cdc96e625emr8328640pff.45.1628975849220;
        Sat, 14 Aug 2021 14:17:29 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id w186sm6722230pfw.78.2021.08.14.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:17:28 -0700 (PDT)
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
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 01/17] bitops: protect find_first_{,zero}_bit properly
Date:   Sat, 14 Aug 2021 14:16:57 -0700
Message-Id: <20210814211713.180533-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_first_bit() and find_first_zero_bit() are not protected with
ifdefs as other functions in find.h. It causes build errors on some
platforms if CONFIG_GENERIC_FIND_FIRST_BIT is enabled.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Fixes: 2cc7b6a44ac2 ("lib: add fast path for find_first_*_bit() and find_last_bit()")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/asm-generic/bitops/find.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 0d132ee2a291..835f959a25f2 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -97,6 +97,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
 
+#ifndef find_first_bit
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
@@ -116,7 +117,9 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 
 	return _find_first_bit(addr, size);
 }
+#endif
 
+#ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
  * @addr: The address to start the search at
@@ -136,6 +139,8 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 
 	return _find_first_zero_bit(addr, size);
 }
+#endif
+
 #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
 #ifndef find_first_bit
-- 
2.30.2

