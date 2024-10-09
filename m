Return-Path: <linux-arch+bounces-7917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB19973D1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 19:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD141C23FBA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147871D356C;
	Wed,  9 Oct 2024 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4yhj5G8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3C1A2630;
	Wed,  9 Oct 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496515; cv=none; b=j+hIgkVsAMdT4OJIb2FqYT163mj0zWHT9Y8yqPWuhLJBzm4ZbbrpUDjtvnYVZymDJDBbLn91eX14gdxQ3tbSvLjfSb4J+ZR/QiF8zXdFxbw+NetcTV6sZRQRLn2UHY0/3QeLuhbAYFLyXUazrXvM3WQldj5g2GlseS4Fg5SqEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496515; c=relaxed/simple;
	bh=1YGuxVVUFMnIT64wnOVEF5YvN1kGXOWmBGuMUEBycUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IW/9MOvvISraOSPCdL9WGP34To/tGHGwOmYP2zmqMI8jhMZBB3Ucx4GNo39cxD+qZHYLd4ZIV160mrpOLbs8r4lzul6ozRKsEieTJ38tusbJexEGhmKzOf7stCusb0PqsIAJSILEwf1Pfj9JJMURgNy+jao23cXD526xHnah19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4yhj5G8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9FC4CEC3;
	Wed,  9 Oct 2024 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496513;
	bh=1YGuxVVUFMnIT64wnOVEF5YvN1kGXOWmBGuMUEBycUk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=h4yhj5G8jgZA070kaJh/jWqfZffY5OQOR+OyYw+efM7jzNSnq/Abtke0dec9Fj5gx
	 90M6TeoTMdJFCWtigIxMLMRmPO0ADkneZlAOXIpM2bqxa2ElcnO/ePbhnqpilfZThC
	 q6enAgBy7RaL75aDdABc53UQh5DvPP2OAx94RHfzwYBJ+cVEi51eBAhXpe9dOrf/2A
	 NyrHD+2Wskkrn5YPjY7O0D6hEaXypn8QUy6vDzVY8m+IMRUufZkUc3yGC5aXHiglDs
	 56N7xOPNcwwBszwa6n1sgtr3qIW0ogpGZtmaaDaw/lBDm89BbzGxmDaGAZtAP0FTUj
	 NNNrmU57ZMxxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1646ECE08E5; Wed,  9 Oct 2024 10:55:13 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:55:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org
Cc: vgupta@kernel.org
Subject: ARC: Use __force to suppress per-CPU cmpxchg complaints
Message-ID: <c88fafb4-47d9-49b6-aeb6-5a83c9778791@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, the cast of the first argument to cmpxchg_emu_u8() drops the
__percpu address-space designator, which results in sparse complaints
when applying cmpxchg() to per-CPU variables in ARC.  Therefore, use
__force to suppress these complaints, given that this does not pertain
to cmpxchg() semantics, which are plently well-defined on variables in
general, whether per-CPU or otherwise.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: <linux-snps-arc@lists.infradead.org>

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 58045c8983404..76f43db0890fc 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -48,7 +48,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 1:								\
-		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\

