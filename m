Return-Path: <linux-arch+bounces-13894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9ABB5D36
	for <lists+linux-arch@lfdr.de>; Fri, 03 Oct 2025 04:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF163B31E9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F72DF123;
	Fri,  3 Oct 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+U6JGKo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29F2DE70C
	for <linux-arch@vger.kernel.org>; Fri,  3 Oct 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759459477; cv=none; b=PD+ihhmibZjOdyFWdWkXqxCit/pHdUstF4AsU1567wZF8ceLrhXMUtruDcXtVByB/vDmajEz/YvrMSKjQ9ztMvuABYK07iu4KGT+vSOx8KnOB99xuWJcTiy68oacCSG65FlPwKaWzwluBLJFNmiVKU8NEqKR3/s2yuit5cWGoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759459477; c=relaxed/simple;
	bh=ssNDj1nyve9l9BTdjQ/zgSqvViNlIcvrKmJ1owlymm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHSasfoPseHcSDH3VZrZ5eFyNS1tjDyzMrVRUTqvIG2PXPLSfQE4wFgX0zTgRWxM5ZIeOjOJf4Z48SmEYWaaJap4ti2B05RotHKSyFgG35eAF0JIU3EgZY6rhzS4dvSYxB+Y7h2ELfFjfBHeGrzNqFEPMC7vqMeCWiycQdtfpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+U6JGKo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26e68904f0eso18025395ad.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Oct 2025 19:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759459472; x=1760064272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qetHx9HVdf2g3s5a7dZOmiU3bkwsi2YCKNcOlkRT3So=;
        b=a+U6JGKoGqHHwMH96EaNqCV+o8bezcfmbIl+mlvYGV4TuMQWYXCmvirLr41CaB/sqI
         Ur5Xdx4AqwpDI9nrnLS4NqrAMJQXdOpPR7Jc5wMKUG94HU4LLxCjjRlJcjw85X8Cn3+b
         yLdLcz/BlCZzyakwN7BEc/QiD289jPCWUBkDec94F/qzPqdkwM1iiy7g7XA96or2IYJB
         u9OuxolCkRRUItW2NcIm+UJVydmkDabQ14i2HcnWLeP35G/PKIM4/RC6fXSEQHN/BnL4
         pb3AApLMS3sUMmImDV5xKl8KOddzeZNuoVAbN0iDA/+/VCUYhNuhR0otD16JbPVAkQgp
         lSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759459472; x=1760064272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qetHx9HVdf2g3s5a7dZOmiU3bkwsi2YCKNcOlkRT3So=;
        b=wJT3/aZNgIeKxFeVC+lmp8ctMPUzm6riJPqBnIvoerBBoo06YGVgLXtu9V2z3D7aiN
         9b3kTGCJkA2/qTNUSPDNIxwIYB9EiHmV/Y2ZTj+XAcqn7nVmITHlD66nN+dK+iiSMadE
         In60tB6gHQKSQ2YV/PBOeMqqjtBPgLwc94TIsmqWiMLLc9txMg8S3BacqaRXS6TWcEbn
         h6FtGY+8IHpgP/dvXzgIYmS4l6VU+UU+/Vwmye94VSH5PpN0JvIa/WXOcTFykd67j2C+
         e0Jxp5Kkac150W4C4SzLU9bhZuanJ6WFJAqcJhMluMpLtttb5NzBZPnbvXaMz7jLil2H
         1CUA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9B4P1zhXva1B9ylAd/VbMVHzdBDXkvS9S4k+8U7Zt9AuGy0Lo8zfWtLanigiR9tjfqE7Pr/P/ulY@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaU8/wv7DyJyU9WS+Ep8WXXkpDVSQM2cDXT5NF9jd3p2STzP+
	GzTergEir5QuY6MGttxX/zlKNv997IjUrYdVjHbze/Q3x3ShIFcpz4+N
