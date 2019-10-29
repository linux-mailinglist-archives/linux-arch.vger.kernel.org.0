Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3DCE9327
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 23:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJ2Ws2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 18:48:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42158 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJ2WsH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 18:48:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so122160pfj.9
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKUfU/s6VNCMjI6UpTZnmPGQRCLUuGC/0Ur+XQYjYn4=;
        b=JCRbAozjQ5VTk70EYdt3VQp5FkX2TuQhI8+q0O4swFbEKS/ln8ZpNnfrYQNiTJub2f
         VQLa3gkCiTL02XzRdUu4wS9OJ+52SaR9sC98PuxTQVCYDfX+vDvExtqftZCxF5xCObaF
         hABVTjF8M6/pRCAh5vpu7idIZ5tib6qfY2wrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKUfU/s6VNCMjI6UpTZnmPGQRCLUuGC/0Ur+XQYjYn4=;
        b=crjAGs60d6gk3PRPyDDO2y8Nlgj6D6RFKbI1IymTuKim0a0v6DhVvX1tbo52Xzgs20
         wTu2pmh+scKmeU5L5GP5o1Pxlytc3MjIgxHRF2u2hi8d7+/ip8z8oR+ZwhROmaWKXTbG
         nrh9mmUdFDNlekD/TIcmn283cLof7s/FVYa8FIfaJ2yfc38amfFwskGSzC88+tEZOKzT
         S8lwdoydzRrsFpaO1eWoR3VQ2v5KzsAZxsoH1j/EK4fvibvyf0nK8VlC/k+NjHNjaB7G
         KLsLsOUQ0gQEpkmBakWvuqL7WHE0sjwvjwd3VsOMM3hkdgH14IRG7WqHwyrnGAlVmQBv
         Zf9w==
X-Gm-Message-State: APjAAAVKsJLqrjXhvPqxPnnc+sD8J1NJdlUt+s4zNIxpt/P8O2xcdJ8L
        18WX7jqK2nbdX2/Hh/343sD5vg==
X-Google-Smtp-Source: APXvYqx2jf6YGVEJMofLmnQuj1bd8RRLe/mmzmKbe1+WcVdSDVf/LY61lDqqHnkFYpwNpoarVLLQbw==
X-Received: by 2002:a62:cecf:: with SMTP id y198mr10781942pfg.86.1572389286825;
        Tue, 29 Oct 2019 15:48:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b23sm143117pju.16.2019.10.29.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:48:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] MIPS: OCTEON: Replace SIZEOF_FIELD() macro
Date:   Tue, 29 Oct 2019 15:47:54 -0700
Message-Id: <20191029224756.28618-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029224756.28618-1-keescook@chromium.org>
References: <20191029224756.28618-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

In preparation for switching to a standard sizeof_member() macro to find the
size of a member of a struct, remove the custom SIZEOF_FIELD() macro and use
the more common FIELD_SIZEOF() instead. Later patches will globally replace
FIELD_SIZEOF() and sizeof_field() with the more accurate sizeof_member().

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-4-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index ba8f82a29a81..44b506a14666 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -44,13 +44,6 @@ static struct cvmx_bootmem_desc *cvmx_bootmem_desc;
 
 /* See header file for descriptions of functions */
 
-/**
- * This macro returns the size of a member of a structure.
- * Logically it is the same as "sizeof(s::field)" in C++, but
- * C lacks the "::" operator.
- */
-#define SIZEOF_FIELD(s, field) sizeof(((s *)NULL)->field)
-
 /**
  * This macro returns a member of the
  * cvmx_bootmem_named_block_desc_t structure. These members can't
@@ -65,7 +58,7 @@ static struct cvmx_bootmem_desc *cvmx_bootmem_desc;
 #define CVMX_BOOTMEM_NAMED_GET_FIELD(addr, field)			\
 	__cvmx_bootmem_desc_get(addr,					\
 		offsetof(struct cvmx_bootmem_named_block_desc, field),	\
-		SIZEOF_FIELD(struct cvmx_bootmem_named_block_desc, field))
+		FIELD_SIZEOF(struct cvmx_bootmem_named_block_desc, field))
 
 /**
  * This function is the implementation of the get macros defined
-- 
2.17.1

