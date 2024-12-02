Return-Path: <linux-arch+bounces-9237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 475019E0F44
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 00:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57D7B2457B
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435211E04A0;
	Mon,  2 Dec 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb0xsa1x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB671DF244;
	Mon,  2 Dec 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181701; cv=none; b=LUvgldSl47SGciFdLAZHL7LElXiGwGvp/H88txVk7QHK8G4AEewDQ+4CMh15NhxhDe4r3hKQgKZ0cFDwLGDeqI8FVmiqnCs6CS9g9LUEKBafES5ZYwAnYWev8F7vX+EPvPleBTS9M02lx8rqZIDZzM6nvkBp9sFn3UibVIpbrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181701; c=relaxed/simple;
	bh=T0fJkNN8lmu0yQW5xDMaUNuwSNQGFIOPmvlds70OAcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lrwZdUX3/VdnL6wp9cm0IChtAgqh5hysh6YrFrSDc3cX74Mprw0qVmkMK06FFmI7pmVDRRzRYRbZWckjrCyw+/+Rh2oP3xMGMkla2IU3MQdQZlTmgoFYXl9eZSx3KIfEmghiFXgISmSsv40sMuDfUgqhR+kM/UR/QIZOPKwEwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb0xsa1x; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4749262b3a.1;
        Mon, 02 Dec 2024 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181699; x=1733786499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyFnOYNR7/uDCGGXOyxce2KX24RRI2ramvA/qoNn6Mw=;
        b=mb0xsa1xL1zLWAMLj9DAEH7IrSW0MrXC93O6mb1xj13XnX4OYEh7XT5vRT319sNf4V
         Ue0UfZrd7AQCOlfWAIG8H1YPEO0/f9a7TrmAgjegA+JUbBvNw1ZyZP7HpwpvfwCrzlWr
         RdB8WBgEodsn3TaqKrxxwNVDUNQPWAMEuE6gXTgRq2DhocMCPQgQHBlt9PBZdB/5ryVg
         MPHVBbc4iyu/mbKFqg7Uv8zogeFfy2MBNTOKbLtWcWyftF6yJ92fq4WLEY5EmCb4OD8Y
         a03beInn3bbgjN8M5kNvkqVsh+8AUCZs7dAI+gdqFIU3sy7TdsnXOiMMKLyQrCoi9yi4
         Id3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181699; x=1733786499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyFnOYNR7/uDCGGXOyxce2KX24RRI2ramvA/qoNn6Mw=;
        b=QiDzYkdYje4oEwpYj1JfSzg69HleZ0AzBpz95eSl1vnr+pbwN7WuJdaeEBlrvkCKAw
         vMMtgEgVrUih6Hsdhs03sQTZYU87kFEn1CHVR/0JtqDc0GtR2eQPz1uL7kwdOd4YrLjN
         VRBaos95QJy21WXifI6xrU9dkAI5T3vCIT9K0yI4mrI7AVyGw7B7YpaAYEbsbikLBKNI
         ajRLD1MO+XPkeB5ks6ZYITxeUoE1n8r2EyhsubRdqR9u1BKwGOqOeV3ipDIVhWTkaacv
         x803aiZ1D3JNAj5RPhHcOEgzs9yrA7QgIx6uHgXHHSfe6RxXoSZX+q6YHGQSZYNzm+vQ
         aJtA==
X-Forwarded-Encrypted: i=1; AJvYcCU6osT9GONdnk3yCCcqiklwZicvc0bKoEkMOLzqd2+S8oeC2LO2oVQ8EKgiQdmUP7Gmfh9N396ErU6vR1hx@vger.kernel.org, AJvYcCVCKA5/gnpEc89ZcU/jOHl7IYLgPwS1eG0Ek2Kq2dq5WRF35Xatn57AXndrhMCq67qTdVsCWEQ8ww867xKsgCtH@vger.kernel.org, AJvYcCVVIuP5aGDih7gJTWrHBjldwuqdSwllXwLufGNIm71F0cd3EY7g0/gx/BtJsMNJVeld7E5fCxy7lIhO@vger.kernel.org, AJvYcCX0WWAToW8+6VFP53KNH5WymgFd7wJeRIMKQz2tShRZgBGxJ62TO97ya2I9EFNXAyOcdyPYSIkk@vger.kernel.org
X-Gm-Message-State: AOJu0Yywyyl+feR19dl+b56rD4xBPD3RaiKzKgJIyUoZRBHmKumE0sxE
	E9oLb8A1MvrQ3OpI7sEnJw7m6oHOPokFy4S5H1ZuPhTz3eYvQMRE
X-Gm-Gg: ASbGncuPl4tX6wGGmMxJmEtUHQg7EOW+OEZFTFyO03XbM3Jv/nhusxlL2INwoPjKvjJ
	Ph01V5YV7NRhOJevjwpLyWYv91JhAgGYtGsF8CyNirQUDs9TGr3Cj9sqsndFN1lq62VN1CYUeMJ
	t+yXKuCqWWFHhAOKXQBriVXhNUYrVCmYV8cUwzoVMGCgSGBj7oFqHlWOg650ETM5Uk9cAUAQHTd
	4018QtHRCpf/9GObG8ahSlKU0F93PVqy1mL6qzH1OiT9OHryY57yFQX+Ks4k5KRpBr7uijc09LN
	bN4y1EU3VeqhcTjH+A==
X-Google-Smtp-Source: AGHT+IEXS03Fw+wgJGBsVZ94KW7dwGXzAeA8iM26jbTjQebKyiUAt9gwXwClHbNDAS7WWsC0K1AuCw==
X-Received: by 2002:a05:6a00:39a8:b0:725:3fb5:5595 with SMTP id d2e1a72fcca58-7257fa3a10dmr317747b3a.5.1733181699099;
        Mon, 02 Dec 2024 15:21:39 -0800 (PST)
Received: from localhost.localdomain ([240d:0:4a45:1d00:4807:3add:383b:ddbc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176fdcbsm9098432b3a.70.2024.12.02.15.21.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 15:21:38 -0800 (PST)
From: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Subject: [PATCH] selftests/net: call sendmmsg via udpgso_bench.sh
Date: Tue,  3 Dec 2024 08:21:29 +0900
Message-Id: <20241202232129.7139-1-nakayamakenjiro@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, sendmmsg is implemented in udpgso_bench_tx.c,
but it is not called by any test script.

This patch adds a test for sendmmsg in udpgso_bench.sh.
This allows for basic API testing and benchmarking
comparisons with GSO.
---
 tools/testing/selftests/net/udpgso_bench.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index 640bc43452fa..88fa1d53ba2b 100755
--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -92,6 +92,9 @@ run_udp() {
 	echo "udp"
 	run_in_netns ${args}
 
+	echo "udp sendmmsg"
+	run_in_netns ${args} -m
+
 	echo "udp gso"
 	run_in_netns ${args} -S 0
 
-- 
2.39.3 (Apple Git-146)


