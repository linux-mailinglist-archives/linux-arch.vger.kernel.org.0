Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D142FC8CC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbhATDYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbhATCal (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:30:41 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89225C061575
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:30:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e9so7518131plh.3
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAA3lMCndc2PgPbdvjREcHcL8uYitiPOghcxLADFEeE=;
        b=XPvAGvQOmfK8wLosdUMEZuFlSKCAbu1TkoBdQSghUc+UHhtpS1K0Z0Uxv+2DgJibq2
         HhuubrtxLIJLKjPHkTw0O9OZcMvOVl5mBxEmjlyXOJCGI/mAA2lk6qtiKrzAkO3Hm8YJ
         OBDHFoX4NAtdli/v2IKxvEgSu0g/u9o91H4HZfGh86GMI9yJxMkvJt8vkSi/fMd/3dEp
         dQl9c6mwXaQZddUmhlEAIt9kKD1QN/hmvf3x7hF7mhRJmertUNTpDS+PPQt6DXd2/2V9
         NcySgiEKWDQV2AUmwv6q6Z2puiKVbQ5nIY3R01PBnd+uOWHgeucyB1f90veZIHD6JLgm
         Hung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAA3lMCndc2PgPbdvjREcHcL8uYitiPOghcxLADFEeE=;
        b=bsnOTHv5J+d/11Itkp8QqSOSQ0K+DoDf/aoZmb1QQMb2mzJFdSx9QhUtzD3PNSqAAG
         aXXJ3fXo7GvIjSC/DeF6AxFCGJKFggXfhYD4r4N6vdRgCfoXvawEH6Jy+01UXYwH3Gon
         SQSRMrE1RdyS0c0asr+VBmNm4LoLwni3JXA5Dqn8FqGj3wEuddl1FCLA8XfqtE6IJvpY
         YGdfpUF5rPJ77nEOoKvaACLvzEgpLDg3GQx7QRVZTvK+exwKLHvieWR9twD0jM+VSiY5
         Tv7i92pna2F1v6SuI6ZYYxxlD21KtRDAce5M34IvUVCJg/MhWky4YVzJQ0yd6GgUWjYC
         zRbQ==
X-Gm-Message-State: AOAM530AjUo6xAd/pyI6UUu4DPV14qbL3gWqPiYRgXzTBc6kMElaqbyL
        chG61MUW5zdUwVwg73KTmAY=
X-Google-Smtp-Source: ABdhPJz4IOHHs9FmJY7mTdSy4f48pU0nbnIFjsSctUnoetbAYhAQyni4cz4EoE/9PPjbkLfBeDAxTQ==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr3037807pjq.230.1611109800944;
        Tue, 19 Jan 2021 18:30:00 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 124sm371628pfc.196.2021.01.19.18.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:30:00 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id F16DC20442D425; Wed, 20 Jan 2021 11:29:57 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 20/20] um: lkl: add documentation
Date:   Wed, 20 Jan 2021 11:27:25 +0900
Message-Id: <043677211bb5562397c511911e7861c3e217611b.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A document describing brief introduction of LKL, why it is needed, and
how it is used is added.  The document is located under uml/ directory.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Documentation/virt/uml/lkl.txt | 48 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                    | 10 +++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/virt/uml/lkl.txt

diff --git a/Documentation/virt/uml/lkl.txt b/Documentation/virt/uml/lkl.txt
new file mode 100644
index 000000000000..4942b7f093c5
--- /dev/null
+++ b/Documentation/virt/uml/lkl.txt
@@ -0,0 +1,48 @@
+
+Introduction
+============
+
+Library mode of UML, a.k.a. LKL (Linux Kernel Library), is aiming to allow
+reusing the Linux kernel code as extensively as possible with minimal effort and
+reduced maintenance overhead.
+
+Examples of how LKL can be used are: creating userspace applications (running on
+Linux and other operating systems) that can read or write Linux filesystems or
+can use the Linux networking stack, creating kernel drivers for other operating
+systems that can read Linux filesystems, bootloaders support for reading/writing
+Linux filesystems, etc.
+
+With LKL, the kernel code is compiled into an object file that can be directly
+linked by applications. The API offered by LKL is based on the Linux system call
+interface.
+
+LKL is implemented as one of the mode of UML (arch/um), and it internally uses
+sub-architecture (SUBARCH) of UML (SUBARCH=lkl). It uses host operations
+defined by the application or a host library (tools/um).
+
+
+Supported hosts
+===============
+
+The supported host for now is Linux (x86 architecture) userspace applications.
+
+
+Building LKL the host library and LKL applications
+==================================================
+
+    $ make ARCH=um SUBARCH=lkl defconfig
+    $ make ARCH=um SUBARCH=lkl
+
+will build LKL as a object file, it will install it in tools/um together with
+the headers files in tools/um/include then will build the host library, tests
+and a few of application examples:
+
+* tools/testing/selftests/um/boot.c - a simple applications that uses LKL and
+  exercises the basic LKL APIs
+
+* tools/testing/selftests/um/disk.c - a simple applications that tests LKL and
+  exercises the basic filesystem-related LKL APIs
+
+Those tests can run with the following kselftest command:
+
+    $ make ARCH=um SUBARCH=lkl TARGETS="um" kselftest
diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..8587a9715020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18613,6 +18613,16 @@ F:	arch/um/
 F:	arch/x86/um/
 F:	fs/hostfs/
 
+USER-MODE LINUX (UML) LIBRARY MODE
+M:	Octavian Purdila <tavi.purdila@gmail.com>
+M:	Hajime Tazaki <thehajime@gmail.com>
+L:	linux-um@lists.infradead.org
+S:	Maintained
+T:	https://github.com/lkl/linux
+F:	arch/um/lkl/
+F:	tools/testing/selftests/um/
+F:	tools/um/
+
 USERSPACE COPYIN/COPYOUT (UIOVEC)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 S:	Maintained
-- 
2.21.0 (Apple Git-122.2)

