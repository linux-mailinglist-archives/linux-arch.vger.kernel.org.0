Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111623C0F5
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgHDUsI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgHDUsD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:48:03 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF1C061756
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:48:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t6so29644335pgv.5
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e9HT6AS5pNuhm0IIEReS4jZdj/HAbOxw73GUYA4oHss=;
        b=WKeGul3KEmcWpYGkwOPuVNB4KHstNGi/6UCVOenRedf0cDpH6p3N89em9zoCkJX65A
         YwY93C9vP5AeXLg6dD+Df8uE9y2uyVPzYuwA+jYo6+NU0T72fcbt0V/T0asicft1AvSa
         99WMuzMxTO67XWoZMW2zQAp8oWB5obGAFel9NIZ1qWvVsujj/eVRbXW05xPYoMBZdRVJ
         cKBW1gC6e9Zl09JEkGwle03eAHNJksK27r3Zb1TfSbk9bwX3QL2530KKioWMzCnfhrjh
         6hNPdTCQEp+UpMnqlccneAqNP9ehdDxEQeDqaV0cQGF5OWhztg1MongG3VrIlfKmdoGk
         yNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e9HT6AS5pNuhm0IIEReS4jZdj/HAbOxw73GUYA4oHss=;
        b=jGyIsnOjS+xNQtZo+ErcTqLurljqIZtGOV/EdP7v1FjFdL+rzSmYB8EdTM+ORwn0iX
         wxq6fAveh/dtejfaCB4zBEyafstmdtEzcIHJOueeJeXtD7ABfuUIlLeEQk5LDidd45qH
         3KemoXKkuaHriMWPvfLUFTs1idLvPMgmTQ76Yo41jdqyLOVX9otEODZuZ/AzUK0Dy/ke
         78/mHlIfkdasEELxsAgMSNRhO/UwYw16LBabAF54FOir3jfw+0zFtdG+rWqhvG2yAkae
         oxuRYK77+g3a9K5MvFhZ3X6BW1ZETb/OoWPOfjfewoOIZ7jECq2HvRmC59+dkfy/V9Ne
         qaZw==
X-Gm-Message-State: AOAM532JP97iy1yZZtzM+k/Zgq1Y8LwDzMj8/b9k0C3qYhePM/6jnsyv
        1SSmiK2yZAVAK21QlLwazR0WWcv3fgp5Ws+DKHqq+Q==
X-Google-Smtp-Source: ABdhPJwvVPf58Z+s5F3/exJw2LvrTU9deyzhRpg78+XvTlgNql9h3A7N5TCVgZfFd9nf9/1cES1eS4gEGASc8UKOHawR4Q==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr87047plp.11.1596574081620;
 Tue, 04 Aug 2020 13:48:01 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:47:45 -0700
In-Reply-To: <20200804204745.987648-1-brendanhiggins@google.com>
Message-Id: <20200804204745.987648-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200804204745.987648-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v6 5/5] Documentation: kunit: add a brief blurb about kunit_test_suite
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
2.28.0.163.g6104cc2f0b6-goog

