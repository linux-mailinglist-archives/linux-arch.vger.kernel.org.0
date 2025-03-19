Return-Path: <linux-arch+bounces-10945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DDCA68147
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA0425402
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1831C1F13;
	Wed, 19 Mar 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LdwLkSF8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58941B3927
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343350; cv=none; b=B7BfHPxmQV6iAPToSzQqN+VuwCtOl7DRpTTL/PBxvfGPizmNNChOpF6ioLSM8XxLHY2WwHABtkVNBz0i6M9WOQp/DRWrEacRDPICXh2f1EzVcdzPg6xHtwAqo2/W1DWxJUUXOMKxmbfjqYSFY0edx3mXy7VF+jJCE5irEykjANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343350; c=relaxed/simple;
	bh=vqb5bSp3KtgrIHH2C10i+ZCVORS25O8aQdSoxaGrdX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+QhHAJMcaUN0aAjfEvATAN1HC+UNFS4di7zPbwOAIz0ESlTKt5ofm02RgUR/G8jzRmZdQbL/dhbx2bOmzsD6oI1lGGIlQYkNkFgTw9pzRnj0grIiFsoAVBmVpY6VkWfKdPMwnbQSV5kW+QT55YRGWSM7RfdL+CwnLQQeY5E6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LdwLkSF8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2264aefc45dso2444965ad.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Mar 2025 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343348; x=1742948148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XqGZqCGsxMqM6QeHlFNqgLyn7L0jWSrp5tLsnvgx2I=;
        b=LdwLkSF8TBzC36dt6CntOhHl+LeUMOlyXozok9/QMwsLzJCbZQtUiV5ZsMTPkYtqcJ
         4vcWfNjrYyGyxoOe5/0cRUNiClXg+CCpU+5N+tyoxTI6DfO2pupR5WhY5mA3NEiF58ul
         8MrOhgdbfV7a7Eii7fwAIIFWtUdit226D4msI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343348; x=1742948148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XqGZqCGsxMqM6QeHlFNqgLyn7L0jWSrp5tLsnvgx2I=;
        b=MPlFTwZBTMjak0z0qpxNvifaTtzXjEioW2Pn7XeHfhqXO4I7bgBetV0WK8sSLd8Qt7
         Wjbj0aQN8nUdX1JyU/KNGm3AOGKGRqN2CgxQqOrUekaS8wD/gW45i4M0vLqtkbotpLn3
         Nqaa770+8XeNQa1GOzgpBJOsTn1MOlu9isZF2zocXEUfKtt8l1ugWPNT4vgwgWXeLvpn
         MA9sJ++OdjL0ME7s4B+9WE9zFq/pWrCf4ah41SpnZ9zqBYJva8eYCXat2sFuoQOYcUqf
         N/dx4Asy8DRjGVPc+AUXBSbkZYInKWv41SngGmFIqG935qzvRPCbpPRjeAXJb+4SBL+S
         NjLA==
X-Forwarded-Encrypted: i=1; AJvYcCUE72/eLENpNrY/rQoR0yRByA+0GKEOiL5pBkpXeQDl1L78396X/mr0rHbZTEyTmJaCv73RSnhYMi4u@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeQoKXQrG4uI/g2bmfqtemC6/oLl64HVSy1OOI773s1SVca1V
	ac3HI+aFneAoagdj2BqnZeufRmTrbiNnIJLLXn0oH95uaJP53bXLcxEXU3+Dx9k=
X-Gm-Gg: ASbGncusaImGKwj+QD7HwExyK5rvMZzKi+ZVnwrENIUXn4diNvvveMHPRWHCZgBhtnt
	jRO4YQqqA1ZM4eqfOD/vcUrnhjXio1eMI1MkUZ3yWDGzkJTrjssveuJXwup5f7h8UsPQ+9AwtX4
	HaeqoGJlLmp1rAdUbyrHP5FqeMk9mu920JJFoiqq9B2ncRoB37Cl+MDIZtcVhTb/qIj7cqRE1Nb
	TjajY/j7GF8VeEuajy3F7Bjh2LIIyps4HHKTZ7TSs630EQY81ekr7IHet71HOSD/W7PbiGLQsgu
	nSx15HYXdsZ/1nlEfOd2ACvr5TIpyWei02sjsioTVqPSftXs66++
X-Google-Smtp-Source: AGHT+IEmJYpbp+6vVhqsiGvsZq35cbhyVslRXzs04bm/SNmdXK2RzQx72NbvXgQ96Ga+Vw4Kk+NJMQ==
X-Received: by 2002:a17:903:22cd:b0:223:58ea:6fdf with SMTP id d9443c01a7336-22649a3c6a7mr8745335ad.28.1742343348190;
        Tue, 18 Mar 2025 17:15:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:47 -0700 (PDT)
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
Subject: [RFC -next 07/10] fs: Add sendfile2 which accepts a flags argument
Date: Wed, 19 Mar 2025 00:15:18 +0000
Message-ID: <20250319001521.53249-8-jdamato@fastly.com>
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

Add sendfile2 which is similar to sendfile64, but takes a flags
argument.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 03d2a93c3d1b..057e5f37645d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1424,6 +1424,23 @@ SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, si
 	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
+SYSCALL_DEFINE5(sendfile2, int, out_fd, int, in_fd, loff_t __user *, offset, size_t, count, int, flags)
+{
+	loff_t pos;
+	ssize_t ret;
+
+	if (offset) {
+		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
+			return -EFAULT;
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, flags);
+		if (unlikely(put_user(pos, offset)))
+			return -EFAULT;
+		return ret;
+	}
+
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, flags);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd,
 		compat_off_t __user *, offset, compat_size_t, count)
-- 
2.43.0


