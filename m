Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290F2172E2C
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 02:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgB1BVC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 20:21:02 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34725 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbgB1BVB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 20:21:01 -0500
Received: by mail-pl1-f201.google.com with SMTP id j8so745954plk.1
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 17:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ojKrxl1PCfCfQcXP0dlp5ruxQqqYc6a397dYZVnYqp0=;
        b=KfovGAA3hYngusOc4O801/OpozFq5bk3pBM09Fm0f+xMWm65rYFn4FPokdCHh6Jzut
         AwQcPV1GQbZQD7YtUQoxvGCQfdMILr/M4f2QE8tKCBkg22l22HKEkPDNmbkuME12auqg
         VdZRBRlAz9i29ZkqcHN3n9KttVbxKzJodRc0++/lm2FzahO+rKn2n3UmH7on8WoaWvRz
         Wzbp77tnPo92vJ86YgtIYW1gOwC/AuuB/hNb2KcuQPq5G7ssUIsDyt90aUWsJ4mhLbke
         /KvsVTb3oL7y2QS9JDSB96JlcRWzWVCOmiNmDItvhmZT/zebT29KmKHbQRgIKCKBsBgw
         vLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ojKrxl1PCfCfQcXP0dlp5ruxQqqYc6a397dYZVnYqp0=;
        b=q8j7XJGOEX8+pVtPiZoTQP/iHhlChH4ytIlxYxPhtbrFjWDsaFbalkUkYh5QKhNgk9
         HeMngKrmvv8watml+kOqit312BZZY7+5m7ucHBPak1pMtp74Es+hdPuu/nJ41bE+kDkw
         R/hkkQoUEDtzxzQymqyOEF2Z/HgMPWsPkRA+5WX2FlmQo8pCz9ju92csvFkFGNKNkkFs
         WyxANtk5a3dV4gbpaIxqyeXupsdTyXGdvJTGVc2GU3Xp73eMFYxdaBISmNMCmHuwPGbC
         IINjv9rsMKZvlFrLej+SNohrSJtCfCqt2pZ04P3u+gjC+MDSWlIPHLUKbhOEqCQEnxFw
         pmiQ==
X-Gm-Message-State: APjAAAVgFozt+Q1sXKGE7C2rXfoH+U9LFFqnxSqidyxsX7xIoM5IoFhB
        39fwfZxkSMUcq5BalVacZkcQ6h/BVd7nsvch0LwJ5Q==
X-Google-Smtp-Source: APXvYqwkRljuIrlXDjEYNBekD9KkQQTbA5MI2lo52Sc84mhjN4+wkeOgkPRnjdKBCR1laBgPCE3wql+OCRfkujQNefCpvQ==
X-Received: by 2002:a63:ba59:: with SMTP id l25mr2147590pgu.68.1582852860531;
 Thu, 27 Feb 2020 17:21:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:31 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 2/7] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41bd..9a9c97f45694c 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.25.1.481.gfbce0eb801-goog

