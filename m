Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C53207DDD
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbgFXU6m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391549AbgFXU6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44ACC061797
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p22so3533805ybg.21
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=eBb2r/O+3xD/ft1cWQIYq+lLT5MaZcDKCI7F68NCZy5mtkJDNhWzHGgMGNZjbp5vY2
         NeciIBXPHqDHAr515OD+KEI2SwbSQA3wPry4syrluMYmbIYDoGubxlmgh9jyRlLOoHz5
         p4aoDDsXGCW7wnWAlLUMV8zs3lliqsQjwHQ3f/IRxPoalCwAHzoMzbTu3F1aBupYM8jY
         RJXyTQ3a1l5kZUWbyWsbEikRBkGpV5M+0D3Trh1EaZC6LuABuarRYjnjmK+YSshwXwQu
         +pk7yF5eODqLsJrD/Gc4h/AznuIk8Jq2hwInTWrfIN5TI1VZdP1CxKJc8TVkKATdArhv
         rkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=HFLHnLPwo0fm0Hy1xgKovyN/KCI6JYA69BMokc7g2vTAhmpPEaZiPBYneILS+D78ip
         ljd5JwVBeOX3cd1Np6h1kjgdcT/M0MnbDZO0hyQIVOfR2FyNTXkNQXLSWUlAgYfvkauL
         RQV3RrTLiVbFZEXMoHtOC7o+9NT+X3PtDHxgltvsjCMngVgD3qpbMQfIVIDGlOyDmwut
         r1Bzi3Q8KwXAdX7lBYBqKIeijD2rbc13MnLjOk7EfDh8pvkszP0yd8i9IRLXasBS99DX
         mMXpXFTC6PRn3yQ1sDv5qxaGC3D03Reobi/UQZ4kHx5NaBIEOQhavN9JTGG1dBbAoJXO
         34RQ==
X-Gm-Message-State: AOAM5328FdWtBUoXCQJTAdT+/G58UZsW7mHLy+zZdwMz23l+0rMBTU15
        05SEM0ocgWIzKHy2ZLt3s83J/isQaJhaneEkR5lBpw==
X-Google-Smtp-Source: ABdhPJyzMN1O9F20c44aUZ3Rj+xXWGPWk9fw0REl0xzDcZiFgklg99lb7/rTyyzMpJHoIh8oBhPbhqyjNv0vmkzqL5BxQQ==
X-Received: by 2002:a25:2d63:: with SMTP id s35mr27292035ybe.367.1593032308955;
 Wed, 24 Jun 2020 13:58:28 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:50 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 11/11] Documentation: kunit: add a brief blurb about kunit_test_suite
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

Add a brief blurb saying how and when the kunit_test_suite() macro
works to the usage documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5feccf..961d3ea3ca19a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -211,6 +211,11 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
+``kunit_test_suite(...)`` is a macro which tells the linker to put the specified
+test suite in a special linker section so that it can be run by KUnit either
+after late_init, or when the test module is loaded (depending on whether the
+test was built in or not).
+
 For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
-- 
2.27.0.212.ge8ba1cc988-goog

