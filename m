Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC13FE635
	for <lists+linux-arch@lfdr.de>; Thu,  2 Sep 2021 02:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhIAXjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 19:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhIAXi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2021 19:38:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F9C0617AD
        for <linux-arch@vger.kernel.org>; Wed,  1 Sep 2021 16:38:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so26153pgc.6
        for <linux-arch@vger.kernel.org>; Wed, 01 Sep 2021 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tl7TywVZic9PhfHq2BmWEfnSDIUToLj1FPGq3mOdgmw=;
        b=amPN+xrpXeCcUvsXZ2d7UHDE2nH9GBoGfLpr/Zq1IJmdo/pqCdlZwLqKWbBbEKvD4u
         ryvzcTzvvpj8VE22IBXoux6mnmBeTmz8rQKRLRvtp3fCsCNSoA5vuIX5ioGrz3CexbzP
         1YShB1JcwaoXaca8CoKe5VbjNjK+gCCwbTCO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tl7TywVZic9PhfHq2BmWEfnSDIUToLj1FPGq3mOdgmw=;
        b=Fsnj8Q4YTpMOwH6U7iTVlFheVpJzbf8qhBpnwXe/madlEDdsKejjSqcThNgJTSA2wZ
         tiEh7+TkYZWmv0e3IMh3AKl1gK9W9z6cEGYRnY4k5u7Ph75cpZt9j0tCg9Ji1b3TU3Zc
         nAn51UPUn74I9/XEV+PPbeaI9W84uBX3ujvlwM2eTlD0t1Vy5/xntUZAKxcaeYtSEClD
         2EjyhF98Nhgv0j8xeCAQa8gLYsl9ELqX8fuWL+u93QsaUHd6K42hofFdjRotVRAFn+Qd
         c7TeJbn9+LsV+ZTuMlvEYJPcp2Adx8vtVfO9WIE0DdMmIHbmEXQ5rPZ0IMZ6v3H0N656
         NT7A==
X-Gm-Message-State: AOAM531V0a5LTdHcLQlhfGCw0usnCW6zWUmRj5QIXo1B/D11NKrnjm0d
        0DtCO5J1ZGPFx8kNOYNWNBSroA==
X-Google-Smtp-Source: ABdhPJw6iwsYq9xnv36qxIxw0UUdgDQijR/zSF04ZL0MjVxWr8jae0SafkiRcENHLnowa/XoNb6S0A==
X-Received: by 2002:a63:f80a:: with SMTP id n10mr187132pgh.303.1630539480763;
        Wed, 01 Sep 2021 16:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm87353pfm.81.2021.09.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:37:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] Fix ro_after_init vs static_call
Date:   Wed,  1 Sep 2021 16:37:53 -0700
Message-Id: <20210901233757.2571878-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; h=from:subject; bh=LMtX30+lHx9d1AiyntE3juWOs+vNiZc4QnLUTVqvMfk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA7UmpG1QrLCXLyjRwNizAoMH23KjhJdgmQwH3oR fiBTMdOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAO1AAKCRCJcvTf3G3AJhMUD/ 9jCNxxAKmyPneQY5gEfnpbv479Oor6moPazSiSEojXx1xulI+ViTPAcS/XqzP98X8/14oKEKVBdpq0 DlK1bjtgs4o3rVcMsHQ/8aH+JeLqzL0IHYCqQeZkB9D0Ruan0SJuN/3elxAWK1MdODurM1SW1Feosd QkHHg589WJdFLo9KzxnxSlmZlW/neMOKqguXhv0lRLc39NmcGjPCp5eN9koPYOi0GH+aa6g/uPu5fv jQm4KGT2KSMSGFZVs3fa8c9BLw9Tk60/PozJshlh9CG8nR16A9Eg6warfWkjjN+sLOXgT6XTjbHCZo TmE1ZRi5Gb1Jn1ySSYanQCvGyiAhsLCKNhJgy+BlGDw6t7J4ZysUEkroOU787UAdsCDZ+LViu6nFkB YKiBo1rrsPhz4+mJlhQp3o/s7qZuBuT+gpC45Y7AqUcl8ZqqTDsc8pUgeUcfx459NIUwPeOmilyoV4 kbyPdmETgDf/qGm0/t1Eef6/Rjcp8nwFg8heK5Dm47NTTm4vzAuCfjqm/GykG7ACHNG2+I5j5s7RX2 n3TmSWONZve8dL2xQjoIkgjICM7bIbdiu8wSfukzjyZSkFzA80GtNt0lMBJoBY67XrOBq2EvztxOpW gX1jQZR2Yg5Dee5YMMqC/hyntgUM5gSGnnjaHB82XdikWFP0FiDFwot8eFXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

It seems the .static_call_sites section was not being marked as
ro-after-init in modules. Adjust the macro names, add comments, refactor
the module section list, and fix .static_call_sites.

Thanks!

-Kees

Kees Cook (4):
  vmlinux.lds.h: Use regular *RODATA and *RO_AFTER_INIT_DATA suffixes
  vmlinux.lds.h: Split .static_call_sites from .static_call_tramp_key
  module: Use a list of strings for ro_after_init sections
  module: Include .static_call_sites in module ro_after_init

 arch/s390/kernel/vmlinux.lds.S    |  2 +-
 include/asm-generic/vmlinux.lds.h | 22 +++++++++++++++-------
 kernel/module.c                   | 29 +++++++++++++++++------------
 3 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.30.2

