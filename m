Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5FA2A4DFE
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgKCSMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37037 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgKCSMF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id i2so20106906ljg.4;
        Tue, 03 Nov 2020 10:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWS2S4IqKiS2heydlDLEdna4ZCr5rpDtwM55ddWvvtU=;
        b=GDIsRb8gi/N+EZOM9ZhX8GMz5WqThw0TMUK1JZySMF5e3OeHnAYnC+P4i2Mx2He8qO
         es4D4HXxVciRv007w0cQPZpGK0Y0IUk/yvghudU4ckQHa+FlF3hTCgNMXc6BNB4Wjm9x
         /ke954LP4fK1CqELLshFioth5aHdB27afRF39kLSLTbZEtObkXHmeEw49rSbyFosTlvl
         wy4p82lsNTbvZ1uCdVsHFcbFcbgio4ZKBCMQ+ffFIPxXhHrpWXB8oxmg5eB/nDiHoeu4
         rZ7SeNvbRra33I73Lpyv1tOwAjFbj6NRVdovfb3VqXTdy9ndp9OkEq/niR832ZUbPQ6u
         jRdg==
X-Gm-Message-State: AOAM530lzkOqGLrABOuNIz9ygilO+TrA8CY3mNo3kRhrOnDvkwdZ6Rpg
        iVQXkpURn+cETP00vRnv74x9kjPEbFx3/w==
X-Google-Smtp-Source: ABdhPJwc8wDtdPCNAYPFmWQsDK9gsD0scYRvOTXL6ZCroo6mSIn3e70xQH7uoKlgadVzXtsqqhLFSg==
X-Received: by 2002:a05:651c:1245:: with SMTP id h5mr8111765ljh.404.1604427123263;
        Tue, 03 Nov 2020 10:12:03 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id p21sm3961746lfc.231.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:12:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mo-0002rk-04; Tue, 03 Nov 2020 19:12:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/8] init: use type alignment for kernel parameters
Date:   Tue,  3 Nov 2020 18:57:08 +0100
Message-Id: <20201103175711.10731-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
References: <20201103175711.10731-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Specify type alignment for kernel parameters instead of sizeof(long).

The alignment attribute is used to prevent gcc from increasing the
alignment of objects with static extent, something which would mess up
the __setup array stride.

Using __alignof__(struct obs_kernel_param) rather than sizeof(long) is
preferred since it better indicates why it is there and doesn't break
should the type size or alignment change.

Note that on m68k the alignment of struct obs_kernel_param is actually
two and that adding a 1- or 2-byte field to the 12-byte struct would
cause a breakage with the current 4-byte alignment.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 7b53cb3092ee..e668832ef66a 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -255,7 +255,7 @@ struct obs_kernel_param {
 		__aligned(1) = str; 					\
 	static struct obs_kernel_param __setup_##unique_id		\
 		__used __section(".init.setup")				\
-		__attribute__((aligned((sizeof(long)))))		\
+		__aligned(__alignof__(struct obs_kernel_param))		\
 		= { __setup_str_##unique_id, fn, early }
 
 #define __setup(str, fn)						\
-- 
2.26.2

