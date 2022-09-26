Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375825E9CDC
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiIZJD7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiIZJD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:03:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C38233;
        Mon, 26 Sep 2022 02:03:56 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28Q92Yo1010468;
        Mon, 26 Sep 2022 18:02:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28Q92Yo1010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664182957;
        bh=BPnfmDEWCeCea4uV8hpuWw2QITJu86RZUqhlhoRXLtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rESuEESr07CyUHm4e7+ZokWao+kBRehSobvHZUWN0tqYYPBNA8QE/PshA+IL+102+
         ashKzPJmxqeTiFM2huHef+2MDsqajBDFXpfCyLG8ejVY8H7HnKR0YsB9KHS1kBPr/w
         +wBVwLY+y5fsjT0C/HhGnvUZZUW6BNyRDULH4q4AFyZ7ZeNWAxp072xZxrwKDB+0Ub
         7JnK9alc28HeGnVU7a/mAX48H+bYrFyxr9Yu5DWqdOW9zplsBog0wOmSjZri9NWphL
         gxe3uT3GxKMl40rUhXFAfoyvzFzagi1TARTQO91CX+bj2681l3jXDEwp01CUNkz8Ut
         bV+LWX7aT/6MQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Fuad Tabba <tabba@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 4/5] kallsyms: take the input file instead of reading stdin
Date:   Mon, 26 Sep 2022 18:02:28 +0900
Message-Id: <20220926090229.643134-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926090229.643134-1-masahiroy@kernel.org>
References: <20220926090229.643134-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This gets rid of the pipe operator connected with 'cat'.

Also use getopt_long() to parse the command line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c      | 51 ++++++++++++++++++++++++++---------------
 scripts/link-vmlinux.sh |  2 +-
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 313cc8161123..5b091625d4c5 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <getopt.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -71,7 +72,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
-			"[--base-relative] < in.map > out.S\n");
+			"[--base-relative] in.map > out.S\n");
 	exit(1);
 }
 
@@ -310,12 +311,19 @@ static void shrink_table(void)
 	}
 }
 
-static void read_map(FILE *in)
+static void read_map(const char *in)
 {
+	FILE *fp;
 	struct sym_entry *sym;
 
-	while (!feof(in)) {
-		sym = read_symbol(in);
+	fp = fopen(in, "r");
+	if (!fp) {
+		perror(in);
+		exit(1);
+	}
+
+	while (!feof(fp)) {
+		sym = read_symbol(fp);
 		if (!sym)
 			continue;
 
@@ -326,12 +334,15 @@ static void read_map(FILE *in)
 			table = realloc(table, sizeof(*table) * table_size);
 			if (!table) {
 				fprintf(stderr, "out of memory\n");
+				fclose(fp);
 				exit (1);
 			}
 		}
 
 		table[table_cnt++] = sym;
 	}
+
+	fclose(fp);
 }
 
 static void output_label(const char *label)
@@ -762,22 +773,26 @@ static void record_relative_base(void)
 
 int main(int argc, char **argv)
 {
-	if (argc >= 2) {
-		int i;
-		for (i = 1; i < argc; i++) {
-			if(strcmp(argv[i], "--all-symbols") == 0)
-				all_symbols = 1;
-			else if (strcmp(argv[i], "--absolute-percpu") == 0)
-				absolute_percpu = 1;
-			else if (strcmp(argv[i], "--base-relative") == 0)
-				base_relative = 1;
-			else
-				usage();
-		}
-	} else if (argc != 1)
+	while (1) {
+		static struct option long_options[] = {
+			{"all-symbols",     no_argument, &all_symbols,     1},
+			{"absolute-percpu", no_argument, &absolute_percpu, 1},
+			{"base-relative",   no_argument, &base_relative,   1},
+			{},
+		};
+
+		int c = getopt_long(argc, argv, "", long_options, NULL);
+
+		if (c == -1)
+			break;
+		if (c != 0)
+			usage();
+	}
+
+	if (optind >= argc)
 		usage();
 
-	read_map(stdin);
+	read_map(argv[optind]);
 	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 6492c0862657..2782c5d1518b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -157,7 +157,7 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	cat ${1} | scripts/kallsyms ${kallsymopt} > ${2}
+	scripts/kallsyms ${kallsymopt} ${1} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
-- 
2.34.1

