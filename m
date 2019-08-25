Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975E29C3D4
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfHYNZH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:25:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33442 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYNZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:25:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so8764662pgn.0;
        Sun, 25 Aug 2019 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnHjdka8q9MM1nbcRBaxfkCGVCCjsDG70zM+YYdNV3E=;
        b=g03zkfsq+c6M14xC3btV7g6IPmWaG8X+9s5nY7dD43zw7K8+Dl6zmdV/meLJmfcsMD
         /XzawISKOMxF9+tzCwu74cViPpHxmr/GarsoBsTn/ENQVJNySASP3aLxbeDN7HAHeP7x
         5AqjpbMw/SWUexnfZkPSUIB379U8mtrc4sNHcxkuWU4mRUZg6at+EX63IeNV5JvMSKsP
         dwxVFHi7nznxJzkCv1jujm1jXMieR9Eb+5viooHTscZhT58A5U5DAPY7JJfRziAsgBjm
         JRivX+QMRW56PFrMRP81NpX/zHCaOTF8BBRZ+789DiMV5Tbs37PC1YPOlEkouAyarn5N
         J2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnHjdka8q9MM1nbcRBaxfkCGVCCjsDG70zM+YYdNV3E=;
        b=b+WQuzbLUyNNHmy8Nk63Q5sXxZkk//HwJsNXmZUHfdE0cW6Du3EqeBttdXiMc7lji4
         yvNt5il60tpcQ2MGTF2wGE2Z7B+nBpnqIpSbSPxlEZJXBFZ4rMnE/CquzdQSaUqDceoL
         WTVoP8xt2O1e9tMoVNELhjliIrKDz8FZucgnCH6DODwH0dnpYmVC6MOFIMZAo5YSHNAg
         +M4pYLbG/UHAR5VR8jkbr4Wd2m7Rkt14fU6OfVso0qOMG3W5neOwIgEkPPi1Ux9kYxco
         Eoa3/olWVw7cgOogx5ogNDSyPVJh8oAQFAozdkT+UpxiYIVltP0EpL35XcmgetbR8TQ3
         vIGQ==
X-Gm-Message-State: APjAAAUhTL5PiowEWjTzv/Keb481HF9T+0mdfE1EVTJbGPVE24dervDC
        oKhn28KNx6RsVVIiyuGvveQ=
X-Google-Smtp-Source: APXvYqyz1vAktHcdxrCebWGWWISA04KQUpd77awztbV1MU/g3rutrKQ4McqGMrzQW2zfpUUXANHC4Q==
X-Received: by 2002:aa7:97aa:: with SMTP id d10mr15293204pfq.176.1566739506119;
        Sun, 25 Aug 2019 06:25:06 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:25:05 -0700 (PDT)
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
Subject: [PATCH 10/11] ftrace: add doc for new option record-funcproto
Date:   Sun, 25 Aug 2019 21:23:29 +0800
Message-Id: <20190825132330.5015-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just add the doc for our new feature.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/trace/ftrace.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index f60079259669..c68fbbedb8bd 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -988,6 +988,7 @@ To see what is available, simply cat the file::
 	nolatency-format
 	record-cmd
 	norecord-tgid
+	norecord-funcproto
 	overwrite
 	nodisable_on_free
 	irq-info
@@ -1131,6 +1132,11 @@ Here are the available options:
 	mapped Thread Group IDs (TGID) mapping to pids. See
 	"saved_tgids".
 
+  record-funcproto
+	Record function parameters and return value. This option
+	is only supported by function_graph tracer on x86_64
+	platform by now.
+
   overwrite
 	This controls what happens when the trace buffer is
 	full. If "1" (default), the oldest events are
-- 
2.20.1

