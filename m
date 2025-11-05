Return-Path: <linux-arch+bounces-14513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE4C33A7B
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 02:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33A0465E4B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8B29898B;
	Wed,  5 Nov 2025 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4qTPyPy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D726462E
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305813; cv=none; b=Sey2dGDqoHgxm/DrroBB0xt2U7dA3ZanMeCYNfa+HbPeNqxoeS5dshdjG6Vp68e3yxj1aVqA/ZAPUODFFOKM0P5tnYm87F5CsxR8HvSnryPAkghKM9WiP5uZyo0K2U3VA9p9nhWlgwIxhgO2UsmSDAg7wmpXAA0py3u2xUCBxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305813; c=relaxed/simple;
	bh=EUVr5JNK/GTAT1ttd11lgstVq87db7L7gS8Y83xgPYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLhZyw2JHmPElbLQKjNGHAZMTNBaVZmF11BIVKVGlPbPMjDZRMPJm9ZBtaSVb7WjWUIO08FT8K0bG6jf2dHS9zBo1/7VZTZkjJu+lhoJLzdnvTGUkfH0bnGz9UGXP/gVj6wu39CtPH58Fth91bkgvywJ6xnRQ2hGuTY41hIhtgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4qTPyPy; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso4457439d50.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305808; x=1762910608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eVDPnkuv2SP94dsK2EFl5pOIR+N6oa4rL2rsMVs/R8=;
        b=S4qTPyPymyijDVhDyYOxTorfZgWjhzgv9UvEmkeogZrad0+Ni11qfJbH2VXOmsGQkT
         WSRN7s725oc7WScFEClLyvYtiHkMENn1NLLdRaZ0MlPXMKxMDTnnbI6dxo8PUonPPnVu
         Ia1cSW+GDU6XTsyY053c3jrI4HrViJipGWuQE92rDsVXIV9SC1MnG8Fsmnt3S5VDYCNj
         C1mrFIV8JWo0ScXI/uGmBiLLwcHcgEeW7l5Uh+zl6LOwSJo8A4usOKIiN7SE5hUbPBm9
         bPfFwN12J8klL5zDqH3t57kdeuhPmKjQERplVgBG0/dDL5py8YiVzmtrA5w+8o8GDzyc
         aUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305808; x=1762910608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eVDPnkuv2SP94dsK2EFl5pOIR+N6oa4rL2rsMVs/R8=;
        b=C46HGgaclzc8AxHC0THh0EJEaAyrITXEW8IIeIdSo96ioPpsCJH4briD9wVoodLoRU
         krdWLrIxvm1P8zQ3ouFjYYKSNiXySSsLz+pKwQ8gxED6YHSvMBEDCrqvPkTWSbSjk6sP
         z86AGbDaVnrAY2Ckyj5d7aYwmtliy9J5Ksaxecj/PHXJllx5RdFwoOW9+1WD8C4/Opjr
         3wD+L3tioQ0Z2xAFuFWlzvAiDOCG0FVn0Mp4md1VgqE3hwBpy0buqSE4f+XkUtNJLbIl
         S7CNdtAdbdd330Q+RCuBmakNBipWzF+zUp9gQaho2fv/EhELo10tCxRtYCNA6Anj66ut
         WxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1S1y/pURKiqPD5L8cpdFcizYAdLV58RRuKInh9k6M6GUaeVEbwyVk5LvT17CF31G4iyxjCje3Amnn@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuChhCqgNEMl4irHjPZ7Qj6hnrBjPg7D83SQy+ecxzJuJtCuW
	eylb6e2Vh/6Co+3uOyZ1eEBWAbmeWlQpV9HyzTcO0uF9HLV9T9wQzY1T
X-Gm-Gg: ASbGncveSmsK1Ca/W8aENO0hwhq9cCNbnLSk3sG7q+GMKU75buEheZ+Q1chi9IqLGzt
	4GyaE7Xtj+mj0arRO+oL2rIVVJwojwWbL2ctxgRyvvFqSkaQA9zLghe9mq/ckAtAZ4oYaegi0nW
	sLUo6AUeXBNKffFVIyiOpYnqj6d0T8kB9BNZFTCZikhi0q8vxgbnyV10/2idx/7rIiIo7pp3XOK
	cbHtKKgprc0Y3ZPd+Qg30wkd9pA9Z6R3o5DZ+RijWJ7+La7R+r7KNM0qjhEI8O4aFHHYDRX8Dc2
	mP7IhGiDAMP4CPkadhXOb6Fzx4x1cH2FH1FKc31Ln7z0A7/ofhZNS+HFg8yc1VBCSuhPoYhYlFZ
	uy3dWJO+N3I6YamK5L56QLBrWwlvyJ1FVikWXsUAOb+4WdtcYGyLK2YEqjFh7AxkkPJUw6uWEHd
	GfrPrzpduO+HM=
X-Google-Smtp-Source: AGHT+IEfDb+oJnGjarh+9F7GOHtv3gc1oPFaNFLIKdQInLnQKAgyBWcutw5Cbxj5+5Saxr4AJ66EZw==
X-Received: by 2002:a05:690e:241c:b0:63f:9f5a:a555 with SMTP id 956f58d0204a3-63fd35a47ddmr1049504d50.50.1762305808562;
        Tue, 04 Nov 2025 17:23:28 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7869a7b978fsm9216057b3.2.2025.11.04.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:28 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:25 -0800
