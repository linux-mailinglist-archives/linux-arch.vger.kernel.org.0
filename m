Return-Path: <linux-arch+bounces-9384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD19F06CB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 09:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12781188B1C0
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366F1AE863;
	Fri, 13 Dec 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei487U02"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D91ADFF6;
	Fri, 13 Dec 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079543; cv=none; b=eMheDkOcV4K5TGlpRnRI6Y7KiPaZHHZ+6/5wVuSiWfAQ6tRe3EeK47DynggZmpz9FNAnhHELJkPC/Vzh8kHLc3S6X2+QEB7ELFyOBDf0QkeYUCsTcDnL5yBUAeZLoViPBdwzrw6Adq5W3broe7m1pjgQymITpYH1xEKCW7CxHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079543; c=relaxed/simple;
	bh=gEXrtWbvKXbc5DAvlMeORK670b/NaKAd2vGNsP6Rfu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7kZjdqI93CkXgCpbOXW6o3Cc1JcQK+0oHP18prE37K8DYeo5rx1MU4vbob6VckhkwF7MxP3zab8UgnSX8+XEOBsgeVRZxQ8y6WxhP4omfHLXxaHnhP2tBgHc6PHLccVxW2CgNl95+Ets+WMFGGpF91leE9V3AICFnpihX5rGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei487U02; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso10139315e9.3;
        Fri, 13 Dec 2024 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079539; x=1734684339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAQPjCfF8R79FFcgAR1MpcWgrbDYC2HDbd/YFnzgQSI=;
        b=Ei487U02MMkvJZ9sDN8Rr8bfV7yRw0HjBCnCxfqa/v1geENc4PiTVAzQ1kMpNo6WLE
         qPl0RV2cgPUDvynJvFj8gZ1dycOLa2EKyE0tdtW5tqdndavyHolup443hXkb8cV5apB+
         IRjRCBRAFdrVhDskcLMNcdr9bGLaY94pYW/BPdOXgFEK7eU0MLaxqfdiQVWVEsQYsJ71
         XA1G8qsXXOjy9PBTEgPI/MAxU2o2ZU/ydHB+P1Hfh5bEWixR9iTeRopDiqlDruDUwDsi
         wufZbhYqiSd14I24YiiJ5Q3i/ovo0kj31VSAwuqz0JZfmQgqnvjP8CKDnxWrb7+TbieW
         bclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079539; x=1734684339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAQPjCfF8R79FFcgAR1MpcWgrbDYC2HDbd/YFnzgQSI=;
        b=hiYyz9i2ljY74Cr4dVwjmHi1uhcNczTP0rqXyS+BxJgvJcRMMNOYkee3CXslXKZdmT
         fFa3/JvGl9YKlF+W7BBiFuh8EXKz6CO9+Fv9CAqXxMqcHbH3TDu2OLtvace7J2ncmU9a
         QaLGfOyrIaXqTxQYUm229hoK9mWPGyLFHbID9DmVCBi++t4BCZzbVJIsSr7YZBF79nQ/
         JH2zth6GNQjMGSSLaIUyJzyVI711Ru17zIPtoFrPWXZvhia1sDCnBKiSdxUcBRw/AUNz
         a03qn0wy/UJBZ4ypWNznBKAFFKSFFzwxXoaivdTjqpAbqqYo0yogIBebovmGLdu7Wq03
         hOTw==
X-Forwarded-Encrypted: i=1; AJvYcCUETsQumaocsCWHTZGq4Bhogi8zMceJhdUlGj/up+lZqXBl8w/kqM6vfG5HtmKdXF3QAMd47o8PmCzx+wbtL1sB@vger.kernel.org, AJvYcCUa7pL3QMjKFZci2iO7+5PYUwxQmpQP8I4RhIxrwcWJxsyqYuLop+Vr9ohftKwU5x0Bsk1979d6rrt3fA==@vger.kernel.org, AJvYcCVN+Muhuh1sV3/vMHo8LxThXsOd4HrxsXGtFVPT/hMw9pcC/t7GVN5/AotbAgOJVmEP+10iz/K/LFL7aHul@vger.kernel.org, AJvYcCVPY4qImGhw5xWYK6C+eQOeQ8bHc3auUQgZ0eBRHc9eZbBw5+7VMSxkxf8zwsOeQdRZz8S82iU7Lkr6@vger.kernel.org, AJvYcCVXq511xWwHcxLD7uRtO0xUUhHkWXAj8A5fQ3ewt1EujVhvUBDtyAQ/D15XO483lQH1NymfUUK/1kjGvg==@vger.kernel.org, AJvYcCWJ7kIC1ITlGLUolbjCf8mzDMqvvZ774E3P1jy+nL5JfkeoJcet919qIMriSurJWYYOX2LkG+qnL/PFBg==@vger.kernel.org, AJvYcCX3NmbfkfDQoafic/kehwypX4gcqNpLDcXk3y/MmFGGO4++/9D6GRIOSay41UyoGmNR41f2XXgutb/mLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwphQF/j5IdovGi3aR4Tvl0Egu5tXjnRgWnC6Zic+fKyvt/0KtZ
	yQevfpZKAIr6jQ6yP38n/3fyC6j5DWg4sNdAKcfp6o45HKZW7Wtu2f3zgE48eBE=
