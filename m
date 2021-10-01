Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9441F482
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355784AbhJASOt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355731AbhJASOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB6C0613E3;
        Fri,  1 Oct 2021 11:12:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n2so6809469plk.12;
        Fri, 01 Oct 2021 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW0jJ5BzCWKEZDvFC9cMEYLIv2cIm64unRMGWihrNWQ=;
        b=Hjjio5YfbTL06CUplVnQJQJhcQPKaiyKvx26hAhLV3vk1nJOntgtfOuJtcvYMOsnFb
         VRx1gO+rerN95uQpdWOqxRrPG3Jy6DaNSeml+AagbFNyv/bvPN3qkA6KctHIuS/tA6io
         YiEd0mfN/Xv496SYNRDlfmOf54pO4xw3B7YcumaxycffAsDCJy7l0N+P7bufKNlkgU8T
         sHBo4sVwP3il0jQhaKjUapuaCP5ae1tL9XcbLk+yGYn8zziBifO0RQW6fEmovylhX4nw
         LyQ8RR2JTeS+IwrAEBtPSlPWoKpMQyHtZw/wyxgCmm/TvhZaKCdL30uGYjTkrAoGU3sO
         MmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW0jJ5BzCWKEZDvFC9cMEYLIv2cIm64unRMGWihrNWQ=;
        b=t7wzv/53R6rzRf18XNrXYLitVnv10I0LpK1+jlLs78v6Tc4GQHQHeUC1wWK955qiTi
         cGzUbO8gUxyS9MwNDPLH8kN512QFoNndY+xDi5D+HaKrYDqbZa4FmlukFaVUktN5Dxu0
         OvUTgOJSEeJfS394Xsc2YOrGjwup38E3hu1KvIcwCVtC/gxB2nrjNyxnhBojz5z+qeG9
         Ic/gpbuImUxIMjXjLA6FX13HTwsPhZaB2ezr95qSggWdBH0iQTiiixPhgz2FEDObfncF
         Ko0zlQpH3ulNAzk4nH4q7qjWQbqTsgOxb6ON44NGr38UMKtfOKLLGKOCB8jfGm+l2LVZ
         QYUA==
X-Gm-Message-State: AOAM533Xgasu9ztymTgv5spXHXG6LN5hW6WQV3gW7dOHl6QJtdDGTdKs
        gUiqt1EBKFDHw4ZZNfLR+56/qZqhCMA=
X-Google-Smtp-Source: ABdhPJzTli1lgOmLPmYx3FXRy4h6bEUXTfXqlWFX2kweIYnlQRpIf0Lo6E+elReKGpgFRHbQJn7LAw==
X-Received: by 2002:a17:902:c409:b0:13c:a5e1:cafc with SMTP id k9-20020a170902c40900b0013ca5e1cafcmr10687285plk.52.1633111968675;
        Fri, 01 Oct 2021 11:12:48 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z8sm6797304pgc.53.2021.10.01.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:12:48 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 01/16] bitops: protect find_first_{,zero}_bit properly
Date:   Fri,  1 Oct 2021 11:12:30 -0700
Message-Id: <20211001181245.228419-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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

