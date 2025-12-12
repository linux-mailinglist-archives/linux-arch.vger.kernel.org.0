Return-Path: <linux-arch+bounces-15381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9ECB880F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C26305F305
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D37314A6C;
	Fri, 12 Dec 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="uKg/GSQK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD0312831
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532177; cv=none; b=gto9AX8fbY2w/uy57lTO1tUgaansXloFlCp7QIPsKMqQB6R3MyVBJdYAlMfYF/Jh+A7QP3Yx9/+D/k2/+nIWfi7Nmgn88hl/iS6ZXO8hzvWWWcDypasX4i32yDlFIg/Ej/QE0KFiLwHoWP5Ghg78QDP7/s9Z2okdVIZ/yKH2w0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532177; c=relaxed/simple;
	bh=RQs+Cr//EkA08UpbUBYAdwgnHf9vZ+MF64Ay7/KhotQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UP99kmy29zD1DMYkHMtIdJZ9p0xnoqF6XL7dTUUtCmQInVkmnUni3W1ynVh3q6kqAjCyDfIG4/fTO2sPJAIjIutsrRXNRwz0uoJhJMLQfjd1tbb5TQHiLblpcWpdU+GoJsy7T4r27F6LC3cgULFY5rlOv9XWIOVJfFW+BSG95vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=uKg/GSQK; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC90OFS144509
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 04:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=za3Z6nCogcC2rSrqJPImaYLaC5
	FD9fqlNIQmXXHpQIY=; b=uKg/GSQKP65HHIXIU/0QSpgmKz0ZJ4mRqkKK0wXo5X
	4p31jMkn0OhTgbSuRyvk+bMLxQmI/TdY8r9vZfeUc2AlUqm+gfU3otqXmISQCjOu
	ydBvK32hqIcxPh139Zy+AXkgKY9qjEtyEaWFwmHClh4bWfpZDlZQ4YYtXF++MeHu
	02LCDVqak3NcTydE2pt3knXB7DVFhmVf7oraRiG5vDoI44eQG2VLZREASUW46fXo
	j9dZReDVYy2mdV13vlmgY+55fRCWQzDz0KmEpPCZY4v4BfbvLaXjtxH9sZ1/DhsZ
	yUq+XbpvKtvgrWAWl7JMk8Pbl0wG5OmkUqJEcj2EukrQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4b07h2j11c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 04:13:50 -0500 (EST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29846a9efa5so16817965ad.0
        for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 01:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530830; x=1766135630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za3Z6nCogcC2rSrqJPImaYLaC5FD9fqlNIQmXXHpQIY=;
        b=tNIAC4ds8Z+cu/bjC3BAZH5PDfiLQ8RyNJPbuYt1UVCPKEQ3KKylJ8Gw0I7At+syCo
         GIPpCXL0DVQ1IeVkb/bT0v50ITWd+nCL/7aLT91NqRkqVPqARcH5kKFcButjuVnvJZuN
         i0rwom+rwCsWy1dYSDEDWcXpt3XNqsGhrfj8w5AFy+/pNoWKudsTsbSvxReGZul9+iDz
         Al4nGO0H/DCgcvuNixTX5aF46/pPNi2Q8Mp2Y3Yc/gxxneVMHkWIvVPuljyCaoWvljYr
         OMGzHoQvK0l0b6s1I0ztSHMA+TVvipzhb7/HKo7jUGpCcHdIPNsEqUJ0+zQzjuQhDOxa
         HnXA==
X-Forwarded-Encrypted: i=1; AJvYcCVuSUY6ivqz60wej5m7Zpw/NQS6ieZb0g90PcEpmW41NI/vw2DV7pVDx76h6FB9KosmoQzelOKw7v2y@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZ+ka/d4pcljYdkTR3RgCNxZ5VhijcLbuZeL+nKv0fSVDPkdn
	DVPU+5TECbJ9QLoq0fGHLn8ug9vxWcNOEnkURJ7zx/KQgXtoi4T6wVSO98R0JbIfYo31ytvmTvl
	TUD94YYwPIvGMxZdazC2xyKedS1WPggZi9rtquqgTpNS4Vzf96f6slJGalFc=
X-Gm-Gg: AY/fxX5/y8UgfKQ/eCpUaeUCvqxSsYKuhMZdDmnTr5S5yckvU9txT2ck9VC8S5QoiLI
	p4MZFOoyCkgcOh5GuiAEC7oq2WPW/iZ8x7vuVDof/lNT5HeYlIVPgUVIKWzfHqO+2CunQ7VxySr
	/+7oScAy4R/JPv0yVU6Zv158li9rd2A4QtBK/fSmZ6nZz1ANbZlwmbZ5NSH77WldaHOydUEzrlH
	Q1tDTj9k891nR85uxpe9o6ymM2fM/fnV79Sb1c7l7F/q+obmMa7x0RP8ZmYvbOZXF0OGzBtKtvb
	qYvkn1BHpMyvIsC+r7pqL3dASkW9Zqkpe/mT/9RP2mYkUvCt6zGltlH+qgujNZMvWXb2xNE5DBN
	uzvnsMmm9w45QypmLRfzY3c6JO3oJfWw4Au8x6NBDsXvMGSxcTdfNZ2uw
X-Received: by 2002:a17:902:da90:b0:298:68e:4057 with SMTP id d9443c01a7336-29f26f02492mr12993525ad.59.1765530830016;
        Fri, 12 Dec 2025 01:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6sKbsPSYsaMyhULdwVqz1JoQu+BSE8km39oGocnv1+kBEsKkLBQeMpkHcDjKtUuydOVQxbw==
X-Received: by 2002:a17:902:da90:b0:298:68e:4057 with SMTP id d9443c01a7336-29f26f02492mr12993135ad.59.1765530829488;
        Fri, 12 Dec 2025 01:13:49 -0800 (PST)
Received: from [127.0.1.1] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016e57sm48497255ad.63.2025.12.12.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:13:49 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/2] x86, mm: minor tlb_flush tracepoint adjustments
Date: Fri, 12 Dec 2025 04:08:06 -0500
Message-Id: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbbO2kC/3WMQQ6CMBAAv0L27JrSUARP/sNwoO1WNkEwbWk0p
 H+3cvc4k8zsEMgzBbhWO3hKHHhdCshTBWYalwch28IghVRCyQ7jrDH60RA6fiPpXrfOXLSWLZT
 m5ano43cfCk8c4uo/xz7VP/vvlGoUKKlvjOpco4S9mXXenprHM9kNhpzzFzEpeemtAAAA