X-Gm-Gg: ASbGncsMlkSDrmsgvYvTZ4T00JiTBo1pl++uHud7lI2knaGTkldgbPCISgx5B4+d1/Y
	VgbuiGrlsWe/tIoCwGg68EqOall/Mp0BQ7uqt4KAW8m0OaGd/4Qs6H8AKyz4/dPVqo60lr9m8po
	InzdJ6tPfLtvfkQm1VpgD+pl+gnm8x69ubiVfKS/w7NmDVwl1Jj16tTnIJczLSKKx8QaJ4LJWa0
	Zo3E5zEdE+TbW4iJRJ3BLt/4wqJvwbs1IILLPSS6mnfs0VA4++QrWZt25hC/5DjnRv8vfSkJn5v
	K0p0HbwWUlhIYlJ8f2p4SVBpWG/pRypNOpy9xbxAq5O5iXIuSQuYPuGycNoZXHM=
X-Google-Smtp-Source: AGHT+IHEs3Cei5msjsPGizCRnMmoZL2dPAJpkHiPIRNVrae9gJi3SXbE3DRfQs3hVdWLib2Sivoeyg==
X-Received: by 2002:a05:600c:1c07:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-4362aa2dea3mr13831005e9.9.1734079538652;
        Fri, 13 Dec 2024 00:45:38 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E9B09007B50BC12F2E5C1B6.dsl.pool.telekom.hu. [2001:4c4e:1e9b:900:7b50:bc12:f2e5:c1b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eaf6sm42487645e9.20.2024.12.13.00.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:45:37 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	horms@kernel.org,
	dsahern@kernel.org,
	linux-can@vger.kernel.org,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tsbogend@alpha.franken.de,
	kaiyuanz@google.com,
	James.Bottomley@HansenPartnership.com,
	richard.henderson@linaro.org,
	arnd@arndb.de,
	almasrymina@google.com,
	asml.silence@gmail.com,
	linux-mips@vger.kernel.org,
	andreas@gaisler.com,
	mattst88@gmail.com,
	kerneljasonxing@gmail.com,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	deller@gmx.de,
	vadim.fedorenko@linux.dev,
	linux-parisc@vger.kernel.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v7 3/4] selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
Date: Fri, 13 Dec 2024 09:44:56 +0100
Message-ID: <20241213084457.45120-4-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213084457.45120-1-annaemesenyiri@gmail.com>
References: <20241213084457.45120-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
ancillary data.

cmsg_so_priority.sh script added to validate SO_PRIORITY behavior 
by creating VLAN device with egress QoS mapping and testing packet
priorities using flower filters. Verify that packets with different
priorities are correctly matched and counted by filters for multiple
protocols and IP versions.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cb2fc601de66..f09bd96cc978 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
+TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
 TEST_PROGS += nl_netdev.py
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 876c2db02a63..bc314382e4e1 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -59,6 +59,7 @@ struct options {
 		unsigned int proto;
 	} sock;
 	struct option_cmsg_u32 mark;
