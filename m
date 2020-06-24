Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF419207D32
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbgFXUcz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391448AbgFXUcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:32:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6357C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:32:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7so3555066ybz.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQdUf2OUslJj5DjDkMf3WWk6yA/Z9kKXMPQTw/J6IlI=;
        b=Xm0pw21CFWwXKUCWT9uv8sjRFTZSZ2FxFwksg6PZZFhaViOtrXe11fAV4rmUtsA/iD
         yw79dp1HbVFKYB9IyYfau+MusfZUyo7hsiV4z3U+B+VERxLsAmDLIOjA6ZbmwYQrk90b
         ude2AkBLX9/aWcsdUn0At059rWaNafFELeyyTNpWfaIPQWe975NuzYbO2Y2+sB6z99TZ
         DkeatZZ3I3Kg3WrJcfsykfzzNiGAFFIiaZ9KHBKGVzxxZKDwbNS3dVYdRS4I3s6IiWF7
         F9FQwIOY90ZeHvihhQegbpcF6vQYY7VW45ZJstmN7BQcaqrs2XDnMXsRYKvPnePBoQiK
         Uk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQdUf2OUslJj5DjDkMf3WWk6yA/Z9kKXMPQTw/J6IlI=;
        b=HY6uUlzthB2FFHRYoquOI3Ubb/WcTC4CvrdrCnxnvku3nvgOdz1qvj8QC9JcuhS+b1
         JE96c2fwRuwDUY5nzeQbz+/OjhG4nDu5/f/v0Qchxqb/PnNlf8dyo7E91EQnevrRcFcY
         J4/IEksNcCD3m0uwqZ28l6HxRT8vqMu03hJfnDiUMmjrUk/ic1IfRTzMyzs/3MOsejXs
         rP3kkE8I/iMLQuOoHX+TPAji4X/JgkZ+KwSHD9m0Fzn6Q9YkHBwAMKrucrp2S/P5dTfP
         lWmkzK5u9UkAzbGuR7/XoNke+IPbBzai/7hrYPBAXorrFkfSnWm2EY1Vp1I9fBRhDmaq
         hzbA==
X-Gm-Message-State: AOAM530MjKtj61uBHdpL7GH+g6+ALtZYTd5MVJtltwLhxbVBa3RYMzmG
        WVgTdKVFmVeU5RYGq+3TMUl2YqkZ1B9L1o60YaQ=
X-Google-Smtp-Source: ABdhPJyaNd4T7jCJ2XxtqDk7As6bELzRlErz6uaK57hfCOoUmajW51Nj+2rWe6ZzApbtPE/D/8XgpW5QlQwx29+bABU=
X-Received: by 2002:a25:4cca:: with SMTP id z193mr43175648yba.510.1593030771779;
 Wed, 24 Jun 2020 13:32:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:39 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 01/22] objtool: use sh_info to find the base for .rela sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ELF doesn't require .rela section names to match the base section. Use
the section index in sh_info to find the section instead of looking it
up by name.

LLD, for example, generates a .rela section that doesn't match the base
section name when we merge sections in a linker script for a binary
compiled with -ffunction-sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 84225679f96d..c1ba92abaa03 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -502,7 +502,7 @@ static int read_relas(struct elf *elf)
 		if (sec->sh.sh_type != SHT_RELA)
 			continue;
 
-		sec->base = find_section_by_name(elf, sec->name + 5);
+		sec->base = find_section_by_index(elf, sec->sh.sh_info);
 		if (!sec->base) {
 			WARN("can't find base section for rela section %s",
 			     sec->name);
-- 
2.27.0.212.ge8ba1cc988-goog

