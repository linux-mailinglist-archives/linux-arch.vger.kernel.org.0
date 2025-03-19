Return-Path: <linux-arch+bounces-10941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7DA68131
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D13BD973
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F116D9C2;
	Wed, 19 Mar 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LNZH3qR1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF713EFF3
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343343; cv=none; b=YHs7TlmE6YBMOLzkoYPu79ogWmrrJEBQvpn9B+ts9K/OHvUVd/KUREzESYwvVaO5C0HUgmKYkISgruA68Twkp9RUdjOn6DcUNQuGfv2GK69kAiq6tJCQ1zLelXlsKpOCMR/ZNmHTHGhfULGRjYb0XMY2i2pGZrX18/Vf4L3dcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343343; c=relaxed/simple;
	bh=4XmeV+SwsUckbKoljf1imPQeQxED4NvPOSxU0C/rldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxKEcTmv4l1Fr9av2Zxaoub///X9xmZ0GX2lXrfELny+vZgxlFs5yKb2A3O7XyeMd1JBxk0in/zy3Bape0n1yCmYuiggEKyNZhWwFoiuVRSckYBU7+IMa91csLRhTw4wPF5KwCq5qcHPV/PneGW+m87T06vmlPJ4bmkRbbowfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LNZH3qR1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22580c9ee0aso108908445ad.2
        for <linux-arch@vger.kernel.org>; Tue, 18 Mar 2025 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343341; x=1742948141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js3UD04AvSWxrN9RHcwFb61ujoiYEshPhpsTiZDgHgM=;
        b=LNZH3qR1uWFDzF9bQC0jRqVCxBj0XhnnQKxLQt53RWWbP9Ddo4X5mxjbDYeRlz2b8g
         x92shF+UhIOeahYVFcSmf9FaeuocEomstZDZHCQEL0sYgMlcbxhXxMb5QxYWnWuET5MM
         xadfXaJoHP5VER3ZT3b4hxYUwe7HeFijMPl14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343341; x=1742948141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js3UD04AvSWxrN9RHcwFb61ujoiYEshPhpsTiZDgHgM=;
        b=RO4fe+25lqdZZAkgfwTEI42atUN07FR0ym7NDCLatBhm+9o7ZXcAR3TxKl0N+VChrX
         LoqcXCk9m0eG4FEpyQ1K48XOI/YdtA+UFUzPFAY9J934EUfthQttM9w4/Bov6gcTA2MX
         Wvn8IRkWGHsLEUL/4rHbaEMmzqOaiqliAZRXJxSKTa7J0dsIahR3yN3XLTgT3VdvFa7c
         LKxT4beo551qNNoldWPgA6/A/C3op+BjFh8457sXflvdXmsKerEEyqLasH1/v1aqcfwL
         teEXnuBU2w+FoTV1DC8EF4zkpGyT11B0f1EXegTploe+cBJNG3cqB9DTGOOH4nOWOB9C
         /tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVma4sjlRLC5YHpxf1uI+gTlZitqsg1IONoeUKEhq5bhPcd+LiCRPsz66xfw+1LIlFY4WGbYMnRA9/V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzucw6P6DkSoAmfb+i9sHkimA2v9ZiZqOxHAL09Y3kmr0I2o5/a
	wi/Z3zA/9a5BQ6EL8Io9FZ2ByGValVPr+kAN/j7100uko34LiS1ufifmIsKKI0g=
X-Gm-Gg: ASbGnctTmLjyyvpH/IWoK1bUHPGoI3iR+qvdcIWmYXhZeFiY5Lie2MjqQN11VQaQ7lr
	UnEcZmcODmcaNrTLymO0QgrSyDeOpaDQhm8iKGNpe7rzayTz1GKoZQrNiml5yYrVug7m6Kx7K0q
	Spi3StZ6kpuOGqcDtKCLPWzdAPZk/0Lfzt3IQIMxrLHWx0dlIey+3zJ8rC/TjS0ST8Ohd7ICfhi
	VzTvIvdLgwJYon2zuULcS32CfkEgzh7qjWSFgybIyDKez3X85NE+8VsQ7LjuuBd+qhqRiyJYyoe
	5JyXhNTllsVbfztTg5A3dBP2WmZdDpNUUH4uq5dR4Q5h6432bOOluwxvPxfFUV4=
X-Google-Smtp-Source: AGHT+IH7oXUPwBlv8OzKX6l4S7tFotTPIWvWoF6rpoUJjb85+9JTpVERsJIAUNLcb6oCGgVeRTkFdg==
X-Received: by 2002:a17:902:ea07:b0:220:fb23:48df with SMTP id d9443c01a7336-22649caa9ebmr8193745ad.36.1742343341302;
        Tue, 18 Mar 2025 17:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 03/10] splice: Factor splice_socket into a helper
Date: Wed, 19 Mar 2025 00:15:14 +0000
Message-ID: <20250319001521.53249-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

splice_socket becomes a wrapper around splice_socket_generic which takes
a ubuf pointer to prepare for zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9575074a1296..1f27ce6d1c34 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -37,6 +37,8 @@
 #include <linux/socket.h>
 #include <linux/sched/signal.h>
 
+#include <net/sock.h>
+
 #include "internal.h"
 
 /*
@@ -783,21 +785,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 EXPORT_SYMBOL(iter_file_splice_write);
 
 #ifdef CONFIG_NET
-/**
- * splice_to_socket - splice data from a pipe to a socket
- * @pipe:	pipe to splice from
- * @out:	socket to write to
- * @ppos:	position in @out
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    Will send @len bytes from the pipe to a network socket. No data copying
- *    is involved.
- *
- */
-ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-			 loff_t *ppos, size_t len, unsigned int flags)
+static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
+				     struct file *out, loff_t *ppos,
+				     size_t len, unsigned int flags,
+				     struct ubuf_info *ubuf_info)
 {
 	struct socket *sock = sock_from_file(out);
 	struct bio_vec bvec[16];
@@ -920,6 +911,25 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 		wakeup_pipe_writers(pipe);
 	return spliced ?: ret;
 }
+
+/**
+ * splice_to_socket - splice data from a pipe to a socket
+ * @pipe:	pipe to splice from
+ * @out:	socket to write to
+ * @ppos:	position in @out
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    Will send @len bytes from the pipe to a network socket. No data copying
+ *    is involved.
+ *
+ */
+ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
+			 loff_t *ppos, size_t len, unsigned int flags)
+{
+	return splice_socket_generic(pipe, out, ppos, len, flags, NULL);
+}
 #endif
 
 static int warn_unsupported(struct file *file, const char *op)
-- 
2.43.0


