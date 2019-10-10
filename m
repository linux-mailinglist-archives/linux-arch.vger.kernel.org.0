Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8606DD3455
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 01:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfJJXYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 19:24:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfJJXYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 19:24:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so4905697pfl.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0G08DVDmHHpYBvqrNiRz2P/EWIDmTXItkvaTB27EiyI=;
        b=L+26j3w/f0Pvqirk5VQGVIaNnOzQ2IdJK1izuYoKNo3SNs6N6HAOgE0M/aYhGT3nnY
         YJiZD1qfB6cRN1s5hFnMMcbVtr1ThMS0G3uUnMNPgxf+aQ5Yioc6LCYHRTtv6d5KMIg/
         Ss3qpng+qg6mwj+zSd5BFQKD6vfSiz3COgl80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0G08DVDmHHpYBvqrNiRz2P/EWIDmTXItkvaTB27EiyI=;
        b=eWUKAROW0RfFHiX3PicsUovf4zFPBMsYQ97za9H8mrmDzaFmmjfOmPxRKwhKaSHnu2
         NGcij7LCLHyii0mk5JyG2M/Y2hgQLzWMCCNKzoHuu7VWrDuE0ZGxiXwZba+N+w5i3ln/
         N2TMGO9EOtBRly5q8NSMX+akSLkcnSkX15lkAvfPja3i6Z/v22RjMzzyIqDBgepEhzm8
         mVfAo3T2lzLIBkV+9dnYk0C2fTYCqdEdku8dBtUGScdzwntk/lh6EETGaosHb39LZFWr
         lBX859EQc0MZA+HE8XI92gQ9NiJ9RAo82PQdF8kKTUlR5jdieCh1ueH0Bi7PvZb0jyGk
         s2KA==
X-Gm-Message-State: APjAAAXvLbbbPZgQVsoaFrdHUauMw6bdp/kZZ6jl/H7vGo4aaT/ZKjOn
        rbzvX0ssslF8B59AHI8w/kurAw==
X-Google-Smtp-Source: APXvYqxjCP9hXmIHY8zl6IMdUQdpDHJPmIqU3YoKsTJXuzror2pooZA8+yn8qs+v6tKBGdrepjliWw==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr13860587pgi.221.1570749840928;
        Thu, 10 Oct 2019 16:24:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 184sm5994385pgf.33.2019.10.10.16.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:23:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] linux/stddef.h: Add sizeof_member() macro
Date:   Thu, 10 Oct 2019 16:23:43 -0700
Message-Id: <20191010232345.26594-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010232345.26594-1-keescook@chromium.org>
References: <20191010232345.26594-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

At present we have 2 different macros to calculate the size of a member
of a struct: FIELD_SIZEOF() and sizeof_field(). As a prerequisite to
bringing uniformity to the entire kernel source tree, add sizeof_member()
macro as it is both more pleasant (not upper case) and more correct
(sizeof()-family cannot operate on bit fields; this is meant to operate
on struct members), as discussed[1].

Future patches will replace all occurrences of above macros with
sizeof_member().

[1] https://www.openwall.com/lists/kernel-hardening/2019/07/02/2

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-2-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h                 | 13 ++++++++++++-
 tools/testing/selftests/bpf/bpf_util.h |  6 +++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 998a4ba28eba..ecadb736c853 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -27,6 +27,17 @@ enum {
  */
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
+/**
+ * sizeof_member(TYPE, MEMBER) - get the size of a struct's member
+ *
+ * @TYPE: the target struct
+ * @MEMBER: the target struct's member
+ *
+ * Return: the size of @MEMBER in the struct definition without having a
+ * declared instance of @TYPE.
+ */
+#define sizeof_member(TYPE, MEMBER)	(sizeof(((TYPE *)0)->MEMBER))
+
 /**
  * offsetofend(TYPE, MEMBER)
  *
@@ -34,6 +45,6 @@ enum {
  * @MEMBER: The member within the structure to get the end offset of
  */
 #define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+	(offsetof(TYPE, MEMBER)	+ sizeof_member(TYPE, MEMBER))
 
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index ec219f84e041..6b4b3e24ba9f 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -31,13 +31,13 @@ static inline unsigned int bpf_num_possible_cpus(void)
 # define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#ifndef sizeof_member
+#define sizeof_member(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 #endif
 
 #ifndef offsetofend
 #define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+	(offsetof(TYPE, MEMBER)	+ sizeof_member(TYPE, MEMBER))
 #endif
 
 #endif /* __BPF_UTIL__ */
-- 
2.17.1