X-Gm-Gg: ASbGncsjQInidTUt0vIp4jJi0H/wYuKqjn7I7eiUiE8hmHCzSP/3Kd6D0jkg+ZTOA4q
	fug9Z4bfx/aD5s/IawT2HWb7wM+Muae1lPWnAIlmflOxfaxfdVgCKptbuth2v5LFVhJSnHaz2PH
	lcjmA4YQ2lEmKnRFY5nIS6vnTk+dT5/X16eJ4gh6yzmecvZXa9Avgm7O5xBR7o89ooRWd82S/Lc
	fl8kEcJoJXNcKU46MBmK2DXQcCbxtwSvxkKnc72Tm3/ME50YvpkXNnVh3+LDXnV1H7k1ByC9AoW
	dMDyWh+uK0+Am42QziakWHpX6fnJ+TMRVb5V61x3VEBeASUzXVR40rujYSY7pFpr88UtcpnRIDh
	pBSVsH6dBZkRFWStMuCaixvhIpLggSWWjaMYOs0sJV1/mg+6dMw==
X-Google-Smtp-Source: AGHT+IGTk3XgIPC+Yt+2pMzfIfhEmbENJy1R9Vc1MqojWaFYNyx0I6oDlvH7RtuE6DjjMeP7CuWGMQ==
X-Received: by 2002:a17:903:f8c:b0:28e:873d:93 with SMTP id d9443c01a7336-28e9a5652b5mr16545255ad.17.1759459472123;
        Thu, 02 Oct 2025 19:44:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108c5sm34680725ad.16.2025.10.02.19.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 19:44:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 84565420B701; Fri, 03 Oct 2025 09:44:28 +0700 (WIB)
Date: Fri, 3 Oct 2025 09:44:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 28/47] dept: add documentation for dept
Message-ID: <aN84jKyrE1BumpLj@archie.me>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-29-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251002081247.51255-29-byungchul@sk.com>

On Thu, Oct 02, 2025 at 05:12:28PM +0900, Byungchul Park wrote:
> This document describes the concept and APIs of dept.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  Documentation/dependency/dept.txt     | 735 ++++++++++++++++++++++++++
>  Documentation/dependency/dept_api.txt | 117 ++++
>  2 files changed, 852 insertions(+)
>  create mode 100644 Documentation/dependency/dept.txt
>  create mode 100644 Documentation/dependency/dept_api.txt

What about writing dept docs in reST (like the rest of kernel documentation)?

---- >8 ----
diff --git a/Documentation/dependency/dept.txt b/Documentation/locking/dept.rst
similarity index 92%
rename from Documentation/dependency/dept.txt
rename to Documentation/locking/dept.rst
index 5dd358b96734e6..7b90a0d95f0876 100644
--- a/Documentation/dependency/dept.txt
+++ b/Documentation/locking/dept.rst
@@ -8,7 +8,7 @@ How lockdep works
 
 Lockdep detects a deadlock by checking lock acquisition order. For
 example, a graph to track acquisition order built by lockdep might look
-like:
+like::
 
    A -> B -
            \
@@ -16,12 +16,12 @@ like:
            /
    C -> D -
 
-   where 'A -> B' means that acquisition A is prior to acquisition B
-   with A still held.
+where 'A -> B' means that acquisition A is prior to acquisition B
+with A still held.
 
 Lockdep keeps adding each new acquisition order into the graph in
 runtime. For example, 'E -> C' will be added when the two locks have
-been acquired in the order, E and then C. The graph will look like:
+been acquired in the order, E and then C. The graph will look like::
 
        A -> B -
                \
@@ -32,10 +32,10 @@ been acquired in the order, E and then C. The graph will look like:
    \                  /
     ------------------
 
-   where 'A -> B' means that acquisition A is prior to acquisition B
-   with A still held.
+where 'A -> B' means that acquisition A is prior to acquisition B
+with A still held.
 
