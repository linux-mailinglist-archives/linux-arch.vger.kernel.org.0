Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02675BAEC1
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiIPOBr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiIPOBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 10:01:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74EAEDBF
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 07:01:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jm11so21493346plb.13
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dshUPBRJIl5fQ3m+ssb6SG/5FdHYdXyc9t5E5ytWG7A=;
        b=KJywVQRZtjplc5TGof+5IB3YhDZ1cj4PaRPTirKpaoAWiDyUT37EbdBi/Y6B5Gkr8z
         ZDGs/2FeL1kKj4BlkwYnaHp7WI0rXBLKeFN8+DRFRPbwxeTpjaP1Wch813VfZj3402OV
         NBI/x++MrNCGX13ciSjAaHPqJlIQFUpAaYvDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dshUPBRJIl5fQ3m+ssb6SG/5FdHYdXyc9t5E5ytWG7A=;
        b=g+5RhDmp5/jXXGsFv5BG7M5mTMLgJm4/tfaCyXClYXW95h4WXo4rooldGVn87Muizj
         aw2XgfqL7jzTzp+Kenx+wmr+vQaS8hGN8YCSRwq7UxtYUOYk+p/4F7WRh5XYbPczGr7A
         1S4G09jLMnBc3N/5hWNiKVQpipTV8ZqsDDUdriNdB23AvhV1W4iN2lri/55Kmo6icwF1
         q9lE57D8RNjxMo+tQ4Yux9OSJ7ic0qlwrC3g5JMWefDtFjWZP8gM39BZDsHIccfudhlW
         lM6I7HIRux8/gHDFoNNBNb10c6zvqQuL5RmzGRPIUNbBn73PdgEmWjdLoGCMNbfS3aun
         nzlg==
X-Gm-Message-State: ACrzQf3YHTcxD2rAXx0mcxek1beZfTZxQMcKa6NWL+Ohf8jpjGF8WqB1
        Tm2rSBP44s0Xo4KKeprHB9Y6qQ==
X-Google-Smtp-Source: AMsMyM7FPr3ttzTgQ3tdx2Q+bJSysj1THjM5T1H6W7iKbf+UddOl/uTNkl6+XFWhGvTzSAnFX79yeA==
X-Received: by 2002:a17:902:7586:b0:172:d0de:7a3c with SMTP id j6-20020a170902758600b00172d0de7a3cmr32332pll.38.1663336895957;
        Fri, 16 Sep 2022 07:01:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b0017693bb573bsm14977334plh.219.2022.09.16.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:01:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 0/3] x86/dumpstack: Inline copy_from_user_nmi()
Date:   Fri, 16 Sep 2022 06:59:51 -0700
Message-Id: <20220916135953.1320601-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; h=from:subject; bh=jSBWpoIe+6cXWMHiTXIhWphUWHU4ykwNIRUXr/4DVx4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjJIFYo65hwFSmDvAvVocaTPb9H0pjJ5jbJ7o1uk2n 7dnNUeyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYySBWAAKCRCJcvTf3G3AJn3rD/ 9E8k/SZ03fsh80iTtJMwqtgbWeq4LfkrcDgACQDybAdhEFe8UHobkHfxFqe6Z7tB1wx1vROAEIMkv9 OrPukObMRJnjWlBukozI//Ks1UA9gQ3KJn7BbLOEGbxc9AMfj7Wop2uuKRIOggTLyxe3tdhzGyykf5 bhkr2yF1yC9qMEDhRZc3HSEPVb7OEONYglnwtkW1kYNxp6oxLocVk2cAic+RN30J2kTVBD3eh7cc1k PIsEwvnF5H5tYncJ3OuXpeOr8bNwOBowuiIz+GZjpjAZbIOo46wxO1Vr+nk7EsvnJOitcIshSkSXIN l6NITgMsLU/1+lKx8HewHzXqdxutwRZHQSR2ktPvG9Iz4BPlk5IYve4WaGayIGX3XJtl8+dhWFq3mS aBjA/aeSmI/+C49lcOiRqtaSe9++BLdnXoxn76HMoSeu+zvratvPEr1qquwMW9zd1bDy1Rs85XPDDS v6KoaYTS7+tYjgb+7O0UbVD4gcQSjy7WIdZIKAAEbR8Ndy4rIN11XJUBUjmRVFrA3KHRgVSJswyH+B 24ev76tRD9itGgmlrzqJ8J52zbYZeHFfnP75AomCUdEmHSmE+BRq8QqZl4PtZAi1BMhPupcPrRa+Nz 0vC/C3W6/62vDvtjpsXdYhWvTyMhYjvTmeW7lyuBJqY6RKIjzU+i+yrN+Idw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This fixes a find_vmap_area() deadlock. The main fix is patch 2, repeated here:

    The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
    designed to skip any checks where the length is known at compile time as
    a reasonable heuristic to avoid "likely known-good" cases. However, it can
    only do this when the copy_*_user() helpers are, themselves, inline too.

    Using find_vmap_area() requires taking a spinlock. The check_object_size()
    helper can call find_vmap_area() when the destination is in vmap memory.
    If show_regs() is called in interrupt context, it will attempt a call to
    copy_from_user_nmi(), which may call check_object_size() and then
    find_vmap_area(). If something in normal context happens to be in the
    middle of calling find_vmap_area() (with the spinlock held), the interrupt
    handler will hang forever.

    The copy_from_user_nmi() call is actually being called with a fixed-size
    length, so check_object_size() should never have been called in the
    first place. In order for check_object_size() to see that the length is
    a fixed size, inline copy_from_user_nmi(), as already done with all the
    other uaccess helpers.

    Reported-by: Yu Zhao <yuzhao@google.com>
    Link: https://lore.kernel.org/all/CAOUHufaPshtKrTWOz7T7QFYUNVGFm0JBjvM700Nhf9qEL9b3EQ@mail.gmail.com
    Reported-by: dev@der-flo.net

Patch 1 is a refactor for patch 2, and patch 3 should make sure we avoid
future deadlocks.

Thanks,

-Kees


Kees Cook (3):
  x86/uaccess: Move nmi_uaccess_okay() into uaccess.h
  x86/dumpstack: Inline copy_from_user_nmi()
  usercopy: Add find_vmap_area_try() to avoid deadlocks

 arch/x86/events/core.c          |  1 -
 arch/x86/include/asm/tlbflush.h |  3 --
 arch/x86/include/asm/uaccess.h  |  5 ++--
 arch/x86/kernel/dumpstack.c     |  4 +--
 arch/x86/lib/Makefile           |  2 +-
 arch/x86/lib/usercopy.c         | 52 ---------------------------------
 include/asm-generic/tlb.h       |  9 ------
 include/linux/uaccess.h         | 50 +++++++++++++++++++++++++++++++
 include/linux/vmalloc.h         |  1 +
 kernel/trace/bpf_trace.c        |  2 --
 mm/usercopy.c                   | 11 ++++++-
 mm/vmalloc.c                    | 11 +++++++
 12 files changed, 78 insertions(+), 73 deletions(-)
 delete mode 100644 arch/x86/lib/usercopy.c

-- 
2.34.1

