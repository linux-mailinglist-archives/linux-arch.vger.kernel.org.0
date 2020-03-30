Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC288197EEA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC3OtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:49:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45803 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3OtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:49:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id t4so853436plq.12
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSuzOG+ewbWDKhDgxww0G95iKdrDh8WJzQDaiNNuPD0=;
        b=bf/0Y3ov/x7KJtJrtZkDbiz3v4S4/t1avT2BTMvBhVcGw2FuNnWOZF7yiVZBgOz4Kq
         qcdIfGwZjitOAJZhaSOEsudSnEf3kwVAaqE/ej+D1akVXyaulQ7wKOkd+OkfFsOWvMWV
         WkSrUFtejSIq8kASoA+Cz4/26ZHtDQM9DcgaDYf1SSHUKjWqshKLPQTxJN8wdD84mCR1
         KdW/RF84TK0f5pArwhw4J1UkKZZ+6qKDtWe5Oj6YRQsU6CHRzihvcQsB1heuuQmqqF9K
         rRrZDlcSJFPDwMkeuIZhpoi2wz7XXVYhfWMlDguD/OJBpFCST2xESxZAX4ulxKNkDnRl
         H03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSuzOG+ewbWDKhDgxww0G95iKdrDh8WJzQDaiNNuPD0=;
        b=lWyFOYOgUM0/tqiZ4myVsfLG72xETMtXu99ZKGn2ctgPXedxC25E1IOjU7wjcn2WWM
         PU2LNHc4YT1A5wfrFPnUhz4yJzEt2gYsZu+Bh9Vx5YPBJ4Rw07S+7WqJxtF3fYUOV6/j
         qs2muc9pNNoLFyQkhczPxCnu3ZM+b2LGq+erIbg0DZxWvplR+MGB6r8fX7yX3ll/dQ0R
         a8oAoIKhgRxtHql6UfmXZhXDLl3bd3gKY1+8aA6osdxXByhrDKP2IDqqRXP4p6tuIThe
         n+51cUEaOP4GUIWBPmXcTALxqPXgvLCaSw7rT/D0OmQk4QGtMdUxowp7yFMyBuzcUTvi
         s22g==
X-Gm-Message-State: ANhLgQ3mJgh+VEBm/IdAGmYuV5/cPM0X8wn5cjPmSO+HwA0JglTlOtpA
        zaQzUTk63EjrCuQUUsFP9os=
X-Google-Smtp-Source: ADFU+vuSEPEP0URWHtgXEE0QX/kINogxQ4v2oPFoZEEXoG5aMvy+w0kPvgvOdLPWZYy4ioFrYEaNqA==
X-Received: by 2002:a17:902:598e:: with SMTP id p14mr12051668pli.276.1585579754735;
        Mon, 30 Mar 2020 07:49:14 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id a127sm10401300pfa.111.2020.03.30.07.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:49:14 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 4E8F1202804EDF; Mon, 30 Mar 2020 23:49:12 +0900 (JST)
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
Subject: [RFC v4 21/25] um lkl: add documentation
Date:   Mon, 30 Mar 2020 23:45:53 +0900
Message-Id: <b5752382991a21a338d098276eb1d3e764fdf937.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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

