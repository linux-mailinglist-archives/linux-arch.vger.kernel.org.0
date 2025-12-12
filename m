Return-Path: <linux-arch+bounces-15383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B433BCB8809
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 10:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D5FB300855B
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162D314A89;
	Fri, 12 Dec 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GKPh8o1P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B463128D5
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532478; cv=none; b=pn+sgwovoINIxVOuLudk/kAcR8hfHlO9RPJ3Z8ckpGljpHQTVUQu2e2fOVOF5xqD3m/GcV3cC4yDgQzDyFvkSiZzoqMC/wVnbw1HowRmLFVtw1Jv+tHY1vDBReJBWXhpj/lQKna8hF8gOjzNS53pqGQcPFQpM6aopKM5687t1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532478; c=relaxed/simple;
	bh=EmdTK/fRZopBGWpziuNMPd4s3SKCTzTlZFLJE/4064U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tw28yeSJ2L8hqU9Ua6Cl/0N9XjAZxDa+2DLm/YEFsU2yWBwOvJGUXg2XJqgzzM2dTaQgPOigUt4zRE1rN4RXMAFhRwr7oFsU4AyiRUDcPb672qpmRQmWFpGrODm5kgiQ/poZiFu8hyiur1/sK8M1ahdLLKCNPhHAWAunPA8o0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GKPh8o1P; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC90Tvx3221103
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 04:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=avil
	WIry9gTxLFV5dzlklnHAwp0+Z25pb6ACZiTI8wE=; b=GKPh8o1P17lf0KKJKa9b
	Q5yu+41K5zsh7QbMxnvFsPzmmtTfVAoCBEmC6sjCjGByGvsEzk3/DMBEKAf0ZXIX
	Zb8wQnlthE3Op2+W4xfZ+fURt0FX+jOqmcOkgBxFf0h6ILh3m2uD4d3JnLLrinqv
	dGLeCrsHQFgqRtgdgmk1kn3Q7Yyq5M2S1LYhjbeT3W6AWWhlcB5tcaTXwiZmyTOo
	PjLyfN4w162BRPpXH8VPtnkJPcfY1tnnBm8mCT8d2CrCrXQIxo3N1mzDL4956LCw
	q5e9jRMy6e1wl2yPsS+7aeLHX+/FlKiHn/q2TeYWhW/sVPcXm3FR+lR+WOEUlfu1
	dQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4b02g1mqqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 04:14:00 -0500 (EST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so2060971a91.1
        for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 01:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530840; x=1766135640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avilWIry9gTxLFV5dzlklnHAwp0+Z25pb6ACZiTI8wE=;
        b=SFdlvuITbqKXWPfti4yKgzYBXuZem1P8Iy2P66VuY3YlGIW3+SIwY3upfG/lSbckYD
         1qdDxj04Vh8V/loRzoSDfYyPqN29hG50E2xJUhHN4BSDkRTI8LT/3/J9QCuwt2BxgoPP
         pQNqt5AxFvCh1VCOXsN6M8erpjetQjks/ksNLHflZk2i4xb0nR7FycUzgHKCEnYqiTFC
         S9RtXyujM5UQW6OisWVkguoAUwpAGBKdmErwZa0eU2BXcWPoRowb/punNlkU3+33c1AT
         lQG2Wz/PBDBId27J9zVic8Me3bVx/HL2WPS7RIpFIP95hFa746ECjygZZ3AE2Vz7rnxl
         u0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgPULEsenfqZkoHvuBvzwxGlVtqdfysKT893c55OmEssrZllXIA3FuKsQOcfgpDFqpN9lhD2kA1c53@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrJGJ3pYvt8n34CJzmkBg0//ZI72j3g+hFOe5MKzM6M/IPmQW
	+MpzSFfx+qfJ6OKGTNwumceneyJmhWEkPgs+Ih7VdWVTXVIr9zE4s+HLhnDbFxOd2r5tobzNt8N
	5LaX2Bm+YNjp2zfdt6K9INi59wR7nWNy8zYGdkI3xatD1aDZK2gtTrYtFaws=
X-Gm-Gg: AY/fxX6ru5Fl+mo5gsfCSvuJ3So1dgzpm1VwnpPymvcXr0HmP9Ft1by0q8jyGkdiwKo
	AON/ounwWdQcmKADy3mL95DgTNIOB3fCwV7bFNRW4dRd+mEzUW/1Lxs6H8PmbogIW1XqLumXqrN
	e1BWLGAm7TViKk9lnj7yBVFrfX9tSUNm+kLEp8ZbWh1aQhRLz58JC/BFUd218LfGC6l57lbmekW
	UavV4mLDw+jBDFc6DCj5OYBeEyY8AYABBc2IQ2Nd4sLaHpYmIDkUogu3so51wG6P7PpclCx+Hsd
	+6eB4hv3XkPhWi6E2CjUlxfh/TwoLTZ3+Z+xRhf1g7tatlz8U2ub/oh+gqB4XyUBLr9yu1zzXfO
	wMY1f6dwDDlLrgagQZDjRUCvqa1GlZ9DXl+57q58c6Hky/jVFK/0wqZTy
X-Received: by 2002:a05:6a20:918d:b0:366:14ac:e1f7 with SMTP id adf61e73a8af0-369b07ab627mr1259525637.73.1765530840058;
        Fri, 12 Dec 2025 01:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELRX7SnPRiviMlTSgk/0tB6eCplpLNDZWHl3aivotSRf1ij/an8wIly2PXn4fRkPYXltl+Rg==
X-Received: by 2002:a05:6a20:918d:b0:366:14ac:e1f7 with SMTP id adf61e73a8af0-369b07ab627mr1259504637.73.1765530839512;
        Fri, 12 Dec 2025 01:13:59 -0800 (PST)
Received: from [127.0.1.1] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016e57sm48497255ad.63.2025.12.12.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:13:59 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 12 Dec 2025 04:08:08 -0500
Subject: [PATCH v2 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765530499; l=689;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=EmdTK/fRZopBGWpziuNMPd4s3SKCTzTlZFLJE/4064U=;
 b=UsUA/XaWe7PQ81AUFd/Djoo4VpRjtMdRkW6w61JAXpaFzEpvAYddwkNn4lF34ddKsrIvtCT5K
 qasOL1ORuYzAbPIRlACXAmu8BfEbBJOoUBeMiE+Sy0LjYBxhUHo3KIn
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=LoGfC3dc c=1 sm=1 tr=0 ts=693bdcd8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=fwyzoN0nAAAA:8
 a=pHWCnKJda-1CI8IbBYIA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Sc3RvPAMVtkGz6dGeUiH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OSBTYWx0ZWRfX7mdIz2qTPG3u
 J/FHcPxN0MvxqrtVke7mwcvWePGTjKYwWHM7b42+Mh3D4YvpzUFEepLm3JNE3HkCSpRKQmzBYKk
 Nuft7Pk5P95S6Op1Yj6b4Qoy3H26cAPfh6xcNYwmsSDj5Nq90+Adc9EBlAmrEps7yjMgvBY24fh
 Q80yhNCXqvvJSlSq6MyGme5ZG2AyrUalqLC1S7uOgnw1zSpt3utGwVrNMlZTn6PopylMrnzEOMq
 blI8VPG29tLhfSZ/vHOlDh7Wr3vgTJTQ97zpAJx4AteT2wepTCV+YvXN+shw6mrYFrJABWJLiP0
 2HFB6hrjS4V94ZNNaV+I1C1ZlHA5tNPIzr4RtzjxBHvh4ESTYLFTeMRlwyhjQ3d1cQI+xS1QI7n
 sv0vb9tcUBQdW80RGYewRKAdfHTXiA==
X-Proofpoint-GUID: 8IxE69xdED4glPEKovR1J8xAskwa3t9n
X-Proofpoint-ORIG-GUID: 8IxE69xdED4glPEKovR1J8xAskwa3t9n
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11639
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=10
 lowpriorityscore=10 spamscore=0 bulkscore=10 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120069

This has been unused since it was added 11 years ago in commit
d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f6de068295d..42af2292951d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1631,7 +1631,6 @@ enum tlb_flush_reason {
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
 	TLB_REMOTE_WRONG_CPU,
-	NR_TLB_FLUSH_REASONS,
 };
 
 /**

-- 
2.39.5


