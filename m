Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B428197EDB
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgC3OsU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:48:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34833 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC3OsU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:48:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id c12so3977816plz.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+mIb8Ex+oi99qKsW1zNkHrEBQF7LZ6jP0LcinC7qeg=;
        b=uYMVovbMODtzSDZZ/oHkCUHFkgQAKIgZifpSioJepflkPtn/r/fbYU0UlH+tIY7laR
         tcedAhg3jlApS3s+coV5Gd/UKoUPk/b1Kbz4r58S0tMYD55jowZ3VfgB2FSBEvkiFAf0
         Nw5PgHAWiZmTRrPXr6NoapGAvICbwuPiOKXxIhQR645LiEut06cjjarydJVzsPrhDKr0
         TX1yO5Mo8Ng9HuWUme86csYSPXz73GThAits0rGy5V6hYLrCMpmq0msnsEQZVARFHGd9
         MBXIIquWfou1CjwLKSSVjGYxoEte+1zny9EvxaIamHkSxS4ZasznwPRN2n0ZhQodQyiU
         qO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+mIb8Ex+oi99qKsW1zNkHrEBQF7LZ6jP0LcinC7qeg=;
        b=PETLFa0mLa0kDCoC3+cSYp229i/ibS2kouSl4yINWDyqMVJhd5g1tM85FONWfoj0Ag
         wXsvnDQkNuQopl1E/wL4j8UsHAB24kUEijREe8keWO7eSZCAtlrp6PUEQxAHe1rBtjaJ
         aiH+PsVC6/SQ7faUL4eRMfGswcRkTe40DKJVpGFQVV86cprAipBjX3nsVscBo2JF7ajN
         FzkHDlYVmk1W/Sxa9PWiagVoW0sz6cZmpZpdFvtZgrfq2HiVd1ePou1grmlSpyosH/Ef
         XsNg8nJ4IUMhUu6Eiqk+M/mTkGPTwTm8xGwKX8sTdgQWC5+T/99u8HE+UJvJF66H3Y9V
         gm9A==
X-Gm-Message-State: ANhLgQ1X5XlT5b6ipiHmcGpRFTCW7hjde6QH50SsCkS9QAoVdiUNe7ht
        c6HDMUA54BQNEdrdGYF71Ks=
X-Google-Smtp-Source: ADFU+vvFZd1p1DkpecjEVCMr+RNcU/o5i2vkKaJ8JD30ThrmrY897vS5R8ozWnUcgOD4+2VE8K9HFw==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr12507815pld.22.1585579695792;
        Mon, 30 Mar 2020 07:48:15 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id m68sm10836017pjb.0.2020.03.30.07.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:48:15 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 2A80B202804DD9; Mon, 30 Mar 2020 23:48:13 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>,
        Patrick Collins <pscollins@google.com>,
        Yuan Liu <liuyuan@google.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 13/25] lkl tools: host lib: add utilities functions
Date:   Mon, 30 Mar 2020 23:45:45 +0900
Message-Id: <7c750f53b2f272239d6626895dc6de22a4fa2ab0.1585579244.git.thehajime@gmail.com>
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

Add basic utility functions for getting a string from a kernel error
code and a fprintf like function that uses the host print
operation. The latter is useful for informing the user about errors
that occur in the host library.

Other configuration and debug utilities are also added.

Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: Patrick Collins <pscollins@google.com>
Cc: Yuan Liu <liuyuan@google.com>
Cc: Motomu Utsumi <motomuman@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/include/lkl_config.h |  61 +++
 tools/lkl/include/lkl_host.h   |   7 +
 tools/lkl/lib/Build            |   7 +
 tools/lkl/lib/config.c         | 744 +++++++++++++++++++++++++++++++++
 tools/lkl/lib/dbg.c            | 300 +++++++++++++
 tools/lkl/lib/dbg_handler.c    |  44 ++
 tools/lkl/lib/endian.h         |  31 ++
 tools/lkl/lib/jmp_buf.c        |  14 +
 tools/lkl/lib/jmp_buf.h        |   8 +
 tools/lkl/lib/utils.c          | 266 ++++++++++++
 10 files changed, 1482 insertions(+)
 create mode 100644 tools/lkl/include/lkl_config.h
 create mode 100644 tools/lkl/lib/config.c
 create mode 100644 tools/lkl/lib/dbg.c
 create mode 100644 tools/lkl/lib/dbg_handler.c
 create mode 100644 tools/lkl/lib/endian.h
 create mode 100644 tools/lkl/lib/jmp_buf.c
 create mode 100644 tools/lkl/lib/jmp_buf.h
 create mode 100644 tools/lkl/lib/utils.c

diff --git a/tools/lkl/include/lkl_config.h b/tools/lkl/include/lkl_config.h
new file mode 100644
index 000000000000..d3edf8b414cf
--- /dev/null
+++ b/tools/lkl/include/lkl_config.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_CONFIG_H
+#define _LKL_LIB_CONFIG_H
+
+#define LKL_CONFIG_JSON_TOKEN_MAX 300
+
+struct lkl_config_iface {
+	struct lkl_config_iface *next;
+	struct lkl_netdev *nd;
+
+	/* OBSOLETE: should use IFTYPE and IFPARAMS */
+	char *iftap;
+	char *iftype;
+	char *ifparams;
+	char *ifmtu_str;
+	char *ifip;
+	char *ifipv6;
+	char *ifgateway;
+	char *ifgateway6;
+	char *ifmac_str;
+	char *ifnetmask_len;
+	char *ifnetmask6_len;
+	char *ifoffload_str;
+	char *ifneigh_entries;
+	char *ifqdisc_entries;
+};
+
+struct lkl_config {
+	int ifnum;
+	struct lkl_config_iface *ifaces;
+
+	char *gateway;
+	char *gateway6;
+	char *debug;
+	char *mount;
+	/* single_cpu mode:
+	 * 0: Don't pin to single CPU (default).
+	 * 1: Pin only LKL kernel threads to single CPU.
+	 * 2: Pin all LKL threads to single CPU including all LKL kernel threads
+	 * and device polling threads. Avoid this mode if having busy polling
+	 * threads.
+	 *
+	 * mode 2 can achieve better TCP_RR but worse TCP_STREAM than mode 1.
+	 * You should choose the best for your application and virtio device
+	 * type.
+	 */
+	char *single_cpu;
+	char *sysctls;
+	char *boot_cmdline;
+	char *dump;
+	char *delay_main;
+};
+
+int lkl_load_config_json(struct lkl_config *cfg, char *jstr);
+int lkl_load_config_env(struct lkl_config *cfg);
+void lkl_show_config(struct lkl_config *cfg);
+int lkl_load_config_pre(struct lkl_config *cfg);
+int lkl_load_config_post(struct lkl_config *cfg);
+int lkl_unload_config(struct lkl_config *cfg);
+
+#endif /* _LKL_LIB_CONFIG_H */
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index b5f96096fe69..85e80eb4ad0d 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -11,6 +11,13 @@ extern "C" {
 
 extern struct lkl_host_operations lkl_host_ops;
 
+/**
+ * lkl_printf - print a message via the host print operation
+ *
+ * @fmt: printf like format string
+ */
+int lkl_printf(const char *fmt, ...);
+
 
 #ifdef __cplusplus
 }
diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index 8b137891791f..658bfa865b9c 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -1 +1,8 @@
+CFLAGS_config.o += -I$(srctree)/tools/perf/pmu-events
 
+liblkl-y += jmp_buf.o
+liblkl-y += utils.o
+liblkl-y += dbg.o
+liblkl-y += dbg_handler.o
+liblkl-y += ../../perf/pmu-events/jsmn.o
+liblkl-y += config.o
diff --git a/tools/lkl/lib/config.c b/tools/lkl/lib/config.c
new file mode 100644
index 000000000000..37f8ac4d942a
--- /dev/null
+++ b/tools/lkl/lib/config.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#define _HAVE_STRING_ARCH_strtok_r
+#include <string.h>
+#ifndef __MINGW32__
+#include <arpa/inet.h>
+#endif
+#include <lkl_host.h>
+#include <lkl_config.h>
+
+#include "jsmn.h"
+
+static int jsoneq(const char *json, jsmntok_t *tok, const char *s)
+{
+	if (tok->type == JSMN_STRING &&
+		(int) strlen(s) == tok->end - tok->start &&
+		strncmp(json + tok->start, s, tok->end - tok->start) == 0) {
+		return 0;
+	}
+	return -1;
+}
+
+static int cfgcpy(char **to, char *from)
+{
+	if (!from)
+		return 0;
+	if (*to)
+		free(*to);
+	*to = (char *)malloc((strlen(from) + 1) * sizeof(char));
+	if (*to == NULL) {
+		lkl_printf("malloc failed\n");
+		return -1;
+	}
+	strcpy(*to, from);
+	return 0;
+}
+
+static int cfgncpy(char **to, char *from, int len)
+{
+	if (!from)
+		return 0;
+	if (*to)
+		free(*to);
+	*to = (char *)malloc((len + 1) * sizeof(char));
+	if (*to == NULL) {
+		lkl_printf("malloc failed\n");
+		return -1;
+	}
+	strncpy(*to, from, len + 1);
+	(*to)[len] = '\0';
+	return 0;
+}
+
+static int parse_ifarr(struct lkl_config *cfg,
+		jsmntok_t *toks, char *jstr, int startpos)
+{
+	int ifidx, pos, posend, ret;
+	char **cfgptr;
+	struct lkl_config_iface *iface, *prev = NULL;
+
+	if (!cfg || !toks || !jstr)
+		return -1;
+	pos = startpos;
+	pos++;
+	if (toks[pos].type != JSMN_ARRAY) {
+		lkl_printf("unexpected json type, json array expected\n");
+		return -1;
+	}
+
+	cfg->ifnum = toks[pos].size;
+	pos++;
+	iface = cfg->ifaces;
+
+	for (ifidx = 0; ifidx < cfg->ifnum; ifidx++) {
+		if (toks[pos].type != JSMN_OBJECT) {
+			lkl_printf("object json type expected\n");
+			return -1;
+		}
+
+		posend = pos + toks[pos].size;
+		pos++;
+		iface = malloc(sizeof(struct lkl_config_iface));
+		memset(iface, 0, sizeof(struct lkl_config_iface));
+
+		if (prev)
+			prev->next = iface;
+		else
+			cfg->ifaces = iface;
+		prev = iface;
+
+		for (; pos < posend; pos += 2) {
+			if (toks[pos].type != JSMN_STRING) {
+				lkl_printf("object json type expected\n");
+				return -1;
+			}
+			if (jsoneq(jstr, &toks[pos], "type") == 0) {
+				cfgptr = &iface->iftype;
+			} else if (jsoneq(jstr, &toks[pos], "param") == 0) {
+				cfgptr = &iface->ifparams;
+			} else if (jsoneq(jstr, &toks[pos], "mtu") == 0) {
+				cfgptr = &iface->ifmtu_str;
+			} else if (jsoneq(jstr, &toks[pos], "ip") == 0) {
+				cfgptr = &iface->ifip;
+			} else if (jsoneq(jstr, &toks[pos], "ipv6") == 0) {
+				cfgptr = &iface->ifipv6;
+			} else if (jsoneq(jstr, &toks[pos], "ifgateway") == 0) {
+				cfgptr = &iface->ifgateway;
+			} else if (jsoneq(jstr, &toks[pos],
+							"ifgateway6") == 0) {
+				cfgptr = &iface->ifgateway6;
+			} else if (jsoneq(jstr, &toks[pos], "mac") == 0) {
+				cfgptr = &iface->ifmac_str;
+			} else if (jsoneq(jstr, &toks[pos], "masklen") == 0) {
+				cfgptr = &iface->ifnetmask_len;
+			} else if (jsoneq(jstr, &toks[pos], "masklen6") == 0) {
+				cfgptr = &iface->ifnetmask6_len;
+			} else if (jsoneq(jstr, &toks[pos], "neigh") == 0) {
+				cfgptr = &iface->ifneigh_entries;
+			} else if (jsoneq(jstr, &toks[pos], "qdisc") == 0) {
+				cfgptr = &iface->ifqdisc_entries;
+			} else if (jsoneq(jstr, &toks[pos], "offload") == 0) {
+				cfgptr = &iface->ifoffload_str;
+			} else {
+				lkl_printf("unexpected key: %.*s\n",
+						toks[pos].end-toks[pos].start,
+						jstr + toks[pos].start);
+				return -1;
+			}
+			ret = cfgncpy(cfgptr, jstr + toks[pos+1].start,
+					toks[pos+1].end-toks[pos+1].start);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return pos - startpos;
+}
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+int lkl_load_config_json(struct lkl_config *cfg, char *jstr)
+{
+	int pos, ret;
+	char **cfgptr;
+	jsmn_parser jp;
+	jsmntok_t toks[LKL_CONFIG_JSON_TOKEN_MAX];
+
+	if (!cfg || !jstr)
+		return -1;
+	jsmn_init(&jp);
+	ret = jsmn_parse(&jp, jstr, strlen(jstr), toks, ARRAY_SIZE(toks));
+	if (ret != JSMN_SUCCESS) {
+		lkl_printf("failed to parse json\n");
+		return -1;
+	}
+	if (toks[0].type != JSMN_OBJECT) {
+		lkl_printf("object json type expected\n");
+		return -1;
+	}
+	for (pos = 1; pos < jp.toknext; pos++) {
+		if (toks[pos].type != JSMN_STRING) {
+			lkl_printf("string json type expected\n");
+			return -1;
+		}
+		if (jsoneq(jstr, &toks[pos], "interfaces") == 0) {
+			ret = parse_ifarr(cfg, toks, jstr, pos);
+			if (ret < 0)
+				return ret;
+			pos += ret;
+			pos--;
+			continue;
+		}
+		if (jsoneq(jstr, &toks[pos], "gateway") == 0) {
+			cfgptr = &cfg->gateway;
+		} else if (jsoneq(jstr, &toks[pos], "gateway6") == 0) {
+			cfgptr = &cfg->gateway6;
+		} else if (jsoneq(jstr, &toks[pos], "debug") == 0) {
+			cfgptr = &cfg->debug;
+		} else if (jsoneq(jstr, &toks[pos], "mount") == 0) {
+			cfgptr = &cfg->mount;
+		} else if (jsoneq(jstr, &toks[pos], "singlecpu") == 0) {
+			cfgptr = &cfg->single_cpu;
+		} else if (jsoneq(jstr, &toks[pos], "sysctl") == 0) {
+			cfgptr = &cfg->sysctls;
+		} else if (jsoneq(jstr, &toks[pos], "boot_cmdline") == 0) {
+			cfgptr = &cfg->boot_cmdline;
+		} else if (jsoneq(jstr, &toks[pos], "dump") == 0) {
+			cfgptr = &cfg->dump;
+		} else if (jsoneq(jstr, &toks[pos], "delay_main") == 0) {
+			cfgptr = &cfg->delay_main;
+		} else {
+			lkl_printf("unexpected key in json %.*s\n",
+					toks[pos].end-toks[pos].start,
+					jstr + toks[pos].start);
+			return -1;
+		}
+		pos++;
+		ret = cfgncpy(cfgptr, jstr + toks[pos].start,
+				toks[pos].end-toks[pos].start);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+void lkl_show_config(struct lkl_config *cfg)
+{
+	struct lkl_config_iface *iface;
+	int i = 0;
+
+	if (!cfg)
+		return;
+	lkl_printf("gateway: %s\n", cfg->gateway);
+	lkl_printf("gateway6: %s\n", cfg->gateway6);
+	lkl_printf("debug: %s\n", cfg->debug);
+	lkl_printf("mount: %s\n", cfg->mount);
+	lkl_printf("singlecpu: %s\n", cfg->single_cpu);
+	lkl_printf("sysctl: %s\n", cfg->sysctls);
+	lkl_printf("cmdline: %s\n", cfg->boot_cmdline);
+	lkl_printf("dump: %s\n", cfg->dump);
+	lkl_printf("delay: %s\n", cfg->delay_main);
+
+	for (iface = cfg->ifaces; iface; iface = iface->next, i++) {
+		lkl_printf("ifmac[%d] = %s\n", i, iface->ifmac_str);
+		lkl_printf("ifmtu[%d] = %s\n", i, iface->ifmtu_str);
+		lkl_printf("iftype[%d] = %s\n", i, iface->iftype);
+		lkl_printf("ifparam[%d] = %s\n", i, iface->ifparams);
+		lkl_printf("ifip[%d] = %s\n", i, iface->ifip);
+		lkl_printf("ifmasklen[%d] = %s\n", i, iface->ifnetmask_len);
+		lkl_printf("ifgateway[%d] = %s\n", i, iface->ifgateway);
+		lkl_printf("ifip6[%d] = %s\n", i, iface->ifipv6);
+		lkl_printf("ifmasklen6[%d] = %s\n", i, iface->ifnetmask6_len);
+		lkl_printf("ifgateway6[%d] = %s\n", i, iface->ifgateway6);
+		lkl_printf("ifoffload[%d] = %s\n", i, iface->ifoffload_str);
+		lkl_printf("ifneigh[%d] = %s\n", i, iface->ifneigh_entries);
+		lkl_printf("ifqdisk[%d] = %s\n", i, iface->ifqdisc_entries);
+	}
+}
+
+int lkl_load_config_env(struct lkl_config *cfg)
+{
+	int ret;
+	char *enviftype = getenv("LKL_HIJACK_NET_IFTYPE");
+	char *envifparams = getenv("LKL_HIJACK_NET_IFPARAMS");
+	char *envmtu_str = getenv("LKL_HIJACK_NET_MTU");
+	char *envip = getenv("LKL_HIJACK_NET_IP");
+	char *envipv6 = getenv("LKL_HIJACK_NET_IPV6");
+	char *envifgateway = getenv("LKL_HIJACK_NET_IFGATEWAY");
+	char *envifgateway6 = getenv("LKL_HIJACK_NET_IFGATEWAY6");
+	char *envmac_str = getenv("LKL_HIJACK_NET_MAC");
+	char *envnetmask_len = getenv("LKL_HIJACK_NET_NETMASK_LEN");
+	char *envnetmask6_len = getenv("LKL_HIJACK_NET_NETMASK6_LEN");
+	char *envgateway = getenv("LKL_HIJACK_NET_GATEWAY");
+	char *envgateway6 = getenv("LKL_HIJACK_NET_GATEWAY6");
+	char *envdebug = getenv("LKL_HIJACK_DEBUG");
+	char *envmount = getenv("LKL_HIJACK_MOUNT");
+	char *envneigh_entries = getenv("LKL_HIJACK_NET_NEIGHBOR");
+	char *envqdisc_entries = getenv("LKL_HIJACK_NET_QDISC");
+	char *envsingle_cpu = getenv("LKL_HIJACK_SINGLE_CPU");
+	char *envoffload_str = getenv("LKL_HIJACK_OFFLOAD");
+	char *envsysctls = getenv("LKL_HIJACK_SYSCTL");
+	char *envboot_cmdline = getenv("LKL_HIJACK_BOOT_CMDLINE") ? : "";
+	char *envdump = getenv("LKL_HIJACK_DUMP");
+	struct lkl_config_iface *iface;
+
+	if (!cfg)
+		return -1;
+	if (enviftype)
+		cfg->ifnum = 1;
+
+	iface = malloc(sizeof(struct lkl_config_iface));
+	memset(iface, 0, sizeof(struct lkl_config_iface));
+
+	ret = cfgcpy(&iface->iftype, enviftype);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifparams, envifparams);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifmtu_str, envmtu_str);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifip, envip);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifipv6, envipv6);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifgateway, envifgateway);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifgateway6, envifgateway6);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifmac_str, envmac_str);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifnetmask_len, envnetmask_len);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifnetmask6_len, envnetmask6_len);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifoffload_str, envoffload_str);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifneigh_entries, envneigh_entries);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&iface->ifqdisc_entries, envqdisc_entries);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->gateway, envgateway);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->gateway6, envgateway6);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->debug, envdebug);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->mount, envmount);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->single_cpu, envsingle_cpu);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->sysctls, envsysctls);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->boot_cmdline, envboot_cmdline);
+	if (ret < 0)
+		return ret;
+	ret = cfgcpy(&cfg->dump, envdump);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int parse_mac_str(char *mac_str, __lkl__u8 mac[LKL_ETH_ALEN])
+{
+	char delim[] = ":";
+	char *saveptr = NULL, *token = NULL;
+	int i = 0;
+
+	if (!mac_str)
+		return 0;
+
+	for (token = strtok_r(mac_str, delim, &saveptr);
+	     i < LKL_ETH_ALEN; i++) {
+		if (!token) {
+			/* The address is too short */
+			return -1;
+		}
+
+		mac[i] = (__lkl__u8) strtol(token, NULL, 16);
+		token = strtok_r(NULL, delim, &saveptr);
+	}
+
+	if (strtok_r(NULL, delim, &saveptr)) {
+		/* The address is too long */
+		return -1;
+	}
+
+	return 1;
+}
+
+/* Add permanent neighbor entries in the form of "ip|mac;ip|mac;..." */
+static void add_neighbor(int ifindex, char *entries)
+{
+	char *saveptr = NULL, *token = NULL;
+	char *ip = NULL, *mac_str = NULL;
+	int ret = 0;
+	__lkl__u8 mac[LKL_ETH_ALEN];
+	char ip_addr[16];
+	int af;
+
+	for (token = strtok_r(entries, ";", &saveptr); token;
+	     token = strtok_r(NULL, ";", &saveptr)) {
+		ip = strtok(token, "|");
+		mac_str = strtok(NULL, "|");
+		if (ip == NULL || mac_str == NULL || strtok(NULL, "|") != NULL)
+			return;
+
+		af = LKL_AF_INET;
+		ret = inet_pton(LKL_AF_INET, ip, ip_addr);
+		if (ret == 0) {
+			ret = inet_pton(LKL_AF_INET6, ip, ip_addr);
+			af = LKL_AF_INET6;
+		}
+		if (ret != 1) {
+			lkl_printf("Bad ip address: %s\n", ip);
+			return;
+		}
+
+		ret = parse_mac_str(mac_str, mac);
+		if (ret != 1) {
+			lkl_printf("Failed to parse mac: %s\n", mac_str);
+			return;
+		}
+		ret = lkl_add_neighbor(ifindex, af, ip_addr, mac);
+		if (ret) {
+			lkl_printf("Failed to add neighbor entry: %s\n",
+				   lkl_strerror(ret));
+			return;
+		}
+	}
+}
+
+/* We don't have an easy way to make FILE*s out of our fds, so we
+ * can't use e.g. fgets
+ */
+static int dump_file(char *path)
+{
+	int ret = -1, bytes_read = 0;
+	char str[1024] = { 0 };
+	int fd;
+
+	fd = lkl_sys_open(path, LKL_O_RDONLY, 0);
+
+	if (fd < 0) {
+		lkl_printf("%s lkl_sys_open %s: %s\n",
+			   __func__, path, lkl_strerror(fd));
+		return -1;
+	}
+
+	/* Need to print this out in order to make sense of the output */
+	lkl_printf("Reading from %s:\n==========\n", path);
+	while ((ret = lkl_sys_read(fd, str, sizeof(str) - 1)) > 0)
+		bytes_read += lkl_printf("%s", str);
+	lkl_printf("==========\n");
+
+	if (ret) {
+		lkl_printf("%s lkl_sys_read %s: %s\n",
+			   __func__, path, lkl_strerror(ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+static void mount_cmds_exec(char *_cmds, int (*callback)(char *))
+{
+	char *saveptr = NULL, *token;
+	int ret = 0;
+	char *cmds = strdup(_cmds);
+
+	token = strtok_r(cmds, ",", &saveptr);
+
+	while (token && ret >= 0) {
+		ret = callback(token);
+		token = strtok_r(NULL, ",", &saveptr);
+	}
+
+	if (ret < 0)
+		lkl_printf("%s: failed parsing %s\n", __func__, _cmds);
+
+	free(cmds);
+}
+
+static int lkl_config_netdev_create(struct lkl_config *cfg,
+				    struct lkl_config_iface *iface)
+{
+	int ret, offload = 0;
+	struct lkl_netdev_args nd_args;
+	__lkl__u8 mac[LKL_ETH_ALEN] = {0};
+	struct lkl_netdev *nd = NULL;
+
+	if (iface->ifoffload_str)
+		offload = strtol(iface->ifoffload_str, NULL, 0);
+	memset(&nd_args, 0, sizeof(struct lkl_netdev_args));
+
+	if (!nd && iface->iftype && iface->ifparams) {
+	}
+
+	if (nd) {
+		if ((mac[0] != 0) || (mac[1] != 0) ||
+				(mac[2] != 0) || (mac[3] != 0) ||
+				(mac[4] != 0) || (mac[5] != 0)) {
+			nd_args.mac = mac;
+		} else {
+			ret = parse_mac_str(iface->ifmac_str, mac);
+
+			if (ret < 0) {
+				lkl_printf("failed to parse mac\n");
+				return -1;
+			} else if (ret > 0) {
+				nd_args.mac = mac;
+			} else {
+				nd_args.mac = NULL;
+			}
+		}
+
+		nd_args.offload = offload;
+		iface->nd = nd;
+	}
+	return 0;
+}
+
+static int lkl_config_netdev_configure(struct lkl_config *cfg,
+				       struct lkl_config_iface *iface)
+{
+	int ret, nd_ifindex = -1;
+	struct lkl_netdev *nd = iface->nd;
+
+	if (!nd) {
+		lkl_printf("no netdev available %s\n", iface ? iface->ifparams
+			   : "(null)");
+		return -1;
+	}
+
+	if (nd->id >= 0) {
+		nd_ifindex = lkl_netdev_get_ifindex(nd->id);
+		if (nd_ifindex > 0)
+			lkl_if_up(nd_ifindex);
+		else
+			lkl_printf(
+				"failed to get ifindex for netdev id %d: %s\n",
+				nd->id, lkl_strerror(nd_ifindex));
+	}
+
+	if (nd_ifindex >= 0 && iface->ifmtu_str) {
+		int mtu = atoi(iface->ifmtu_str);
+
+		ret = lkl_if_set_mtu(nd_ifindex, mtu);
+		if (ret < 0)
+			lkl_printf("failed to set MTU: %s\n",
+				   lkl_strerror(ret));
+	}
+
+	if (nd_ifindex >= 0 && iface->ifip && iface->ifnetmask_len) {
+		unsigned int addr;
+
+		if (inet_pton(LKL_AF_INET, iface->ifip,
+			      (struct lkl_in_addr *)&addr) != 1)
+			lkl_printf("Invalid ipv4 address: %s\n", iface->ifip);
+
+		int nmlen = atoi(iface->ifnetmask_len);
+
+		if (addr != LKL_INADDR_NONE && nmlen > 0 && nmlen < 32) {
+			ret = lkl_if_set_ipv4(nd_ifindex, addr, nmlen);
+			if (ret < 0)
+				lkl_printf("failed to set IPv4 address: %s\n",
+					   lkl_strerror(ret));
+		}
+		if (iface->ifgateway) {
+			unsigned int gwaddr;
+
+			if (inet_pton(LKL_AF_INET, iface->ifgateway,
+				      (struct lkl_in_addr *)&gwaddr) != 1)
+				lkl_printf("Invalid ipv4 gateway: %s\n",
+					   iface->ifgateway);
+
+			if (gwaddr != LKL_INADDR_NONE) {
+				ret = lkl_if_set_ipv4_gateway(nd_ifindex,
+						addr, nmlen, gwaddr);
+				if (ret < 0)
+					lkl_printf(
+						"failed to set v4 if gw: %s\n",
+						lkl_strerror(ret));
+			}
+		}
+	}
+
+	if (nd_ifindex >= 0 && iface->ifipv6 &&
+			iface->ifnetmask6_len) {
+		struct lkl_in6_addr addr;
+		unsigned int pflen = atoi(iface->ifnetmask6_len);
+
+		if (inet_pton(LKL_AF_INET6, iface->ifipv6,
+			      (struct lkl_in6_addr *)&addr) != 1) {
+			lkl_printf("Invalid ipv6 addr: %s\n",
+				   iface->ifipv6);
+		}  else {
+			ret = lkl_if_set_ipv6(nd_ifindex, &addr, pflen);
+			if (ret < 0)
+				lkl_printf("failed to set IPv6 address: %s\n",
+					   lkl_strerror(ret));
+		}
+		if (iface->ifgateway6) {
+			char gwaddr[16];
+
+			if (inet_pton(LKL_AF_INET6, iface->ifgateway6,
+								gwaddr) != 1) {
+				lkl_printf("Invalid ipv6 gateway: %s\n",
+					   iface->ifgateway6);
+			} else {
+				ret = lkl_if_set_ipv6_gateway(nd_ifindex,
+						&addr, pflen, gwaddr);
+				if (ret < 0)
+					lkl_printf(
+						"failed to set v6 if gw: %s\n",
+						lkl_strerror(ret));
+			}
+		}
+	}
+
+	if (nd_ifindex >= 0 && iface->ifneigh_entries)
+		add_neighbor(nd_ifindex, iface->ifneigh_entries);
+
+	if (nd_ifindex >= 0 && iface->ifqdisc_entries)
+		lkl_qdisc_parse_add(nd_ifindex, iface->ifqdisc_entries);
+
+	return 0;
+}
+
+static void free_cfgparam(char *cfgparam)
+{
+	if (cfgparam)
+		free(cfgparam);
+}
+
+static int lkl_clean_config(struct lkl_config *cfg)
+{
+	struct lkl_config_iface *iface;
+
+	if (!cfg)
+		return -1;
+
+	for (iface = cfg->ifaces; iface; iface = iface->next) {
+		free_cfgparam(iface->iftype);
+		free_cfgparam(iface->ifparams);
+		free_cfgparam(iface->ifmtu_str);
+		free_cfgparam(iface->ifip);
+		free_cfgparam(iface->ifipv6);
+		free_cfgparam(iface->ifgateway);
+		free_cfgparam(iface->ifgateway6);
+		free_cfgparam(iface->ifmac_str);
+		free_cfgparam(iface->ifnetmask_len);
+		free_cfgparam(iface->ifnetmask6_len);
+		free_cfgparam(iface->ifoffload_str);
+		free_cfgparam(iface->ifneigh_entries);
+		free_cfgparam(iface->ifqdisc_entries);
+	}
+	free_cfgparam(cfg->gateway);
+	free_cfgparam(cfg->gateway6);
+	free_cfgparam(cfg->debug);
+	free_cfgparam(cfg->mount);
+	free_cfgparam(cfg->single_cpu);
+	free_cfgparam(cfg->sysctls);
+	free_cfgparam(cfg->boot_cmdline);
+	free_cfgparam(cfg->dump);
+	free_cfgparam(cfg->delay_main);
+	return 0;
+}
+
+
+int lkl_load_config_pre(struct lkl_config *cfg)
+{
+	int lkl_debug, ret;
+	struct lkl_config_iface *iface;
+
+	if (!cfg)
+		return 0;
+
+	if (cfg->debug)
+		lkl_debug = strtol(cfg->debug, NULL, 0);
+
+	if (!cfg->debug || (lkl_debug == 0))
+		lkl_host_ops.print = NULL;
+
+	for (iface = cfg->ifaces; iface; iface = iface->next) {
+		ret = lkl_config_netdev_create(cfg, iface);
+		if (ret < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+int lkl_load_config_post(struct lkl_config *cfg)
+{
+	int ret;
+	struct lkl_config_iface *iface;
+
+	if (!cfg)
+		return 0;
+
+	if (cfg->mount)
+		mount_cmds_exec(cfg->mount, lkl_mount_fs);
+
+	for (iface = cfg->ifaces; iface; iface = iface->next) {
+		ret = lkl_config_netdev_configure(cfg, iface);
+		if (ret < 0)
+			break;
+	}
+
+	if (cfg->gateway) {
+		unsigned int gwaddr;
+
+		if (inet_pton(LKL_AF_INET, cfg->gateway,
+			      (struct lkl_in_addr *)&gwaddr) != 1)
+			lkl_printf("Invalid ipv4 gateway: %s\n", cfg->gateway);
+
+		if (gwaddr != LKL_INADDR_NONE) {
+			ret = lkl_set_ipv4_gateway(gwaddr);
+			if (ret < 0)
+				lkl_printf("failed to set IPv4 gateway: %s\n",
+					   lkl_strerror(ret));
+		}
+	}
+
+	if (cfg->gateway6) {
+		char gw[16];
+
+		if (inet_pton(LKL_AF_INET6, cfg->gateway6, gw) != 1) {
+			lkl_printf("Invalid ipv6 gateway: %s\n", cfg->gateway6);
+		} else {
+			ret = lkl_set_ipv6_gateway(gw);
+			if (ret < 0)
+				lkl_printf("failed to set IPv6 gateway: %s\n",
+					   lkl_strerror(ret));
+		}
+	}
+
+	if (cfg->sysctls)
+		lkl_sysctl_parse_write(cfg->sysctls);
+
+	/* put a delay before calling main() */
+	if (cfg->delay_main) {
+		unsigned long delay = strtoul(cfg->delay_main, NULL, 10);
+
+		if (delay == ~0UL)
+			lkl_printf("got invalid delay_main value (%s)\n",
+				   cfg->delay_main);
+		else {
+			lkl_printf("sleeping %lu usec\n", delay);
+			usleep(delay);
+		}
+	}
+
+	return 0;
+}
+
+int lkl_unload_config(struct lkl_config *cfg)
+{
+	if (cfg) {
+		if (cfg->dump)
+			mount_cmds_exec(cfg->dump, dump_file);
+
+		lkl_clean_config(cfg);
+	}
+
+	return 0;
+}
diff --git a/tools/lkl/lib/dbg.c b/tools/lkl/lib/dbg.c
new file mode 100644
index 000000000000..b613353bce5c
--- /dev/null
+++ b/tools/lkl/lib/dbg.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <lkl.h>
+#include <limits.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static const char *PROMOTE = "$";
+#define str(x) #x
+#define xstr(s) str(s)
+#define MAX_BUF 100
+static char cmd[MAX_BUF];
+static char argv[10][MAX_BUF];
+static int argc;
+static char cur_dir[MAX_BUF] = "/";
+
+static char *normalize_path(const char *src, size_t src_len)
+{
+	char *res;
+	unsigned int res_len;
+	const char *ptr = src;
+	const char *end = &src[src_len];
+	const char *next;
+
+	res = malloc((src_len > 0 ? src_len : 1) + 1);
+	res_len = 0;
+
+	for (ptr = src; ptr < end; ptr = next+1) {
+		size_t len;
+
+		next = memchr(ptr, '/', end-ptr);
+		if (next == NULL)
+			next = end;
+
+		len = next-ptr;
+		switch (len) {
+		case 2:
+			if (ptr[0] == '.' && ptr[1] == '.') {
+				const char *slash = strrchr(res, '/');
+
+				if (slash != NULL)
+					res_len = slash - res;
+				continue;
+			}
+			break;
+		case 1:
+			if (ptr[0] == '.')
+				continue;
+			break;
+		case 0:
+			continue;
+		}
+		res[res_len++] = '/';
+		memcpy(&res[res_len], ptr, len);
+		res_len += len;
+	}
+	if (res_len == 0)
+		res[res_len++] = '/';
+	res[res_len] = '\0';
+	return res;
+}
+
+static void build_path(char *path)
+{
+	char *npath;
+
+	strcpy(path, cur_dir);
+	if (argc >= 1) {
+		if (argv[0][0] == '/')
+			strncpy(path, argv[0], LKL_PATH_MAX);
+		else {
+			strncat(path, "/", LKL_PATH_MAX - strlen(path) - 1);
+			strncat(path, argv[0], LKL_PATH_MAX - strlen(path) - 1);
+		}
+	}
+	npath = normalize_path(path, strlen(path));
+	strcpy(path, npath);
+	free(npath);
+}
+
+static void help(void)
+{
+	const char *msg =
+		"cat FILE\n"
+		"\tShow content of FILE\n"
+		"cd [DIR]\n"
+		"\tChange directory to DIR\n"
+		"exit\n"
+		"\tExit the debug session\n"
+		"help\n"
+		"\tShow this message\n"
+		"ls [DIR]\n"
+		"\tList files in DIR\n"
+		"mount FSTYPE\n"
+		"\tMount FSTYPE as /FSTYPE\n"
+		"overwrite FILE\n"
+		"\tOverwrite content of FILE from stdin\n"
+		"pwd\n"
+		"\tShow current directory\n"
+		;
+	printf("%s", msg);
+}
+
+static void ls(void)
+{
+	char path[LKL_PATH_MAX];
+	struct lkl_dir *dir;
+	struct lkl_linux_dirent64 *de;
+	int err;
+
+	build_path(path);
+	dir = lkl_opendir(path, &err);
+	if (dir) {
+		do {
+			de = lkl_readdir(dir);
+			if (de) {
+				printf("%s\n", de->d_name);
+			} else {
+				err = lkl_errdir(dir);
+				if (err != 0) {
+					fprintf(stderr, "%s\n",
+						lkl_strerror(err));
+				}
+				break;
+			}
+		} while (1);
+		lkl_closedir(dir);
+	} else {
+		fprintf(stderr, "%s: %s\n", path, lkl_strerror(err));
+	}
+}
+
+static void cd(void)
+{
+	char path[LKL_PATH_MAX];
+	struct lkl_dir *dir;
+	int err;
+
+	build_path(path);
+	dir = lkl_opendir(path, &err);
+	if (dir) {
+		strcpy(cur_dir, path);
+		lkl_closedir(dir);
+	} else {
+		fprintf(stderr, "%s: %s\n", path, lkl_strerror(err));
+	}
+}
+
+static void mount(void)
+{
+	char *fstype;
+	int ret = 0;
+
+	if (argc != 1) {
+		fprintf(stderr, "%s\n", "One argument is needed.");
+		return;
+	}
+
+	fstype = argv[0];
+	ret = lkl_mount_fs(fstype);
+	if (ret == 1)
+		fprintf(stderr, "%s is already mounted.\n", fstype);
+}
+
+static void cat(void)
+{
+	char path[LKL_PATH_MAX];
+	int ret;
+	char buf[1024];
+	int fd;
+
+	if (argc != 1) {
+		fprintf(stderr, "%s\n", "One argument is needed.");
+		return;
+	}
+
+	build_path(path);
+	fd = lkl_sys_open(path, LKL_O_RDONLY, 0);
+
+	if (fd < 0) {
+		fprintf(stderr, "lkl_sys_open %s: %s\n",
+			path, lkl_strerror(fd));
+		return;
+	}
+
+	while ((ret = lkl_sys_read(fd, buf, sizeof(buf) - 1)) > 0) {
+		buf[ret] = '\0';
+		printf("%s", buf);
+	}
+
+	if (ret) {
+		fprintf(stderr, "lkl_sys_read %s: %s\n",
+			path, lkl_strerror(ret));
+	}
+	lkl_sys_close(fd);
+}
+
+static void overwrite(void)
+{
+	char path[LKL_PATH_MAX];
+	int ret;
+	int fd;
+	char buf[1024];
+
+	build_path(path);
+	fd = lkl_sys_open(path, LKL_O_WRONLY | LKL_O_CREAT, 0);
+	if (fd < 0) {
+		fprintf(stderr, "lkl_sys_open %s: %s\n",
+			path, lkl_strerror(fd));
+		return;
+	}
+	printf("Input the content and stop by hitting Ctrl-D:\n");
+	while (fgets(buf, 1023, stdin)) {
+		ret = lkl_sys_write(fd, buf, strlen(buf));
+		if (ret < 0) {
+			fprintf(stderr, "lkl_sys_write %s: %s\n",
+				path, lkl_strerror(fd));
+		}
+	}
+	lkl_sys_close(fd);
+}
+
+static void pwd(void)
+{
+	printf("%s\n", cur_dir);
+}
+
+static int parse_cmd(char *input)
+{
+	char *token;
+
+	token = strtok(input, " ");
+	if (token)
+		strcpy(cmd, token);
+	else
+		return -1;
+
+	argc = 0;
+	token = strtok(NULL, " ");
+	while (token) {
+		if (argc >= 10) {
+			fprintf(stderr, "To many args > 10\n");
+			return -1;
+		}
+		strcpy(argv[argc++], token);
+		token = strtok(NULL, " ");
+	}
+	return 0;
+}
+
+static void run_cmd(void)
+{
+	if (strcmp(cmd, "cat") == 0)
+		cat();
+	else if (strcmp(cmd, "cd") == 0)
+		cd();
+	else if (strcmp(cmd, "help") == 0)
+		help();
+	else if (strcmp(cmd, "ls") == 0)
+		ls();
+	else if (strcmp(cmd, "mount") == 0)
+		mount();
+	else if (strcmp(cmd, "overwrite") == 0)
+		overwrite();
+	else if (strcmp(cmd, "pwd") == 0)
+		pwd();
+	else
+		fprintf(stderr, "Unknown command: %s\n", cmd);
+}
+
+void dbg_entrance(void)
+{
+	char input[MAX_BUF + 1];
+	int ret;
+	int c;
+
+	printf("Type help to see a list of commands\n");
+	do {
+		printf("%s ", PROMOTE);
+		ret = scanf("%" xstr(MAX_BUF) "[^\n]s", input);
+		while ((c = getchar()) != '\n' && c != EOF)
+			;
+		if (ret == 0)
+			continue;
+		if (ret != 1 && errno != EINTR) {
+			perror("scanf");
+			continue;
+		}
+		if (strlen(input) == MAX_BUF) {
+			fprintf(stderr, "Too long input > %d\n", MAX_BUF - 1);
+			continue;
+		}
+		if (parse_cmd(input))
+			continue;
+		if (strcmp(cmd, "exit") == 0)
+			break;
+		run_cmd();
+	} while (1);
+}
diff --git a/tools/lkl/lib/dbg_handler.c b/tools/lkl/lib/dbg_handler.c
new file mode 100644
index 000000000000..01d165a5fc1e
--- /dev/null
+++ b/tools/lkl/lib/dbg_handler.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <lkl_host.h>
+
+extern void dbg_entrance(void);
+static int dbg_running;
+
+static void dbg_thread(void *arg)
+{
+	lkl_host_ops.thread_detach();
+	printf("======Enter Debug======\n");
+	dbg_entrance();
+	printf("======Exit Debug======\n");
+	dbg_running = 0;
+}
+
+void dbg_handler(int signum)
+{
+	/* We don't care about the possible race on dbg_running. */
+	if (dbg_running) {
+		fprintf(stderr, "A debug lib is running\n");
+		return;
+	}
+	dbg_running = 1;
+	lkl_host_ops.thread_create(&dbg_thread, NULL);
+}
+
+#ifndef __MINGW32__
+#include <signal.h>
+void lkl_register_dbg_handler(void)
+{
+	struct sigaction sa;
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_handler = dbg_handler;
+	if (sigaction(SIGTSTP, &sa, NULL) == -1)
+		perror("sigaction");
+}
+#else
+void lkl_register_dbg_handler(void)
+{
+	fprintf(stderr, "%s is not implemented.\n", __func__);
+}
+#endif
diff --git a/tools/lkl/lib/endian.h b/tools/lkl/lib/endian.h
new file mode 100644
index 000000000000..aaccfa0edb65
--- /dev/null
+++ b/tools/lkl/lib/endian.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_ENDIAN_H
+#define _LKL_LIB_ENDIAN_H
+
+#if defined(__FreeBSD__)
+#include <sys/endian.h>
+#elif defined(__ANDROID__)
+#include <sys/endian.h>
+#elif defined(__MINGW32__)
+#include <winsock.h>
+#define le32toh(x) (x)
+#define le16toh(x) (x)
+#define htole32(x) (x)
+#define htole16(x) (x)
+#define le64toh(x) (x)
+#define htobe32(x) htonl(x)
+#define htobe16(x) htons(x)
+#define be32toh(x) ntohl(x)
+#define be16toh(x) ntohs(x)
+#else
+#include <endian.h>
+#endif
+
+#ifndef htonl
+#define htonl(x) htobe32(x)
+#define htons(x) htobe16(x)
+#define ntohl(x) be32toh(x)
+#define ntohs(x) be16toh(x)
+#endif
+
+#endif /* _LKL_LIB_ENDIAN_H */
diff --git a/tools/lkl/lib/jmp_buf.c b/tools/lkl/lib/jmp_buf.c
new file mode 100644
index 000000000000..f6bdd7e4bd83
--- /dev/null
+++ b/tools/lkl/lib/jmp_buf.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <setjmp.h>
+#include <lkl_host.h>
+
+void jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void))
+{
+	if (!setjmp(*((jmp_buf *)jmpb->buf)))
+		f();
+}
+
+void jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val)
+{
+	longjmp(*((jmp_buf *)jmpb->buf), val);
+}
diff --git a/tools/lkl/lib/jmp_buf.h b/tools/lkl/lib/jmp_buf.h
new file mode 100644
index 000000000000..8782cbaaf51f
--- /dev/null
+++ b/tools/lkl/lib/jmp_buf.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_JMP_BUF_H
+#define _LKL_LIB_JMP_BUF_H
+
+void jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void));
+void jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val);
+
+#endif
diff --git a/tools/lkl/lib/utils.c b/tools/lkl/lib/utils.c
new file mode 100644
index 000000000000..7de92bbe5475
--- /dev/null
+++ b/tools/lkl/lib/utils.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <lkl_host.h>
+
+static const char * const lkl_err_strings[] = {
+	"Success",
+	"Operation not permitted",
+	"No such file or directory",
+	"No such process",
+	"Interrupted system call",
+	"I/O error",
+	"No such device or address",
+	"Argument list too long",
+	"Exec format error",
+	"Bad file number",
+	"No child processes",
+	"Try again",
+	"Out of memory",
+	"Permission denied",
+	"Bad address",
+	"Block device required",
+	"Device or resource busy",
+	"File exists",
+	"Cross-device link",
+	"No such device",
+	"Not a directory",
+	"Is a directory",
+	"Invalid argument",
+	"File table overflow",
+	"Too many open files",
+	"Not a typewriter",
+	"Text file busy",
+	"File too large",
+	"No space left on device",
+	"Illegal seek",
+	"Read-only file system",
+	"Too many links",
+	"Broken pipe",
+	"Math argument out of domain of func",
+	"Math result not representable",
+	"Resource deadlock would occur",
+	"File name too long",
+	"No record locks available",
+	"Invalid system call number",
+	"Directory not empty",
+	"Too many symbolic links encountered",
+	"Bad error code", /* EWOULDBLOCK is EAGAIN */
+	"No message of desired type",
+	"Identifier removed",
+	"Channel number out of range",
+	"Level 2 not synchronized",
+	"Level 3 halted",
+	"Level 3 reset",
+	"Link number out of range",
+	"Protocol driver not attached",
+	"No CSI structure available",
+	"Level 2 halted",
+	"Invalid exchange",
+	"Invalid request descriptor",
+	"Exchange full",
+	"No anode",
+	"Invalid request code",
+	"Invalid slot",
+	"Bad error code", /* EDEADLOCK is EDEADLK */
+	"Bad font file format",
+	"Device not a stream",
+	"No data available",
+	"Timer expired",
+	"Out of streams resources",
+	"Machine is not on the network",
+	"Package not installed",
+	"Object is remote",
+	"Link has been severed",
+	"Advertise error",
+	"Srmount error",
+	"Communication error on send",
+	"Protocol error",
+	"Multihop attempted",
+	"RFS specific error",
+	"Not a data message",
+	"Value too large for defined data type",
+	"Name not unique on network",
+	"File descriptor in bad state",
+	"Remote address changed",
+	"Can not access a needed shared library",
+	"Accessing a corrupted shared library",
+	".lib section in a.out corrupted",
+	"Attempting to link in too many shared libraries",
+	"Cannot exec a shared library directly",
+	"Illegal byte sequence",
+	"Interrupted system call should be restarted",
+	"Streams pipe error",
+	"Too many users",
+	"Socket operation on non-socket",
+	"Destination address required",
+	"Message too long",
+	"Protocol wrong type for socket",
+	"Protocol not available",
+	"Protocol not supported",
+	"Socket type not supported",
+	"Operation not supported on transport endpoint",
+	"Protocol family not supported",
+	"Address family not supported by protocol",
+	"Address already in use",
+	"Cannot assign requested address",
+	"Network is down",
+	"Network is unreachable",
+	"Network dropped connection because of reset",
+	"Software caused connection abort",
+	"Connection reset by peer",
+	"No buffer space available",
+	"Transport endpoint is already connected",
+	"Transport endpoint is not connected",
+	"Cannot send after transport endpoint shutdown",
+	"Too many references: cannot splice",
+	"Connection timed out",
+	"Connection refused",
+	"Host is down",
+	"No route to host",
+	"Operation already in progress",
+	"Operation now in progress",
+	"Stale file handle",
+	"Structure needs cleaning",
+	"Not a XENIX named type file",
+	"No XENIX semaphores available",
+	"Is a named type file",
+	"Remote I/O error",
+	"Quota exceeded",
+	"No medium found",
+	"Wrong medium type",
+	"Operation Canceled",
+	"Required key not available",
+	"Key has expired",
+	"Key has been revoked",
+	"Key was rejected by service",
+	"Owner died",
+	"State not recoverable",
+	"Operation not possible due to RF-kill",
+	"Memory page has hardware error",
+};
+
+const char *lkl_strerror(int err)
+{
+	if (err < 0)
+		err = -err;
+
+	if ((size_t)err >= sizeof(lkl_err_strings) / sizeof(const char *))
+		return "Bad error code";
+
+	return lkl_err_strings[err];
+}
+
+void lkl_perror(char *msg, int err)
+{
+	const char *err_msg = lkl_strerror(err);
+	/* We need to use 'real' printf because lkl_host_ops.print can
+	 * be turned off when debugging is off.
+	 */
+	lkl_printf("%s: %s\n", msg, err_msg);
+}
+
+static int lkl_vprintf(const char *fmt, va_list args)
+{
+	int n;
+	char *buffer;
+	va_list copy;
+
+	if (!lkl_host_ops.print)
+		return 0;
+
+	va_copy(copy, args);
+	n = vsnprintf(NULL, 0, fmt, copy);
+	va_end(copy);
+
+	buffer = lkl_host_ops.mem_alloc(n + 1);
+	if (!buffer)
+		return -1;
+
+	vsnprintf(buffer, n + 1, fmt, args);
+
+	lkl_host_ops.print(buffer, n);
+	lkl_host_ops.mem_free(buffer);
+
+	return n;
+}
+
+int lkl_printf(const char *fmt, ...)
+{
+	int n;
+	va_list args;
+
+	va_start(args, fmt);
+	n = lkl_vprintf(fmt, args);
+	va_end(args);
+
+	return n;
+}
+
+void lkl_bug(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	lkl_vprintf(fmt, args);
+	va_end(args);
+
+	lkl_host_ops.panic();
+}
+#ifndef __arch_um__
+int lkl_sysctl(const char *path, const char *value)
+{
+	int ret;
+	int fd;
+	char *delim, *p;
+	char full_path[256];
+
+	lkl_mount_fs("proc");
+
+	snprintf(full_path, sizeof(full_path), "/proc/sys/%s", path);
+	p = full_path;
+	while ((delim = strstr(p, "."))) {
+		*delim = '/';
+		p = delim + 1;
+	}
+
+	fd = lkl_sys_open(full_path, LKL_O_WRONLY | LKL_O_CREAT, 0);
+	if (fd < 0) {
+		lkl_printf("lkl_sys_open %s: %s\n",
+			   full_path, lkl_strerror(fd));
+		return -1;
+	}
+	ret = lkl_sys_write(fd, value, strlen(value));
+	if (ret < 0) {
+		lkl_printf("lkl_sys_write %s: %s\n",
+			full_path, lkl_strerror(fd));
+	}
+
+	lkl_sys_close(fd);
+
+	return 0;
+}
+
+/* Configure sysctl parameters as the form of "key=value;key=value;..." */
+void lkl_sysctl_parse_write(const char *sysctls)
+{
+	char *saveptr = NULL, *token = NULL;
+	char *key = NULL, *value = NULL;
+	char strings[256];
+	int ret = 0;
+
+	strcpy(strings, sysctls);
+	for (token = strtok_r(strings, ";", &saveptr); token;
+	     token = strtok_r(NULL, ";", &saveptr)) {
+		key = strtok(token, "=");
+		value = strtok(NULL, "=");
+		ret = lkl_sysctl(key, value);
+		if (ret) {
+			lkl_printf("Failed to configure sysctl entries: %s\n",
+				   lkl_strerror(ret));
+			return;
+		}
+	}
+}
+#endif
-- 
2.21.0 (Apple Git-122.2)