+	struct option_cmsg_u32 priority;
 	struct {
 		bool ena;
 		unsigned int delay;
@@ -97,6 +98,8 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	       "\n"
 	       "\t\t-m val  Set SO_MARK with given value\n"
 	       "\t\t-M val  Set SO_MARK via setsockopt\n"
+	       "\t\t-P val  Set SO_PRIORITY via setsockopt\n"
+	       "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
 	       "\t\t-d val  Set SO_TXTIME with given delay (usec)\n"
 	       "\t\t-t      Enable time stamp reporting\n"
 	       "\t\t-f val  Set don't fragment via cmsg\n"
@@ -115,7 +118,7 @@ static void cs_parse_args(int argc, char *argv[])
 {
 	int o;
 
-	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:")) != -1) {
+	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) != -1) {
 		switch (o) {
 		case 's':
 			opt.silent_send = true;
@@ -148,6 +151,10 @@ static void cs_parse_args(int argc, char *argv[])
 			opt.mark.ena = true;
 			opt.mark.val = atoi(optarg);
 			break;
+		case 'Q':
+			opt.priority.ena = true;
+			opt.priority.val = atoi(optarg);
+			break;
 		case 'M':
 			opt.sockopt.mark = atoi(optarg);
 			break;
@@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_SOCKET, SO_MARK, &opt.mark);
+	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+			  SOL_SOCKET, SO_PRIORITY, &opt.priority);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
new file mode 100755
index 000000000000..35dde2c5b67f
--- /dev/null
+++ b/tools/testing/selftests/net/cmsg_so_priority.sh
@@ -0,0 +1,151 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+readonly KSFT_SKIP=4
+
+IP4=192.0.2.1/24
+TGT4=192.0.2.2
+TGT4_RAW=192.0.2.3
+IP6=2001:db8::1/64
+TGT6=2001:db8::2
+TGT6_RAW=2001:db8::3
+PORT=1234
+TOTAL_TESTS=0
+FAILED_TESTS=0
+
+if ! command -v jq &> /dev/null; then
+    echo "SKIP cmsg_so_priroity.sh test: jq is not installed." >&2
+    exit "$KSFT_SKIP"
+fi
+
+check_result() {
+    ((TOTAL_TESTS++))
+    if [ "$1" -ne 0 ]; then
+        ((FAILED_TESTS++))
+    fi
+}
+
+cleanup()
+{
+    cleanup_ns $NS
+}
+
+trap cleanup EXIT
+
+setup_ns NS
+
+create_filter() {
+    local handle=$1
+    local vlan_prio=$2
+    local ip_type=$3
+    local proto=$4
+    local dst_ip=$5
+    local ip_proto
+
+    if [[ "$proto" == "u" ]]; then
+        ip_proto="udp"
+    elif [[ "$ip_type" == "ipv4" && "$proto" == "i" ]]; then
+        ip_proto="icmp"
+    elif [[ "$ip_type" == "ipv6" && "$proto" == "i" ]]; then
+        ip_proto="icmpv6"
+    fi
+
+    tc -n $NS filter add dev dummy1 \
+        egress pref 1 handle "$handle" proto 802.1q \
+        flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
+        dst_ip "$dst_ip" ${ip_proto:+ip_proto $ip_proto} \
+        action pass
+}
+
+ip -n $NS link set dev lo up
+ip -n $NS link add name dummy1 up type dummy
+
+ip -n $NS link add link dummy1 name dummy1.10 up type vlan id 10 \
+    egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
+
+ip -n $NS address add $IP4 dev dummy1.10
+ip -n $NS address add $IP6 dev dummy1.10 nodad
+
+ip netns exec $NS sysctl -wq net.ipv4.ping_group_range='0 2147483647'
+
+ip -n $NS neigh add $TGT4 lladdr 00:11:22:33:44:55 nud permanent \
+    dev dummy1.10
+ip -n $NS neigh add $TGT6 lladdr 00:11:22:33:44:55 nud permanent \
+    dev dummy1.10
+ip -n $NS neigh add $TGT4_RAW lladdr 00:11:22:33:44:66 nud permanent \
+    dev dummy1.10
+ip -n $NS neigh add $TGT6_RAW lladdr 00:11:22:33:44:66 nud permanent \
+    dev dummy1.10
+
+tc -n $NS qdisc add dev dummy1 clsact
+
+FILTER_COUNTER=10
+
+for i in 4 6; do
+    for proto in u i r; do
+        echo "Test IPV$i, prot: $proto"
+        for priority in {0..7}; do
+            if [[ $i == 4 && $proto == "r" ]]; then
+                TGT=$TGT4_RAW
+            elif [[ $i == 6 && $proto == "r" ]]; then
+                TGT=$TGT6_RAW
+            elif [ $i == 4 ]; then
+                TGT=$TGT4
+            else
+                TGT=$TGT6
+            fi
+
+            handle="${FILTER_COUNTER}${priority}"
+
+            create_filter $handle $priority ipv$i $proto $TGT
+
+            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+
+            if [[ $pkts == 0 ]]; then
+                check_result 0
+            else
+                echo "prio $priority: expected 0, got $pkts"
+                check_result 1
+            fi
+
+            ip netns exec $NS ./cmsg_sender -$i -Q $priority \
+	            -p $proto $TGT $PORT
+
+            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+            if [[ $pkts == 1 ]]; then
+                check_result 0
+            else
+                echo "prio $priority -Q: expected 1, got $pkts"
+                check_result 1
+            fi
+
+            ip netns exec $NS ./cmsg_sender -$i -P $priority \
+	            -p $proto $TGT $PORT
+
+            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+            if [[ $pkts == 2 ]]; then
+                check_result 0
+            else
+                echo "prio $priority -P: expected 2, got $pkts"
+                check_result 1
+            fi
+        done
+        FILTER_COUNTER=$((FILTER_COUNTER + 10))
+    done
+done
+
+if [ $FAILED_TESTS -ne 0 ]; then
+    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
+    exit 1
+else
+    echo "OK - All $TOTAL_TESTS tests passed"
+    exit 0
+fi
-- 
2.43.0


