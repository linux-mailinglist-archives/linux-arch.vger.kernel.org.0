Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F125A33E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 04:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIBCyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 22:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBCxz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 22:53:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7319C061258
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 19:53:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so1588594plr.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqktUKjWMSHZ7i2u+s16x0sbSP9VPDjkmXRnw4GPeg4=;
        b=RHjhmExyg+rpKyv5Nc9ZaYdn2DDJqjk8uDuYweNqZFU1j+qj3H0V4lh98xtDwrZCOQ
         v535m4lYwgRAkju+Q23kPxEFj0WUXNg/5bty5jvMQrEg8y9c7PPEG+wW8D0rM+8L60/H
         hDYiteu/ngFeVisaqnjEhGrnjlZIlr1hy/6d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqktUKjWMSHZ7i2u+s16x0sbSP9VPDjkmXRnw4GPeg4=;
        b=fchtXQ/BQdFS81vzGUS8RBX2EvdsyFjGWg5fHpErUJP1DVRTpXHq93pwyApziZH6yR
         FOohLcOo7RG4efEgo1Q2YA+sSjp8Y48uxXbRVDUbc60BfFAW/gDM7neyuCUvS2cyFPwx
         SegodLt35qleh2z56zh1fzuWm6SF/36OBJR/vYM6TmYqB8JAjJSiadgERGCLRgHfFMcq
         vd2sERwAuNXtMP/b8cjTf2/j+np2nFR808IvuesvpmcCOT56qWP1ByfHkeo/IXYqhnzx
         XBbu7EzmWLiRE/Kr8o4Rc95/Hsbe92Vw+mRK/nIYlWBzgQMpTsPmQ3Y4vcbbJ48CEI66
         /SLw==
X-Gm-Message-State: AOAM5314JXefCTLLqMGQV7h9cRQGhItUmhxGItOIi50vR554CPSjXoJa
        rmUom/NZL9XOe6OKLiY1c5lnoA==
X-Google-Smtp-Source: ABdhPJwag7uthri0Mn2pyA9vD0vrAX4zwO2oNYtPUmO8FPFRZu7rxMxErll80vPwkn1YAidGcFN4NA==
X-Received: by 2002:a17:90a:17e8:: with SMTP id q95mr220525pja.161.1599015233232;
        Tue, 01 Sep 2020 19:53:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k88sm2949999pjk.19.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:42 -0700
Message-Id: <20200902025347.2504702-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ingo,

The ever-shortening series. ;) Here is "v7", which is just the remaining
Makefile changes to enable orphan section warnings, now updated to
include ld-option calls.

Thanks for getting this all into -tip!

-Kees

v6: https://lore.kernel.org/lkml/20200821194310.3089815-1-keescook@chromium.org/
v5: https://lore.kernel.org/lkml/20200731230820.1742553-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200629061840.4065483-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

Kees Cook (5):
  arm64/build: Warn on orphan section placement
  arm/build: Warn on orphan section placement
  arm/boot: Warn on orphan section placement
  x86/build: Warn on orphan section placement
  x86/boot/compressed: Warn on orphan section placement

 arch/arm/Makefile                 | 4 ++++
 arch/arm/boot/compressed/Makefile | 2 ++
 arch/arm64/Makefile               | 4 ++++
 arch/x86/Makefile                 | 4 ++++
 arch/x86/boot/compressed/Makefile | 1 +
 5 files changed, 15 insertions(+)

-- 
2.25.1

