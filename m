Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1693CB40F0
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2019 21:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfIPTPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Sep 2019 15:15:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32811 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Sep 2019 15:15:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so1196414qkb.0;
        Mon, 16 Sep 2019 12:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wUc3QBRhsqMMHvwIEi6V0XE3vX9eu/T89TukX6CeZiI=;
        b=c+oJoM/WOFrA8iLVqvSbHE7msUsl9Sx6OwQY8JRYcO1GpNbwc4GWGRCw58TrEoWA50
         hLccV0Hn/dIpqwE8lgmSY8ANuUfgOisTHJaE6y18UgAJEBE6Qwgq9AsJg76Y3qA59fb9
         5hx95/siNpQt5v330pZf3nzs2/ashPwRHbHcZn16fRlSRUPUSHv8RQmnGhcH7Y0TaT3S
         Aw7nuuYSp1VnlN1g98vjFT+0RHtwaGUOjzWTNdEdlXaXxRbhq2IWA8D7knoGIFcMMtQl
         0shTAYfNMNGTvFpTA62g7qEqK2gMTE+tqWw1PNvFAj+zZ7TNtglCQ2ils4dlkMUwpKBw
         pjuA==
X-Gm-Message-State: APjAAAV9xE0V0pGcqDq9FpGU03s4QhHN5m7a9K7SyeRIkumCjNkc78QP
        jjTBCJzQAqBiQpZxe1+CHvdKlfEDhiHSn+ujbU4=
X-Google-Smtp-Source: APXvYqxbsy8a23okkYT9gLlSl1NfjJbzTB0IQVPck0cj7cyO0Cirse11Pyi1DQJ25JIBlJAH6rN51oL5RVa0mXU2N5Q=
X-Received: by 2002:a37:a858:: with SMTP id r85mr1635451qke.394.1568661319809;
 Mon, 16 Sep 2019 12:15:19 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Sep 2019 21:15:04 +0200
Message-ID: <CAK8P3a0N9+-fmmg=oPVsKmoNb0vAYsASOneXUYBVAp8nyJEwdQ@mail.gmail.com>
Subject: [GIT PULL] asm-generic changes for v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Denis Efremov <efremov@linux.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.4

for you to fetch changes up to 9b87647c665dbf93173ca2f43986902b59dfbbba:

  asm-generic: add unlikely to default BUG_ON(x) (2019-09-01 23:53:39 +0200)

----------------------------------------------------------------
asm-generic changes for v5.4

Here are three small cleanup patches for the include/asm-generic
directory. Christoph removes the __ioremap as part of a cleanup,
Nico improves the constant do_div() optimization, and Denis
changes BUG_ON() to be consistent with other implementations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (1):
      asm-generic: don't provide __ioremap

Denis Efremov (1):
      asm-generic: add unlikely to default BUG_ON(x)

Nicolas Pitre (1):
      __div64_const32(): improve the generic C version

 include/asm-generic/bug.h   |  2 +-
 include/asm-generic/div64.h | 16 ++++++++++------
 include/asm-generic/io.h    |  9 ---------
 3 files changed, 11 insertions(+), 16 deletions(-)
