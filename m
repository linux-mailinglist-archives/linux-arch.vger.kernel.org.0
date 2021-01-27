Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02E305334
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 07:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhA0GaR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 01:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhA0GSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 01:18:42 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A35FC06174A;
        Tue, 26 Jan 2021 22:18:02 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id y17so737536ili.12;
        Tue, 26 Jan 2021 22:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECfYTa8g/RycDbRtH0Yn068mLUNU/nijcXJNyLlgQgY=;
        b=eDw4roxzk2VITFd9zUB48hbCgR9FB1N9cd2g7I7ayoi9LWIjrpHZgrtvgIJBSfLWD+
         eorNCdswJvZUQCPzFRzbQsAtKdztjr+cJ9Vd8+UR07mCBr2qHA1JymoLnCHRd696NvjX
         uOslp6y4BKiKdhVlS9Xixpsphrh0P5jTOcZW74OvAyp9ddPsm7HrHyFrlK8EPVoXdPr9
         +8Fk6Ovf1qUAeQYwwDPXLdCMonkMPUicaCPS30q3znj1XuWuN6WusHvbQugQtBd4pwOr
         CthT7yQagTUJYu4zCDYmybJqqDOjzu0HMCLt9RqPyqdBl6Pf8bFwMJ4LNdWOwXPDXSZ3
         ywrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECfYTa8g/RycDbRtH0Yn068mLUNU/nijcXJNyLlgQgY=;
        b=VhvWj1CZQjREbXo41XK7cQ40FTjsXQJNWQNJFU28gcGwLw9qpuFUnK2DwZGmUZeymw
         EKk4/TMUREWTNAPxYQ8dkQ+nNN4pUBO7r5l4dwuCoI80I8N5Tw9QX6ovA38UFyqscdLI
         QO3XME0q5rNlQO8+8NfZSBfiNh3QmIjdhr3CUFWSndG5lUIMgQuPC+tY+rbyhb+It46j
         iNKM2reb35DgSOHaP399nF2JjPDrC4el652ZklOGg5NFOXNSM/jf/XIr0s8wccXLQNBH
         NLItd/iiD2cJtc0QeIgCBuz23OgimtHDrH1w6DAJx0kHChGo7HYe9sDJDGhDC8DaZnPl
         TE6Q==
X-Gm-Message-State: AOAM531WXF/VDzLjlsv5jboQaEtdzm+Zy5I5yamcHewOwzW+Ya3K9qW5
        iLy9tBVszc7pLzU8mYZDZKgS/buBFjUftQ==
X-Google-Smtp-Source: ABdhPJz82JoqeNCni7Sw0B4tNgZbCVA/qBL4J2zNUePZmXzJdMP0M/BzJxS+yDG9sz+arplzdzsBlQ==
X-Received: by 2002:a92:a803:: with SMTP id o3mr2618129ilh.82.1611728281311;
        Tue, 26 Jan 2021 22:18:01 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id r6sm547556ilt.56.2021.01.26.22.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 22:18:00 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Subject: [PATCH 19/20] dyndbg: try conditional linker expression in KEEP - RFC
Date:   Tue, 26 Jan 2021 23:17:52 -0700
Message-Id: <20210127061752.120083-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the last patch in v3 of patchest Ive sent previously:
v2: https://lore.kernel.org/lkml/?q=Cromie+v2+00%2F19+2020-12-25+-Re

It isolates my only issue now, Id appreciate advice, and dont want to
distract you with the 18 previous commits.

Im trying to use ? : inside a KEEP(*(expression)) to only include
A_header when A has content.

IE:
  KEEP(*( A ? A_header : ))

It fails with inscrutable linker error.
  GEN     modules.builtin
  LD      .tmp_vmlinux.kallsyms1
ld:./arch/x86/kernel/vmlinux.lds:46: syntax error

Is this possible by other modes of expression ?

I tried inserting {} 1st, that failed, appearing to foreclose any
foreach-like construct.  I also tried () around each term, and a
preceding, embedded "_loc=.;" statement to test the parser.

I didnt try doing this with 2 separate KEEPs; while it would be
simple, it defeats the adjacency guaranteed by *(.text .rdata), which
is the point of this.

If this were to be possible, it opens up interesting options to
statically construct table headers, and possibly even tree structures
in the linker script.  Id use it to add 1 header for each module, and
strip a column out of the table.

Ive pulled binutils to take a look at the source; having never done
anything bison-ish, I anticipate a long study without some focused
primer knowledge.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 87868c5a980a..6198cc850f9b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -329,10 +329,10 @@
 #define DYNAMIC_DEBUG_DATA()						\
 	. = ALIGN(8);							\
 	__start___dyndbg_sites = .;					\
-	KEEP(*(__dyndbg_sites .gnu.linkonce.*.dyndbg_site))			\
+	KEEP(*(__dyndbg_sites ? .gnu.linkonce.*.dyndbg_site : ))	\
 	__stop___dyndbg_sites = .;					\
 	__start___dyndbg = .;						\
-	KEEP(*(__dyndbg .gnu.linkonce.*.dyndbg))				\
+	KEEP(*(__dyndbg ? .gnu.linkonce.*.dyndbg : ))			\
 	__stop___dyndbg = .;
 #else
 #define DYNAMIC_DEBUG_DATA()
-- 
2.29.2

