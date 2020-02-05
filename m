Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA901526FB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgBEHbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:31:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39457 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgBEHbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so741818pfy.6
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSuzOG+ewbWDKhDgxww0G95iKdrDh8WJzQDaiNNuPD0=;
        b=jVhAH0EOT3haPjvbOrvnO3vqz7Xl8nZLxZpIT6NkpVuqDJ5uwy8wwRhcWbIQsI0NTl
         noQy12VHmjVaqA5GI618gjgMATT+JPWkUUkuxv3baSUj1HNdZKqKPF9/mJOrVqLt+xL1
         sZSE5A0wkPGi9KTwfkecF9g0ycIJrmFE8Rl39sqlJ0A/28/rxYi15vq5gj33+ul6dfan
         yjCPFey7t0z0IFP0Kc9oLb7SX0JJEhAhM+Y7ntTQSX5TY6/CMx4Y7n/QTmbmbDHEL15P
         74eSYPsopGYbghk5iEhMN8A3R6z96XMT6I/lxJew0Ja4fouRzfL8QNWtZt5BM4oMdhT5
         dlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSuzOG+ewbWDKhDgxww0G95iKdrDh8WJzQDaiNNuPD0=;
        b=sdoMZ3C3QtXSiMTQo1khln8tncnNBAVqfUrhuNM3Qj+IQtdzzqQQMzzDrNjoH8xZCt
         o9l7/ru2YwRVqacHUkQ+gg5dAXfSDz25TnY1FgylZX8c9TN87G/YN05NzqeaM1hc0ecp
         c3BlGtbG+53j+1CcsEjAipbYDVLJuVFo1o0uEyjxh2Pd7ajqJMCjbRQnBYYyLyYtyJuF
         j6NMnIsFYuBXzDFVLxyYZuULwOPzD8zS476FxICns0VtZkuqzhvu462jcGcpEu45ylDV
         HI8JMcTS5MajH2OuT9R1BsjyPAaUHqcWCYzRW3iLxzU78VNOfnrrtGygSw/xOWmA3OOv
         +2AQ==
X-Gm-Message-State: APjAAAWLhLyKh0Au93ixr3xa84UACn/7HSz7/tyxStZQuVjysf1cMZbu
        eHwaKLSqp0XvIshYF8Mwhi4=
X-Google-Smtp-Source: APXvYqx4LXpQw7BBmM/4EDeszz7Kutie9ln+hCMIkmOXdl3wN7aomvNY8npNyIUm3nzeaAv4CVf++w==
X-Received: by 2002:a63:4850:: with SMTP id x16mr36995148pgk.334.1580887895786;
        Tue, 04 Feb 2020 23:31:35 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id d4sm6164238pjg.19.2020.02.04.23.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:31:35 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id E29992025730A9; Wed,  5 Feb 2020 16:31:33 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Chenyang Zhong <zhongcy95@gmail.com>,
        Conrad Meyer <cem@FreeBSD.org>,
        Gustavo Bittencourt <gbitten@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Yuan Liu <liuyuan@google.com>
Subject: [RFC v3 22/26] um lkl: add documentation
Date:   Wed,  5 Feb 2020 16:30:31 +0900
Message-Id: <0ea656300b51827b11416b4c2fd7f6ba320c8e37.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

A document describing brief introduction of LKL, why it is needed, and
how it is used is added.  The document is located under uml/ directory.

Cc: Chenyang Zhong <zhongcy95@gmail.com>
Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: Gustavo Bittencourt <gbitten@gmail.com>
Cc: H.K. Jerry Chu <hkchu@google.com>
Cc: Motomu Utsumi <motomuman@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 Documentation/virt/uml/lkl.txt | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/virt/uml/lkl.txt

diff --git a/Documentation/virt/uml/lkl.txt b/Documentation/virt/uml/lkl.txt
new file mode 100644
index 000000000000..f6d581092331
--- /dev/null
+++ b/Documentation/virt/uml/lkl.txt
@@ -0,0 +1,64 @@
+
+Introduction
+============
+
+LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code as
+extensively as possible with minimal effort and reduced maintenance overhead.
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
+LKL is implemented as one of the mode of UML (arch/um). It uses host operations
+defined by the application or a host library (tools/lkl/lib).
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
+    $ make -C tools/lkl
+
+will build LKL as a object file, it will install it in tools/lkl/lib together
+with the headers files in tools/lkl/include then will build the host library,
+tests and a few of application examples:
+
+* tests/boot - a simple applications that uses LKL and exercises the basic LKL
+  APIs
+
+* tests/net-test - a simple applications that uses network feature of LKL and
+  exercises the basic network-related APIs
+
+* fs2tar - a tool that converts a filesystem image to a tar archive
+
+* cptofs/cpfromfs - a tool that copies files to/from a filesystem image
+
+* lklfuse - a tool that can mount a filesystem image in userspace,
+  without root privileges, using FUSE
+
+
+Building LKL on Ubuntu
+-----------------------
+
+    $ sudo apt-get install libfuse-dev libarchive-dev xfsprogs
+
+    # Optional, if you would like to be able to run tests
+    $ sudo apt-get install btrfs-tools
+    $ pip install yamlish junit_xml
+
+    $ make -C tools/lkl
+
+    # To check that everything works:
+    $ cd tools/lkl
+    $ make run-tests
-- 
2.21.0 (Apple Git-122.2)

