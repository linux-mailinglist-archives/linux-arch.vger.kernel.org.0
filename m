Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20F167616
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2019 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfGLVEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Jul 2019 17:04:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40446 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGLVEs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 17:04:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so9571557qtn.7;
        Fri, 12 Jul 2019 14:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mSMFuRKbx2HYgvgOC0DE3zBa5k/+Pq+uovL+hqxsxVk=;
        b=doIFWy/bZ5b4p7mjQpyVevL1hYzR1LEyHYU0cqIIm1SFR5NVyv92bH+vtNocf60AXi
         9Qe8f112sDSj6TxAuhItixVdroHOqI4X7xPKW7NctT6HvoKegfjaD1Ts3MKxisTf9M6r
         VGHUJ2P0qJGX+p+Sa301XtABGOkZGA3ubGjhFQtIaGo+V5bTY/DsCFmIUFoZptWSpb2P
         b2OOsrgfQv2c7SXLs9fScroFgggClzRkfcFRKskpnhw8uqicDT/XJMuIy3Z6QC4jfdiC
         JGVOzOe/KKirWrENraVZRTJaeACbNTJlINmXlBrby57976N/aSqZf5cGH7F0O6YNjm6W
         KxEA==
X-Gm-Message-State: APjAAAU+mGcNKEIdUfMM+24rw0fQlsV8CspK6/KmG3vKl9w745gUPz1x
        5VzW6K8wUne/jE8eXegCzeLpnb8XeMyPW+skfwQ=
X-Google-Smtp-Source: APXvYqwUujy3kUTV2pdh54hutC3poR1IQl21jzeCx8GP35kKdZhBpQIZNvArgDx8xauO0iDCUbqjNgldedYnEsb8yws=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr7575984qve.45.1562965487204;
 Fri, 12 Jul 2019 14:04:47 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 23:04:31 +0200
Message-ID: <CAK8P3a1ic6ty+ktmur-77f-_=1hu4Drpt617jT8Bz3MMWixvoA@mail.gmail.com>
Subject: [GIT PULL] asm-generic: remove ptrace.h
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.3

for you to fetch changes up to 7f3a8dff1219fba3076fe207972d1d7893c099bb:

  asm-generic: remove ptrace.h (2019-07-01 17:51:40 +0200)

----------------------------------------------------------------
asm-generic: remove ptrace.h

The asm-generic changes for 5.3 consist of a cleanup series from
Christoph Hellwig, who explains:

"asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design."

Link: https://lore.kernel.org/lkml/20190624054728.30966-1-hch@lst.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (5):
      arm64: don't use asm-generic/ptrace.h
      powerpc: don't use asm-generic/ptrace.h
      sh: don't use asm-generic/ptrace.h
      x86: don't use asm-generic/ptrace.h
      asm-generic: remove ptrace.h

 MAINTAINERS                       |  1 -
 arch/arm64/include/asm/ptrace.h   | 31 ++++++++++-------
 arch/mips/include/asm/ptrace.h    |  5 ---
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++----
 arch/sh/include/asm/ptrace.h      | 29 +++++++++++++---
 arch/x86/include/asm/ptrace.h     | 30 +++++++++++++---
 include/asm-generic/ptrace.h      | 73 ---------------------------------------
 7 files changed, 91 insertions(+), 107 deletions(-)
 delete mode 100644 include/asm-generic/ptrace.h
