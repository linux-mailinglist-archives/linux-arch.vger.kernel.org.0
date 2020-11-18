Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC62B876E
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKRWIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgKRWH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:07:59 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1050C0613D6
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:58 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id 60so2506475qvb.15
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ybG+vgy2nM0cZESjHkdkrOB9uboR6Bigv/FKTPhrj4k=;
        b=hIIcn4BpUGto4r6NHqbLnzUmUXfubNWPf/6Zv3GZRtWFHTU5uAvFN3tQzxc1WSCFCE
         QInEMAz5D1L8ymumteFJDjH04mB3gIw3xTPG+sIitd8fhUMxyqQPbPxfi9jbz4SdCsY5
         IMaYwzp6CiX4uEC0/+NopWwTLoT+Hs+OIt2rLskAikpv2CYx+NW+NMMv+UZMLb0cf3To
         3Gj3U/0KWBUaSX2TChjkL5H3cDumu19oheeYzVpian9YZ/DVNUcRVSEjbwAUTLGxGpKv
         acQ+xEREurokEV7Kzv9fVI7s3GeTBazq9YMWsdRv9DQFq4TQ25fd7ZWZErFnH/R86xe9
         IAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ybG+vgy2nM0cZESjHkdkrOB9uboR6Bigv/FKTPhrj4k=;
        b=GKju+6slpzqI+p1WC3oT2tg/qwfIL9HjY/u+egVZKI2rl4LTady61e+kfFNkzXfIul
         HUPKOquYB2x+lD8cgS0puiHSIT3M7I0dhzgikewRzqlW2G1Qv4RpOYdBAPUW71d7k8BP
         vIEaBuNZ1Tq7LYVy/cphFAD5jBCaxbH5HvYp58vCjEKDiTdxuBiBLU/FK5aYlJGxPtog
         c0v3W4K7kD9wfHSwgboTvZR19TfaSBvVyl8YV+FiHN80K4gNxTrOJHnNKIdiIZbZ6hcl
         G5nGhMXD9EteTDTC2v6Ys5bFw23doewSmbNbfhp2Dzv27AQJ/n5Z3DJDwOpPNJCC17tT
         NxeA==
X-Gm-Message-State: AOAM533qPamkRv/rbuTnOgt8zmgeoFq0rXKaCKmvOinT0+m8d+NIFefs
        7Da4mnmZ+Gx0WuOmSs9DKYxk8azIO0jPW29vJgI=
X-Google-Smtp-Source: ABdhPJwB2N/tm5mg6DDYK/Diu4h6yGV1GgLC8syn/S8N63ypD7xd4rXJmZv355L3RjYXmAC1JtFs6niBEXIXoHLUras=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:32f:: with SMTP id
 j15mr7580348qvu.35.1605737277806; Wed, 18 Nov 2020 14:07:57 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:25 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 11/17] scripts/mod: disable LTO for empty.c
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.29.2.299.gdc1121823c-goog

