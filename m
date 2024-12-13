Return-Path: <linux-arch+bounces-9385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABE9F06D1
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 09:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430BB282C5C
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE91AF0B9;
	Fri, 13 Dec 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejl8/pF7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307F1AF0AE;
	Fri, 13 Dec 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079546; cv=none; b=r9qlGafH8zFHgRMROJbH4t+mIW8Z51SSJz8gdCXJE1B2YxwKhJ1bnLLZYXMDupR6CwqYiZ0pyxx3B61togQUWyChTF2BBK8cJtGD+xPTtdWUvWFdOfR9gazvJD1X+jHUdIzxZP0z4DltJfjMFU8p1DzQXFNsYo0ss/gzzQlqGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079546; c=relaxed/simple;
	bh=bKHfseLrLFam+t0l4K7cSgf5MpnHwyP6kMNZLJ8EnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxgQfHkBYSEg54wvmEkJpwXTK1yL766YFqdo/5GWsRokc4TB+3L9Di8L9SWs6IgRbphAjp18RuTIo00i1WZemZiMnVcLtvTxlkDBOb8tXP2L9eSF7Sy4jQUD7ZfomJkxo2qi0zskV9UzzUNYD28yQnJTJBEB+gZIenT0VnyaJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejl8/pF7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436281c8a38so7570525e9.3;
        Fri, 13 Dec 2024 00:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079542; x=1734684342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wy+YHf2E614t23hlQRqaAuPuP0RfmetGDSjCxDtFm8=;
        b=ejl8/pF7Gegjk72RzgxkSdBbtaM+1Wp6tEXVdZfD9Ma/LEGNOrdClQ9BgiSrqx6ztU
         OeKL1JMSg8HbY1My3RICis7ltJZxCMdt1CzEz8EcMtfxnGeJshA6EECYHtZgkD4D9AFw
         tNrYtPKCXu+Keva43VDFYE1w0aWra2qSigf3+BhBL/NGTiUIi84hMxroznBLJSxS4WLK
         laNdJ55nB9rdU1qm3uzBYDnJMAa47nP0LUYH5IGDb5RqVcHwYOKTS+0F66x6RjQI6LA/
         zHzdJDAq+0s/ckhYVbRnxW2AIJrMrYlLBAn4j2JqQfzbb44cHiui3u/fcncIb3UpvJ6l
         nrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079542; x=1734684342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wy+YHf2E614t23hlQRqaAuPuP0RfmetGDSjCxDtFm8=;
        b=HLGU6Z6TRNIDKcVd4JF2bXaQJBmCmlRwV61BLdff2GROfKAryA/ocilwtv9EL1E+y1
         LtdXLECGI4/6twXbX9NATYB8LWO2bOqF0ox6cIXk7p1YWVJbnCC6N3vlGyNk2p4LI2uh
         Bk1BNc7FFOcbs1isJlo+mqeu/gX4kUvvzFV1TaEeRZ9rQr5upEosOAS5bHOoZuEJ9O73
         PyUh5F7kk8R6Vn4t+cB5CpDVn8QrJt7zcU0wWlmrvexni4tc/L5sR4jbHMtV0nJHyck5
         twH9+OCuqSK7EyDlbMAyzDftvc9x5GUIyJaQ3fSt4J0bHrYAGHfbstuGzzhQksfBXxpo
         VdOw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+fCzbpm3xlsmZGIYvmaAdGVgvQRj7iQvtJz+0E+MHDOb2/dElixqq1pw9qY2t1khiBJzf8O2se6smR1T@vger.kernel.org, AJvYcCUT45oj2kTrxIIm7jCUG7AL5ZuHBqoL5ozOaLn5bDloNFAnCSlqPJs/K60tvkbr0n4EpSfKE2Md5QNcjg==@vger.kernel.org, AJvYcCUd0vPpirqF/JTNBIBMcNsPsSKVMoMruN2/HUZHai6bsB4TYgyJZlms+K7mo5aFItv0ZIX0dkUXLqPD@vger.kernel.org, AJvYcCUxTKUU9Zp6hTjSvelblLMBmEe5o3paBlQrRfxyzdTUEo3UeztdostNXHJQl7Es9TFQjPZHHmlnjKGReA==@vger.kernel.org, AJvYcCVCVBIED9z/68mpHuoA4p60a+y+dzsQM8wW43AX7HwfqqDYvhrS9w0VQcLKO4SeBnpG0QJcDIQ2faNFOw==@vger.kernel.org, AJvYcCXctg1UrifCnXGu49FEmzeEcQlZBeccoB3EeQm68znGHGZnvOUEXDLt0fKsEpBeOH58QkC4yl1caXPNorURMms6@vger.kernel.org, AJvYcCXejwd42gPiB+joTt6OEZpPk7gAGFgz/AhbZE8Y+lobvxUFK9O84TN81W2J/GIxovUBj+nH6HdB7MOfiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZH4dUM3sjb0/M54wvw1HqlPWW+nVvw7MCc/dh29Kc+aLeyDp3
	0Ty9mgnrmc897Rhz8RRnC5HF+DMt4Ng5xOV/+McTyT+bJpzzQEBpwrxZ/oorIio=
X-Gm-Gg: ASbGncs8398qdHKWr4sL6A8KOPfvVYqo+uSAOcPfdx36req4obmLFIQpsMCpzoIftXU
	P/L8s5WPURqSkWM61Zln5IlP7dBncCH3d6o56i3menxHUMigvbV/xtopAU8hD5GbnucOvIj3Ns3
	nO+mthzegGPbxr0eYSjnkcmFuaYZaKwwzVuRVI2ypGGOtn8iqFJS+BCTIC+buNepwq/4zUoiU79
	1Z3LaeQpZvG+edm8BM82STObWgZbMyxiSKP8sLOzvkyKeApPeeFjjs2GZ9rEtTpJOTbkHpZpj7G
	sSp1U4okno3Yv5QcUIwsdk5nGkuRT/QIciQ709sIraqRUkWNMEJOBZLcdU3sYvQ=
