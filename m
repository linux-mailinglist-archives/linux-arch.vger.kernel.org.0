Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8A35A812
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhDIUnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDIUnW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 16:43:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C5C061762;
        Fri,  9 Apr 2021 13:43:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y12so5230480qtx.11;
        Fri, 09 Apr 2021 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5egM9nTAiSvtggnO3tpew7WNqYrN+YEXT3SXh6GmWSQ=;
        b=QSlyGb/A95EP5OjqcyCBgyMj627hQfbwtpMM43gY6hAO0WVM7OD6Dz8FHHxaSyGSPn
         4B4yU3R9/JSyZJbLXMO3CHmNvbwkrxVKbYWQYFoQUb4lVOW6rKgnZYqc6Z4RMHsm6byy
         5ge7QOZ+Pl40Eb9dGhUU+Aap/BKAjppLON6gPgJ6N0eph5/lMCtn+xDLMawj9lQ6n/h4
         TB4qXUYR2iv64+A9qh7bLDdGK37Vs3owEIbXEQDa4FHvajNdXGl56F+ww1N8TRXosYaf
         Jqdxk73JKMhI0Mg3xRMXmKcKIVTOvWSH+UJ6xcxccszI/bgZtnJxCUHllm7qbuhgr/Kc
         OUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5egM9nTAiSvtggnO3tpew7WNqYrN+YEXT3SXh6GmWSQ=;
        b=m0Ur8Bo4F3ALR7QPK8Tty278Fsf1N5hlN1kSGRLkHlQ2RzIPjdh9Ksq+McIXo5Ozqc
         xsy6VAa4MklEcA8FXbDgpmyaOqz6ERlasXu/8qITs1EUOdyO+Vg7hQ7WvYvp9LtLc5bA
         EiCWd4gNTZJTOJ/yRxdpxeBVcxzHYW+2tTURRt2e3+wAtrRjMtqTGp63sgJIMrxIRlw3
         ArDUw5i02ppAMZAYn+wgXVBbuVBe5dUCvb8XVV2sxapr3ymbxrjpZmao/uO4b1DQpeDq
         eRKkBCZ9niQF3WRWD/DFN67C7S2a0hFcPkU8/FwF1dh3ejfuoZxgNf60ZM9/Ewk8AyiR
         6nPQ==
X-Gm-Message-State: AOAM533KCDd/UVye2rpuUvf8k7dI3XeiK0VqOvGbkVF51AP0wH7GT0CA
        mHvllRD9tMAXTPgENxMMnovr/3V3oMU=
X-Google-Smtp-Source: ABdhPJwa5EzdjbIaeJLeKTBSfSfYFmdyDre14QyeTvuHCxILOITvSijBpVGmAdgCeYJyWhICrtVLAQ==
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr14500706qta.211.1618000987067;
        Fri, 09 Apr 2021 13:43:07 -0700 (PDT)
Received: from localhost ([2601:4c0:104:643a:1d89:8a12:ef21:87e0])
        by smtp.gmail.com with ESMTPSA id 1sm2859528qtu.96.2021.04.09.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 13:43:06 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic types
Date:   Fri,  9 Apr 2021 13:43:04 -0700
Message-Id: <20210409204304.1273139-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Recently added memfd_secret() syscall had a flags parameter passed
as unsigned long, which requires creation of compat entry for it.
It was possible to change the type of flags to unsigned int and so
avoid bothering with compat layer.

https://www.spinics.net/lists/linux-mm/msg251550.html

Documentation/process/adding-syscalls.rst doesn't point clearly about
preference of ABI-agnostic types. This patch adds such notification.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 Documentation/process/adding-syscalls.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 9af35f4ec728..46add16edf14 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
 registers.  (This concern does not apply if the arguments are part of a
 structure that's passed in by pointer.)
 
+Whenever possible, try to use ABI-agnostic types for passing parameters to
+a syscall in order to avoid creating compat entry for it. Linux supports two
+ABI models - ILP32 and LP64. The types like ``void *``, ``long``, ``size_t``,
+``off_t`` have different size in those ABIs; types like ``char`` and  ``int``
+have the same size and don't require a compat layer support. For flags, it's
+always better to use ``unsigned int``.
+
 
 Proposing the API
 -----------------
-- 
2.25.1