Subject: [PATCH net-next v6 6/6] net: devmem: add tests for
 SO_DEVMEM_AUTORELEASE socket option
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-6-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add -A flag to ncdevmem to set autorelease mode.

Add tests for the SO_DEVMEM_AUTORELEASE socket option:

New tests include:
   - check_sockopt_autorelease_default: Verifies default value is 0
   - check_sockopt_autorelease_set_0: Tests setting to 0 and reading
     back
   - check_sockopt_autorelease_set_1: Tests toggling from 0 to 1
   - check_sockopt_autorelease_invalid: Tests invalid value (2) returns
     EINVAL
   - check_autorelease_disabled: Tests ncdevmem in manual token release
     mode
   - check_autorelease_enabled: Tests ncdevmem in autorelease mode

All check_sockopt tests gracefully skip with KsftSkipEx if
SO_DEVMEM_AUTORELEASE is not supported by the kernel.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/devmem.py  | 115 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  20 +++-
 2 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 45c2d49d55b6..29ec179d651f 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -1,6 +1,9 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import socket
+import errno
+
 from os import path
 from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx
@@ -63,12 +66,122 @@ def check_tx_chunks(cfg) -> None:
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+@ksft_disruptive
+def check_autorelease_disabled(cfg) -> None:
+    """Test RX with autorelease disabled (requires manual token release in ncdevmem)"""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -A 0"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_autorelease_enabled(cfg) -> None:
+    """Test RX with autorelease enabled (requires token autorelease in ncdevmem)"""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -A 1"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+def check_sockopt_autorelease_default(cfg) -> None:
+    """Test that SO_DEVMEM_AUTORELEASE default is 0"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        val = sock.getsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE)
+        ksft_eq(val, 0, "Default autorelease should be 0")
+    except OSError as e:
+        if e.errno == errno.ENOPROTOOPT:
+            raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+        raise
+    finally:
+        sock.close()
+
+
+def check_sockopt_autorelease_set_0(cfg) -> None:
+    """Test setting SO_DEVMEM_AUTORELEASE to 0"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 0)
+        val = sock.getsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE)
+        ksft_eq(val, 0, "Autorelease should be 0 after setting")
+    except OSError as e:
+        if e.errno == errno.ENOPROTOOPT:
+            raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+        raise
+    finally:
+        sock.close()
+
+
+def check_sockopt_autorelease_set_1(cfg) -> None:
+    """Test setting SO_DEVMEM_AUTORELEASE to 1"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        # First set to 0
+        sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 0)
+        # Then set back to 1
+        sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 1)
+        val = sock.getsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE)
+        ksft_eq(val, 1, "Autorelease should be 1 after setting")
+    except OSError as e:
+        if e.errno == errno.ENOPROTOOPT:
+            raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+        raise
+    finally:
+        sock.close()
+
+
+def check_sockopt_autorelease_invalid(cfg) -> None:
+    """Test that SO_DEVMEM_AUTORELEASE rejects invalid values"""
+    SO_DEVMEM_AUTORELEASE = 85
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    try:
+        try:
+            sock.setsockopt(socket.SOL_SOCKET, SO_DEVMEM_AUTORELEASE, 2)
+            raise Exception("setsockopt should have failed with EINVAL")
+        except OSError as e:
+            if e.errno == errno.ENOPROTOOPT:
+                raise KsftSkipEx("SO_DEVMEM_AUTORELEASE not supported")
+            ksft_eq(e.errno, errno.EINVAL, "Should fail with EINVAL for invalid value")
+    finally:
+        sock.close()
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx, check_tx_chunks],
+        ksft_run([check_rx, check_tx, check_tx_chunks,
+                  check_autorelease_enabled,
+                  check_autorelease_disabled,
+                  check_sockopt_autorelease_default,
+                  check_sockopt_autorelease_set_0,
+                  check_sockopt_autorelease_set_1,
+                  check_sockopt_autorelease_invalid],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3288ed04ce08..34d608d07bec 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -83,6 +83,10 @@
 #define MSG_SOCK_DEVMEM 0x2000000
 #endif
 
+#ifndef SO_DEVMEM_AUTORELEASE
+#define SO_DEVMEM_AUTORELEASE 85
+#endif
+
 #define MAX_IOV 1024
 
 static size_t max_chunk;
@@ -97,6 +101,7 @@ static unsigned int ifindex;
 static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
+static int autorelease = -1;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -890,6 +895,16 @@ static int do_server(struct memory_buffer *mem)
 	if (enable_reuseaddr(socket_fd))
 		goto err_close_socket;
 
+	if (autorelease >= 0) {
+		ret = setsockopt(socket_fd, SOL_SOCKET, SO_DEVMEM_AUTORELEASE,
+				 &autorelease, sizeof(autorelease));
+		if (ret) {
+			pr_err("SO_DEVMEM_AUTORELEASE failed");
+			goto err_close_socket;
+		}
+		fprintf(stderr, "Set SO_DEVMEM_AUTORELEASE to %d\n", autorelease);
+	}
+
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin6_port));
 
@@ -1397,7 +1412,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:A:")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -1426,6 +1441,9 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'A':
+			autorelease = atoi(optarg);
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.47.3


