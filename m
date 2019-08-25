Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E409C3DE
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfHYNZO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:25:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYNZO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:25:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so8764783pgn.0;
        Sun, 25 Aug 2019 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QzXKgHJNJjac27m2EIm1Lz0/kAofQ72J+526iejRFQ=;
        b=GO/PVWf3Aip/lj76SnUDb0sMdXD+1tVF4Pr4MtQbEEKh9xmXb2UDDeimXy+D9tSRoG
         ONfI3x+1GnVxlk4972mu5UBRbB3v9cDn0s0GXIfDvUkoxvFpZB7qpM3Wm7svq08IqXES
         3/9H/nvW/APPaP6DXd/ZlsqTaXXFgfY5nbRum3oET7EhpHDQM6O7aQgrLYUCx31vh/tp
         Pj3jnXMeh/9xoFgvF62TEqWkl9dtlG9kZEQ23LqbLsRsqn9qkIxzDaA35xnLfCdk7Yvg
         kdWiDXZHWBnkOUGF5K8KzJ635D2qzEbl/F8Ge9MZplop+b+vPJfi/jVV3tdF7l5wEKUI
         HPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QzXKgHJNJjac27m2EIm1Lz0/kAofQ72J+526iejRFQ=;
        b=Jvvca8TFYhzYsqQ/ZFPDiSNutCaBpej+5YxzhZvvjJSLbcab7uIEPRV4tJHG5HKAJl
         suuVlly85JWk8GgrzrdO2B0jEvxIm00qLeTDHwk1Cy50T7dGhJiQgTdapAUv4Q/dmFqK
         ktEHfIU49Eus3RvJ8DDf1p2zeAyBBOT8k0bs7/l1uiYiYfawHQOYTCNW2LXahdcxRees
         TPbf8FdMQbJvUvdbXBF1OIGIWMrTGrKiBZyed30PdtcPXZQPs0V12fjqtUhi2n+9P8o+
         tWmTdbVjPxFuQEYrn4nAsfwk73qYxlDYCak06TUX4mXFYkBhhJ3e17kD8XBjdyt02W+2
         452A==
X-Gm-Message-State: APjAAAWBPEmoJISmEYJN+ZGWdinrVEqqb+pPMSFlF05v0L2Uug8TFZch
        Q5tzo4+eWCFxJS4ZJeLe6Vk=
X-Google-Smtp-Source: APXvYqxZ3PAtXLqHmn+Zgv1+tnSLgb0uWh1NyJ7+nIhirLt8hpEvkUAsM2RAxT5IIyrqsmvFKAmyHw==
X-Received: by 2002:a17:90a:3465:: with SMTP id o92mr14610155pjb.20.1566739513587;
        Sun, 25 Aug 2019 06:25:13 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:25:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/11] MAINTAINERS: make scripts/ftrace/ maintained
Date:   Sun, 25 Aug 2019 21:23:30 +0800
Message-Id: <20190825132330.5015-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make scripts/ftrace/ maintained and I would like to help with reviewing
related patches.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd0..ca012ea260d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16293,6 +16293,7 @@ F:	drivers/char/tpm/
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
+R:	Changbin Du <changbin.du@gmail.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 S:	Maintained
 F:	Documentation/trace/ftrace.rst
@@ -16303,6 +16304,7 @@ F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
 F:	tools/testing/selftests/ftrace/
+F:	scripts/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
-- 
2.20.1

