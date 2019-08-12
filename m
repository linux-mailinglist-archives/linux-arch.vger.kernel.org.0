Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78958A9F9
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 23:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfHLVwu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 17:52:50 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37283 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfHLVwt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Aug 2019 17:52:49 -0400
Received: by mail-pl1-f201.google.com with SMTP id v13so3188557plo.4
        for <linux-arch@vger.kernel.org>; Mon, 12 Aug 2019 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Yon+tib6K4agCcJ7udMNHZNwzVmJ2uncNyVHsVPdrbk=;
        b=AwtjYLPB1NH0++/16ytBu/qI2LJprggt3H70hAQSh1ZzM8gc9ZiVcgqdHhYHXjchQt
         px5nT4Pi96B1pKyG9a5L3txn6JOs4iAqr09VPH4Rc6QBU0eIn18RE2GlNcfxtWkO95vq
         Ly5ZNh4d0hDjxSSOfFs68hEEiC7GflyQcqAFn1iTWgvWYYb2TAk7xqAS59yUSWRrr9F3
         WtuDrsR+Q2muciUZZXeLwu0n7pCa1Q/LADXXO5mjKy9NHLwVSB9CVMCXlCnpigDonN01
         P+EORjsojsvbjUmK6aVl6sSTi/qOtZasZVk8CgCwV1MtPLNISfyl0xMhy6EYCrfo3xhU
         UoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yon+tib6K4agCcJ7udMNHZNwzVmJ2uncNyVHsVPdrbk=;
        b=jjJ4WfDhQvl2hVuYIHw0AdaHGidQvS0K0vXsJR8BGa9RlCuUs4z+C9X4+B6ZJnwoia
         trBop0v0PCLW6QHoaKVmMtUVIe8zcjx+ZVxtohJ3M0u6kG+QgPEIv3P2VvHTw5TtQDjW
         A+U3q7s059rYkdS33ALoODGmnDil2J0f++rcEkv3WSX4r+2ALDRNu+RwRt1qNw0erJu3
         4qWFx07tRyFBLyh6bIbdG/XoxGEuLHo2I7nNnyEcfyqPDiaUfFIJwN5TNgtv05/KjrW5
         abNCuZLdOFB4aQ+fD/Ty3jk5ha0pNShQSeobp5h4RM93g6LDEvlp3NqRoV+WN0BWCfad
         HGKQ==
X-Gm-Message-State: APjAAAXjG1CH+UGvuhPrskXHoZ1hA1ziOqmhocTZM88Ex35FRmD4Ibbd
        +t/2JIOizxdZIocZBNFk1elXJw1HBFMbVYTGCgU=
X-Google-Smtp-Source: APXvYqzCWXrNnwSVGWU/yjnPa5MZIYrlXiagIBVTokW6Y6IHKWHzr3XziMRENeEKwhMqE6kFR9aoA+C9u955afZ4mGE=
X-Received: by 2002:a63:5550:: with SMTP id f16mr33164653pgm.426.1565646768288;
 Mon, 12 Aug 2019 14:52:48 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:46 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-13-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 13/16] include/asm-generic: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/asm-generic/error-injection.h | 2 +-
 include/asm-generic/kprobes.h         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 95a159a4137f..a593a50b33e3 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -23,7 +23,7 @@ struct error_injection_entry {
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
 static struct error_injection_entry __used				\
-	__attribute__((__section__("_error_injection_whitelist")))	\
+	__section(_error_injection_whitelist)				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 4a982089c95c..20d69719270f 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -9,12 +9,11 @@
  * by using this macro.
  */
 # define __NOKPROBE_SYMBOL(fname)				\
-static unsigned long __used					\
-	__attribute__((__section__("_kprobe_blacklist")))	\
+static unsigned long __used __section(_kprobe_blacklist)	\
 	_kbl_addr_##fname = (unsigned long)fname;
 # define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
 /* Use this to forbid a kprobes attach on very low level functions */
-# define __kprobes	__attribute__((__section__(".kprobes.text")))
+# define __kprobes	__section(.kprobes.text)
 # define nokprobe_inline	__always_inline
 #else
 # define NOKPROBE_SYMBOL(fname)
-- 
2.23.0.rc1.153.gdeed80330f-goog

