Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB8D2C72AA
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgK1VuO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbgK1Sc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:32:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC6AC0258FE;
        Sat, 28 Nov 2020 08:02:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t18so4136657plo.0;
        Sat, 28 Nov 2020 08:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ryYzZTfuMdMQoDGnZ6qQm92nrELT0Bznsq8pS5zNkE=;
        b=O2SH7PLZYn9x9yrSkPvaAZdWZ4Hk1Nz9o1vpICXBIyIIgIdy8d9QFKV+1r92+5zuOs
         gYKTram4WPDCSdl+hhVkmF9+vrkTQECccC9p+zkSVnyHnydt6RZsEWjgzXbamDwz8Ryf
         WwRcOCDkLf2yHoNmiO4MHVOErhGamyhGZEu/rYwWW8NOV9V/N1bEFCnSnAJQkVeT5lqs
         dhR5ybbQNLsLTLCFZze+EY6rm27mttggd2bAwJ7eXS3YKnz/bnqJ0GT0EmjvtORGnwS+
         17SXi5CsTI/P47c8OyIr30m3TcLjy6wRktbukjqqdEaVGzvGIE/erk1qflt4sxiTfF0m
         Fmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ryYzZTfuMdMQoDGnZ6qQm92nrELT0Bznsq8pS5zNkE=;
        b=eK3ziEiE/BotdTZW6j9wspQR52WnithtcjadyQQbvez7+1nH9mIw713INsCA7atain
         WnZ7/xIS4VZzgXyzV1pYxSaKqL0Pssl1nqpimSjtQELdominV9kPVi1/eHMiiipqUZZL
         jQZuV7MiVqi+9lSv8j+q2XTAZ7UjtH/sNKruXFkJfI7xbBJbfDM9oHa0JFgyIVZpK9Gr
         Jk/8ygVfsO0964Ih11yWpcg1wYp/028w4zHA5stZyVLwVWuk3X6ZEQHDNXYgF8+BJ7YB
         XCXI10L8x7UjqqfQtnXQxf9Q964IL+LodZNVw/OWBmxqtWic85AIRyxPUsyIKONaJHeS
         nowA==
X-Gm-Message-State: AOAM531fO9qEJrbSwNy66FU3VtJELN11WMKjloj4ZrMoIrRdfgzXEN1Z
        CdCjJeKO2AtrYmjY7OsluNOUUMYn+wU=
X-Google-Smtp-Source: ABdhPJxOmOSo7yBdZGFr5Ee5U/YJuP5XMrKl+Nl3YUOkuajp7hYak8NpHsUyWSygIXkb6jTi/aUZeA==
X-Received: by 2002:a17:902:ee53:b029:da:4c68:2795 with SMTP id 19-20020a170902ee53b02900da4c682795mr8244122plo.7.1606579347904;
        Sat, 28 Nov 2020 08:02:27 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:02:27 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 8/8] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Sun, 29 Nov 2020 02:01:41 +1000
Message-Id: <20201128160141.1003903-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second. After this patch it goes up to 118 million.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..d4793c0229d2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -231,6 +231,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
+	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
-- 
2.23.0

