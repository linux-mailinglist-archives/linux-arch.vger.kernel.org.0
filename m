Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C74D3443
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 01:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJJXX7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 19:23:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36964 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfJJXX7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 19:23:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so4639480pgi.4
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKUfU/s6VNCMjI6UpTZnmPGQRCLUuGC/0Ur+XQYjYn4=;
        b=D51UL9rR9U7OMRC5kU/1LTr0ek5QCAdhAcQxhNohfHmGY1xfQuGmsaX43izG0+lrE0
         ylCyES33CwISf98T+j7OteRdsjztl0mPIJJyaZTX072VBYlsYPO47quZ4flLQdBfNjVz
         zjCmXjZDOX7lIGxFeth+TOG2oD33SESzGVRI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKUfU/s6VNCMjI6UpTZnmPGQRCLUuGC/0Ur+XQYjYn4=;
        b=GBeBXifeyjTzBzSMD24plzn1LoopbCc93Vum79Y1xssFgH3+MjZaKREVgq5ZmSNw2t
         51OluRF/MtL1HbB7Idhx2Igbe+a7Z8F8amyhDbGynITJfAeEdXd33qbKWZfylnK1hinN
         wZUCfYz1p7xt8vExSB2ZNWFC2ifvitufvuOPDsFXMXi0icULGgySsO+4ypMjoMBAOhrZ
         YkyV/q5BTimOSYqZndrPfaDF+h/V3jSdHZ4DPWoMhc2eQIvK+FSTdJAckz2gRR/HMam2
         vptpee6apxZvnu7CvxSWxDXCsn0ygQHF+CpAoltHrrVpsAWwuEDNCXfjPNiLBhWsLjRe
         1a4w==
X-Gm-Message-State: APjAAAVOALTtNDZz2wCoxSMqusC1gy7IwvU7ELdhmfYjNHOc0fuv8KUg
        RiyxHaS7o5o/WRdlzleoyCqzsQ==
X-Google-Smtp-Source: APXvYqzKvAiLNIuxwJuj4wKQhF4ru4G8rWSNTC6EJdJa6fnz989nt0l/p9guk494hejHp/ITyXIR/w==
X-Received: by 2002:a63:8b:: with SMTP id 133mr3725412pga.183.1570749838835;
        Thu, 10 Oct 2019 16:23:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p1sm10658112pfb.112.2019.10.10.16.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:23:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] MIPS: OCTEON: Replace SIZEOF_FIELD() macro
Date:   Thu, 10 Oct 2019 16:23:42 -0700
Message-Id: <20191010232345.26594-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010232345.26594-1-keescook@chromium.org>
References: <20191010232345.26594-1-keescook@chromium.org>
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

