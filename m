Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000492F4028
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 01:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438125AbhAMAnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 19:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392394AbhAMAd2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2021 19:33:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB27CC061786
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 16:32:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so601724yba.4
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 16:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5rko6s7/MxxtN4vVcBpBg113Pb8TIp2GhMMzMhRrSK4=;
        b=p4mDtQ/JWBQVcqiSngiVHj1RDJXheN9j4tRJZdYqOef3abOmLeMAEwfLvwCSZaq72V
         G+vUc4J+fzLAMEur0uasAO4tZTA5D+eRIvWKG6bK0GwnwBgnyCe/P3TDCE/ZVxj/33iW
         nI7HNKVv87dAHunABvsFKROzqxByZa2P1XtgX+yh6cVQuPHUtAiwQ78s1ui09zTayJbN
         HS2wFLIEu9gMfxL7BaqP8CrMPeoTys7pn1IOwKxGpH91mGB46UBdoqFiKjkGWXF6exUH
         pbPMt7PkH59Kw0zzF1wq9mDSqSdLTBVqOfplGUeTXNf3oKX3HMCJmxz7+IAUaLi6fvpE
         N41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5rko6s7/MxxtN4vVcBpBg113Pb8TIp2GhMMzMhRrSK4=;
        b=ciispqtyRJP9gHqwxyjrjroYIfKRrOnjw0xkcZu5l4P8XHRvcWPOrsHHPwzmefhDhN
         fOdZkMnX2fjuVZDpZbxPqrUTO4EsMaYtGgmUVeg7HLEONewzR7eU7B93Wt3cFy6TExlw
         hOv8iKx/V0SfFpC7JmcDJYkyDd27x1h+Z+okjZJpRDNuhXIqs0AHUHHRJ+KYHa3KIpnv
         aQ6AgC6AIAREAtXa4ZzwzzwBlui/WTdQpw2N+R+6E1SEZFamgGUO41Mup6DenYGqkMsw
         rXQXMle+XihRXsr+Qcb2O+4RAIaoAinwh5rIti8XvucncecQBp2hFPAlc3g5IfvnvqS3
         Egnw==
X-Gm-Message-State: AOAM533GM6cNAK3Vp7RREGCcqqh1CIbfmyaKTSzUIhpNCtN/rYFGCurd
        VxFb6Y8TeRc3innKY2vFA/4OlH14zPfRXBZIcWs=
X-Google-Smtp-Source: ABdhPJyz29k5mHwumIN/WLsewxzzQWULrBkzUA+/LMCzZdq219IKRBifSlFkuKDLgTPRlO+O4yjAZg9VmDmhK0cKzJM=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:9387:: with SMTP id
 a7mr3131575ybm.73.1610497966973; Tue, 12 Jan 2021 16:32:46 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:32:32 -0800
Message-Id: <20210113003235.716547-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 0/3] Kbuild: DWARF v5 support
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format.

DWARF5 wins significantly in terms of size when mixed with compression
(CONFIG_DEBUG_INFO_COMPRESSED).

Link: http://www.dwarfstd.org/doc/DWARF5.pdf

Patch 1 is a cleanup from Masahiro and isn't DWARF v5 specific.
Patch 2 is a cleanup that lays the ground work and isn't DWARF
v5 specific.
Patch 3 implements Kconfig and Kbuild support for DWARFv5.

Changes from v3:

Changes as per Arvind:
* only add -Wa,-gdwarf-5 for (LLVM=1|CC=clang)+LLVM_IAS=0 builds.
* add -gdwarf-5 to Kconfig shell script.
* only run Kconfig shell script for Clang.

Apologies to Sedat and Nathan; I appreciate previous testing/review, but
I did no carry forward your Tested-by and Reviewed-by tags, as the
patches have changed too much IMO.

Changes from v2:
* Drop two of the earlier patches that have been accepted already.
* Add measurements with GCC 10.2 to commit message.
* Update help text as per Arvind with help from Caroline.
* Improve case/wording between DWARF Versions as per Masahiro.

Changes from the RFC:
* split patch in 3 patch series, include Fangrui's patch, too.
* prefer `DWARF vX` format, as per Fangrui.
* use spaces between assignment in Makefile as per Masahiro.
* simplify setting dwarf-version-y as per Masahiro.
* indent `prompt` in Kconfig change as per Masahiro.
* remove explicit default in Kconfig as per Masahiro.
* add comments to test_dwarf5_support.sh.
* change echo in test_dwarf5_support.sh as per Masahiro.
* remove -u from test_dwarf5_support.sh as per Masahiro.
* add a -gdwarf-5 cc-option check to Kconfig as per Jakub.

Masahiro Yamada (1):
  Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4

Nick Desaulniers (2):
  Kbuild: make DWARF version a choice
  Kbuild: implement support for DWARF v5

 Makefile                          | 15 +++++++----
 include/asm-generic/vmlinux.lds.h |  6 ++++-
 lib/Kconfig.debug                 | 41 +++++++++++++++++++++++++------
 scripts/test_dwarf5_support.sh    |  9 +++++++
 4 files changed, 58 insertions(+), 13 deletions(-)
 create mode 100755 scripts/test_dwarf5_support.sh

-- 
2.30.0.284.gd98b1dd5eaa7-goog

