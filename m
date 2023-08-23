Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67EC785D15
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjHWQO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbjHWQO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 12:14:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93017E7E;
        Wed, 23 Aug 2023 09:14:49 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id B645E2126CC6;
        Wed, 23 Aug 2023 09:14:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B645E2126CC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692807289;
        bh=lt0BWoCzKU9aBI9VmoKWYDdOwLmOs+rGiamRpCppdZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryDQ3sg5K+4/KzXzDFfl6WO5jLgxConn53svwJRwhCmCIy1U97+2rfnKtiLqSzC7/
         Wy7VcR/j0ODnGkadQBvdgDc3ZSLaH7iWYF/5FFDCwaomlxYfAmMRsAOb07Kuq8Hop/
         K9zQ+WI3VTnDXTorW1jr08P24+y+Q8IEsQQ8jGpQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH v1 1/1] tracing/kprobes: Return ENAMESVRLSYMS when func matches several symbols
Date:   Wed, 23 Aug 2023 18:14:10 +0200
Message-Id: <20230823161410.103489-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823161410.103489-1-flaniel@linux.microsoft.com>
References: <20230823161410.103489-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Previously to this commit, if func matches several symbols, a PMU kprobe would
be installed for the first matching address.
This could lead to some misunderstanding when some BPF code was never called
because it was attached to a function which was indeed not call, because the
effectively called one has no kprobes.

So, this commit introduces ENAMESVRLSYMS which is returned when func matches
several symbols.
This way, user needs to use addr to remove the ambiguity.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
---
 arch/alpha/include/uapi/asm/errno.h        |  2 ++
 arch/mips/include/uapi/asm/errno.h         |  2 ++
 arch/parisc/include/uapi/asm/errno.h       |  2 ++
 arch/sparc/include/uapi/asm/errno.h        |  2 ++
 include/uapi/asm-generic/errno.h           |  2 ++
 kernel/trace/trace_kprobe.c                | 26 ++++++++++++++++++++++
 tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
 tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
 tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
 tools/include/uapi/asm-generic/errno.h     |  2 ++
 11 files changed, 46 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 3d265f6babaf..3d9686d915f9 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -125,4 +125,6 @@

 #define EHWPOISON	139	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	140	/* Name correspond to several symbols */
+
 #endif
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index 2fb714e2d6d8..1fd64ee7b629 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -124,6 +124,8 @@

 #define EHWPOISON	168	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	169	/* Name correspond to several symbols */
+
 #define EDQUOT		1133	/* Quota exceeded */


diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..c7845ceece26 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@

 #define EHWPOISON	257	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	258	/* Name correspond to several symbols */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 81a732b902ee..1ed065943bab 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -115,4 +115,6 @@

 #define EHWPOISON	135	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	136	/* Name correspond to several symbols */
+
 #endif
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..3d5d5740c8da 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -120,4 +120,6 @@

 #define EHWPOISON	133	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	134	/* Name correspond to several symbols */
+
 #endif
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23dba01831f7..53b66db1ff53 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1699,6 +1699,16 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 }

 #ifdef CONFIG_PERF_EVENTS
+
+static int count_symbols(void *data, unsigned long unused)
+{
+	unsigned int *count = data;
+
+	(*count)++;
+
+	return 0;
+}
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1709,6 +1719,22 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;

+	/*
+	 * If user specifies func, we check that the function name does not
+	 * correspond to several symbols.
+	 * If this is the case, we return with error code ENAMESVRLSYMS to
+	 * indicate the user he/she should use addr and offs rather than func to
+	 * remove the ambiguity.
+	 */
+	if (func) {
+		unsigned int count;
+
+		count = 0;
+		kallsyms_on_each_match_symbol(count_symbols, func, &count);
+		if (count > 1)
+			return ERR_PTR(-ENAMESVRLSYMS);
+	}
+
 	/*
 	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 3d265f6babaf..3d9686d915f9 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -125,4 +125,6 @@

 #define EHWPOISON	139	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	140	/* Name correspond to several symbols */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index 2fb714e2d6d8..1fd64ee7b629 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -124,6 +124,8 @@

 #define EHWPOISON	168	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	169	/* Name correspond to several symbols */
+
 #define EDQUOT		1133	/* Quota exceeded */


diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..c7845ceece26 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@

 #define EHWPOISON	257	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	258	/* Name correspond to several symbols */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 81a732b902ee..1ed065943bab 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -115,4 +115,6 @@

 #define EHWPOISON	135	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	136	/* Name correspond to several symbols */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..3d5d5740c8da 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -120,4 +120,6 @@

 #define EHWPOISON	133	/* Memory page has hardware error */

+#define ENAMESVRLSYMS	134	/* Name correspond to several symbols */
+
 #endif
--
2.34.1

