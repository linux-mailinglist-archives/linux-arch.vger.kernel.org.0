Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768B22565BE
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH2II3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH2II0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:08:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E2C061236;
        Sat, 29 Aug 2020 01:08:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id u1so1139324edi.4;
        Sat, 29 Aug 2020 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dcPTzvRLlTI6xHLAGh4Hges33sLkvHOakU2B8m2O5A0=;
        b=Xqlny0HUc0wfxwPg0SfcOh/WgfmTxE4M5qk14Gm3NE2zP2qd/Tf1yok4QAbkhwyhrF
         tZfDjjduoPcOkVP9Wo1jVA1VeK1qOoVfVkf1YD7AQ4dy7A1DcwFwU+ESVaHS04CDS2q3
         S0F6LVA7WD7zvAYXN1SJNnJMmCGjM3p7NU7TcdgK3Iq94EgYJEafjQ/zyGbmECUqyu99
         u7UKB6BNJZew/jc+82oKjy/c2ikV3Xq7gA3QMAKsKne+4MdwetD6+MNevGSVMFFiAfd+
         644Sem6hrCY1S/s3BY7s1dTdjCu52mwnUWTjc+H8mVhYHBoaTBu3sjHaC4NeYaAmat11
         md0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dcPTzvRLlTI6xHLAGh4Hges33sLkvHOakU2B8m2O5A0=;
        b=OAqKbS+kV1rQAbBlHw8CliVFJUYQUKqJYMWK5DxsmzmV6lWJxlsieE4xKR7PTg9H3p
         eflUjMMoUGhLIXJh+Tpc/t2n8YAu1Y/Vuh5BxaW9pew7Ico5bJr7hn4Te9NMeCvY11md
         bjai5S5PXqJ0/sAL/PpUtQWOYdW3q9wI26/E76tA0hB3K0UBklXg4tsberrXKcpsyVNe
         J9YL6gmN3fUXndcd30moPjyP7d9/hBCSmet7ZzE33VtHDGkWnrVhGgtOaioJQerBw7xn
         3iwA0I/zjH6gHnTDFAPpXreJxxsmTRSfanM2ZQuwN5ld9xHmQCiIX3zBtgIQ0dUnYbfW
         PmCg==
X-Gm-Message-State: AOAM531kLu+O5/MgMgNSrpcKc/66776JaI95WgRpkZKkE1dWxM5FxDEp
        MXJb6w+OPwlKqvSXQ8ff7YN5Tc9sSTw=
X-Google-Smtp-Source: ABdhPJzfhiMfW/vnm5JpeZVezG9+LQnLYvD8MdVgxYlQrAHxPABkr/TWWSMe4T5wsCJPdyXj+54VqQ==
X-Received: by 2002:a05:6402:b32:: with SMTP id bo18mr2511762edb.201.1598688504620;
        Sat, 29 Aug 2020 01:08:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id h25sm1568923ejq.12.2020.08.29.01.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:08:23 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 0/3] memory-barriers: Apply missed changes
Date:   Sat, 29 Aug 2020 10:08:13 +0200
Message-Id: <20200829080816.1440-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset applies missed changes that should land in the
memory-barriers.txt and its Korean translation.

The patches are based on v5.9-rc2.

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

