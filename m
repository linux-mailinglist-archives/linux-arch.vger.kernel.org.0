Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4132BB19D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgKTRnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbgKTRnG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 12:43:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B49C0613CF;
        Fri, 20 Nov 2020 09:43:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so8522643pfg.12;
        Fri, 20 Nov 2020 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kmuAYSzMoeIo0u18AuX5Dattf9rqR9IenRhvLXpBl38=;
        b=VI+nmxvQg2sUIWi35kqMfRMIJ3Fz8czvVaSR7G1Zfgx8FiDgqspZLIVJIoQgfC9/3R
         vgz47lVm4b0zgiQWEYEx81MnYUa2OckpIPL38evGB35D1ZIZ4z3C6jfnGOMTuI4V37gg
         S58LIbJR+YDRJBM5FVzE/MB6eps76AZ2nUezRy8tqpv5UlRaXRE9NXvHEN+1ySEC6D4z
         AfLBNuhEaJeBvJlolW8rXubLak9FFD//01PhNq+ZDDvZCN2mRQjfAfXHQc8hUrbM3/vN
         utzUzUgJU5a5bbWo6r39NcOShTjktTO2Kq5lUDWytCUWlYZWAhiyXL3gewy0MCVHJYxt
         cVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kmuAYSzMoeIo0u18AuX5Dattf9rqR9IenRhvLXpBl38=;
        b=BGMHDHJBROnI/Ep2aA/ejtfYt+aBLD1kTri3jR9dPzgjlHP1hLQnCXax4HDt6s+eWC
         Dp+EOO8aP0Z5KkroJ22ofK4Tj0cbmnBeXxFX2pVMYPLGEdn+33+ln9/PlGgnUa6pJpko
         2ho0dJ3z8Tbv2aqaafBKK6znt2BzEU+TW17/gM0dSZoalmdoirKRZi4q6yPzBHjM6rRn
         8GXY9AeBH3FdpsEdXivrNGaBncqwunXQz6+yQ52j48eKLtcYq8zGQpmL/uc5o7+lIgAe
         ObOVYrnUCGCVZu4fLG86nEKutyMjStpuK6/L9nIhL20ii4rWVdkxAaAIH7IetDdEegNR
         L2tw==
X-Gm-Message-State: AOAM530veF9S8uTXXaya0L4E1XUdji9djil6OMAEjJvdhXqWmvY/Cdgb
        geVDx626F0N4KfjIYL4NoQM=
X-Google-Smtp-Source: ABdhPJz/l0AJ+PJtLuAfYLcSRppjH0Yz5mla4ScCRnKm4ezN8+CXxzOdqZOJxDwSuNiM5cQWBdyCRQ==
X-Received: by 2002:a63:9d8d:: with SMTP id i135mr18423403pgd.213.1605894185560;
        Fri, 20 Nov 2020 09:43:05 -0800 (PST)
Received: from syed ([2401:4900:2e82:cfda:fc82:287b:3e19:db98])
        by smtp.gmail.com with ESMTPSA id y19sm4284226pfn.147.2020.11.20.09.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:43:05 -0800 (PST)
Date:   Fri, 20 Nov 2020 23:12:44 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/4] Modify bitmap_set_value() to suppress compiler warning
Message-ID: <cover.1605893641.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

The purpose of this patchset is to suppress the compiler warning (-Wtype-limits).

In function bitmap_set_value(), add explicit check to see if the value being
written into the bitmap does not fall outside the bitmap.
The situation that it is falling outside is never possible in the code 
because the boundaries are required to be correct before the function is 
called. The responsibility is on the caller for ensuring the boundaries 
are correct.
The code change is simply to silence the GCC warning messages
because GCC is not aware that the boundaries have already been checked.
As such, we're better off using __builtin_unreachable() here because we
can avoid the latency of the conditional check entirely.

Michal,
What do you think of [PATCH 4/4]? Is the conditional check needed, and also whether
returning -EINVAL looks good?

Syed Nayyar Waris (4):
  bitmap: Modify bitmap_set_value() to check bitmap length
  lib/test_bitmap.c: Modify for_each_set_clump test
  gpio: xilinx: Modify bitmap_set_value() calls
  gpio: xilinx: Add extra check if sum of widths exceed 64

 drivers/gpio/gpio-xilinx.c | 18 ++++++++++++------
 include/linux/bitmap.h     | 35 +++++++++++++++++++++--------------
 lib/test_bitmap.c          |  4 ++--
 3 files changed, 35 insertions(+), 22 deletions(-)


base-commit: b640c4e12bbe1f0b6383c3ef788a89e5427c763f
-- 
2.29.0