X-Change-ID: 20250528-tlb-trace-fix-eb9b6fc7bb26
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765530499; l=788;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RQs+Cr//EkA08UpbUBYAdwgnHf9vZ+MF64Ay7/KhotQ=;
 b=HNx9jzUDiAP5JSX3noLQxFsehtAhFIOg4dMKrEKthREshjiRp5BImwVYJwMexc6sxNAWzyZPY
 sa/Ub59Y1T7D4+rjSgEPJvT53cMT2cdm+oFqczWFoehSiGm+14I70uS
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 8HNJTS53zJMrJ-fyMS7aEsG06ocVWyKr
X-Authority-Analysis: v=2.4 cv=Vd/6/Vp9 c=1 sm=1 tr=0 ts=693bdcce cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=D63WkmDjCBH-idvp9jYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 8HNJTS53zJMrJ-fyMS7aEsG06ocVWyKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OSBTYWx0ZWRfX54gt39GQOJbO
 vBlIbztkrIWkS4N4maQptFFdUSM81afIvTMFYDTfu0uX2yAUvAZffXxmkGWdk0MVeXvKkKKPATw
 cJXrKwni7fv14yPFIyFfXQVfIf4SubAX3v+sPQThFzuC4uXGRa7yc3+ZRLH9ZZyxoG2YqIFMC9u
 ZEt4NI8aUf9/xpH3VGii1wt3vlw8nRjudixkmkjeCQimS+HeTksMGIYX6WFGOQhjRYQo2Ub+7gz
 IOu0SDYNDvD0cgKEgdx4FXbVWNxRfnUoCLtWM3u1wfSuIVh3c6bMoVz9fIGXS63irxcoQ3MusVD
 fxe5eZ9uc30wXstMadC42ijwuYd4hadYp6/TAdcOaowoh358TVH1sS+FQMKAUeWvRqntFcO9One
 tuvSMMSHdNdqtbqbjNi0VBR/2hplAQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11639
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 priorityscore=1501 adultscore=0
 lowpriorityscore=10 phishscore=0 malwarescore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120069

One minor fix and one minor cleanup related to the tlb_flush tracepoint.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Propagated tags (thanks David, Rik, Steven!)
- Added MMU Gather maintainers to recipients
- Rebased on master
- Link to v1: https://lore.kernel.org/r/20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu

---
Tal Zussman (2):
      x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
      mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS

 include/linux/mm_types.h   | 1 -
 include/trace/events/tlb.h | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20250528-tlb-trace-fix-eb9b6fc7bb26

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


