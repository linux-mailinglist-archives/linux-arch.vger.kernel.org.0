Return-Path: <linux-arch+bounces-11114-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1CCA705F0
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 17:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F547A62F3
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2625A2DD;
	Tue, 25 Mar 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvM8Zca1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C921D3F4
	for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918506; cv=none; b=VZHMpDJG5X679c716/TjCY4euQFHW9jCUQk+jmb5N8GHHAcNw8GRfQ4AGhB1G8Y6pOF/yW5iVHAvxYa77Mnmv15vsa+2m4n8HKtMTNhfZBQfc38CDQxL0sUMYSWzSnufMH0iRpBJP1WOD5DQ+IGP/YRelTDeQsa1MCODo4XdOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918506; c=relaxed/simple;
	bh=O2dKRA9uvJbAtmJ8DU5c5NB3nWRxzGZSCc3fQ+OAJwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n7Wtm6s5moorxAXP9fPmSQzMux5ENBSXwpz995fYfdY+HjiJlBESmkPzaj/FQZVvXbGXcskQfjVZkDi8qqcOODoS2lA9KQfyacQEsV6+k8H7/C9p94rHfW1wjxPuomxliFPEeLIzUJIkrVN59udV7n0DrI36fFsRPOnbmazobjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvM8Zca1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso60615e9.1
        for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742918503; x=1743523303; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNLrWaHC+F16KWC7Wcys7gq72QWKKTUqdbgRYbG35Hw=;
        b=FvM8Zca1YHsgXMcg2etmQqR+N6Yo8z0GMYgF3pru4QfLDpGjVPhXGD7yJKxJAjQLbL
         8xKvpVk2YPDKJvIesnZwOvFVVNi7IO33d+grHovsdy8envdPbzvjXfsH3r6JkbiWrWpf
         oWJj3iSVU3EiisP+hvckvEBEuqqoWJofHGAZYwNQX+HdhoB/l0wll9oR6BqJvek89bz5
         +Fyx8FH143ZoR4t0BhNle6VVW9jlhIXcgCnt5/fSJ0fS4dQxAE150EJ8UpgVBwakLGGF
         BZs10Qea5uiI7KcTdik82yHPtREVZp1qjts/BNc/wFJtpSO09dWj7tnOFwD74vslqKaO
         MPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918503; x=1743523303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNLrWaHC+F16KWC7Wcys7gq72QWKKTUqdbgRYbG35Hw=;
        b=rVJEz6dUk67T2gGWx2DSXCipMVelr6sLDLRJdhM1tym7rE4ssMA3k7b3UlNkbpt2ZU
         Q5fSXg3h9QK0dPr5Wz0Rlr0E6s5q/5ruzIHcpGWthgydvkHmG9plYSmrc+vPW1t9GOf2
         WpHcZtePl3nXkuzYhUUkoQ9qUkH5RqeU4NouUlTSsi3rEuMR9JaYmYSasOAdHfFUit4f
         9W0CsKAWPERKjSRJM5UujSUFUozYHwRPwlBEVoCx9Yd5hKrF45JSJQkpcVnpDA8n0XFN
         FOX5HU5wVqIS4cQe5U9VOwaJdIutROxodDg6A/vDyBlk20eblOksnmyiWcBoQYr5fIil
         b4HA==
X-Forwarded-Encrypted: i=1; AJvYcCVdioKucSc+d2cpdQ7v3u7RgbGZTT7CA9Th6neSwlLzRgaMFb3N+MSnL+ERpgsK42MuoRJ7EXoNpQy5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6KzAxtjH2P2e/49Js53nsAE7LuZelYtXxLHbq61jt6oYpT8G
	d43rTV6mwILcwkVeWykjrlRjV4f5YngT7rr/JakdL+AcEAju/JRfB3c23auikQ==
X-Gm-Gg: ASbGncvMhofMGNPxnnjxwUeEZITt1VioLvcf0N9P51t9QG6qq8lFyGgW4FpxwpkoR2e
	PHfgw+0NmmSYuTRpGbC4SsY+wS1MaCj+9JltHLYLgt9d4UjpiXEpBqgmeKfKFesTE7xXuiy9k9p
	bR6gFd2w4Qgb+kNQhcZWjcw4eV/5D7hIOIHMY928MUUuMxrUlEtDFvOk0rtvdhKa5xkLloWyxS1
	2KH0oKvviU9iTZr5VAnUlnr7bWG5mBRZKuh1jMOJ91nUTYEm4ue+KZtOHuimCnIDY5723GTcQat
	OoSDX4jJFiZsA5Eev3vVupkZNxfB80JW2g==
