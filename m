Return-Path: <linux-arch+bounces-5075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D829161CF
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F241F219D5
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A9148836;
	Tue, 25 Jun 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBgs6JCa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1813A252;
	Tue, 25 Jun 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305984; cv=none; b=KXVHe5n8VdlpP7BVnBttfyvyRhuBug0L5FaCqzwVl5VswZjucCqeUA884tjvMA+t+BAGgLYIKSfAmRR89S/5LF/C9UYYE7wjfT69Bg2xnae6de8NlxrnvKAVMQgEe7TCXxxcQmyReQXavqCACW+SGER09kuAcDPl8ibJg533XFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305984; c=relaxed/simple;
	bh=CoOIXNxDYC35xzbOrHuwRn6hRG4X1EKHermPGHnANY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz/K0I0bgKuTCQVDcQQuoqiOPz9XlSgvlhI1VtdenakBTXCXUB3oEZFGUGjoP4qdooxxxh2/7vUmfd5f1rjHUOwYgGonmDZGgWpK03hpoqzbKBhAltlAh6oOkReeAOk300Hy73PxEQGcuYjh36ppktXOJG0cvSv9Emke4xc9wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBgs6JCa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f47f07aceaso41179805ad.0;
        Tue, 25 Jun 2024 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719305981; x=1719910781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPBlRVdLjhqhXvqWA2atexQ/GKxdhaGgyqgobdeqIO4=;
        b=nBgs6JCabiFXLzQ1TgaVxZOn8Kuv5gSq+7nZVdU8Aiimh+MM6aVBIW0uJipJkuoyrx
         gMqNC0em1Ouw+l7SqjaGkgxZRwTt0YHUrTsW3v/ChZkAsUeAnChnAI9SA8ydTtxjmAwm
         iviNH3IKH1t1UUUUFBDN22yZIz0/2O41TPKiMiMKcuE+wyWe6FsFPzMhERHq/02zgMhs
         oairJkLgs9/RjFTb1lxZuDUPF3i0C/R0PCErTnbayUJDSLnj/hs75oVcZjASwsGvbqlf
         QdwjZgqEYCm0zwouX1dHrtLQOx0Cm2XhpZndoDQZAkhzaV2rydwEC9eX/Oud0GW6rRRP
         sKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305981; x=1719910781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPBlRVdLjhqhXvqWA2atexQ/GKxdhaGgyqgobdeqIO4=;
        b=RFwiyylSuW+YqONkbzUL4jIpJcKcPAm1G4Vop7Jp2yjjlzrN/rfXQSZOFeta1BgsOq
         UEBDkCRAk6BuuIbRPrnG9oI+zHrMWgDnnBJh79p/bV2tBgRXJpjkDgvTK85ojkxpzKGO
         B8nMhMyKceMt+DBPsDA64X9RdVYlrzgRTwfzWiyz1S0wCfGNuskVEWZoByqsFPFUsa6x
         8xCPQWkBZHgZiuRYVkRxgDqv3UrFc71pT9jhL1QbRCjZJ+qeEunenTkZU0SCe7RBqicx
         kZNu255/LKD/tjPeWrAFZaLu8UieLDoI0J9aSh6tVOFHf0DMHgNewl9sZ4hv7DeS9XOK
         ZsZg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Fd54v8VnTE1lhaW5gtzwb/GRquc9NYlYbYKX/NOmi+jBGiEu4WlDlbXgQ4UuVRcne7hdB7IQlSs0emmnfUu+Da+68mf7DtuFHzV9TYuJNkPIMeIWBHlZwPThF/n7kuzAsWbeCEfhHA==
X-Gm-Message-State: AOJu0YydG0Sy6b+FoqRubWR5qZ8WKAr+x46us/gThbhpmwmKkkFVtE4u
	qxUCp+yqiim6isyjWQO00slDRTj/OSGcJd9GQtNYaeOotcoUcNow
X-Google-Smtp-Source: AGHT+IE9g9uiT1061smMhHji0lQ/KnnxmzA1cPclNXAuM4LTMvAH9msbvLFmER6NkBel7IFARZoS9g==
X-Received: by 2002:a17:902:ea08:b0:1f7:2479:a50b with SMTP id d9443c01a7336-1fa15937ad1mr92432295ad.54.1719305981044;
        Tue, 25 Jun 2024 01:59:41 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf962sm76042955ad.231.2024.06.25.01.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:59:40 -0700 (PDT)
Message-ID: <892a47a2-ed78-48fe-882e-da9dd14050c8@gmail.com>
Date: Tue, 25 Jun 2024 17:59:37 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH lkmm v2 2/2] tools/memory-model: simple.txt: Fix stale
 reference to recipes-pairs.txt
To: "Paul E. McKenney" <paulmck@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
 Marco Elver <elver@google.com>
References: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There has never been recipes-paris.txt at least since v5.11.
Fix the typo.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
v2:
  No change.

--
 tools/memory-model/Documentation/simple.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 4c789ec8334f..21f06c1d1b70 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -266,5 +266,5 @@ More complex use cases
 ======================
 
 If the alternatives above do not do what you need, please look at the
-recipes-pairs.txt file to peel off the next layer of the memory-ordering
+recipes.txt file to peel off the next layer of the memory-ordering
 onion.
-- 
2.34.1



