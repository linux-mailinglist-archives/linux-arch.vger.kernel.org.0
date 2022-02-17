Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F434BA8CB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbiBQSub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA2532E5;
        Thu, 17 Feb 2022 10:50:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so11335916edd.1;
        Thu, 17 Feb 2022 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E7vDJlr3ShCmm14rXXbmLyiW36foVXBUCP88CYbZEQ=;
        b=UZNPaJbQTUyjcPbr/PNBbpLXQRT7b7gb4jnh8EQAYcDSaxNcnhmHXvL8dFXa4HwFff
         ZBW0wACsTlHyQ5wWSmgJ8NQFgE5BWKRMrVIO+2Pt7/v71HX2bJUwn/ThGTRtJRQHdq8b
         1CXkbmgbaAqofVAMOW6tWeegzhzQWbcwr/6PAhz4+hoaT4+ZNlG+l3+M2wVNdBZP+yxJ
         EPKctpk/bEedKWCtPMie0yZpg3BEuwbXeUSp+anEzwJcDIs5yfUJlRgncigJx+4Hvwvj
         Hdf6JRkQMBsA8wZmeLAYbs1SdpbRoq57z/xUVZA3zyOh3BM/9cPhu72bRO+3bwX8a0+h
         Xu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E7vDJlr3ShCmm14rXXbmLyiW36foVXBUCP88CYbZEQ=;
        b=sFsDuocLH5gct/BUFdeHOd28HsemhTgH6PEQDXRNnR8FJaAf8/nZ1ZCsNz4Q/b76m4
         r+XRFzxWxMdm4l9XrOX8aJsnbPoEakH2QBE0Yb9k9Kua4XRpjPWM2RCd+9YYopOzh3Yd
         LLjmYC6NtCLfLJGemUmsNDaIOBw/YOVEe06kPeVtCooSECGzM6g+eyLjXKl3amG1dAmq
         ntXHap80y1UIDxjHR3KQ/xh+HHKDmslcYDIC5RwQrBiWRCNjpAFfzzvBeEqaAcOFzTkM
         viOvMmBmYXR11ccTuYLTKrjtgzHBAf69pBjEtnHfbul8b5ZLWrJ8c55hsTQCc4AvHm9I
         DVlw==
X-Gm-Message-State: AOAM532d7r7sM3ISFLGLOgg7U/MX6fNW6kugBPrdqIasGXmeaO1ywLxg
        1TaOqWRbX5pv4N/A4KwMv6SsCEsj8SiRxEgC3GJMoQ==
X-Google-Smtp-Source: ABdhPJwohka0Px+31wNalaj/bE14nYoTr+UZeDUWbd8NMqNlF11xv6t6hTAYV4SuzQfXhziq5TgK/g==
X-Received: by 2002:aa7:cc12:0:b0:410:cb7b:a9ba with SMTP id q18-20020aa7cc12000000b00410cb7ba9bamr4125709edt.196.1645123807668;
        Thu, 17 Feb 2022 10:50:07 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:07 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 10/13] powerpc/spufs: future proof usage of list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:26 +0100
Message-Id: <20220217184829.1991035-11-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217184829.1991035-1-jakobkoschel@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the speculative safe version of the list iterator spu will be NULL
if the terminating condition was hit and needs to be reset to spu
derived from the head, before returning spu.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 369206489895..5b2afda1653d 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -384,6 +384,8 @@ static struct spu *ctx_location(struct spu *ref, int offset, int node)
 		}
 	}
 
+	if (!spu)
+		spu = list_entry(spu, ref->aff_list.prev, aff_list);
 	return spu;
 }
 
-- 
2.25.1