-This graph contains a subgraph that demonstrates a loop like:
+This graph contains a subgraph that demonstrates a loop like::
 
                 -> E -
                /      \
@@ -67,6 +67,8 @@ mechanisms, lockdep doesn't work.
 
 Can lockdep detect the following deadlock?
 
+::
+
    context X	   context Y	   context Z
 
 		   mutex_lock A
@@ -80,6 +82,8 @@ Can lockdep detect the following deadlock?
 
 No. What about the following?
 
+::
+
    context X		   context Y
 
 			   mutex_lock A
@@ -101,7 +105,7 @@ What leads a deadlock
 ---------------------
 
 A deadlock occurs when one or multi contexts are waiting for events that
-will never happen. For example:
+will never happen. For example::
 
    context X	   context Y	   context Z
 
@@ -121,24 +125,24 @@ We call this *deadlock*.
 If an event occurrence is a prerequisite to reaching another event, we
 call it *dependency*. In this example:
 
-   Event A occurrence is a prerequisite to reaching event C.
-   Event C occurrence is a prerequisite to reaching event B.
-   Event B occurrence is a prerequisite to reaching event A.
+   * Event A occurrence is a prerequisite to reaching event C.
+   * Event C occurrence is a prerequisite to reaching event B.
+   * Event B occurrence is a prerequisite to reaching event A.
 
 In terms of dependency:
 
-   Event C depends on event A.
-   Event B depends on event C.
-   Event A depends on event B.
+   * Event C depends on event A.
+   * Event B depends on event C.
+   * Event A depends on event B.
 
-Dependency graph reflecting this example will look like:
+Dependency graph reflecting this example will look like::
 
     -> C -> A -> B -
    /                \
    \                /
     ----------------
 
-   where 'A -> B' means that event A depends on event B.
+where 'A -> B' means that event A depends on event B.
 
 A circular dependency exists. Such a circular dependency leads a
 deadlock since no waiters can have desired events triggered.
@@ -152,7 +156,7 @@ Introduce DEPT
 --------------
 
 DEPT(DEPendency Tracker) tracks wait and event instead of lock
-acquisition order so as to recognize the following situation:
+acquisition order so as to recognize the following situation::
 
    context X	   context Y	   context Z
 
@@ -165,18 +169,18 @@ acquisition order so as to recognize the following situation:
 				   event A
 
 and builds up a dependency graph in runtime that is similar to lockdep.
-The graph might look like:
+The graph might look like::
 
     -> C -> A -> B -
    /                \
    \                /
     ----------------
 
-   where 'A -> B' means that event A depends on event B.
+where 'A -> B' means that event A depends on event B.
 
 DEPT keeps adding each new dependency into the graph in runtime. For
 example, 'B -> D' will be added when event D occurrence is a
-prerequisite to reaching event B like:
+prerequisite to reaching event B like::
 
    |
    v
@@ -184,7 +188,7 @@ prerequisite to reaching event B like:
    .
    event B
 
-After the addition, the graph will look like:
+After the addition, the graph will look like::
 
                      -> D
                     /
@@ -209,6 +213,8 @@ How DEPT works
 Let's take a look how DEPT works with the 1st example in the section
 'Limitation of lockdep'.
 
+::
+
    context X	   context Y	   context Z
 
 		   mutex_lock A
@@ -220,7 +226,7 @@ Let's take a look how DEPT works with the 1st example in the section
 		   mutex_unlock A
 				   mutex_unlock A
 
-Adding comments to describe DEPT's view in terms of wait and event:
+Adding comments to describe DEPT's view in terms of wait and event::
 
    context X	   context Y	   context Z
 
@@ -248,7 +254,7 @@ Adding comments to describe DEPT's view in terms of wait and event:
 				   mutex_unlock A
 				   /* event A */
 
-Adding more supplementary comments to describe DEPT's view in detail:
+Adding more supplementary comments to describe DEPT's view in detail::
 
    context X	   context Y	   context Z
 
