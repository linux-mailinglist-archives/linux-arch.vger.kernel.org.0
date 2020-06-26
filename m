Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61E20BB0D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFZVJs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgFZVJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:09:47 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5AC03E97A
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z187so7442674pgd.11
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=ZVmC9pMZrVunA2Fe2R9SmfDjSh6jHe61Xaa87YaHusNTBjJf/LeLbaReVAu2j9TGqG
         DxFNyk3GpI7sLmWMCSdQD7bvz9rONUgJGdF7uQgwV9+yZ/fSaQQKgZ4gmTg7ATax4Vk1
         oV5uEEY5wckV5kA6VI1hcndIeFh/iBm6by2153y7uZEUrlPNuhJOGVBqtgu612iYSDS5
         kqjVhZYud4bB1XAnEHsKMzN8i0QHS6lt4v2+aUunA9LQhB4hkvgOKdZy4uYW9e9c4Pee
         JZVonLmRJ7SKlMenwZofGiFcAJe3AeZZuDV2tMMxx47AoxweQmK1o1oVFzbg31I8w3zR
         nK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=MC7hzGedRl9+KF1LPwDjHKl6GRxmQILFqlvEkSzk0WWA5fly8D7uf+lLa8HGMN3xdM
         Hi38dyH423rPgWaLWMyeNI6lRBmYHRaFpGhr2bT4+rstLAfzxitMWcD2fxFIK2fHGUfw
         kEhYvsvDeB3O/pPYDfb1EZu1I7zGi3mh70HyQHtKEIhFwqho9qnZOqkD+Pszg2CnWnHa
         teVmdXqisaW7vEh5h4J7tQwiolZipIzKYfmi9NVHZnEZud/Ftpp7F7EyHffdTjAteG+R
         zFeUFpq7cHdP1lgnNnSOsEhgGpFLvDVWDE4ZkQnAhrdQkZXT10j6ww+DiEaYoyGuZBiA
         tnQQ==
X-Gm-Message-State: AOAM532+C+2IYY9oEuIxdFrPtxIOvjes1xy1bL+AAOJWvFCExCWF2dcw
        AUtD+/v/cOHYRgamgPare6WnYB2r8Fj1tHzyHDxGOA==
X-Google-Smtp-Source: ABdhPJyHSEr0Zmc7EVSRsW7eDiy4Wfh57qQNf0udG5ob/OtFkSC+pCfiBpVQAOifQwHuQ/h0kM0ynYxDTAXmSlHhH6715Q==
X-Received: by 2002:a65:6707:: with SMTP id u7mr567899pgf.233.1593205786593;
 Fri, 26 Jun 2020 14:09:46 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:17 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 12/12] Documentation: kunit: add a brief blurb about kunit_test_suite
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

