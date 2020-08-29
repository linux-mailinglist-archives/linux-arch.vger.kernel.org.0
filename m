Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1376256603
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH2I0R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgH2I0Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:26:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076BC061236;
        Sat, 29 Aug 2020 01:26:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so1150825edk.6;
        Sat, 29 Aug 2020 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RwgSj0zcBhFAyzOPKtL2HfaK9Tz9Xl24jPUnmRTsitw=;
        b=M5rdx8b2nTsjNq9bLsQg4H1Fd0gXOfTJoXgkM3mcOcJPl9BEgDkTe6kW+TZI6DySxO
         6yGTZg7mVke4aewYyFioNIBfUx9Jf1d5Vfh2QqRVL7V9LCDL57bi65abWkLixOCCe8pI
         L5MHQpFeGa6LDYVS8AINyiOZBUyp9fHx6IzuVkw3yWcOi0mXZvcSdpyRMeuJ8GzzL9lA
         dnP6wfWE627cNAtVj77BLpGj23PWORHC8S32pb7QL4PLf4w/UnjS2JZhEwnv3fH9R+th
         /yKt3XdQ26xPO+RtLSZJirVucc0tqKkCbWnsQIUJ9WiiMCWzlUZwT/SLYqwVEQ23Mf8B
         Z9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RwgSj0zcBhFAyzOPKtL2HfaK9Tz9Xl24jPUnmRTsitw=;
        b=PIZmWPlk8yMTMHXtjhB+e8ky9dULjftXtzZNpfCUll8AfrecNEXBEbRhSJLoGUa85z
         y44D3TCLYQmbzHQSB/vJmnF7T5NGcDTuUTAy8PDSWP5MprJqyL45wz+LKqdXy1+nkfBS
         KhmPIYf/Lhm7lTykmmKDHHUSR0i2zU1AL3Rc32vrfZ9ErKvrPSUdgCh/wxgf9UV73UE/
         7pN4pXLctUNHVSDIVyO27zJGtQ5Ufmv3fPoB+UCydFjevILnCKuzraTZyhReBe9rMcSg
         OIrNuGZB+XlwDxh/UFGshaOIsQhh8M+3Itosj+km4P0PEaEDnGDqMwoZ5I3lgP5LoqNQ
         c4SA==
X-Gm-Message-State: AOAM532xcnJeWJgWSKFd0yAEmbB2ZO1KhDkci5j9OzsrUm763ZMmkJZW
        xUAM2wF8DHtofOxWNq/Rzxw=
X-Google-Smtp-Source: ABdhPJzqA9uWZrhIZxhIWexfKxpboeyBHTltFP6rIUvLzgTPd1eGoL0HHMUY++jNmZfwfMV/L+Jbbg==
X-Received: by 2002:aa7:da09:: with SMTP id r9mr2587958eds.7.1598689574787;
        Sat, 29 Aug 2020 01:26:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id b23sm1566538eja.86.2020.08.29.01.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:26:14 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 0/3] docs/memory-barriers: Apply missed changes
Date:   Sat, 29 Aug 2020 10:26:04 +0200
Message-Id: <20200829082607.3146-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset applies missed changes that should land in the
memory-barriers.txt and its Korean translation.

The patches are based on v5.9-rc2.

Changes from v1
 - Fix mismatch between author and Signed-off-by:

SeongJae Park (3):
  docs/memory-barriers.txt: Fix references for DMA*.txt files
  docs/memory-barriers.txt/kokr: Remove remaining references to mmiowb()
  dics/memory-barriers.txt/kokr: Allow architecture to override the
    flush barrier

 Documentation/memory-barriers.txt             |  8 ++---
 .../translations/ko_KR/memory-barriers.txt    | 32 ++++++++++++-------
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.17.1

