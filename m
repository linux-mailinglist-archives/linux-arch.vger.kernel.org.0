Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4203BE9142
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfJ2VOC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41852 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2VOC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so8299857plr.8
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBMCQcUOloL4FNQm5udB+snIcmDdRxu45Na8ZXgn6j0=;
        b=kdVHFkWUWfSKoiPKPgWKbAsFTrcW5JNBQhTGTF4q2deleiY3/8n0BF6eoXBERPq8mq
         MXvnqxBYuL7FPHWZ/R6H0s/W1xjZNZPEiLHYArhnUWssmjQ9IekX8pDgbayL/8UyYSTb
         kH2PTazTZLVUdMFc2ETjXJ8rIdmfptOgLDOBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBMCQcUOloL4FNQm5udB+snIcmDdRxu45Na8ZXgn6j0=;
        b=grBpKQuo0gQEmFvK6/lpdE7Sv1oH/hqTFx+Pj5g0IYp1NcBHRR+EHLcSw2yXRFQLIv
         onApR8r2yJrFpsGtw+lwvLa0b/aQpau54IGeNWOMVnzUmohoLLkY4teTMPg7trTSshUa
         G0pCa0i3JJt4ttG1mcEBQtHRzS8SquUDvy7fcH02Ct8wY+XSynC+vqPAIBd1LZ3EFBKo
         TycLnmTdwlkRO+hLHBqBiNk3HZQal8JgpGXfrHJiVIrcsRvaTrxaj/frpgoLfmHcuY2M
         3wkA1VfATypvtizSXqZRcRn+3LDaflJ6Mwyv24RZiafNZXI+rLrfu5MmonO5yvla7llH
         vlJQ==
X-Gm-Message-State: APjAAAUj25OGjepXTXPFQboKVDORAcLBduE7Dp2EWcKZb57rkWX+QU1k
        2j2RLijFvthiudLJgmpBV6ePgw==
X-Google-Smtp-Source: APXvYqxEU/jPSR344Zm3qUnGnizPxb8rt1UkEG6PtKOdviXqXNGWzTbgn7h13zjGLZsYob22VLKUOQ==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13mr785919pls.29.1572383641856;
        Tue, 29 Oct 2019 14:14:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm135208pgs.46.2019.10.29.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Date:   Tue, 29 Oct 2019 14:13:23 -0700
Message-Id: <20191029211351.13243-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Program Header identifiers are internal to the linker scripts. In
preparation for moving the NOTES segment declaration into RO_DATA,
standardize the identifier for the PT_NOTE entry to "note" as used by
all other architectures that emit PT_NOTE.

Note that there was discussion about changing all architectures to use
"notes" instead, but I prefer to avoid that at this time. Changing only
powerpc is the smallest change to standardize the entire kernel. And
while this standardization does use singular "note" for a section that
has more than one note in it, this is just an internal identifier. It
matches the ELF "PT_NOTE", and is 4 characters (like "text", and "data")
for pretty alignment. The more exposed macro, "NOTES", use the more
sensible plural wording.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..81e672654789 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -19,7 +19,7 @@ ENTRY(_stext)
 
 PHDRS {
 	kernel PT_LOAD FLAGS(7); /* RWX */
-	notes PT_NOTE FLAGS(0);
+	note PT_NOTE FLAGS(0);
 	dummy PT_NOTE FLAGS(0);
 
 	/* binutils < 2.18 has a bug that makes it misbehave when taking an
@@ -177,7 +177,7 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :kernel :notes
+	NOTES :kernel :note
 
 	/* The dummy segment contents for the bug workaround mentioned above
 	   near PHDRS.  */
-- 
2.17.1

