Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC820BAFF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFZVJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgFZVJf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:09:35 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218AFC08C5E0
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u186so7553616qka.4
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=QoyX5QkLkeZufbY3DPWqVcx8p1G2Pf6aerfPyt2zQE/ujAwEYOP4MavORdpoC0kiKu
         EBTjnDggRXo0KQe45lMKlqgesoVoq2M/WZaVEKYilzw17KOXTZudXtu6crQek7qlLud6
         wgqfeApVUIS2o9DKhJa1hfmORSYPYOqHxCziPwrSa4G+57ASkLll7CukI9nktN3Owv9v
         NukYDAxu7zl52PVDoi+7jdhfKkThnizMJ68rg/tVzgIVSHiP3aAKWELQxmH03U/bRKpt
         6Wgu+YeU85Wm8LsbzjbD34Ud+5/9JGpyI65sawIxfi18MEFZnvGjX41U/bIx6IVwD7H1
         RvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=ewMSOPqOrKXEVjUEv9O/nb4abI97AX+dktsnbFyP1+dr40ESSQpxh0Ni5LqAt46LBY
         bYsR7BWuLKv7Fq8NcGQbvHAbf7kRymdKZSCAGqfIyGqGAnlccXIdLSmTRhjPh9Pz+uhS
         cht1zz6TT4YE54m4q/LkhKfr+hZdphPZ6dtcoeAAhLNJuKzv/1Xs7oBhHjswVvqOclqs
         6g91iOaeJ6VhY+85POHZWKiryLeEdP6XsFGZV4hn9uzyMqzZBUxwNjIDkzyyrD9f7+82
         CRfFt20JmM8N2QmfWO+aZxRJMJmyiYOHjcwzy0uB6R+ftLOauW5belog6U2mJ4/Y0SKL
         vofA==
X-Gm-Message-State: AOAM5330bXEBweF4ye9QzUlRSLLcG26vd0EV7KxEqYo5rVb5WjrxSBzW
        Nzp7tu8sCTfrdLD92AOgfK9yZR5ikyvNDqQSlm2nAw==
X-Google-Smtp-Source: ABdhPJypYrK6iZse6cCSs4YnSv2AzXM6d8Vad2NCnBdBrfM4NUTiqCIXIvHzUdHQAv3Yb81UEf64dXgB2cs8yGqX9AXtcw==
X-Received: by 2002:a0c:8e8c:: with SMTP id x12mr5032791qvb.55.1593205773222;
 Fri, 26 Jun 2020 14:09:33 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:10 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 05/12] arch: um: add linker section for KUnit test suites
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

