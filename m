Return-Path: <linux-arch+bounces-3932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B78B135D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C9B22325
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77CE762D0;
	Wed, 24 Apr 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdzHKOnR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D55CDF0
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986263; cv=none; b=l3gT69MwTd+2QRD0zv/4u5CmHQ2h60mclSRbcCJFSmwPVe/nkmH8tqKkyuTeLqgg1tfVuGzHvjCE3twPOd7aqCUDUr0pZXNobernvaNL0ikLtA4ndhnS048KB+0xjCjQHVaRmvc4vujOdrgSTCBN5U9H8LCMtyn5AcLlRjwSpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986263; c=relaxed/simple;
	bh=WfTBGnBFkRU20qhctvMnIHaixmJ1m8yq7qOHp+mKQX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4mtIEoAipSey0lvR/Kk7+hDLQ2aYGquD0SoRG5pdbHFPj1yzN+ahzX9YG0Cb77OT5wxDG+wO4Q4tYsHFJHsgADsZZFMbWMyO8BidcPTTUlokY+hlH8JGC3D+qJ1lLNA2FBbolpX/oFiIolL8z9bSVa7FDqvhx3EJ/aVOKhiEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdzHKOnR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e5c7d087e1so1843755ad.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713986261; x=1714591061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5yDcYDvu79ikloFjmN2ArtCsis9cNcuVqbWpK2seK4=;
        b=WdzHKOnR2NZYbZjMSuOUnxhgbN6UtJedTL0ijhz4M2j4e52gVe+Pt6iZfR0Rfl0JJs
         Lc4RQfwHcLmpOSzbRRQQXlj3pwkgaks6ElhyvlSGtFuKE9sBFzhzHNrBQxcF0wj3WujX
         SzmfZB1348TAfGvXZOEY8x6Aqk5/gTvCZHufU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986261; x=1714591061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5yDcYDvu79ikloFjmN2ArtCsis9cNcuVqbWpK2seK4=;
        b=XeAZyiSu1eYzfErb/WCdmHcOni1VAzEEZK4+xqkaqAut/7D0lAapybslxU3wjkeOy3
         JxSQO2QkwoDVAz5qTg1FD7DBFfIBZs3gMYPtmUH3DpvA/tZqzJCPBddKiEM2sIdrz5Lb
         gXNKt0Ur6KHysQ0GSvrpxUSYSHuzT6I1f0T13hQZbOURb4gakvSgSe/JKdn1NRDZKlmw
         fCTS6ftRw5xSTOJq262ufvixvt4NOXqiQ6ZfvD6GUnhmW1kxC+Ulg7SGS8vy3o263pwO
         agtT+qYkQ/q87rewBCUoN/hMPJEL3LPz73PixwWIhExrm5hAJDd8/jXPIizFpQEscWy8
         Vtnw==
X-Forwarded-Encrypted: i=1; AJvYcCXJH0SPHfekbA3U21DN8fHa0pEX/oM7gBAmvuzSwEIEFukCqmN1wxAUrnp1/KvM+r63kfqYc6hXlZrwTe0x61t69BaN9wPD2KR7eg==
X-Gm-Message-State: AOJu0YxTzFrTtGdbSSKqmH/PwapLQhpEgPqeEcKiaDFhPEFf6bYAStzj
	BtoOfzlz5hkm68iIXSmIXOr4p/z/yu0IsFaT8a1R1J5Axxv0LsNSPQ3sLGX+mw==
X-Google-Smtp-Source: AGHT+IEJ7QE65ebG0qqOnn+xdnnZ+q5pZtXGv5jZGzp9dsg2qcg4PCBbrB2p5kleElQysLvEwEP7kg==
X-Received: by 2002:a17:903:22c8:b0:1ea:9596:9218 with SMTP id y8-20020a17090322c800b001ea95969218mr1597370plg.45.1713986261347;
        Wed, 24 Apr 2024 12:17:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001e1071cf0bbsm12295846plg.302.2024.04.24.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:17:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] ipv4: Silence intentional wrapping addition
