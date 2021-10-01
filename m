Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6064341F46B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355692AbhJASOR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355678AbhJASOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB4C061775;
        Fri,  1 Oct 2021 11:12:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u7so8620775pfg.13;
        Fri, 01 Oct 2021 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW0jJ5BzCWKEZDvFC9cMEYLIv2cIm64unRMGWihrNWQ=;
        b=OvJdBZ+TF4jDhWy9BJ6uKlsG0FLwYuOoH5YLebogbOHxu0ArFHYVlz2NYsHLjGE7xb
         NoWQqacK8Yo+yedJyLoO1etzorDl6RZeu8n+wFlsnNqSuEPlIRXzICRdL9HJwH43Zw/P
         Aa/ecDWFDqUDa2loqbwBfyNNf9BTr01Y5FDteezZ1jq/MtTycZQU529DhJ6WiGtCiXcP
         othIZ84A8xvioPVrNWz2YcP6VMVw7a0v5zwJJ140k1ZSqRNnsxSCFZiNaArQ/apq9tyh
         oDz0Nz5Lm24BImyFoWs2PWEvJC8LjutHfXJ2kLyaAuQVsGhfsi6oIgfwb9Mpa96a54eV
         rHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW0jJ5BzCWKEZDvFC9cMEYLIv2cIm64unRMGWihrNWQ=;
        b=fbtONLRJkzCYQFm8Nb3u/77g3xnlWv6SDw34XonTi8RDk0oI0GIA9cHJqi/DRkgnlR
         alTu1Zt+bHHjI2VeuRwwfyZlmeSPCZe2SK4IRVvDkusOib+M0qm4OAmlbHIkV2apE/rw
         5Rs2FRn4NWaEhgKzGV0k3YxecDLM2aEXhrNlfqDmi4mZ+PYjdNx5bkfVt8Y2J2FyeYKl
         Lbm5BXYouQXmmKCa5YmApDBLbXl3GjM+WDEwzS2BCM+XwJ+oHkYoQ1eDJ8sPeEl/wajF
         HSMKK/O7+vZq0t1HsJ1wRyJUL1V7b6esfkAQvVx/7YQ7PKtztuW6x5MZ5T+DVvkwsUDS
         BQHQ==
X-Gm-Message-State: AOAM53068hNRPncCMQJKHo8hJug/ZIwAixtQ9SzPNOFA1XB0649PiMeQ
        jM7hIAW151pj1WiSG75kS+Q=
X-Google-Smtp-Source: ABdhPJxqTPwamXGfN+pIwwf94qaNiZ/wFFLL07ruZTsc1SqUjiRJCfdHOmnGO/+uLGkCcSET0GhKkg==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr10412536pgl.437.1633111950399;
        Fri, 01 Oct 2021 11:12:30 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q10sm3172388pgn.31.2021.10.01.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:12:30 -0700 (PDT)
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
Date:   Fri,  1 Oct 2021 11:12:11 -0700
Message-Id: <20211001181226.228340-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181226.228340-1-yury.norov@gmail.com>
References: <20211001181226.228340-1-yury.norov@gmail.com>
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