@@ -283,7 +289,7 @@ Adding more supplementary comments to describe DEPT's view in detail:
 				   mutex_unlock A
 				   /* event A that's been valid since 4 */
 
-Let's build up dependency graph with this example. Firstly, context X:
+Let's build up dependency graph with this example. Firstly, context X::
 
    context X
 
@@ -292,7 +298,7 @@ Let's build up dependency graph with this example. Firstly, context X:
    /* start to take into account event B's context */
    /* 2 */
 
-There are no events to create dependency. Next, context Y:
+There are no events to create dependency. Next, context Y::
 
    context Y
 
@@ -317,13 +323,13 @@ waits between 3 and the event, event B does not create dependency. For
 event A, there is a wait, folio_lock B, between 1 and the event. Which
 means event A cannot be triggered if event B does not wake up the wait.
 Therefore, we can say event A depends on event B, say, 'A -> B'. The
-graph will look like after adding the dependency:
+graph will look like after adding the dependency::
 
    A -> B
 
-   where 'A -> B' means that event A depends on event B.
+where 'A -> B' means that event A depends on event B.
 
-Lastly, context Z:
+Lastly, context Z::
 
    context Z
 
@@ -343,7 +349,7 @@ wait, mutex_lock A, between 2 and the event - remind 2 is at a very
 start and before the wait in timeline. Which means event B cannot be
 triggered if event A does not wake up the wait. Therefore, we can say
 event B depends on event A, say, 'B -> A'. The graph will look like
-after adding the dependency:
+after adding the dependency::
 
     -> A -> B -
    /           \
@@ -367,6 +373,8 @@ Interpret DEPT report
 
 The following is the example in the section 'How DEPT works'.
 
+::
+
    context X	   context Y	   context Z
 
 		   mutex_lock A
@@ -402,7 +410,7 @@ The following is the example in the section 'How DEPT works'.
 
 We can Simplify this by replacing each waiting point with [W], each
 point where its event's context starts with [S] and each event with [E].
-This example will look like after the replacement:
+This example will look like after the replacement::
 
    context X	   context Y	   context Z
 
@@ -419,6 +427,8 @@ This example will look like after the replacement:
 DEPT uses the symbols [W], [S] and [E] in its report as described above.
 The following is an example reported by DEPT for a real problem.
 
+::
+
    Link: https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
    Link: https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
 
@@ -620,6 +630,8 @@ The following is an example reported by DEPT for a real problem.
 
 Let's take a look at the summary that is the most important part.
 
+::
+
    ---------------------------------------------------
    summary
    ---------------------------------------------------
@@ -639,7 +651,7 @@ Let's take a look at the summary that is the most important part.
    [W]: the wait blocked
    [E]: the event not reachable
 
-The summary shows the following scenario:
+The summary shows the following scenario::
 
    context A	   context B	   context ?(unknown)
 
@@ -652,7 +664,7 @@ The summary shows the following scenario:
 
    [E] unlock(&ni->ni_lock:0)
 
-Adding supplementary comments to describe DEPT's view in detail:
+Adding supplementary comments to describe DEPT's view in detail::
 
    context A	   context B	   context ?(unknown)
 
@@ -677,7 +689,7 @@ Adding supplementary comments to describe DEPT's view in detail:
    [E] unlock(&ni->ni_lock:0)
    /* event that's been valid since 2 */
 
-Let's build up dependency graph with this report. Firstly, context A:
+Let's build up dependency graph with this report. Firstly, context A::
 
    context A
 
@@ -697,13 +709,13 @@ wait, folio_lock(&f1), between 2 and the event. Which means
 unlock(&ni->ni_lock:0) is not reachable if folio_unlock(&f1) does not
 wake up the wait. Therefore, we can say unlock(&ni->ni_lock:0) depends
 on folio_unlock(&f1), say, 'unlock(&ni->ni_lock:0) -> folio_unlock(&f1)'.
