Return-Path: <linux-arch+bounces-4483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942E8CB3CE
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 20:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C78B20C6D
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818D2D047;
	Tue, 21 May 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QViIUyaS"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848591FBB;
	Tue, 21 May 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317220; cv=none; b=G6r1r8wEXXSjcDSnaqPJwL3Ztvau8ELi/q4lJgPVmwLRC6jOjlq5tmEP9/Uq1DjcIBClX7kQ5NcSTK1HX3bMIYTaBb4d4um1Sf304gv9BufUgtfzvCmLZI/y843Ub45OP7+0nYC4tHrquCY8jlNQYS7woPp6NXw3Odg05nPl0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317220; c=relaxed/simple;
	bh=XqxKOHttdZ46eK91LTby3jcYvDTPEtz6AIEvPA04bec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCZL2fD6tStyg5mWU1MrKARDuNO+jj09RPtEJifUY3X98IP0QGaNjOe7iOKYMosHook+ixhy0sKLMzRRe0asbis8/H98ubVV4oO4Yi0pEiXP1ukQ8sCiSFMjLLNmfZEo/Plc2h4HIJaMqiNr26q27PMOmVwRlf4W/bJLY/Bua94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QViIUyaS; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y/5UVdvZ1lmITZcH56jVLeBbXXMJ/x+KMGtg8QR5gjY=; t=1716317216; x=1716922016; 
	b=QViIUyaS5g6cq8jZ5a/2fvkWiF9aPY3NhmBPcJT79gYbWliHfzldPeb5SaE77ubNshtmy/0sjQq
	b64/RFVed8TLdLUFDgcdnUhmFeja3+w/oKty+K61hsn5WVvjWjyjua9dxuZAkqTbJ8kB9CxZujkyF
	5kfDWG/tT/O0xqWqWSkSeX6CWyasiT9s9bKENiuCju2yjrsBNUojQ+8QnJa85v4bV6nhU1OT4+3Ph
	2E7qIYrRDEVYg4Mo0H+X+kib7qHNvcLCb5ohmbRPLo2ol7W7S0aXsvi5DHEvWtFtXAPQwnUwtCmO8
	nEwcmqWzWeWZMcb4Lk1hDJiwDWv/BBoH9Pjg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s9UVh-00000000hEi-0uCa; Tue, 21 May 2024 20:46:53 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s9UVh-00000001cSH-020X; Tue, 21 May 2024 20:46:53 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1s9UVg-007rnG-2B;
	Tue, 21 May 2024 20:46:52 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: mattst88@gmail.com
Cc: keescook@chromium.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate warn_slowpath_fmt() usage)
Date: Tue, 21 May 2024 20:46:52 +0200
Message-Id: <20240521184652.1875074-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

Replacing the calls to raw_smp_processor_id() in __warn() with just "0" fixes the problem for me:

diff --git a/kernel/panic.c b/kernel/panic.c
index 8bff183d6180..12f6cea6b8b0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -671,11 +671,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
        if (file)
                pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
-                       raw_smp_processor_id(), current->pid, file, line,
+                       0, current->pid, file, line,
                        caller);
        else
                pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
-                       raw_smp_processor_id(), current->pid, caller);
+                       0, current->pid, caller);
 
 #pragma GCC diagnostic push
 #ifndef __clang__

So, I assume the problem is that SMP support is not fully initialized at this
point yet such that raw_smp_processor_id() causes the zero pointer dereference.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