X-Google-Smtp-Source: AGHT+IGTU+lhc2lWa5575ClokcDUoOVQuXcljdePkNZ8VtH/nBtJO1u/jxwEfj0Q47P8NpjHVdg9Xw==
X-Received: by 2002:a05:600c:a10:b0:434:a59c:43c6 with SMTP id 5b1f17b1804b1-4362aaa4c0cmr10082605e9.26.1734079542232;
        Fri, 13 Dec 2024 00:45:42 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E9B09007B50BC12F2E5C1B6.dsl.pool.telekom.hu. [2001:4c4e:1e9b:900:7b50:bc12:f2e5:c1b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eaf6sm42487645e9.20.2024.12.13.00.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:45:41 -0800 (PST)
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
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v7 4/4] sock: Introduce SO_RCVPRIORITY socket option
Date: Fri, 13 Dec 2024 09:44:57 +0100
Message-ID: <20241213084457.45120-5-annaemesenyiri@gmail.com>
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

Add new socket option, SO_RCVPRIORITY, to include SO_PRIORITY in the
ancillary data returned by recvmsg().
This is analogous to the existing support for SO_RCVMARK, 
as implemented in commit <6fd1d51cfa253>
("net: SO_RCVMARK socket option for SO_MARK with recvmsg()").

Reviewed-by: Willem de Bruijn <willemb@google.com>

Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 arch/alpha/include/uapi/asm/socket.h    |  2 ++
 arch/mips/include/uapi/asm/socket.h     |  2 ++
 arch/parisc/include/uapi/asm/socket.h   |  2 ++
 arch/sparc/include/uapi/asm/socket.h    |  2 ++
 include/net/sock.h                      |  4 +++-
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         |  8 ++++++++
 net/socket.c                            | 11 +++++++++++
 tools/include/uapi/asm-generic/socket.h |  2 ++
 9 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 302507bf9b5d..3df5f2dd4c0f 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -148,6 +148,8 @@
 
 #define SCM_TS_OPT_ID		81
 
+#define SO_RCVPRIORITY		82
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index d118d4731580..22fa8f19924a 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -159,6 +159,8 @@
 
 #define SCM_TS_OPT_ID		81
 
+#define SO_RCVPRIORITY		82
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index d268d69bfcd2..aa9cd4b951fe 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
 
 #define SCM_TS_OPT_ID		0x404C
 
+#define SO_RCVPRIORITY		0x404D
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 113cd9f353e3..5b464a568664 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -141,6 +141,8 @@
 
 #define SCM_TS_OPT_ID            0x005a
 
+#define SO_RCVPRIORITY           0x005b
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 316a34d6c48b..d4bdd3286e03 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -953,6 +953,7 @@ enum sock_flags {
 	SOCK_XDP, /* XDP is attached */
 	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
+	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
@@ -2660,7 +2661,8 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 {
 #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)			| \
 			   (1UL << SOCK_RCVTSTAMP)			| \
-			   (1UL << SOCK_RCVMARK))
+			   (1UL << SOCK_RCVMARK)			|\
+			   (1UL << SOCK_RCVPRIORITY))
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index deacfd6dd197..aa5016ff3d91 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -143,6 +143,8 @@
 
 #define SCM_TS_OPT_ID		81
 
+#define SO_RCVPRIORITY		82
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index a3d9941c1d32..f9f4d976141e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1518,6 +1518,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_RCVMARK:
 		sock_valbool_flag(sk, SOCK_RCVMARK, valbool);
 		break;
+
+	case SO_RCVPRIORITY:
+		sock_valbool_flag(sk, SOCK_RCVPRIORITY, valbool);
+		break;
 
 	case SO_RXQ_OVFL:
 		sock_valbool_flag(sk, SOCK_RXQ_OVFL, valbool);
@@ -1947,6 +1951,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sock_flag(sk, SOCK_RCVMARK);
 		break;
 
+	case SO_RCVPRIORITY:
+		v.val = sock_flag(sk, SOCK_RCVPRIORITY);
+		break;
+
 	case SO_RXQ_OVFL:
 		v.val = sock_flag(sk, SOCK_RXQ_OVFL);
 		break;
diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f..79d08b734f7c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1008,12 +1008,23 @@ static void sock_recv_mark(struct msghdr *msg, struct sock *sk,
 	}
 }
 
+static void sock_recv_priority(struct msghdr *msg, struct sock *sk,
+			       struct sk_buff *skb)
+{
+	if (sock_flag(sk, SOCK_RCVPRIORITY) && skb) {
+		__u32 priority = skb->priority;
+
+		put_cmsg(msg, SOL_SOCKET, SO_PRIORITY, sizeof(__u32), &priority);
+	}
+}
+
 void __sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		       struct sk_buff *skb)
 {
 	sock_recv_timestamp(msg, sk, skb);
 	sock_recv_drops(msg, sk, skb);
 	sock_recv_mark(msg, sk, skb);
+	sock_recv_priority(msg, sk, skb);
 }
 EXPORT_SYMBOL_GPL(__sock_recv_cmsgs);
 
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index 281df9139d2b..ffff554a5230 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -126,6 +126,8 @@
 
 #define SCM_TS_OPT_ID		78
 
+#define SO_RCVPRIORITY		79
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.43.0


