Return-Path: <linux-arch+bounces-10946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A58A68151
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02954164C14
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BA1C8FCE;
	Wed, 19 Mar 2025 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Fgfu4GvO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79D1BFE00
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343352; cv=none; b=CtZmnz4IrNcp6Q0tNP7l44tTMgm26HJntUik3V0usD+R34jfsGYyXMhQ1VTXSxkxI6gCLuj40sOsJBWuiLtu7mJ/nTclqOaNUfDRpf2gN46uvSmmxo3FCPMv+v2wcLM4Yh7zLEMuo6rk8J1ailHra8qKNdLLjmMjaHXdiFZDMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343352; c=relaxed/simple;
	bh=vfmaI48yQu2LzbBRsfUKYj71ya/2pybugWom3+MlAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moERBfz5N+JGJb26OoqKZXgEkmdqKM6K4fyWV3hYULs3KiT9G7IcmoWb5/rXBWCOUzNPQhBeTZuvqhU0bDqZ6EQbO/s2aSaVkjg8/dB5AmEP4YiQTbvmYRFunyR+eMYOjausdlNfSbdLpowl+uGwfyV15SZy4SbvJ5kbHuq0L0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Fgfu4GvO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22359001f1aso7642575ad.3
        for <linux-arch@vger.kernel.org>; Tue, 18 Mar 2025 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343350; x=1742948150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2h8ahGEK8NaWNEbWiVu/ZrnscNwqcwDayJj5C9lFzM=;
        b=Fgfu4GvOW7stKhQu5e7z9IC/Nv0oQmJEqDAVI/BLiHzM8QdXiSjIqaUlpvskDPWngk
         M4Hhz1GrWXmXi+HYbhJImPSMiUnprJifoEwOxFpvOZAdYtnHrcj830d1SNiEyFw5h2uP
         z0OEH0Ld/35wCgYMxFW3HKiDEMZ3tg9kH47Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343350; x=1742948150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2h8ahGEK8NaWNEbWiVu/ZrnscNwqcwDayJj5C9lFzM=;
        b=qDky8ivuLJoyeRQV60a305oYVq5LEyY76kyes6YG1ey8f2eJqw0PPDV237f0HZ3F/+
         Rfmu8H3X0proetzRizP8fclVUca1IryujAqMm2P2uOKT7h5J7a9XAfez5ZXebtoSrVTK
         Bvz4z1zF1QstdYSshshdhnoIBPici42TlvnWTe+fKEeomeUqhQPsvQmAfWTbf2QDUxy3
         dByZG07OH+HjzPZCFigZE03sna5Zq8y3TyL32tVjGCo3ChksJwOHuTmkLK2g2xYOQKmy
         ndCQhUYAUei2WqkWu04shUg4PKoY6bPKLLOb2USYCn2DcR47FxWidkseVoB9PC6ArAgN
         agDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDMSdiLeRpXAQ9OiaN3uXjh0+MZwcv2IP7i58CYpK6tgobiTO4Yc6AjwW3yZjBRkHYJwnfirHlmnfd@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsaTNp4Y8M+OYSs0XK187cmgqapeB78Xi/Kgbq0BuGTe04cVl
	OBemFcmMevNddhNhdvVB4uWC21d9jO06RoNGvR9UpScX5SmKxIAiADpgCyjxgL8=
X-Gm-Gg: ASbGncsrHmSzAl/O7ALedAB2G3AhZ36MlWaCxbeCERUHE+8Kd/aNs1/PZYA8foUklVX
	CgDp/qmkx1wIiD+XFzvNIG6g2rrjWXRNjCGm+H1QgOF91B6F+Mn3VTdtuGoZSWbQXAtazspUfWJ
	Pmn9/jFb9SlxXZzB1I3eCoAT+KFh4MOAPAhoR+DRmpYSP4/suOLqRDrb0JCZithpKw6Q12iOP2t
	u/Swi75du1H52D73pvxs/0K59v5gpOE4JCoUfdmRobl/vNHsfNcqjVhtywC1M272dituE16WTT7
	qNKPIFRaD1QcP2/ffDfL7QdO5EvEKzxOscE68XgRsE+JaK3+uXhj
X-Google-Smtp-Source: AGHT+IGTEGf1f8q+q48T1ikUY+fDbR7xEVmvuzHJIMrxwMpGrnPzwUvPjVZv+TsZZ6BX0OHQ1CwSDw==
X-Received: by 2002:a17:903:22c4:b0:220:faa2:c911 with SMTP id d9443c01a7336-2264992ff63mr9690915ad.14.1742343349888;
        Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
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
Subject: [RFC -next 08/10] fs: Add sendfile flags for sendfile2
Date: Wed, 19 Mar 2025 00:15:19 +0000
Message-ID: <20250319001521.53249-9-jdamato@fastly.com>
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

Add a default flag (SENDFILE_DEFAULT) and a flag for requesting zerocopy
notifications (SENDFILE_ZC). do_sendfile is updated to pass through the
corresponding splice flag to enable zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c          |  5 +++++
 include/linux/sendfile.h | 10 ++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 include/linux/sendfile.h

diff --git a/fs/read_write.c b/fs/read_write.c
index 057e5f37645d..e3929fd0f605 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
+#include <linux/sendfile.h>
 #include <linux/splice.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
@@ -1360,6 +1361,10 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
 		if (retval < 0)
 			return retval;
+
+		if (flags & SENDFILE_ZC)
+			fl |= SPLICE_F_ZC;
+
 		retval = do_splice_direct(fd_file(in), &pos, fd_file(out), &out_pos,
 					  count, fl);
 	} else {
diff --git a/include/linux/sendfile.h b/include/linux/sendfile.h
new file mode 100644
index 000000000000..0bd3c76ea6f2
--- /dev/null
+++ b/include/linux/sendfile.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef SENDFILE_H
+#define SENDFILE_H
+
+#define SENDFILE_DEFAULT (0x1)  /* normal sendfile */
+#define SENDFILE_ZC (0x2)       /* sendfile which generates ZC notifications */
+
+#define SENDFILE_ALL (SENDFILE_DEFAULT|SENDFILE_ZC)
+
+#endif
-- 
2.43.0


