Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A84152702
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBEHbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:31:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54158 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBEHbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so601107pjc.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BE2CIeYLuvmQLbPTA0A8Oy0mfYI7Ki1Lsyf1Q2IfEvE=;
        b=ubp814OfjkbHQekMjusCjybyT6oQ3b5B8GE+oeKe9m0GUEAYdTkYRH8XzT5y9B5VFI
         va1Jn7omm85JvyiG1Qf9CzDaBYynkPG378bKlGdRH9pJ5CMoNGiOiBq1ivNyn/jZ2YHT
         ia9Gr+G5+Z8HN6xEXTv+xXze7BU9irusGpjVfSZhQZvTDKdfCeqHCkTJEmsC3w7OV+Xl
         4x2sB5RSWHIDHSMFaqhhsDaHuENTXjgPd4EPQOaTSjtAUJC/cwAohrf5KvUloeu0Ft8/
         csa4DmthkRJ9v5UHPAJB1kwnHyRYnIJwyN8sM/YN9gvCdUYr5PPce5pyLCKCHJzKmMnp
         PuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BE2CIeYLuvmQLbPTA0A8Oy0mfYI7Ki1Lsyf1Q2IfEvE=;
        b=NiGrzgutLUTmsIZKKQVUOcHRzMCphCL4/YARk8lmmPCVkwZG7Rhrj5NTIp4nvo1193
         1PXNT/AaNarlYnVXFMuSI3IAX4xozp5viaB04jfxEpCpbP1yLwerpF7wnqR8RE+FcF4p
         zMaEYCLeW7fwSD/K2+AemcTvh3Z6n7b1BuhuBTzAMvlefv55L337+8Og8Vpx5V3TRmN4
         nnrywLMjL6ITUjbQTylFI/5B8nIel57YslTY+3cDREJZCoNT1iAFgFVgVMt0oU9U882U
         GE9E59zf0VHlt7VHgIsVt3+dap26xtGbS7mhaYCqsuqsBA/2AoAwLxce6E9li7c/oFEZ
         7GoQ==
X-Gm-Message-State: APjAAAVJEa0uCV4zMY+EY7DSFiMilzTv/3RFgJl3q+Osyw37q83JhUt7
        j4Jho4mNUOiWhC556VsvjAM=
X-Google-Smtp-Source: APXvYqx2oFlzChk85ktwakhh00kEaZrWwtlbaBRMO8xNrjpjlFzclT0TOyAeqLqJbf4zR46X4Z5jow==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr34780209ple.267.1580887906493;
        Tue, 04 Feb 2020 23:31:46 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id d24sm28851044pfq.75.2020.02.04.23.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:31:45 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 128392025730CB; Wed,  5 Feb 2020 16:31:44 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 26/26] um: fix clone flags to be familar with valgrind
Date:   Wed,  5 Feb 2020 16:30:35 +0900
Message-Id: <b3072caaef01f2cef5f34bc012e066826798500c.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
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

