Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC12F872C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbhAOVHC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbhAOVHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:07:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4127FC0613C1
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:06:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203so8178726ybz.2
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZbInGrM8DQpEvZpcv+BH44NrN/in7NktHoThO/+hjn0=;
        b=fTf4GrnRn3rHcZiqqJ3n4RDpL4htAC4GKILeEvMx9YIwYeaCdF0u0YZFa65oByW2MJ
         vuebTsSmoY54pAF/stdeDILEdoVgV8y++f3KQ617fYgz9ufXJdX4v1clDE7VjOp3KnZp
         Gpyzcpd300ndhov7N5kjnC+sr7nlXpM3k3wqes+fD0R9Da14q0KdxH/FN3xLAdIhiK1y
         VkZdjPmq7AZ9m0yF3+Me+HN1A5UsShNPWWrHn3RPhY7UyUs7YA+mgaOE/hrPsQ3c88AA
         EUVGL5n4F4wF2sv6YxNNtJ8pTdoqUmeUEwWrINqlCsn/NTunNo0d8b2RvtbH5ScxlTGP
         z1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZbInGrM8DQpEvZpcv+BH44NrN/in7NktHoThO/+hjn0=;
        b=Js+peexXZJyukE/+igkjtt73CO0eKhZOzVMZaO7fjOdO0yHZHictqaUug7GGePaIlt
         v5F9IPr6E+5AvH7CxbOshKavyeBiSqQ90PzKgM5IXzkLggNrVM9O/Pz36K2GVnqGsBru
         IUYx58bdjuwikFswayWphvu+mq+fFvyIlctx+zK9iYXXeS+SYJgtexYod5huHqitI9w2
         +c6FOWaBJI62Dtsw1eVSlEsDCdlUiqraqgAXA0NF3VODtevLAjIhOb1UTtaPKGN1X+tM
         IlFd9WIF5v3rA7QVsFACf5MROnawTGw8aZoKXGbAELh29mTdMyLX5w5bKbr8cncJ/aT9
         /Jtw==
X-Gm-Message-State: AOAM532izPVcomwm2hcIiPiW7ihffK2zRtK5sdCn6tgXOyWw1pJ+e/ZS
        qaz3nvMpEa60+knVxvREdtqNYP9YVfbU+vWBRns=
X-Google-Smtp-Source: ABdhPJyCJsv5sa6GTOA0Ua9jGRg1Lvl3d6yJ4eg9TKI7QsjVEKnRO5iFLPKsu3uDFWveQhYCj5Tjl5TTMNn9uLPgTIQ=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ef47:: with SMTP id
 w7mr19625123ybm.509.1610744779507; Fri, 15 Jan 2021 13:06:19 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:06:13 -0800
Message-Id: <20210115210616.404156-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v5 0/3] Kbuild: DWARF v5 support
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
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

Changes from v4:
* drop set -e from script as per Nathan.
* add dependency on !CONFIG_DEBUG_INFO_BTF for DWARF v5 as per Sedat.
* Move LLVM_IAS=1 complexity from patch 2 to patch 3 as per Arvind and
  Masahiro. Sorry it took me a few tries to understand the point (I
  might still not), but it looks much cleaner this way. Sorry Nathan, I
  did not carry forward your previous reviews as a result, but I would
  appreciate if you could look again.
* Add Nathan's reviewed by tag to patch 1.
* Reword commit message for patch 3 to mention LLVM_IAS=1 and -gdwarf-5
  binutils addition later, and BTF issue.
* I still happen to see a pahole related error spew for the combination
  of:
  * LLVM=1
  * LLVM_IAS=1
  * CONFIG_DEBUG_INFO_DWARF4
  * CONFIG_DEBUG_INFO_BTF
  Though they're non-fatal to the build. I'm not sure yet why removing
  any one of the above prevents the warning spew. Maybe we'll need a v6.

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

*** BLURB HERE ***

Masahiro Yamada (1):
  Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4

Nick Desaulniers (2):
  Kbuild: make DWARF version a choice
  Kbuild: implement support for DWARF v5

 Makefile                          | 13 +++++++---
 include/asm-generic/vmlinux.lds.h |  6 ++++-
 lib/Kconfig.debug                 | 42 +++++++++++++++++++++++++------
 scripts/test_dwarf5_support.sh    |  8 ++++++
 4 files changed, 57 insertions(+), 12 deletions(-)
 create mode 100755 scripts/test_dwarf5_support.sh

-- 
2.30.0.284.gd98b1dd5eaa7-goog