X-Google-Smtp-Source: AGHT+IHsIR3lfUVsohrP4cvxcT+BcBgE15Za3l/+RapEBvyBlFjLjq5LVDT20yOcw4Ik++ZPr0Tzpg==
X-Received: by 2002:a05:600c:1c8d:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43d591c2295mr4838215e9.0.1742918502385;
        Tue, 25 Mar 2025 09:01:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:1e00:1328:5257:156e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdeb6esm204516205e9.31.2025.03.25.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:01:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 17:01:34 +0100
Subject: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
X-B4-Tracking: v=1; b=H4sIAF3T4mcC/x3MQQqAIBBA0avIrBtQw4VdJVrINNYQaChUIN09a
 fkW/zeoXIQrTKpB4Uuq5NRhBgW0h7QxytoNVlunR+vwoBoSljsnYiTvNVsykYKDnpyFozz/bl7
 e9wMgdafTXgAAAA==
X-Change-ID: 20250325-kcsan-rwonce-c990e2c1fca5
To: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742918498; l=2606;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=O2dKRA9uvJbAtmJ8DU5c5NB3nWRxzGZSCc3fQ+OAJwU=;
 b=pD/K1HEzZBcPmL7dDKYAHw7aJiLQxHybO/JPTsCHTVCbR2lbNDnEkZVIXWh7hZC82JiFHIbka
 JyE20sMYsBeCBqqi9VId3Q0s9Ahg7NAmY7BkecpwJtQZlp2u/OebQm6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

read_word_at_a_time() is allowed to read out of bounds by straddling the
end of an allocation (and the caller is expected to then mask off
out-of-bounds data). This works as long as the caller guarantees that the
access won't hit a pagefault (either by ensuring that addr is aligned or by
explicitly checking where the next page boundary is).

Such out-of-bounds data could include things like KASAN redzones, adjacent
allocations that are concurrently written to, or simply an adjacent struct
field that is concurrently updated. KCSAN should ignore racy reads of OOB
data that is not actually used, just like KASAN, so (similar to the code
above) change read_word_at_a_time() to use __no_sanitize_or_inline instead
of __no_kasan_or_inline, and explicitly inform KCSAN that we're reading
the first byte.

We do have an instrument_read() helper that calls into both KASAN and
KCSAN, but I'm instead open-coding that here to avoid having to pull the
entire instrumented.h header into rwonce.h.

Also, since this read can be racy by design, we should technically do
READ_ONCE(), so add that.

Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
Signed-off-by: Jann Horn <jannh@google.com>
---
This is a low-priority fix. I've never actually hit this issue with
upstream KCSAN.
(I only noticed it because I... err... hooked up KASAN to the KCSAN
hooks. Long story.)

I'm not sure if this should go through Arnd's tree (because it's in
rwonce.h) or Marco's (because it's a KCSAN thing).
Going through Marco's tree (after getting an Ack from Arnd) might
work a little better for me, I may or may not have more KCSAN patches
in the future.
---
 include/asm-generic/rwonce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e982..e9f2b84d2338 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -79,11 +79,14 @@ unsigned long __read_once_word_nocheck(const void *addr)
 	(typeof(x))__read_once_word_nocheck(&(x));			\
 })
 
-static __no_kasan_or_inline
+static __no_sanitize_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
+	/* open-coded instrument_read(addr, 1) */
 	kasan_check_read(addr, 1);
-	return *(unsigned long *)addr;
+	kcsan_check_read(addr, 1);
+
+	return READ_ONCE(*(unsigned long *)addr);
 }
 
 #endif /* __ASSEMBLY__ */

---
base-commit: 2df0c02dab829dd89360d98a8a1abaa026ef5798
change-id: 20250325-kcsan-rwonce-c990e2c1fca5

-- 
Jann Horn <jannh@google.com>


