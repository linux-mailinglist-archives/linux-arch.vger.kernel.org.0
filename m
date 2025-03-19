Return-Path: <linux-arch+bounces-10940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E3A6812A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC2D1740E1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A191B95B;
	Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gMn0Gk81"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A13595A
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343342; cv=none; b=Ielk8DEBjwEWsBTag90VZbrg+82UCXqzhdHcigFYVsrxuqi9rVYTVISb/OHYrRF9YGgSY/XoDPFBEw8ynqLIaPzHVdyjGEQXsaxiZ7cT1IXWfn4oAwJX9cw/KVE/rjgqyPJKcnx+HRoIbUXKVGzhQ2zu4om/19F5jLNeg7y3yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343342; c=relaxed/simple;
	bh=zDwqRePv1ZFUDi9FjMPQDVKfJ1n1RRe7hhmBOVzyCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzcWg8nyIcqtQDUlAH43sHg7WMEpNHXYSA3as7yVV+V18OLR3E9p2hd7OoQ5jRIii3rbORFJrnggcyJRzJb9gd+HlB9vG/RY+X34CJRKujUv6r1w2QHIGmASe5XAEQXNUt2C2VscbWKf8QDIgjsNTTYqRORT9AtiQ5JVus/nPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gMn0Gk81; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff64550991so4886606a91.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343339; x=1742948139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=gMn0Gk81p6q/vZ4LGycCtV8PrWqmKL2X2+1X7JUYuAk7MxmnWIJuOfblGJYKzH1qHS
         NHGtmlgyX/4nIO0x+NDViqz93DL2F52q8hztCpCwajF3yIzTdhN8LJJc8uSXOkRRSbyx
         r8JDzvsMP8tNb3e/DiHLdTjOx59RF5ciEg/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343339; x=1742948139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=Xu5PigikwMZtTBtGz1OaY6FW5VqUjBjDJkMZwNP4Yp/mIySAuSDlygrNfR54Z0bOjq
         bbEwWTgsmm+vlr6NbM4SQPcb88QZQqp/I0WCFvfY7dJDbFAV/xaD6rXL5wID/Uhp0qRz
         lRjWJ32BicCTsY6pFBE6FEdNIuoI2SuoyOx0Cw5WqZ3QkVcbywqc0/RHCt8lwVTmU8bR
         ad3Qy6dY6SAd7uLbTRD2SoKbQ6kEnETSCnxvwMPT/zEykNTlPQ8gkzOnFhegO3zYK3Dj
         YyVmqnr8AoS5rucVtW3bveTB6Vlchx9WPOz0ojQnK6ZRHXwGRVKjWyV5W+5t6yRgD2p6
         zkkg==
X-Forwarded-Encrypted: i=1; AJvYcCUaLVHXT24Cmv9vazhwRfZ0kjDgR865x40ybKYDGqf+2wI7YvuAULCVefNnaat/hbdy12t1kB8FN3YQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxit1FvdmKNmJwZols1gZfps+qnEe5bTtQ8l3OEyTA2nkgZTPJb
	rpqF8gnW8OWbT6GvAZuddkVL0K4CHWQbpIZCvh+uv8AbD6RH6sO/FMfvp/0TcgQ=
X-Gm-Gg: ASbGncv075vfIQh6fOJneZN5b+g6SkevYVrSjARx+1qAvvklp976Q3EyKO2/szcZI70
	SNu9pAoAjTaQkTkihK8NU2j3SdLWzzzQ20LgnqTPBarHhn4UkADcKg6qaQomiwgVixkPyScz6fq
	XjsypHxSJsXoI7SmgkRWSz/M+U7TLKwYtOxTPJ7zwZAXlh7eXTnL4fTAdeK2KNhc+GFEQgAgMu+
	yndzjh9D6gIvUYfJDgkaW6sxtwmmMBRhOePzIxV0d0EiIo4EI4ZrDnQv7byfDR8NaCPZ6/cuktr
	NQbE/g1kG0k+mWpUUzdnDXLmfTqWqNtVh1khnC9x45mJRDNtqmyJj9hAyIVhg1M=
X-Google-Smtp-Source: AGHT+IEnc6PYsekT6MewbYE2xz5zbksEbwPRypdKB1fVzKJg+O8NyDF3d1M1ZZ7rEg687HtSnDkx0Q==
X-Received: by 2002:a17:90b:2f44:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-301be204e8dmr956493a91.30.1742343339529;
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
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
Subject: [RFC -next 02/10] splice: Add helper that passes through splice_desc
Date: Wed, 19 Mar 2025 00:15:13 +0000
Message-ID: <20250319001521.53249-3-jdamato@fastly.com>
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

Add do_splice_from_sd which takes splice_desc as an argument. This
helper is just a wrapper around splice_write but will be extended. Use
the helper from existing splice code.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..9575074a1296 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -941,6 +941,15 @@ static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
+static ssize_t do_splice_from_sd(struct pipe_inode_info *pipe, struct file *out,
+				 struct splice_desc *sd)
+{
+	if (unlikely(!out->f_op->splice_write))
+		return warn_unsupported(out, "write");
+	return out->f_op->splice_write(pipe, out, sd->opos, sd->total_len,
+				       sd->flags);
+}
+
 /*
  * Indicate to the caller that there was a premature EOF when reading from the
  * source and the caller didn't indicate they would be sending more data after
@@ -1161,7 +1170,7 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 	long ret;
 
 	file_start_write(file);
-	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	ret = do_splice_from_sd(pipe, file, sd);
 	file_end_write(file);
 	return ret;
 }
@@ -1171,7 +1180,7 @@ static int splice_file_range_actor(struct pipe_inode_info *pipe,
 {
 	struct file *file = sd->u.file;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	return do_splice_from_sd(pipe, file, sd);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
-- 
2.43.0


