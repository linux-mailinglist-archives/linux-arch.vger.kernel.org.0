Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6B207DE8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbgFXU6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389715AbgFXU6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA5C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m63so3533150ybc.13
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=MyLNvjH4BaSpMVt4m7OL8w8Kh4XLox5uMmU6/Z0ItdZP4yMrnH98CNwuV3QeifZL92
         3Y8tuGJwfcNuWZHxP1UkeqK/xJb1NRFlgtf+ZsZAZxk1HsrR1w7SdO7zb9wvBE1lihXo
         /gM/39u4cbejNpzreOPpLQs+1yfAKtUU1a9px0EyuTVEN0JzHssKb05XMKZvWoaTlB2G
         t5NtebZVftxPJvJkT4/iXrbXs6qVYFATI3eRi67iQDiHIAzrHfb/09cLTk76ga0CyglA
         oHFKXvdwJWazciq0ZtyNXvUR8S40GGOhq2T3LzC+e+3smItGPZh/hoBFWoC5eBtta1xc
         lXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=aGQL1Qmp9/K63VoLSdjYj1NOLyVb+zJXM7zMtN7xjzltEKUA2wVNqFJSmg9UGbZrMY
         7jdkWwBJg1fMnVhjlUfpXqBwl/hMoUbeGnF25sBE3ypSSwpGDSYvuG4858nT4AHkR0cM
         sS3Qe+NYHf/iq73i52veH/W7RGrEcl3IEfSwpttL0CwaO7UpCi2Yfiao0+S7K7hZxJCM
         elZ8pBOC00RzYHsff4SpqzPdSUAblTKGik4mveyI9eHCskAS53RfeUfMzvuS+0xyQ50J
         I3chMso1znSLKGhzutbJBWojvhyUt7OrdlUUebUN0NLV8MWX+tKhmArkK8YnwORBcZI3
         b9VA==
X-Gm-Message-State: AOAM532WEBRvx0TlddItbeW8i2KY92qM9vMhlTNWAwr4Jr0JWvEMZDRo
        P2h+bGqXm+gyoVenA0swRBf7v/r79x67Bt/nDSzbZw==
X-Google-Smtp-Source: ABdhPJzg+Au4umwjyLRblCRE3PuIJNmc8kxElVJsT/B0YDcGaL41JkWSqA7GJtKTxCWTEEXd8EUt+BFhsEEeVgNcGl0dpQ==
X-Received: by 2002:a25:73c3:: with SMTP id o186mr43621885ybc.230.1593032297774;
 Wed, 24 Jun 2020 13:58:17 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:44 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 05/11] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
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
2.27.0.212.ge8ba1cc988-goog

