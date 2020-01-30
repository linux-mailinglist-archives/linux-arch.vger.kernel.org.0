Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B747914E5EF
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jan 2020 00:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgA3XIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 18:08:37 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35580 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgA3XIf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 18:08:35 -0500
Received: by mail-pf1-f202.google.com with SMTP id q1so2771234pfg.2
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 15:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GWHGFk+tfCHvu/qeG8h3yhiMIdqay1deL3woZTxVWJc=;
        b=SK7qbAbMVIMUgyE42nQVDPyGZ3xVFHv0chQcoZWlALn4b+uUTa/V5PsexsEkn4W2Kb
         bZ7asnJNgDPXfOBetYqJnB9J2XcNvSCZ2/XQ46hFJbZuHTPb4tjLrji35a2EH5gEYQHX
         Vkr9rAsWvphKeh+EesgLzV0XxJ8zZnKFtmATHJ3yzTibY5hSi70Lnx1UCkTYJAuNwZlh
         OicLwo5w9sN3kYYpjEk4VGqXocphh9jYWtcIwf1NuOdGOcvYH5uehNSugKLXxfxcIe4+
         5dUSUaen9Esm8+Jozb1twYu1kudX5eI+ybO5b2ahw9UpOS7dJqKDb5rKEe1YFZwBGUag
         JZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GWHGFk+tfCHvu/qeG8h3yhiMIdqay1deL3woZTxVWJc=;
        b=TqSQf5wCM3KWmD5/RSKuLCdMB2GzhS0FabV8u6Cos3S917uZzFwiSoSwRZoKkLUnNQ
         L5/Z/tIpf2N2EoGfzdns+TnqEWjIe9SAGudtga08mtY1uULTCRoedmkqpPHVYAitYeyo
         1wH0i2x+LajZZyiw4w5V3GnaKNqIfxqty+sHNlBJNE4v0u348BdfspNueLkrULQDBwfH
         kKF5lSCCaaqBlI0cjsj+dX8735uqsLUH3MiSB9VbNesi6ymnmJlgitf4Zu45Fzua3tSH
         M1dzjunN7oYEYEfoaanhi8aZv+1QBZcN5Kux/w4cbbDUDLK0pRWweoOSG7Y8K5c7Kfrj
         aa5w==
X-Gm-Message-State: APjAAAW86VpPxaIqDQ04FeMkjtEUHJWBJHFxAzCHT+pKoeQv/nSIv7Bz
        1KzCsBALk7NePG8zc7qDABPOUV+dVc4e4aUj7xMoow==
X-Google-Smtp-Source: APXvYqzh84slKzyUU7Hf8lA5m17FvOWJKZUYYrXcCEAGxMB3WhDFDTTWmSv14cUPAQuwHTR0/deMhklQVof4n1fVyRG7sw==
X-Received: by 2002:a65:4142:: with SMTP id x2mr7048130pgp.393.1580425714304;
 Thu, 30 Jan 2020 15:08:34 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:07 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
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
index 7145ce6999822..eab9ceb450efd 100644
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
2.25.0.341.g760bfbb309-goog

