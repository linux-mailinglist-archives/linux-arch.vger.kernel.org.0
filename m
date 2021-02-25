Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3529325111
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBYN54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 08:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBYN5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 08:57:47 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39662C061756;
        Thu, 25 Feb 2021 05:57:07 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f17so5653554qkl.5;
        Thu, 25 Feb 2021 05:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YjQQYAvCYurZK7ldaR7wdMuQlhqNk26sh+booS2Ah34=;
        b=uRMIB6gDJkTYgjbHVu7BAzdGGm1PFtEAm1zu98MInx0ilMKOd79he4zUJKLVyn5GUB
         tlZMhqNfr5G/ILE0mA8nnhJq9AmzfJXAmQi4oBS5dxezyZR1l5Xn1oyEoao/cjg5BqrO
         sP+AsEjwmcT4MM333CaI0Cf5xGOa8PyZX7ueyudp64ptucBQtz7m3rPqFL8aN42MDGmo
         b7tIRoRtY7HBLDg8S7aXUBME8kjVgCe5DTZeoXRDRcl9MM4D7Bh7GxY2WMcjazIOmGDo
         nPO9CWDk4Zt5sOSjW3zTaEUgj5g5ihUB387FcuwKTBil76LwLkgVWpX4iK0iu/V+bppa
         78EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YjQQYAvCYurZK7ldaR7wdMuQlhqNk26sh+booS2Ah34=;
        b=Jz0QXzZ1tAt5UkcOmZabi3BUy/vEoIy5YS97RyeA8VfZQ2maEVj+/gbZHYhg5wKO5Z
         FSeDNSPR9QfHnKjMRhdmjKlguSgxjWYzVs1gTwQr7klatUtuatzf5GCyBJYdZ3Zv/MiK
         kN4/DYDtwG3LOauSxZvWdudG0b2NyBVeU+4vkwlIHdeiA4tbUj0R2eRVEJ9VWULn5HHn
         3/uRYJTfVxPXGKRWuBpYfEyh9FMdWR7GtJvM77efw3v+1U+o2Vq+Cne5PaoT6pmdHcMk
         rPAXc24qIrBjx0pTp285mxkuF23yG1rFlsg1M/YYPu01NBH5/FhSIjbSdi6WnXkbOczw
         1otw==
X-Gm-Message-State: AOAM532ZTtTBUyd4rVCHtRhdR878tfHj7kh+mc0ZpR6N1QxFeQ79aAn6
        H+XxzDbeQ/t1LicacA94MfY=
X-Google-Smtp-Source: ABdhPJx+PKOZos9XXN2E6Yo01qJv1TAuCbOtRjCLWy1ChLGZFh7LIPlXALSkc5a6ENsIBlQSRnoD1Q==
X-Received: by 2002:a05:620a:166e:: with SMTP id d14mr2846844qko.82.1614261426421;
        Thu, 25 Feb 2021 05:57:06 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id z1sm3522908qtu.83.2021.02.25.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 05:57:06 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] MIPS: enable GENERIC_FIND_FIRST_BIT
Date:   Thu, 25 Feb 2021 05:57:00 -0800
Message-Id: <20210225135700.1381396-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225135700.1381396-1-yury.norov@gmail.com>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>

MIPS doesn't have architecture-optimized bitsearching functions,
like find_{first,next}_bit() etc.
It's absolutely harmless to enable GENERIC_FIND_FIRST_BIT as this
functionality is not new at all and well-tested. It provides more
optimized code and saves some .text memory (32 R2):

add/remove: 4/1 grow/shrink: 1/53 up/down: 216/-372 (-156)

Users of for_each_set_bit() like hotpath gic_handle_shared_int()
will also benefit from this.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d89efba3d8a4..164bdd715d4b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -26,6 +26,7 @@ config MIPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
-- 
2.25.1

