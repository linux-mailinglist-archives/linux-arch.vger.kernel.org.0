Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E192FDE42
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbhAUA5p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbhAUAHX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:07:23 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44AEC0613C1;
        Wed, 20 Jan 2021 16:06:36 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j18so131808qvu.3;
        Wed, 20 Jan 2021 16:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq2mU7OrVeGPTcxA188YnFoob4ru+nBZ6S/huK+o6i0=;
        b=H6+23XVfkVA18ccIGaJGJhR+g280khYkE3BxT7jrGwkiTdVD/r+g+WOjI+A8wd/HQe
         w4WRcHwotkQ6hK7UldM8ZDqP9GbBt9RidoOK7q/G9WJCuq7JbnZW3Oii2Y9FvQq3OIr0
         lLjYFFFl9Qeep2e49ViwNzpHkojD+5WIgkAn/8bWdujhIUQqRbN1+sOPy1oGS5HC9fQY
         2hj/sr5NtoKme2y3NaRAS/a79cTxaqE66Su6Az1RzRMXvoTXV1vmYcllV5t8En/kOcXU
         BmoXYba5u/UAZ1CgsJmUkQ74golR7cct+jMMWnLcFnDWFNwr8IGFsCNnRZ49RqqMkIuc
         Jhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq2mU7OrVeGPTcxA188YnFoob4ru+nBZ6S/huK+o6i0=;
        b=Zgi1DFt0VgI8sc1hixcHEUUvVWDepcNvYOxp1c6CKFL4gvUBsJ9A3szVlT7CCW5svV
         tgyFpYKRjes8QE0gmw41xwkTenbIYuatjKb2r7CNAQmtv18uxMxSU7+iVlsiMJmN99yh
         rkBgVhYdpWlGm6F/terdaqMEhT8JRIAmyAKXsmA44X8C0SOBCWNvX2lOwuzT7rkAb92+
         lXupySM1rqybzjY1sA7x8P9oILeHRGyXoVPUU3lMVmFNmrfYyPD0n9I6KcQ6ghbs13uM
         HFKtl25I0zFAOaI66i1U1C50C96yKHU3gJRI38Cf0eHRrNpGjMPxuT8KwJL6GmZE7lzN
         rsyQ==
X-Gm-Message-State: AOAM531nq5g3ul4UhLE/AwXyUDUZuugnpa1hggC8v525gtg6D7fFbw5E
        Qbt+FH0CIxzPPD3sADwQqgU=
X-Google-Smtp-Source: ABdhPJxpoAehXDqLMJQECWz6+rWOBFDlP1o9TdiUvJhrl51jSOmANePT/DqVuAJyhHr1sxiCymASyw==
X-Received: by 2002:ad4:46a1:: with SMTP id br1mr12152632qvb.28.1611187595785;
        Wed, 20 Jan 2021 16:06:35 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id x28sm2235985qtv.8.2021.01.20.16.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:34 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/6] lib/find_bit: fast path for small bitmaps
Date:   Wed, 20 Jan 2021 16:06:24 -0800
Message-Id: <20210121000630.371883-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bitmap operations are much simpler and faster in case of small bitmaps,
whicn fit into a single word. In linux/bitmap.h we have a machinery that
allows compiler to replace actual function call with a few instructions
if bitmaps passed into the function is small and its size is known at
compile time.

find_next_*_bit() lacks this functionality; despite users will
benefit from it a lot. One important example is cpumask subsystem if
NR_CPUS <= BITS_PER_LONG. In the very best case, the compiler may replace
a find_*_bit() call for such a bitmap with a single ffs or ffz instruction.

Yury Norov (6):
  arch: rearrahge headers inclusion order in asm/bitops for m68k and sh
  bitmap: move some macros from linux/bitmap.h to linux/bitops.h
  tools: sync bitops macro definitions with the kernel
  lib: inline _find_next_bit() wrappers
  lib: add fast path for find_next_*_bit()
  lib: add fast path for find_first_*_bit() and find_last_bit()

 arch/m68k/include/asm/bitops.h    |   4 +-
 arch/sh/include/asm/bitops.h      |   3 +-
 include/asm-generic/bitops/find.h | 123 +++++++++++++++++++++++++++---
 include/asm-generic/bitops/le.h   |  45 ++++++++++-
 include/linux/bitmap.h            |  11 ---
 include/linux/bitops.h            |  23 +++---
 lib/find_bit.c                    |  68 ++---------------
 tools/include/linux/bitmap.h      |  11 ---
 tools/include/linux/bitops.h      |  11 +++
 9 files changed, 188 insertions(+), 111 deletions(-)

-- 
2.25.1

