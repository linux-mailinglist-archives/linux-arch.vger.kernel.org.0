Return-Path: <linux-arch+bounces-15382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D722CCB87D6
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7506300A224
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990E1E5B63;
	Fri, 12 Dec 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SUefY2h+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D892DC354
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532235; cv=none; b=gtyQETtZWXFIvqZUonNClfpK8ZcLwgsv8rkdftOa6x50glguRnnOgc60JqxRQhq4rI+j2G9+tO9qKLkzCOEB+pSN1eP6wF1Oht/iMl2ab8P0tfw0IRUE8B9bXFzUUm05qaElnMYOAq5LaRgkrMTHy7/3tjIP3BYdG9KXLXaEpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532235; c=relaxed/simple;
	bh=3RXsGKqukvEhsXy2ryEgjMGzkVB8QVOoAFGKjU+lkAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNq/BPYzNWfcwAKgB37pu/gj4tKDF4GMu+Nlj5r1Q+eME41M6MDI7ROivETkKyZ4hk3OrmYBUTz5n5AlhvZ1USaIB31AHGDfFjSMzw8fe7F3ajomp8nIVckDAkNZ/Fn3CpdFOo8cV6hiMihlPc8IHTrjb9N5U66MmNPxstK9BQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SUefY2h+; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC90c4P145931
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 04:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=s1cT
	Pmb/E3ED4jNPhT8P6htYkPi/ZEzeet04bZUSBAw=; b=SUefY2h+X+0yV5h9UDKf
	0L/P4l74lqkcaH0AfwtOqJvXh9ZG/pfMqujyu20Ftb4CVkk6J+1RC5lzd9o/25I7
	fafQTEqH0vIvoUHqBkOKBZOgxQSWiutsZbsGEEKnx3mWq2jPLYlqCkRceS1YyRQs
	6g+X+xm/foRjPN1An4/Lpo+e+BGfMfvGzU/WvYaNR55GBetwqVHOkFHWJL6C+L/i
	xIbtfsofl5qhY4V7kRx8weBnBodlUlQmyC1YbISzVWba6/k+IHT3+9DdGcUoVM84
	jAXmn+5ZSw1Q3dt6e0NbHq7BY6R6NB0whQVK70XDP1g3sMkwKKK2VeUN40FVUItt
	BQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4b07h2j11v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 04:13:55 -0500 (EST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f26fc6476so6932855ad.1
        for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 01:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530835; x=1766135635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1cTPmb/E3ED4jNPhT8P6htYkPi/ZEzeet04bZUSBAw=;
        b=PYej0UUnD3zNm3vAISC5NMJ0HsgXjGeK7IzXCnOykc3RveBikVIxGIkjADSEZcH87Q
         0qBTyh0CtYGlg6YAwQi7HV0aSpmJp1sEJQpxp/kwRynirQ5++pEB1JJC5idpfPw2jpBl
         o2wR8pjPTElU7CULJOWaINhfOWUr698ROGUioJI1poSw0XfEoR0XmiRNgY/knNFy1E8/
         Xi0eB8TvC65UTluMXG7xf78Ti9OMenayaiq/4BeySS7LIV+xmAGMbsfUImUj43Jf9mAL
         s47NDlasgqByRhfAy0+tQG/+CQtMwxWu3Eiv3a5LlRdroDoz7aWix/0qfR2jkK3CEi0N
         RtAw==
X-Forwarded-Encrypted: i=1; AJvYcCW0k6g3mNhRWfXvWr7Ar1KoExfOA+Ya5q2Rs8LYGLoM6NZNGz4zEPjJDbSleSZHM+UMeE9S+HmB2waK@vger.kernel.org
X-Gm-Message-State: AOJu0YxCq41IhH6Zwvyv9zoL8Uny2M+Jqljammt3ib066GZiKJEWpqJb
	pZ50sHeE8qhg4I+Y8cMzacPiLBvUcZTkALIbE/hkmI3+Zb1d2amtCGUFRv0VB8/wZdD67FleomN
	bMAGTLkAo+04GTo9mHsdMR15Ya5KCb6EivKalXVdeO1XTpf9x0+phmPyM2Mk=
X-Gm-Gg: AY/fxX7AiwzkGIxBZ9vVNU51iCbod6x+wra7qyaW0XDeag94Xyh72mRY9BInWWcQ5RY
	de2qiWwhQJJoGWTZn3l/5xgSx+6MDh97gCUrBlBKtiwBE27dQW/GctcwBE7b3gmARgdckd/7bnS
	hjsSmbCriplN9+YtcgsA2Ehd/9y/Y5H059lShGYD22rZHKpeLQbIE1ILXBPj/LDJjY+/vsSLk0X
	SEWAqeysnp9yGENICJhEL9ODtz59y8dikceFlgfA/oc8eV/ev7MxNssL1gh7LXTFLJDaK7eqd2V
	0Fw/JleI2m7n+bKTBypjsxP+Aaf7xmw0c7QvzDGHWeUFHXqTLIz/y9EbKP+1yCLubGZbDQMQw3C
	m6mY9C47e87LgTUWJGJZR/DDlIoKVKQmRxRW8IHu3M27wVIlNL/UfQlNW
X-Received: by 2002:a17:902:e80f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29f244bcf85mr18583015ad.56.1765530834988;
        Fri, 12 Dec 2025 01:13:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwvOAURq/suPyQQI1KUWuzlf+xBV7BfHZ9tWHXTmC5W67Xs98SEZvrSF3mE+NsgMan4KBjtg==
X-Received: by 2002:a17:902:e80f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29f244bcf85mr18582605ad.56.1765530834512;
        Fri, 12 Dec 2025 01:13:54 -0800 (PST)
Received: from [127.0.1.1] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016e57sm48497255ad.63.2025.12.12.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:13:54 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 12 Dec 2025 04:08:07 -0500
Subject: [PATCH v2 1/2] x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-tlb-trace-fix-v2-1-d322e0ad9b69@columbia.edu>
References: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
In-Reply-To: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>,
        David Hildenbrand <david@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765530499; l=1293;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=3RXsGKqukvEhsXy2ryEgjMGzkVB8QVOoAFGKjU+lkAo=;
 b=u8Ap52Jd1shp/j5YC1M4uPMvXwfjjDYnAsVA6o3090sKSZmF8nxXTd4XMzAAufSFFftag/Sds
 I9zmJSMnLejCrmyrOBBN0KHmXvL13pBcYyuqAhhaNXDrChF9WQe589R
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: txGfypJdgfLJeYZvfVR25s4kE5d0r2Mg
X-Authority-Analysis: v=2.4 cv=Vd/6/Vp9 c=1 sm=1 tr=0 ts=693bdcd3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8
 a=fwyzoN0nAAAA:8 a=tN_j7I10ly-BD7A3SNgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=2JgSa4NbpEOStq-L5dxp:22 a=Sc3RvPAMVtkGz6dGeUiH:22
X-Proofpoint-GUID: txGfypJdgfLJeYZvfVR25s4kE5d0r2Mg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OSBTYWx0ZWRfX5UKVAYooqOKp
 JFxRVH9GGAOjjm2IpuHVQIg/Wiol07JTlRaJFzimK+9J67ZE7yHuUYYdNuW2/J90lqrCU800j1A
 iaEfjP/fGnxKYV+sBXW+/mhkisNRAEES9ULZaax5qtX2CXUL3GQR/DJK9C72Rgkzl/Tw3wz/i6S
 zsZxN+tS80AxRC9Q7XdQEI+jvmXslu41V4+LyeYIKCWBjg+V7kbrj9GN3F0TI1mkdzQ17HzKT2U
 wfuWDPZmdyEosAnLx25Cf6KuRIZId3nHtD5BocRaVHmzWkWyy7/FfVSonVRlXN60aJQakq5Lx7a
 hHRVa5e6Vq8FmswnO4l73AeDBoA9TGd4brw9sRGFd0dIizxy76NN1jeeQye1MIGM33UpeEL35tl
 9D/SsUL5tbiR/3NBcGYtweie0cmFQw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11639
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 priorityscore=1501 adultscore=0
 lowpriorityscore=10 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120069

When the TLB_REMOTE_WRONG_CPU enum was introduced for the tlb_flush
tracepoint, the enum was not exported to userspace. Add it to the
appropriate macro definition to enable parsing by userspace tools, as
per [0].

[0] Link: https://lore.kernel.org/all/20150403013802.220157513@goodmis.org

Fixes: 2815a56e4b72 ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/trace/events/tlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/tlb.h b/include/trace/events/tlb.h
index b4d8e7dc38f8..725a75720a23 100644
--- a/include/trace/events/tlb.h
+++ b/include/trace/events/tlb.h
@@ -13,7 +13,8 @@
 	EM(  TLB_REMOTE_SHOOTDOWN,	"remote shootdown" )		\
 	EM(  TLB_LOCAL_SHOOTDOWN,	"local shootdown" )		\
 	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local mm shootdown" )		\
-	EMe( TLB_REMOTE_SEND_IPI,	"remote ipi send" )
+	EM(  TLB_REMOTE_SEND_IPI,	"remote ipi send" )		\
+	EMe( TLB_REMOTE_WRONG_CPU,	"remote wrong CPU" )
 
 /*
  * First define the enums in TLB_FLUSH_REASON to be exported to userspace

-- 
2.39.5


