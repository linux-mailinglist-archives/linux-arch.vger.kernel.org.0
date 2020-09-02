Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE225A32F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBCxz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 22:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBCxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 22:53:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04AC061244
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 19:53:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j11so1573207plk.9
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gClGbep+iV5WfCNFybEdnpd2yOKBqRu+dgKC1E3FLqg=;
        b=etH6NKPqvQ0E/BEfK1vGJeNK5TqdvKBju+PVw+Mb41Om+kz+V3liIydjrFcRux4SkU
         v05mxqn5MJF8kH9X94XWKQG2jM7AFeMLaNS02HEIB7YHiurUIEtkT+i/BFHv0qdgbId+
         JfK1I292Rf3BQCyWOqL6J7XZBXjo/fSJ76OhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gClGbep+iV5WfCNFybEdnpd2yOKBqRu+dgKC1E3FLqg=;
        b=GxkUl4enqnf5irgfub99LXIl4RTKBn1jyR++Y2+apbHLfGXpHslZ7w9Y6d6ixD7NKK
         GuQasauxq6dRPkGir0h5wkMhICA/DGcG6N5yvKOlIWSjxTdhm+O/5I24eEt1QSGeQKOU
         N+GD9TYNTUmBM8ZvpxqELo+xdir0I7koljuIuo8KNmS42I91d5dJCgUYRkV7pcwyEMbd
         k7QatAyadv7o2g6qnTRrEjW5ySXrIi8tannpKxAVioBvFmKElzlmhwLdVW7lv61SjAlF
         avkGE7uQyIH1j19b1AYK84Nm3oUTiFOSWZmryASi1uNevUFmm3NTFval9FaSpNLRG4ks
         ZW9w==
X-Gm-Message-State: AOAM5339VXnb9zYZTa4Z5VzkQM7E6K3T/uNGeb6B/SIAPh+bMTeGf7hO
        dJusaxbiGS5H86r0XsO4e9AL1g==
X-Google-Smtp-Source: ABdhPJzgc+AwMOXYevHKlYRL3a9Gq1SPcptqwTmA/q6SZkJHgbLxcLNKxPWoUeQVwVN+9q7tAZgD6w==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr256915pjb.174.1599015231590;
        Tue, 01 Sep 2020 19:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm3597155pfr.46.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] arm/build: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:44 -0700
Message-Id: <20200902025347.2504702-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902025347.2504702-1-keescook@chromium.org>
References: <20200902025347.2504702-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

With all sections handled, enable orphan section warning.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4e877354515f..e589da3c8949 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
-- 
2.25.1

