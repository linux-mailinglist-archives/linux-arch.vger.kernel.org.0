Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2B163C46
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 05:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBSEyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 23:54:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39571 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSEyc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so22579807oih.6;
        Tue, 18 Feb 2020 20:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os68XGDBUjifyLXJ9YoVcjf5m29kyGwpnUt6cu21Uo4=;
        b=WlD3m2XzyakcphSWqvY6ufrDPoLiHTqfkDQel1TWzkr4wSIEc8m6I2qtiY+qrLWeU0
         g24miItGoafOI1Afqip5txCb4iejvdTbOEcciEI4t2EBCj5h+bH9ZcXAzvN+u3OfKper
         lHkxw+DTwWmAZjVEJ9pySiYz9LIakW1AssZAbdku//dq8ulQQ6aGSko1ag5vhyO0v3jx
         +9ixehPaMPDo8W1qU/yf4TdND+x19tPSzYWPvF/V7kJ1uHkDn2m4TiaQTPm6xWdI37dD
         RyhBWAPc8LYQTGV2ukmDO4AvpZVnmIaw9KdKvw6fkGEK7i4GfP/zjQUWgjm+eEBE+aDn
         nfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os68XGDBUjifyLXJ9YoVcjf5m29kyGwpnUt6cu21Uo4=;
        b=JtGJsFzbtbYy9hpVw7vAX3v66jUF41pPQbA5LZKNAyfR76ggOrX6o2HsGcZ6IIzSpd
         O48y0/sD7oeVwo9/MdFGTknETjd+Gxxa4h5iED5YDO8QanBoLzjgUatHd9chSGdcIdvB
         ssyBTm/pZphQJ0UNjHFnW87S1wY5wh5klhy8gRWP6B9NS1Pi4BXPU7T+aq1xHt4oJvy1
         DRg5t+0QXkJbc4XyODt4nHJaodNfuK3UAk5J2ty1D/IkLcSl7Z4XC+cHnvVZIt+r2J8m
         I2W8OI8TykyLqOUusX3FKxuTBqNgJfRE1gWXjJmwrpuhc7fTIpvI7RepV2OYPtWYl5ZT
         OdVw==
X-Gm-Message-State: APjAAAW5geamwYyfA5yvh/q7hFDF8H9J5l1+r7PKv40m8WlPtf0BFnSm
        k/3VRTjlSnZ+eoHJiF7iY94=
X-Google-Smtp-Source: APXvYqxy9VnLpe/f+G1QU6ZpnKmD90vBPbNlWqY9osCEKUE9HSgK6fxs2ivjl+MoiJ1Q8dJ5DNS0zg==
X-Received: by 2002:aca:1204:: with SMTP id 4mr3613290ois.143.1582088071777;
        Tue, 18 Feb 2020 20:54:31 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm288894otn.81.2020.02.18.20.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:54:31 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 0/6] Silence some instances of -Wtautological-compare and enable globally
Date:   Tue, 18 Feb 2020 21:54:17 -0700
Message-Id: <20200219045423.54190-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi everyone,

This patch series aims to silence some instances of clang's
-Wtautological-compare that are not problematic and enable it globally
for the kernel because it has a bunch of subwarnings that can find real
bugs in the kernel such as
https://lore.kernel.org/lkml/20200116222658.5285-1-natechancellor@gmail.com/
and https://bugs.llvm.org/show_bug.cgi?id=42666, which was specifically
requested by Dmitry.

The first patch adds a macro that casts the section variables to
unsigned long (uintptr_t), which silences the warning and adds
documentation.

Patches two through four silence the warning in the places I have
noticed it across all of my builds with -Werror, including arm, arm64,
and x86_64 defconfig/allmodconfig/allyesconfig. There might still be
more lurking but those will have to be teased out over time.

Patch six finally enables the warning, while leaving one of the
subwarnings disabled because it is rather noisy and somewhat pointless
for the kernel, where core kernel code is expected to build and run with
many different configurations where variable types can be different
sizes.

A slight meta comment: This is the first treewide patchset that I have
sent. I pray I did everything right but please let me know if I did not.
I assume someone like Andrew will pick this up with acks from everyone
but let me know if there is someone better.

Cheers,
Nathan

Nathan Chancellor (6):
  asm/sections: Add COMPARE_SECTIONS macro
  kernel/extable: Wrap section comparison in sort_main_extable with
    COMPARE_SECTIONS
  tracing: Wrap section comparison in tracer_alloc_buffers with
    COMPARE_SECTIONS
  dynamic_debug: Wrap section comparison in dynamic_debug_init with
    COMPARE_SECTIONS
  mm: kmemleak: Wrap section comparison in kmemleak_init with
    COMPARE_SECTIONS
  kbuild: Enable -Wtautological-compare

 Makefile                       | 3 +--
 include/asm-generic/sections.h | 7 +++++++
 kernel/extable.c               | 3 ++-
 kernel/trace/trace.c           | 2 +-
 lib/dynamic_debug.c            | 2 +-
 mm/kmemleak.c                  | 3 ++-
 6 files changed, 14 insertions(+), 6 deletions(-)


base-commit: 02815e777db630e3c183718cab73752b48a5053e
-- 
2.25.1

