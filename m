Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174E42D937A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 08:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407171AbgLNHCX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 02:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407167AbgLNHCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 02:02:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850B7C061794;
        Sun, 13 Dec 2020 23:01:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x126so2661838pfc.7;
        Sun, 13 Dec 2020 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxv1/xcoFyc0+rLkO7iNlzfTmTCUobsv0mf1a1fJaKs=;
        b=EBV8ywP4FdjYHK6Zs3pDMM/umySWWxUPltYnJrMBAcmSNSrWDQ9XMhWHy0oK/dZhkt
         mLuWcdPYgZ1T+rntAUck+SBWkw1wKlUH94Qr46nl4/BWhJw7PzgNFCdnq92WNA9BhoWB
         s8B9bP0O7v5R2B1SM/hMsaO1bfvOw7EJZu4ZBQi6Io0XQvfLxxp/ScAF6c5nl5Z4gxOY
         EqAy2QuVQUTiezdjMTmBwRk86RieavdiE+zX/OVFC/wJy1fiIcpfP12XwS8WErhncquo
         WlvMsM6ce4p/hs3r4DiLYkhtSooj48Kx8Zo4YtnHMIXxP3UmAA3IOmqOGzrTgI7cEb2+
         dYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxv1/xcoFyc0+rLkO7iNlzfTmTCUobsv0mf1a1fJaKs=;
        b=ozl/n2+i/nFBrbtj3TZWkLQOoSRQEOmFMH5ybvFC16UgvM3lViJtdZb6zEeude6QJY
         ZGqzO3YSi2yMby6877XjdmfJKejR3OjBJQsMmmzASNrcgfLsrGa6cQQAIGnDbUVsd4ca
         s5/9NoWkyI1ViEemWKRPakq3qKetvFK1xDybYq0Bfed8gd4Ybge5OC1+phpO7hIeNxMN
         OmKiyxl6LkoYW3iQHk3KufTKwUZvJMj0qq0WfrwXPjjffwJYb4AP1VsLxzau0J9Vny7y
         J7aHis2lcs4+a0cGqTRzM37S+HIs/bNua7nr7R9f8yzmcFVoq45SKkxSkp5QXAtbrqxy
         EX1w==
X-Gm-Message-State: AOAM533Ns/QxwhDcGaKYWzkAr2ri4k/oY84o1BuJcn54cw/EDQgZaKBT
        287gwE2e4tX7zsfL25sjCt7a8aFxruo=
X-Google-Smtp-Source: ABdhPJx5AmILXSD1xPGNVdPYIqA2jTn8bVniddzn968H7tbSxzitU/Hs0byrii/p6xSaJmriLmU4jw==
X-Received: by 2002:a63:5418:: with SMTP id i24mr22887288pgb.165.1607929293976;
        Sun, 13 Dec 2020 23:01:33 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 84sm19570018pfy.9.2020.12.13.23.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 23:01:33 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 5/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Mon, 14 Dec 2020 16:53:12 +1000
Message-Id: <20201214065312.270062-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201214065312.270062-1-npiggin@gmail.com>
References: <20201214065312.270062-1-npiggin@gmail.com>
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
index 5181872f9452..356138bdb5bb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
+	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
-- 
2.23.0

