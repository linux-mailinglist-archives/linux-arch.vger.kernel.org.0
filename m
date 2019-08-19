Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD28951CA
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHSXli (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 19:41:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34718 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfHSXlV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so1733601plr.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HreLvL0NQdF/1iA+dDAwR1GTUkwZVUVVoZNTJGq+G44=;
        b=ND71brxDZ8HW8h/QEOw2Eqv8UdzrmWN9/xAdOnsfh5mtlt4yOg/eu6/HpN1WxjGZmC
         j17BrdwqFoFFQnoBtAF2cN7VJKMl637FR9zO+Rzb8jKa4Dhe5TwyF9z90VS3VglsiY1A
         iQ9ww2B8zf10ZJ0kFFjt0BT3+eLVp9byy3fV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HreLvL0NQdF/1iA+dDAwR1GTUkwZVUVVoZNTJGq+G44=;
        b=F59VhfvwMK01U/BWHtQE8VgHS9Fo/ilhsD2R/JFbLWYxzpYhebiGEM545pNo1VUKyg
         G2rBNNcSiv6PQ30pTx5RUHsdgwPgRlclSIGfEUeDSe8Qp9758lw1un5Mb3g3J4KY/VG+
         IwLdtUOAfM+wUg8+zbSDOPTlbISRmmuZApzwGrwshplZ3oQsry3YDVFUQh2bhTahavKe
         MrLa0t9S28ufaAPLGXvCyc/gqOZmhUFt90IxktImImbyOZJYDgDA9I8gJpCRjbU6RHFA
         9SK7cpAYNQw4tQ3ob/er3FUt9/SRitU/De5qNTrNutbR31wZqEi8s1qmjl8q74n3VrfG
         xoLA==
X-Gm-Message-State: APjAAAXZ5l0p9O8fzsp81tZvkg9IAeUs+9byCXs8GBxmuRZUhBwGutx3
        dXILsSHHMpqRBlzPIXEG4FB8zQ==
X-Google-Smtp-Source: APXvYqwGeOsqWXlN559F9D2mI4DfjIxBmzpkVPBpeH+5L2IqdWudvDJ9Z3nTop04Q3ieydSVvjsdpQ==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr24783840plk.33.1566258080522;
        Mon, 19 Aug 2019 16:41:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm17784276pfk.157.2019.08.19.16.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Drew Davenport <ddavenport@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Clean up WARN() "cut here" handling
Date:   Mon, 19 Aug 2019 16:41:04 -0700
Message-Id: <20190819234111.9019-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy noticed that the fix for missing "cut here" in the
WARN() case was adding explicit printk() calls instead of teaching the
exception handler to add it. This refactors the bug/warn infrastructure
to pass this information as a new BUGFLAG.

Longer details repeated from the last patch in the series:


bug: Move WARN_ON() "cut here" into exception handler

The original clean up of "cut here" missed the WARN_ON() case (that
does not have a printk message), which was fixed recently by adding
an explicit printk of "cut here". This had the downside of adding a
printk() to every WARN_ON() caller, which reduces the utility of using
an instruction exception to streamline the resulting code. By making
this a new BUGFLAG, all of these can be removed and "cut here" can be
handled by the exception handler.

This was very pronounced on PowerPC, but the effect can be seen on
x86 as well. The resulting text size of a defconfig build shows some
small savings from this patch:

   text    data     bss     dec     hex filename
19691167        5134320 1646664 26472151        193eed7 vmlinux.before
19676362        5134260 1663048 26473670        193f4c6 vmlinux.after

This change also opens the door for creating something like BUG_MSG(),
where a custom printk() before issuing BUG(), without confusing the "cut
here" line.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
Signed-off-by: Kees Cook <keescook@chromium.org>


-Kees

Kees Cook (7):
  bug: Refactor away warn_slowpath_fmt_taint()
  bug: Rename __WARN_printf_taint() to __WARN_printf()
  bug: Consolidate warn_slowpath_fmt() usage
  bug: Lift "cut here" out of __warn()
  bug: Clean up helper macros to remove __WARN_TAINT()
  bug: Consolidate __WARN_FLAGS usage
  bug: Move WARN_ON() "cut here" into exception handler

 include/asm-generic/bug.h | 53 ++++++++++++++++-----------------------
 kernel/panic.c            | 34 ++++++++-----------------
 lib/bug.c                 | 11 ++++++--
 3 files changed, 40 insertions(+), 58 deletions(-)

-- 
2.17.1

