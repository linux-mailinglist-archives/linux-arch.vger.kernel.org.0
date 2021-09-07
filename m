Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42050402351
	for <lists+linux-arch@lfdr.de>; Tue,  7 Sep 2021 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhIGGSJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Sep 2021 02:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIGGSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2021 02:18:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D80C061575;
        Mon,  6 Sep 2021 23:17:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23so785336pji.0;
        Mon, 06 Sep 2021 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpsu6Lyznk51HkPRuVtGufFSf0LrPgqfiWm3oQbycoM=;
        b=m7K7DKlPqbUpVAFZOZly4egnHNyAilGh1wCeWZtvRAQcH7lZtsvwj/NAjouRHRq28L
         jAHKPDxFCfv4RSGvAJbN4ufejKyidjlKubDrKHNNwAzlR8sFuCZWlrWUgMTRwzAgp0fO
         BqgrEvLo9kyi2tI1flh/ejLsDiRcKuNei6YJ1hUVRmL1MBYwi4NNc9jiIZlCmPMLgAAj
         7Ug6m/K2AxwcGPvHcHz6SohS3TW8C8mooUkznD4LXLZhqoF98TQHpjychTm3Z1+iik6q
         Gk//tmW2bmY6i+MGsIm8iZPpVt2UwAUWRG/UWr/s6WBog/MyxekbFQUbIYLEpcuCSDSA
         BnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpsu6Lyznk51HkPRuVtGufFSf0LrPgqfiWm3oQbycoM=;
        b=DRM/9CJGkbswIUWTg3Cuv09N7k8A1AgoS9m9xo8r7U6qoH3wuYQSb7w6H8WSLcIjKY
         fPhkSQ9Li2vPtAhqtanIYkZ6DRp02il6hNVKQ+VQa3NuplGgWRQ3ezJ8V0DTZ1oFZO1V
         sHavtluXrqbwmsiziIAMqRAI3mjJZfXZfEnSiZeS3hldC/1VukcouqJEQ3Vo8VCt3jpP
         623GyrKCv3g4tbyX6zyMmHAFSGWsCOaYYH9PbHVIsIJwlWuotvIfU0GAaVHvB1JbxM+v
         SNrVQWY235bDgh/vLlqB5dTwfo2845Psw1FAR5y+PfNdUYtPOXlH7k3wD4VJZC8rPWXs
         uezg==
X-Gm-Message-State: AOAM530jIlfGeSe9R/QHNvdml9VfQx/Sg/mxMm98KYyTGsacxBJmoxYS
        aPZBDbgP14Y94cqzKRSKAPE=
X-Google-Smtp-Source: ABdhPJwx1UokZ8gcOa4Uq9z6eoGxLtoPU+L2M01B/g+LgX+IkDNPiprvYpjX6d/T4G65tvD6QP72ww==
X-Received: by 2002:a17:90a:4f46:: with SMTP id w6mr2874174pjl.9.1630995422426;
        Mon, 06 Sep 2021 23:17:02 -0700 (PDT)
Received: from archlinux.localdomain (61-219-114-7.hinet-ip.hinet.net. [61.219.114.7])
        by smtp.gmail.com with ESMTPSA id d18sm7708492pge.65.2021.09.06.23.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 23:17:02 -0700 (PDT)
From:   FreeFlyingSheep <chris.chenfeiyang@gmail.com>
X-Google-Original-From: FreeFlyingSheep <chris.chenfeiyang@outlook.com>
To:     tsbogend@alpha.franken.de, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, chris.chenfeiyang@gmail.com
Subject: [PATCH 0/2] mips: convert to generic entry
Date:   Tue,  7 Sep 2021 14:16:53 +0800
Message-Id: <cover.1630929519.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Convert mips to use the generic entry infrastructure from
kernel/entry/*.

Feiyang Chen (2):
  mips: convert syscall to generic entry
  mips: convert irq to generic entry

 arch/mips/Kconfig                         |   1 +
 arch/mips/include/asm/entry-common.h      |  13 ++
 arch/mips/include/asm/irqflags.h          |  42 ----
 arch/mips/include/asm/ptrace.h            |   8 +-
 arch/mips/include/asm/sim.h               |  70 -------
 arch/mips/include/asm/stackframe.h        |   8 +
 arch/mips/include/asm/syscall.h           |   5 +
 arch/mips/include/asm/thread_info.h       |  17 +-
 arch/mips/include/uapi/asm/ptrace.h       |   7 +-
 arch/mips/kernel/Makefile                 |  14 +-
 arch/mips/kernel/entry.S                  | 143 +-------------
 arch/mips/kernel/genex.S                  | 148 +++-----------
 arch/mips/kernel/head.S                   |   1 -
 arch/mips/kernel/linux32.c                |   1 -
 arch/mips/kernel/ptrace.c                 |  78 --------
 arch/mips/kernel/r4k-bugs64.c             |  14 +-
 arch/mips/kernel/scall.S                  | 130 +++++++++++++
 arch/mips/kernel/scall32-o32.S            | 223 ----------------------
 arch/mips/kernel/scall64-n32.S            | 107 -----------
 arch/mips/kernel/scall64-n64.S            | 116 -----------
 arch/mips/kernel/scall64-o32.S            | 221 ---------------------
 arch/mips/kernel/signal.c                 |  59 +-----
 arch/mips/kernel/signal_n32.c             |  15 +-
 arch/mips/kernel/signal_o32.c             |  29 +--
 arch/mips/kernel/syscall.c                | 147 +++++++++++---
 arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
 arch/mips/kernel/traps.c                  | 202 ++++++++++++++------
 arch/mips/kernel/unaligned.c              |  19 +-
 arch/mips/mm/c-octeon.c                   |  15 ++
 arch/mips/mm/cex-oct.S                    |   8 +-
 arch/mips/mm/fault.c                      |  12 +-
 arch/mips/mm/tlbex-fault.S                |   7 +-
 34 files changed, 562 insertions(+), 1342 deletions(-)
 create mode 100644 arch/mips/include/asm/entry-common.h
 delete mode 100644 arch/mips/include/asm/sim.h
 create mode 100644 arch/mips/kernel/scall.S
 delete mode 100644 arch/mips/kernel/scall32-o32.S
 delete mode 100644 arch/mips/kernel/scall64-n32.S
 delete mode 100644 arch/mips/kernel/scall64-n64.S
 delete mode 100644 arch/mips/kernel/scall64-o32.S

-- 
2.27.0

