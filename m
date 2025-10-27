Return-Path: <linux-arch+bounces-14351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190AC0CAB3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 10:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD22B3A6FB4
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2D2E92D6;
	Mon, 27 Oct 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J2p2qfnG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bpj003fp"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D61EEA6;
	Mon, 27 Oct 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557346; cv=none; b=l3JxB6OcBfnKa25HGHS76H24RAbwaDfxbIZq+CExsNJ3mpvAiLvbMED7h7EK5Mp2OkNjUIaDMPeW7SkpSYgmkGOxMq7Gyk2SK5KGNw+Sv+8S4YmcuPCkp3GCdP8st7BhLr07/gBkWCZaZoG+bvTgtCL1RCY/ywUzaihQeRxpmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557346; c=relaxed/simple;
	bh=+BWwjSsK3LJJOmiDFTF+Hy6QpGnroVjKs/vRRZ/rk30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBVGUMkHNiXoPNOoI2eoqH8TrJOAHBeTNJV4c6JPqpm+IaA58koDHVVMVeF3hFtqr59K9dmM4UQZBvTcs3hOM3wN3QwaS5/1yf1yFVzidp4xzy0wfTee/XoDrH1VRPDuV5qlXyQ/V/7ycBCwnAdtWCc9zylM3YOQ3BW+c8cq6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2p2qfnG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bpj003fp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 10:29:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761557343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dN2WGLKJLTILaSCeVMwVxkFyJlJGIPBlamDv+nHPaTc=;
	b=J2p2qfnGHgRJ3BvgvsnniZWuDKdN+t9UQe7q4baD2L2nnbqDikUapSl1P6FZSGcvqNRLS+
	x8wnvprs+MGbc2jGrhGGxYjNsClpyoyGJLbeP9kqDTFsEDqR1wae9tQYwuXu7w0fk6P8RY
	dbAgASIJ9m1YBdkHfHUspT0OFzTVGLWS1z6FxGdaCn2WF1uZg8xEkcydqPY18TiZb0hVOI
	G4m2/IJAxWXHgBOcZID72toNFdi2QJaue4xbqXXAkx/1pS4VV7aJUIrd1lELzXF49CqfHv
	i1pEmcmJiqRPvAMpkW8+27dAO6SFDD2/Vz1OihXdYzKekwWybodGnZjp9ZOpRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761557343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dN2WGLKJLTILaSCeVMwVxkFyJlJGIPBlamDv+nHPaTc=;
	b=Bpj003fprKxxi7SMLMy6A7fyp99rPfNgf0JgjIx7iLe5+S5sd2jP/xu6dFbELSsb7J+cAm
	yEwDhi4EmySkHBBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 03/12] rseq: Provide static branch for time slice
 extensions
Message-ID: <20251027092901.fm5D-9TX@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.091502763@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022121427.091502763@linutronix.de>

On 2025-10-22 14:57:32 [+0200], Thomas Gleixner wrote:
> Guard the time slice extension functionality with a static key, which can
> be disabled on the kernel command line.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Might want to fold:

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e5..34325cf61b8de 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6482,6 +6482,10 @@
 
 	rootflags=	[KNL] Set root filesystem mount option string
 
+	rseq_slice_ext= [KNL] RSEQ slice extension
+			Disable the slice extension at boot time by
+			setting it to "off". Default is "on".
+
 	initramfs_options= [KNL]
                         Specify mount options for for the initramfs mount.
 

Sebastian

