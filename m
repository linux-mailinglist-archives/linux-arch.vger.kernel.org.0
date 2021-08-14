Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF13EC58C
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhHNVT6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhHNVT1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:19:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26FDC0611C2;
        Sat, 14 Aug 2021 14:18:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso21217898pjy.5;
        Sat, 14 Aug 2021 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KItrf/8CC1jUWlWikMSRYATLzZeQvXDG/CTBGZDdNyk=;
        b=l7uYI947B/iw2oaTR7JjucF7IyKsXidFIWIUtEbEfTUZ0oL5cANSJOEu4LQvrD0/Ob
         INoa7L2UC9R77ysNLBwmzDnKzS7P+OmIUeaVA9HYMHSfLLg9uvnkQ9uh58TN6xd2Mhm6
         +9iqzdQw/XUxgE1X2WDYRNRNdCexF8vTgevY8DLYNO4bdPpJoiX5S1DTs5p/opti/LgB
         ycFqlax2zOS2Rlc1mGtUKKUoGk/3mzIgSskZmOsT+32YEZfIvLb8t0ysJ9zs9J5gi6t0
         xYYFAaavHGoNmnRfC7WYKNw+KZ3ozra8W7Vl+2IZkbugaXRTkCrZGixsBEsXegMfulSR
         Ieqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KItrf/8CC1jUWlWikMSRYATLzZeQvXDG/CTBGZDdNyk=;
        b=lS+Xs3oLdScrQbM/aAFJgeswy4NmtwDLv6T/siNWVxRrcRLXn021M792R0vTTeoYmf
         UdLJ879uYx1Gvna1zWW8Nujj7o/cxvaBkH3HPhWIpq2WswemhqoRj/AidhTWyLeo9tPG
         6dsJphiWfQkMU5E1vtB/rLWpw7Q9P/D4fFQZ9QnTrNDiNmb/dlIEvVSyOzM/R1RA3s4i
         joVVQ7YlLn8QDxubV09KhFPLHAlFVvpqwF09oAXhiYpBC56yETdkNG1D157q3asq/VVU
         dGooxwvvqFL7j34M/4uTsCX7hkhCBzHFknjwYR8KjbLekB2AY3AcOp5LalH1K1AKlc/m
         p8zg==
X-Gm-Message-State: AOAM5314TVrDAzGx6hvY+bfi4kP6B/4u/b5B9fOjC9SBayE/yRiI7AY2
        SW/98c/HntDj4PMIpZvEeuQ=
X-Google-Smtp-Source: ABdhPJzx0zgC2+trJYnSik3yZXHcM4MjcSGOM6wo+MY1DbERIodJQzdRIpPicFndvREAiSf80uQWGg==
X-Received: by 2002:a62:e50c:0:b029:2f9:b9b1:d44f with SMTP id n12-20020a62e50c0000b02902f9b9b1d44fmr8751892pff.42.1628975923174;
        Sat, 14 Aug 2021 14:18:43 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id g19sm6309451pfc.168.2021.08.14.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:18:42 -0700 (PDT)
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
Subject: [PATCH 11/17] find: micro-optimize for_each_{set,clear}_bit()
Date:   Sat, 14 Aug 2021 14:17:07 -0700
Message-Id: <20210814211713.180533-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
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

