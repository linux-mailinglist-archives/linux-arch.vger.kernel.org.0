Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9163786B4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfG2Hwy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 03:52:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33721 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2Hwy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 03:52:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so27115429plo.0;
        Mon, 29 Jul 2019 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aFfdHNjtZ8FvdMKefYxPb4HYVmdWsWB3kamH0o/qnSM=;
        b=CzCFjtTZ3CJMX30K6CFDjmpB+9jugErXTxabPXRU1AJg+whC6Y33eXgp+moQCZnvfm
         yIieXvZE/TTFBXC0RhibxtQuQ13sXhCGtkwG21IqbH3bEOPxlX0NzMT3SDi1SYJNM8Em
         M7WJGWGRW1Ykn5ZeQTOYH/yOrryEidYW4UKlYr7W4rAJzpjpUn75am6gWGqEifBe6KZU
         WK3YUIZImQWTQa85NtsJ986+tnQrXZlu5D2Cbw4NYD5flXJefs8zog97LZtDytAtafV5
         l1Svz08mo+PJzx3NtERVxX2NUaVH+ynAtBMGEg6cLYd9Fb/2ZSqRm3n9YjxIadU0kIjj
         bTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFfdHNjtZ8FvdMKefYxPb4HYVmdWsWB3kamH0o/qnSM=;
        b=M+6xekvFUKix80kx/C3G6Yg6CqmH6PDCxx2jVTxOSCS51lFS2zDSWtkkJlFBgLDoID
         KtS+BXKBhg+N99AFQZhD9WK9GOUTvxeHiwd83c4VzODG1/TvpkonWfacChwq8AVV7jho
         iX5c5Eq/fWNiStnXwvwtog0m1fvc15fDAXeQaW64tqTerrnRmFE+BImOx87Y72oOTxe6
         dh6N64go1c+Q56BlIaYd/JE7/gEC/8BLIwJOkGuQIrgmDhiFb6ewSeH0u19QZIa1rH7x
         His9CDxYzJvtoZmdxetd2TluQ8589L60G1CeItMCJDmrNVMFg+PdOzmtKl9/VyM2UpZB
         YJJw==
X-Gm-Message-State: APjAAAVGOSa6D5uNGUuO6ir5W7JG9MzJEO9WGquHEpn4GVvuA3XIYzpA
        vFk10iVZv0jUufO715XXIwk=
X-Google-Smtp-Source: APXvYqx5eweOEy2a7XzPX3gI88Dv920d1KqhTKxxTQQ0h7rf/Kzm0LmJEP4E5GCpUxUPFmOW5BLBKg==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr109950171pls.156.1564386774076;
        Mon, 29 Jul 2019 00:52:54 -0700 (PDT)
Received: from SAW-L7607608QSA.guest.corp.microsoft.com ([167.220.255.91])
        by smtp.googlemail.com with ESMTPSA id s5sm40878033pfm.97.2019.07.29.00.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 00:52:53 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
Date:   Mon, 29 Jul 2019 15:52:41 +0800
Message-Id: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
on x86.  But native_sched_clock() directly uses the raw TSC value, which
can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
to set the sched clock function appropriately.  On x86, this sets
pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
scaled and adjusted to be continuous.

Also move the Hyper-V reference TSC initialization much earlier in the boot
process so no discontinuity is observed when pv_ops.time.sched_clock
calculates its offset.  This earlier initialization requires that the Hyper-V TSC
page be allocated statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

Tianyu Lan (2):
  clocksource/Hyper-v: Allocate Hyper-V tsc page statically
  clocksource/Hyper-V: Add Hyper-V specific sched clock function

 arch/x86/entry/vdso/vma.c          |  2 +-
 arch/x86/hyperv/hv_init.c          |  2 --
 arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
 drivers/clocksource/hyperv_timer.c | 34 ++++++++++++++++------------------
 include/asm-generic/mshyperv.h     |  1 +
 5 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.14.5

