Return-Path: <linux-arch+bounces-9242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 019529E2F43
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 23:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3505B298C1
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2024 22:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80837209F51;
	Tue,  3 Dec 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJzoTjec"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F7202F84;
	Tue,  3 Dec 2024 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264977; cv=none; b=hXq81poE8MoF4hRF+qeSuIbTOZLXdGunKOiPY+ucPhjm8o6x1q1X8XMBLqeid4+j3Z0ldHputaqr4/VIf2KxF/a8FcMGvyK0CnXaytYr9K0/Nk7QD7SQbiGAyfSgQ4UHlYOYyOk1QDs/9j4DTXrTmFlZ1IUaSS2wfvtTzg01gO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264977; c=relaxed/simple;
	bh=v1NJNp5Tk7wpwinjGLDTU4LArY+PKjGPBb1DekJ1O6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAlcCL537VM+zJJ73QSdiGeifHjGx2QL2Fpo6LDnks8TrTarzy1s5SwEKB8Nude1oUtleaykav4ilbsX6OnusNoxNzvUCH83qPfVXmb8yWlk6of4DrI+NrvwOMD5tOswRjGifmAda8gWfx49J8/wvMSk9mVdW0NJLnEk5iPttz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJzoTjec; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so3640148a12.3;
        Tue, 03 Dec 2024 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264975; x=1733869775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOQqhZdgI8+JB/qh1dFLYIuDBxbHyOD15IWWEIuDAMg=;
        b=AJzoTjecKLzsoGsVs3OdruKRC90CUVwafnbgu7PrVrxm59H6H8sXzEbWI2r3eosIwD
         UNZpD83PKMoxrvQH+4tITghcnenoOkEXD+THCVPTNF1W/t4LdYCrYbqG9QRsXgUykQdz
         5+Z7zfFIkcbUKwOroyUY22bsuw92cp0cXrFAbf7HGMeCW+zDv1wAqK60lwm+2oj5r2mD
         /uM60E9YFzB7sBhYRhZueLyY95+zbufnaKfYPtYp8Jgw4ol2vzvAFOXYKMVhhYgNBLlA
         xUPuLEc6weDXNNrhAd5C7uNGGWX08vCnQo+eyV8SN3KLjUVm09gAZYI2Z13YM/xgxghA
         ZFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264975; x=1733869775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOQqhZdgI8+JB/qh1dFLYIuDBxbHyOD15IWWEIuDAMg=;
        b=HmdPbpFZmnL4K5XnsjHDBNDORVEmtP2aSYNSGedha6xb2eu+x8jrZo438Fil40ao8K
         jDxjSb5WgFLfFlwsWVXmJhkpDSAE31GClOcpuDW160fyD+abqYzX67kUUN5YowM1gw1j
         dllnG/EDyLglgYeG7WbCJHDlEHPpin93jAZ590PXscg74cbM70brFgGESCSd0ZwrmB3A
         sztQrtQllxsbg3knzBnfwFCvRJVNOgoUEUn06n8mgQQFiRdDcMDB5gpdL7AWy+ys52IS
         8JJYo0MJBnqgRwmfhZqHYOUoHkc2nkbdueUZu/vrsUQDXNVk4Hd4DWAifGfG1kvu0FQF
         h8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUXtSiF3PVCzaxON6xIRx1wnoS7/w0NpMHez67cW/HuqRF5N6aLO1FFlQFt17FF0muYX0ZMe40dNR/P@vger.kernel.org, AJvYcCUbDgDtPpO0yc+ahIjRdmxFn8v73RKNqzBnQKHdRdDiv/prKTrzruRPrbxoraDDcm/XOtSqsrb0wLEHoekIWChe@vger.kernel.org, AJvYcCV2FqhGei1GjJOumGFyh4ZAnHS6Gnao6D7nvYNe57r36iXkYMKXA3x2tF0dKGCNXt7o8sEfXB1ODtmmpHkn@vger.kernel.org, AJvYcCWCFE9p2ccbH3B8Ax2ZxTyXLebOm7imzYMEAZmQQz5HCtYx602b9DeD+ln8uOPo3OeUMT/bDQSt@vger.kernel.org
X-Gm-Message-State: AOJu0YxObALbq1K+oSVTR2eSE5Obic4RqLeZEuJrs4NdUdfeJ57Fl670
	UfOITO+PVQCci9It0IqwRDJEqjQu0BIqSuZEz9c5w4VglsQPEtQm
X-Gm-Gg: ASbGnctaik9TedA87IH+Crb3ICGPWTZnMef4uBV+XmWURhejxlNhPrOH45ITQ1ZmxFW
	gr8M3SVcKUr0OV4DH5ddLqqwux9kGN2ULIK2nbuBzS0YN3XCE9E+MRgn5qymXfwLkrlf7vSEdqw
	LNFlyB0shn2TT3/wG+nWroZhexnqH9cvgSAFSx8b3rvXA2EJ8PjXshnZij/nuNMwyyehQNZ59CI
	uqRWrKkEtK7c/HQy37HB9xtTvyQVvMo3KB291Tad3vZ1F2AAO55yuv5HxpSlQAWlK51NKPIUlMW
	F1Uwjm3wd0Ajh7SRWA==
X-Google-Smtp-Source: AGHT+IGvaKP6B5Mct/zhxb1Oq+XpVrniUhSuQiZr/lzz3hOewfIePelGBKpMi3jZHY3N98/XDM2qYQ==
X-Received: by 2002:a05:6a20:841f:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e1653b7c37mr6146784637.12.1733264975288;
        Tue, 03 Dec 2024 14:29:35 -0800 (PST)
Received: from localhost.localdomain ([240d:0:4a45:1d00:61fb:e21e:f97a:dd9c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3b6ee3sm10055175a12.85.2024.12.03.14.29.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Dec 2024 14:29:34 -0800 (PST)
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
Subject: [PATCH net-next v2] selftests/net: call sendmmsg via udpgso_bench.sh
Date: Wed,  4 Dec 2024 07:28:44 +0900
Message-Id: <20241203222843.26983-1-nakayamakenjiro@gmail.com>
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

Signed-off-by: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
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


