Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139821007A6
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2019 15:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKROvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Nov 2019 09:51:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKROvU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 09:51:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so19864393wrw.1;
        Mon, 18 Nov 2019 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qJmyyg10F+Q9Yx2crAs7oi6VE5FR9DEMY/ulUWTGJq4=;
        b=kY243T6AG6i4Efp5kRlkWuRtX6TzF+5/toOFakhl5hQZ2KFKCQQYK6dhqfc/Fdh2zE
         sqo7UTjfGcSKXmpJSPHRJgl3NNM00iBG6b3ORQp4kxvuGM28sshflmghNFMecQf2xb3E
         t14jsGulPdOVzD/Qlpc+apoFBs6jiW3KYJKw6U9MyyO2Llwzbbo3HAnYaOna3e3pq2lP
         alo1QDDNE2ZwZvaNEg8N6jhXVD45Cy5N7F4Ddy5zVY8LETuCRiSm5mOL+M8jh3CDgKNq
         dBHfEQ2gm2uQzV8qrC28qsMvjt5hpQ9kVKUvwgR58NbKmr5GNrBOKjGDZOH6lH7PTFUC
         n58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qJmyyg10F+Q9Yx2crAs7oi6VE5FR9DEMY/ulUWTGJq4=;
        b=Q1MKBOJI2a5poir5Miu7+xPZyqdeco/4mkzhQW5esGE4xXIWhb676qqpO06Ngwl6n2
         ISwgu0wVxVcZGe+Kzszggh/zPsUwS9Q4ykTNn/W76ytRwV2RGeVWaKquzIPWL5ywrEYl
         iqwMGSOiomMX6FZB4Wfhd/aPfIj7TCTSQIfpBaQoMQNNJmv47QumyKs7HzqWzGIA+h6+
         kZdp7jNi1O7/hYFs+CaxrVp489TSUDycCAnG4ZD6N0eR7IWY2wOVCwgIdH4kzt9yPLEk
         2myoP0W6SDRuFSR7L9AibsYX2C0yFeTH+EDTHcggnqeBnoBPSzdMkr/dZe/STfuO8dJh
         a/0g==
X-Gm-Message-State: APjAAAW9EyJLv0rXSk0HxR8OhPhL41BJCMSMTihMdahJlX5ivSwcjgir
        TP+1PC3Nv0WgsW8hu4Scz87wrQA=
X-Google-Smtp-Source: APXvYqwbRz54q4B8bt535RGs5FfHUfsV/tQm+JcHl0NsmrudKXw0v3jJ7uzxrx0UMl6EknlFIsApVg==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr32943767wrr.279.1574088677774;
        Mon, 18 Nov 2019 06:51:17 -0800 (PST)
Received: from avx2 ([46.53.249.232])
        by smtp.gmail.com with ESMTPSA id y15sm22797730wrh.94.2019.11.18.06.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:51:17 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:51:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org
Subject: [PATCH] ELF: warn if process starts with executable stack
Message-ID: <20191118145114.GA9228@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PT_GNU_STACK is fail open design, at least warn people that something
isn't right.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/exec.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		goto out_unlock;
 	BUG_ON(prev != vma);
 
+#ifdef CONFIG_MMU
+	if (vm_flags & VM_EXEC) {
+		pr_warn_once("process '%s'/%u started with executable stack\n",
+			     current->comm, current->pid);
+	}
+#endif
+
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
 		ret = shift_arg_pages(vma, stack_shift);
