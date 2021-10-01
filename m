Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A241F4B0
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355820AbhJASPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355893AbhJASPL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:15:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF5C06177E;
        Fri,  1 Oct 2021 11:13:21 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r201so4251638pgr.4;
        Fri, 01 Oct 2021 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KItrf/8CC1jUWlWikMSRYATLzZeQvXDG/CTBGZDdNyk=;
        b=hvzO7QUqCKq80JWmczkm9F1XsojfIjsT6sL1BvDhvH3yswXLbSqB14lWUycWwf17Cs
         paVfPt37iaUgR3aZ7T+AMrC1BChw7Oqpqq57H33vNLmXrrb11VGpILQPPsdw3Db3npKG
         YbBObDz1hT6+1J2OJmxUytIs/F3NSrfcQtZX2sR2XZUpcvbIGDkgplolWn7Zao4+aY3P
         nnJjv3/j26hXWVP8GAUelSasST0cBj9n/WGwyvqYVC2+iiMjfj0NYMwKnFf/gu4h8bD0
         2DdRLmcVlHtNdrYGNPLPBYhx9CxjMAO7RwbbzM9A2J/2jgv3MCsUU84RLb1z9cUXbrVo
         AFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KItrf/8CC1jUWlWikMSRYATLzZeQvXDG/CTBGZDdNyk=;
        b=sz3hl6Cl4foMI7aZ+F+QXzR7coYpr3EueZDkH13eIcJcsTslInKXrnOQRiRwPvozdT
         LpUBovXVDpagPNBjppxbbvgVOOMwslRNVKUcm6VXGplOT07WEs2HCTDFMNc2a4BXL7MV
         Kpk0MInHBtwnHHHKs3DS/tjT4tI401iZzcASxwDorZGh6dHP0srObD0aafCwPQOCp4vX
         YxWohNdd+W1a4LIANbfvjQFfQ4M6d5qJBHQA1hVgYD90GLFfoGPtNb+DKBlEPNEG897K
         9CE5zna1uQoOSbuCFNELA2g3SgLD2Ku3Is+/v11kS88+Nl6eh6QDbrRKkNOSMIjzaUXh
         6K7g==
X-Gm-Message-State: AOAM531CRe5bS/xkljzLHwupneN9Jw25qU8DXAv1hh2W7xcgI5AtuNB4
        XBlpky0dIjdU74Nw+Sb92aU=
X-Google-Smtp-Source: ABdhPJy63QWzYfka9stv8WCp68mZSua/IICcFSjcVwG0FkOdVATEaBbbU7JB45fFwQs/JjJuBnib2w==
X-Received: by 2002:a62:7ec4:0:b0:44b:bc4b:844b with SMTP id z187-20020a627ec4000000b0044bbc4b844bmr12986951pfc.48.1633112000495;
        Fri, 01 Oct 2021 11:13:20 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id g9sm6983227pfh.13.2021.10.01.11.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:20 -0700 (PDT)
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
Date:   Fri,  1 Oct 2021 11:12:40 -0700
Message-Id: <20211001181245.228419-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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

