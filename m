Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6D8D323
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfHNMc1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 08:32:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNMc1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 08:32:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so5209224pfc.13;
        Wed, 14 Aug 2019 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bScrLOPkx8T8jsTd/oJ+R9nDwyouzFa8tBbrlwj/4dE=;
        b=KcKp2BwrqlITo3B45rK0EztJWn8t2lkFizTIryV/calhu7C+7V211m1XNHDPi3FHaN
         4CJhTDfmACnwl5HKgYn4hGo1bXaVfm3YnanH0FNTj0qaaEaVybgJzupCD/nWL6Hz5Mla
         fmo8agQX8CWXurnZQD+QTn9A5+BH6fn+I4O9TGflkncgxh6vSfpuq5kjFIP0yvHeIULC
         X1Ly8RSnU1CU43vtjhbaMbDTSERE+gL7b9S2W17PaKBjpDwPvLEavJo0bn8Cuz2yeMOT
         y281WZvWx3NbPe+4o3ME7lpdEB/3h3Gpmel2cQEwZF4wthkiplwMfL0zD6ttWOf7gRvd
         NQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bScrLOPkx8T8jsTd/oJ+R9nDwyouzFa8tBbrlwj/4dE=;
        b=iiTh16BfxJmavxsnlx36DymbpXYi/gf2mCX8WvjRyaDBZ5lI1hnfZJOMN9JlJXdxJC
         a36AVyZ97w2Hxo4Ra3TFrptsQsakJDpswzD/AiIZbCI2cNaG1s5nK4iXHUNsZmw3rC7Z
         FlAo7cZvXDF8ZfE/TzTeDeuz+F6bKom0bni0goX8zi+ZiWB/XRm4HhDFKqI0SurKNOOd
         7vf5NQQ1OD04ihag4esNNL3ncnX5pJfyz8XVtnywUBoO/slSp2zosqDzbHEn5uyhmN6k
         zuQt23jw3LcQ5/um7b+4ZubbPYSl6Rnmju4Y3qEGzxxRlj6ndkmJA3sPE8ePy4dsZ0Ix
         7L1A==
X-Gm-Message-State: APjAAAUDvt+eAWPJpkVz9BQRz3fzb9KLUuROO2dTuFLVXX7qDgEBLT8/
        MpX5+lgbcC2XsBfd84vbAu8=
X-Google-Smtp-Source: APXvYqwTmcoXZ5l9Arr9V/DkJppKlUROq/tLcfCMNd0DVzrcZdSdL1+wFXjcBQF8Yquymvsmr2FyCQ==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr38049981pgg.295.1565785946131;
        Wed, 14 Aug 2019 05:32:26 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id u69sm135276430pgu.77.2019.08.14.05.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 05:32:25 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock
Date:   Wed, 14 Aug 2019 20:32:14 +0800
Message-Id: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
on x86. But native_sched_clock() directly uses the raw TSC value, which
can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
to set the sched clock function appropriately.  On x86, this sets
pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
scaled and adjusted to be continuous.

Also move the Hyper-V reference TSC initialization much earlier in the boot
process so no discontinuity is observed when pv_ops.time.sched_clock
calculates its offset.  This earlier initialization requires that the Hyper-V TSC
page be allocated statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

Change since v1:
	- Update patch 1 commit log
	- Remove and operation of tsc page's va with PAGE_MASK
	in the read_hv_sched_clock_tsc().

Tianyu Lan (2):
  clocksource/Hyper-v: Allocate Hyper-V tsc page statically
  clocksource/Hyper-V:  Add Hyper-V specific sched clock function

 arch/x86/entry/vdso/vma.c          |  2 +-
 arch/x86/hyperv/hv_init.c          |  2 --
 arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
 drivers/clocksource/hyperv_timer.c | 34 ++++++++++++++++------------------
 include/asm-generic/mshyperv.h     |  1 +
 5 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.14.5

