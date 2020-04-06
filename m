Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1519F932
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgDFPxg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgDFPxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id u65so7723565pfb.4;
        Mon, 06 Apr 2020 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PvwW/9sQV91GxFUMxx/QXPp3Z+S4dWs0vj3Jf2cw5SI=;
        b=dTtf3LcuHq9DVSUmTHwwFyk0GqNwJ8mmft/rvyPrytkiB+AE7if1Ewt4ZChTfA9cwa
         urTa9BVMKk/fjtxmdlXnZ+UrSYyLSK9CBgax/QDFF/cOGdoy2EHOTcNkjmQ/LbTLsPeE
         XyXvdVn8Sd2KiANJECpKl2aO3BCUkqtIp93IZb9M/sK7VrEqBM4RBHwotf52k+tAgh89
         /BARescvH5q+Jid5Y7T4jb/+mktcyTP7C3A9yRplOJXKMJ9Ib28xpnew2k1qr2LdkUbF
         rdeUy1niAO9oA27ZDtaVtz5bi7oyUWH5atxERg7CSNPJTp9S4AeBVsaHkmwfJ9hxcP1k
         m73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PvwW/9sQV91GxFUMxx/QXPp3Z+S4dWs0vj3Jf2cw5SI=;
        b=c8MMQo3l/+Gi5QdD9IDbFqVLPOXJgGEZ6gpbJSxjWuCNG9tI0kufCsRaGseZKgOWJ5
         D+DagIJkwQ1x4KSFJIJXJJA/GLWsyWzzG/BjBUfG2Z/O22+HVf/LfeHrylAg5ISxodch
         OOBF3tQqvC/kib8E6WT9kE1Y1zEEQx3h1+4k1fCzwFNm/MWkFv/p4ncQZ7TBD4+55R/2
         URy4iRK9ij5b4GuITjkooSkeSUrCIRiMhCsp1/Ii7Z/wuLA96PbbN0d4aWfoaEy9/uRH
         CZsLbMJKxpyW6y356gScWRg1mu+aCxWubvkEYiVtXejh0n7JKxWvWfwOU3r3VJMHqUPt
         OBOw==
X-Gm-Message-State: AGi0PuYkqCK5Ei2kmEEwf4S1eMSQ/lNCdALoONGimY4yuAfDsPkaf2Al
        +6/J/6HGA1eZvzm+h2yHvxj1d9+b
X-Google-Smtp-Source: APiQypLlXZ9/q2dQeTVcu9eqF5ReVI3oGbpaCb79uKaT6u+hpkBbBGhfqjEIbl7GsUqZMbAn53jo+Q==
X-Received: by 2002:aa7:9f12:: with SMTP id g18mr120263pfr.262.1586188415045;
        Mon, 06 Apr 2020 08:53:35 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:34 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V4 0/6] x86/Hyper-V: Panic code path fixes
Date:   Mon,  6 Apr 2020 08:53:25 -0700
Message-Id: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset fixes some issues in the Hyper-V panic code path.
Patch 1 resolves issue that panic system still responses network
packets.
Patch 2-3,5-6 resolves crash enlightenment issues.
Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
VM in order to report crash data or kmsg to host before running
kdump kernel.

Tianyu Lan (6):
  x86/Hyper-V: Unload vmbus channel in hv panic callback
  x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
  x86/Hyper-V: Trigger crash enlightenment only once during
    0;136;0c0;136;0c system crash.
  x86/Hyper-V: Report crash register data or kmsg before  running crash
    kernel
  x86/Hyper-V: Report crash register data when sysctl_record_panic_msg
    is not set
  x86/Hyper-V: Report crash data in die() when panic_on_oops is set

 arch/x86/hyperv/hv_init.c      |  6 +++-
 arch/x86/kernel/cpu/mshyperv.c | 10 +++++++
 drivers/hv/channel_mgmt.c      |  3 ++
 drivers/hv/vmbus_drv.c         | 62 ++++++++++++++++++++++++++++++------------
 include/asm-generic/mshyperv.h |  2 +-
 5 files changed, 63 insertions(+), 20 deletions(-)

-- 
2.14.5

