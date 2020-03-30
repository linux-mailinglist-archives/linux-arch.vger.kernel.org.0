Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D0197EF1
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC3Otq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:49:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45833 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3Otq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:49:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id t4so854080plq.12
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BE2CIeYLuvmQLbPTA0A8Oy0mfYI7Ki1Lsyf1Q2IfEvE=;
        b=fM5YmBSUpVhk2D3kZFLo43ShLvBtqFZuD9H6HiI7nyNSnDfqHq24n18WHy7NSezkAK
         mYdmPYDizB1X85i83HT5JqBOZFJNSa/I6tdyGvzXgqescPXlj4qNZHLORdpg9x6rGy/V
         P9XyFO0hv5gCGVxeeFe/YslE0TNYh92panQ2II13Q+atUdCZ3K8ppsh0F3dCFxgCKtHn
         Tmc5BdmaPeizdvg3UScNGCFspqY+9uMJ+jmhc8GQQN2rHo306MAdlbHjMgVjIPU4Zg24
         k/qjYfBNGjyyYKrC/fMf0HStp2k+6T3gpkeInrsRzclCfvsN5XuGpmtKBH/p2rBvrVGS
         KdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BE2CIeYLuvmQLbPTA0A8Oy0mfYI7Ki1Lsyf1Q2IfEvE=;
        b=HHx6skfeF6ODjqXwFp1c+5XDMKBhIknr4Zt+bJOWTojU6zwG+8trsAVDHj32EJEk/c
         /0c1p5z0uufqqh0bKDmzPW2xcVQt94ScvUB4iAZU5K6d0Ed8Hi1oYwkMEdrUrLXdwZA2
         OijBcIkuoT2vsE64s7dKVm68ZT1j/e+iGNinyYI6Bg0jA7f5fxkWFLcUL7vgK0hlhDdn
         F6AQ84v+FmWPUyIL5Hd43TgLwZCMQX6OPfttboaX+2g2Pu0gvAUUOpluGjrgEWPEdyph
         7cLeF3f0E5HMp5vF3TBLSYNk5dQNTWbvs80I3Ic7vSuCoD5wceNEtaoDdX82Ze4xWXw5
         CRQQ==
X-Gm-Message-State: ANhLgQ19N/qh5uiMr4f+QCripB4FzDC9DpdMgIKJfqKQeRPTxIN1KvKd
        fJIUW/jmf44C8dckhOTY7plZ7XS8WNafZw==
X-Google-Smtp-Source: ADFU+vtByNg2KagPD0ozfZL5ly8dh5icC2xyEJ7dF1U47aZpMsjWzNupjMsttHEKhTzqbd3vMkVfAQ==
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr16258384pjb.110.1585579785301;
        Mon, 30 Mar 2020 07:49:45 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id k189sm9755377pgc.24.2020.03.30.07.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:49:44 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 3141B202804F59; Mon, 30 Mar 2020 23:49:43 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 25/25] um: fix clone flags to be familiar with valgrind
Date:   Mon, 30 Mar 2020 23:45:57 +0900
Message-Id: <59ed4e23efa7abc9c7d52e6b5fb31fb8ce795c5c.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Valgrind reports the following error with UML when ubd driver is
compiled in.

==29588== Unsupported clone() flags: 0x500
==29588==
==29588== The only supported clone() uses are:
==29588==  - via a threads library (LinuxThreads or NPTL)
==29588==  - via the implementation of fork or vfork

Adding CLONE_FS flags silences this issue.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/ubd_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..fabb50e91c37 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -47,7 +47,8 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}
 
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
+	pid = clone(io_thread, (void *) sp,
+		    CLONE_FILES | CLONE_VM | CLONE_FS, NULL);
 	if(pid < 0){
 		err = -errno;
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
-- 
2.21.0 (Apple Git-122.2)

