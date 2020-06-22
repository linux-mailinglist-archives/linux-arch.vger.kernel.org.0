Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C802045EA
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 02:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbgFWAkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 20:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731682AbgFWAkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 20:40:14 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63FFC061796;
        Mon, 22 Jun 2020 17:39:35 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so17407628oix.11;
        Mon, 22 Jun 2020 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5frG9PhqG81tC9AD8peh3y6lnck0h80KeA34w2QTi0=;
        b=M4LHMsDwVudq789ECDROYNzRIICk1ttjS1ncna7EYie51HINxwRkSCkD47RoL0NnHh
         glYQPY8zfU33XLAeJFMslLYAIiou9SKAZf9Jb0E+/mjydddQRBMGjMyo9lkgDo2O89Vf
         JcGpe11+gNsWlu4C1DCk+DRA0XmZiLB+qPMQGWEVCNscx7kk6m3zIif0znRiHlhUhRcI
         FSqQVdQ7iNlDjLrNJLSSqb9NjPXP4WIG50NllRFqsCzYg+8Pkwx5zm4l75QvHPmXUg4i
         SJQHK7qd9Vyl1T/8s1hA2UaMiX8wN/ZB5RxNle9Mp/ktwj12uG2TDt2s3v/j4UPpj9/J
         Jchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5frG9PhqG81tC9AD8peh3y6lnck0h80KeA34w2QTi0=;
        b=gn8U0JODEJjtV4eubRTIT/mC/2tE2jMUC0cN+uPYKmEUHvLHIx5eyHS9gs2kzbHxay
         kKLbMVtGjvTr7U/7sIKRq1aUVtjyBkRhsidir1PZ6QOOpLwH5JZKZp/7OI4hxJAnOYS0
         VGhLAsKgMSFlfO7+P4CbWzP1bahcFruK/JorqUUXbyR4vI0J4sxkAmjD55MuoMe1bq8j
         67ZwKWZPscbDVXR2S47whLsQjWVbN+I882rLxqG9hNkCondZmS+ZcEE5AjmWfu1cZsxs
         gOZybD3T/SmPMkTo86ifsF2RnUJ16Ki2DXFV4LrODYijqpQ3hx4HXznhCla8hj8oyXrQ
         dqQg==
X-Gm-Message-State: AOAM530lNvoMK84D7atPnsWgFApZVwnEZHEJxJenPJ0RltcsRVdilC++
        euhcvGL5rOWOcVGEsNYt1QQ=
X-Google-Smtp-Source: ABdhPJwkxsnp1phakg48o1v9aSd9BwDZmncJUg+C6esTltMQGvrMcZOkpNlawBJzvOzS0ELy6l5QTA==
X-Received: by 2002:aca:4ec3:: with SMTP id c186mr13675944oib.64.1592872775112;
        Mon, 22 Jun 2020 17:39:35 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id y31sm3677828otb.41.2020.06.22.17.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:39:34 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/2] asm-generic: Make cacheflush.h self-contained
Date:   Mon, 22 Jun 2020 16:47:40 -0700
Message-Id: <20200622234740.72825-3-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234740.72825-1-natechancellor@gmail.com>
References: <20200622234740.72825-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, cacheflush.h has to be included after mm.h to avoid several
-Wvisibility warnings:

$ clang -Wvisibility -fsyntax-only include/asm-generic/cacheflush.h
include/asm-generic/cacheflush.h:16:42: warning: declaration of 'struct
mm_struct' will not be visible outside of this function [-Wvisibility]
static inline void flush_cache_mm(struct mm_struct *mm)
                                         ^
...
include/asm-generic/cacheflush.h:28:45: warning: declaration of 'struct
vm_area_struct' will not be visible outside of this function
[-Wvisibility]
static inline void flush_cache_range(struct vm_area_struct *vma,
                                            ^
...

Add a few forward declarations should that there are no warnings and the
ordering of the includes does not matter.

Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/asm-generic/cacheflush.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 907fa5d16494..093b743da596 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
+struct address_space;
+struct mm_struct;
+struct page;
+struct vm_area_struct;
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
-- 
2.27.0