-The graph will look like after adding the dependency:
+The graph will look like after adding the dependency::
 
    unlock(&ni->ni_lock:0) -> folio_unlock(&f1)
 
-   where 'A -> B' means that event A depends on event B.
+where 'A -> B' means that event A depends on event B.
 
-Secondly, context B:
+Secondly, context B::
 
    context B
 
@@ -719,14 +731,14 @@ very start and before the wait in timeline. Which means folio_unlock(&f1)
 is not reachable if unlock(&ni->ni_lock:0) does not wake up the wait.
 Therefore, we can say folio_unlock(&f1) depends on unlock(&ni->ni_lock:0),
 say, 'folio_unlock(&f1) -> unlock(&ni->ni_lock:0)'. The graph will look
-like after adding the dependency:
+like after adding the dependency::
 
     -> unlock(&ni->ni_lock:0) -> folio_unlock(&f1) -
    /                                                \
    \                                                /
     ------------------------------------------------
 
-   where 'A -> B' means that event A depends on event B.
+where 'A -> B' means that event A depends on event B.
 
 A new loop has been created. So DEPT can report it as a deadlock! Cool!
 
diff --git a/Documentation/dependency/dept_api.txt b/Documentation/locking/dept_api.rst
similarity index 97%
rename from Documentation/dependency/dept_api.txt
rename to Documentation/locking/dept_api.rst
index 8e0d5a118a460e..96c4d65f4a9a2d 100644
--- a/Documentation/dependency/dept_api.txt
+++ b/Documentation/locking/dept_api.rst
@@ -10,6 +10,8 @@ already applied into the existing synchronization primitives e.g.
 waitqueue, swait, wait_for_completion(), dma fence and so on.  The basic
 APIs of SDT are:
 
+.. code-block:: c
+
    /*
     * After defining 'struct dept_map map', initialize the instance.
     */
@@ -27,6 +29,8 @@ APIs of SDT are:
 
 The advanced APIs of SDT are:
 
+.. code-block:: c
+
    /*
     * After defining 'struct dept_map map', initialize the instance
     * using an external key.
@@ -83,6 +87,8 @@ Do not use these APIs directly.  These are the wrappers for typical
 locks, that have been already applied into major locks internally e.g.
 spin lock, mutex, rwlock and so on.  The APIs of LDT are:
 
+.. code-block:: c
+   
    ldt_init(map, key, sub, name);
    ldt_lock(map, sub_local, try, nest, ip);
    ldt_rlock(map, sub_local, try, nest, ip, queued);
@@ -96,6 +102,8 @@ Raw APIs
 --------
 Do not use these APIs directly.  The raw APIs of dept are:
 
+.. code-block:: c
+
    dept_free_range(start, size);
    dept_map_init(map, key, sub, name);
    dept_map_reinit(map, key, sub, name);
diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index 6a9ea96c8bcb70..7ec3dce7fee425 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -24,6 +24,8 @@ Locking
     percpu-rw-semaphore
     robust-futexes
     robust-futex-ABI
+    dept
+    dept_api
 
 .. only::  subproject and html
 

> +Can lockdep detect the following deadlock?
> +
> +   context X	   context Y	   context Z
> +
> +		   mutex_lock A
> +   folio_lock B
> +		   folio_lock B <- DEADLOCK
> +				   mutex_lock A <- DEADLOCK
> +				   folio_unlock B
> +		   folio_unlock B
> +		   mutex_unlock A
> +				   mutex_unlock A
> +
> +No. What about the following?
> +
> +   context X		   context Y
> +
> +			   mutex_lock A
> +   mutex_lock A <- DEADLOCK
> +			   wait_for_complete B <- DEADLOCK
> +   complete B
> +			   mutex_unlock A
> +   mutex_unlock A

Can you explain how DEPT detects deadlock on the second example above (like
the first one being described in "How DEPT works" section)?

Confused...

-- 
An old man doll... just what I always wanted! - Clara

