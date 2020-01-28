Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C414B049
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 08:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA1HUe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 02:20:34 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37946 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgA1HUe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 02:20:34 -0500
Received: by mail-pj1-f74.google.com with SMTP id 14so961283pjo.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 23:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=klZSQn7VqC7h7im1FGCSgAsyHBEPANhNSwWbBSFGQEg=;
        b=QbvcI+etsqAlCV8e08VCXPOpU8eZ3t5R/0WlbHTJvxoQjpGyprnI2S+3VA6TTU6VcK
         QX1fWLkdGx43woSE9wxtOr/nIAR3GDaX0+tn1XlmHZ/gDfsUEus8JCgUXj/7t81YSGwq
         A1+5KuQ/mfdwKuU6SJEJcnV3OamCXXd43jahBhlSObRoHRxmuhcNwcQLh/PNROz4WbAm
         cTrDAdcVVc6LRnp5yWQAHaMmosEmCohM+vE8NJDyUtTlY82smbWOEof+WuehV/08VE1/
         7PHZ1+O99hDXEO3U5zm/NWDW0yicvPq5SOraPW0/CVRO6+C//tnAYf5QyggRVE/D9Iqx
         WDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=klZSQn7VqC7h7im1FGCSgAsyHBEPANhNSwWbBSFGQEg=;
        b=fhgLu0D2MZtANQh512nzQc0QO7wZg1FMSXIWVy5C+IIktCPL1Cudcy0vU46iYPeqDA
         pms5oDb+39UcwX45xP5OV2z5gMiLHL4pfgF0uooInpFv32opATy1NgEKljqu/khC6zpL
         91t7vLQIArDP0D9ITlLLJwv/a9rdSLVBHOv7tT4UG4gk0pgu3QvqXNlh8KFDSmfd+yE9
         J0XMCjPknNHvlnXhwxICYsayHEU9q6PQBDB3TLLrUI/2xuyjMSePS8Cq5XWprYWuvx54
         u0WPyjm9pHgR39ho6WOeAZ6eho32z403cB9Oy5kwwDHJsIWSUeRgQJOuUvcFYIRf6f6I
         AkPw==
X-Gm-Message-State: APjAAAVDVwEXANIbFYrVTYMR56WYTYDtvybyiA37OrPRisKnBxle9WrH
        w0tdMZW2mAKbjpdaq8a/F8fzyfNcMe/ExUIgxXR2OQ==
X-Google-Smtp-Source: APXvYqwA5T0XsCGucJCgnj8mr7+umXSlJ/p82m0DTcBQ5anFOlb+KkNonTYUXWa6suDswZ7MNnrzg6/s9XBTLENdrlmgtA==
X-Received: by 2002:a63:c747:: with SMTP id v7mr14107372pgg.291.1580196033243;
 Mon, 27 Jan 2020 23:20:33 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:20:02 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e03..0472b02ce16bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2054,6 +2054,13 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running tests.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests.
+			halt:		halt the kernel after running tests.
+			reboot:		reboot the kernel after running tests.
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.25.0.341.g760bfbb309-goog

