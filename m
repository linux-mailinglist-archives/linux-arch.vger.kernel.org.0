Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315FB455675
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbhKRIOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbhKRION (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:14:13 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C714C06120D
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:13 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso2733982wms.1
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K7olqGN/TGjGn55ZVkEX4B3oA8fATuBzpoXYDPWo+s8=;
        b=lSb0XjstLr6FE8BYAlex4H4DOucXhMa/eDsWAfxzdlozfip0h44l0sLp32R3+Xdu5p
         cRgEI5NPu8ANL3d/YklNrAWTPBD//ZFXFprmYerrlADA8kJb77v94IibTG4XwaHJWIXA
         P38AlhW4PKnoU8Xlkk3/IvV4cc1TOq7w+4vWmIGL7Zydr2tgvIyiwP+2f3aQAiGYDfR7
         89QIRhOMC5IqfMZoXAZ3rymy13CwsavWk+VAc5ucer3gPbxuzdnqXILFbBpt27+IXZo9
         0w72TIzWjD+rFn/DvKY/BoUGNaOwGkD5/2DzBlU8jl8foApHdCq3J9EEF9O1GlLqo21h
         j7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K7olqGN/TGjGn55ZVkEX4B3oA8fATuBzpoXYDPWo+s8=;
        b=a0LHasepo3bYg7KH6CeVRd2DyxxMk9MfDBocZNtG2ukT2OUEXAk77AFmKtjBoW0V59
         JcLaoZVu5K4w+Jp7Giu8HTseUI/V5PfwsdoGG4mlUSm0NCkrfDJTAOT/d3YlM+/qh3kB
         lt0J5nJenPULujmAx5usOt0NHli7fRYsEWWiCw4cSZQfQJf/k/rd4ElSYEt1UKZnhGq/
         yvJaGneUozmv9sJTJscOddRJL4ThywOYvPWyM5bjxLH9IzJogZE4cks3pBn7im959M4+
         TpypaBJ/LBfljyek6SmL4X+t3FrEF62+PiRCQy1YAxXtP9PD6bn0NEeLhfo3HVERtV+M
         TsYQ==
X-Gm-Message-State: AOAM531B9u5YvMeyzOzaPlHWl/BnwWjmI6OIfqgCPpflFRbCh4Z75txk
        b2wJ7BvO0KfBaeFxxiu0QcFVLxksTw==
X-Google-Smtp-Source: ABdhPJzNNfd9plpADaoab7s2hg00vIn01fs5fi9KbQaBWpR62h2FNBAPwGMc0qpkJtxn8fjqTKnfbHVu5g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:1e27:: with SMTP id
 ay39mr7793632wmb.84.1637223071430; Thu, 18 Nov 2021 00:11:11 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:10 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-7-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 06/23] kcsan, kbuild: Add option for barrier
 instrumentation only
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Source files that disable KCSAN via KCSAN_SANITIZE := n, remove all
instrumentation, including explicit barrier instrumentation. With
instrumentation for memory barriers, in few places it is required to
enable just the explicit instrumentation for memory barriers to avoid
false positives.

Providing the Makefile variable KCSAN_INSTRUMENT_BARRIERS_obj.o or
KCSAN_INSTRUMENT_BARRIERS (for all files) set to 'y' only enables the
explicit barrier instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.lib | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d1f865b8c0cb..ab17f7b2e33c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -182,6 +182,11 @@ ifeq ($(CONFIG_KCSAN),y)
 _c_flags += $(if $(patsubst n%,, \
 	$(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
 	$(CFLAGS_KCSAN))
+# Some uninstrumented files provide implied barriers required to avoid false
+# positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_INSTRUMENT_BARRIERS_$(basetarget).o)$(KCSAN_INSTRUMENT_BARRIERS)n), \
+	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
 
 # $(srctree)/$(src) for including checkin headers from generated source files
-- 
2.34.0.rc2.393.gf8c9666880-goog