Date: Wed, 24 Apr 2024 12:17:37 -0700
Message-Id: <20240424191740.3088894-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424191225.work.780-kees@kernel.org>
References: <20240424191225.work.780-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=keescook@chromium.org;
 h=from:subject; bh=WfTBGnBFkRU20qhctvMnIHaixmJ1m8yq7qOHp+mKQX8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKVrRYEsvdcnHI4MuZvwNOd4oD1dteUrKWikwo
 S1OiHOayDWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZila0QAKCRCJcvTf3G3A
 JkkcD/401uVxwndvI6fIAQZvmMpVPjLvFTgxS4IRuBU7Pqf0z0a5RSlHhEAeKEg4DA1/5Qn/Nk4
 7VXgUWo66jWzFRmlmmipMniWFPzLt29JLEXmEIi/HV0UsKdhNmPyzFXJRXOKetIyH8MmkvA0nAQ
 PDrehyaM/tAewU/mTA9oiLtlT3Pg1bfNwDz5pvHwwJ+ON0Y6wxXaEqePkQt3WfBRCtTqIGaGl1e
 ow4LBS1klep8nsTmXBxq+ACfXBFNBrZebSFAuwGdlBJGy7EAo9NmKw4zZjqGze1GxLRsImdA8EI
 UxYMHW372KXbTpFeK0tNXvnb4mrDNqQ6a8FhdTEWDKMo5d4V2DHssDDI9Ol4XN/WioLS4gJ+wtm
 1Os3DVpUl2LAzSNYLSEE1TokL+uJEMfnHPZLep2xANF25i11AnPPluIaEpGaMJrTKe0r2JjJw3Q
 jl0+qHCiCYcwTnajqt5uItmDrlePlJSVkhWTGJJK0TAh/aA28ei9NkULfuqGBG/QjMoB+a9EZyQ
 HXOifu761IGfEi9g62Q3Smz8Ha3KKrhBtCzTaGRrkW0/IFeGrE/iqa9cpRZm/hPl5dbuFKmFuPY
 zWTLOe3+l8OTPy5xS07j+aMrOmS+PihzCAw+ZJn7ax6TlLG1LcomfeZoMEIjNpHm1d4OPWK1BEw jpwKjUXXLLcV1Kw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The overflow sanitizer quickly noticed what appears to have been an old
sore spot involving intended wrap around:

[   22.192362] ------------[ cut here ]------------
[   22.193329] UBSAN: signed-integer-overflow in ../arch/x86/include/asm/atomic.h:85:11
[   22.194844] 1469769800 + 1671667352 cannot be represented in type 'int'
[   22.195975] CPU: 2 PID: 2260 Comm: nmbd Not tainted 6.7.0 #1
[   22.196927] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[   22.198231] Call Trace:
[   22.198641]  <TASK>
[   22.198641]  dump_stack_lvl+0x64/0x80
[   22.199533]  handle_overflow+0x152/0x1a0
[   22.200382]  __ip_select_ident+0xe3/0x100

Explicitly mark ip_select_ident() as performing wrapping signed
arithmetic. Update the passed type as a u32 since that is how it is used
(it is either u16 or a literal "1" in callers, but used with a wrapping
int, so it's actually a u32). Update the comment to mention annotation
instead of -fno-strict-overflow, which is no longer the issue.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 include/net/ip.h |  4 ++--
 net/ipv4/route.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 25cb688bdc62..09d502a0ae30 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -537,10 +537,10 @@ void ip_dst_metrics_put(struct dst_entry *dst)
 		kfree(p);
 }
 
-void __ip_select_ident(struct net *net, struct iphdr *iph, int segs);
+void __ip_select_ident(struct net *net, struct iphdr *iph, u32 segs);
 
 static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
-					struct sock *sk, int segs)
+					struct sock *sk, u32 segs)
 {
 	struct iphdr *iph = ip_hdr(skb);
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c8f76f56dc16..400e7a16fdba 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -458,7 +458,7 @@ static u32 *ip_tstamps __read_mostly;
  * if one generator is seldom used. This makes hard for an attacker
  * to infer how many packets were sent between two points in time.
  */
-static u32 ip_idents_reserve(u32 hash, int segs)
+static __signed_wrap u32 ip_idents_reserve(u32 hash, u32 segs)
 {
 	u32 bucket, old, now = (u32)jiffies;
 	atomic_t *p_id;
@@ -473,14 +473,14 @@ static u32 ip_idents_reserve(u32 hash, int segs)
 	if (old != now && cmpxchg(p_tstamp, old, now) == old)
 		delta = get_random_u32_below(now - old);
 
-	/* If UBSAN reports an error there, please make sure your compiler
-	 * supports -fno-strict-overflow before reporting it that was a bug
-	 * in UBSAN, and it has been fixed in GCC-8.
+	/* If UBSAN reports an error here, please make sure your arch's
+	 * atomic_add_return() implementation has been annotated with
+	 * __signed_wrap or uses wrapping_add() internally.
 	 */
 	return atomic_add_return(segs + delta, p_id) - segs;
 }
 
-void __ip_select_ident(struct net *net, struct iphdr *iph, int segs)
+void __ip_select_ident(struct net *net, struct iphdr *iph, u32 segs)
 {
 	u32 hash, id;
 
-- 
2.34.1


