Return-Path: <linux-arch+bounces-12556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C921AF7CE5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEFB564516
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056922F77F;
	Thu,  3 Jul 2025 15:52:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5451FFC46;
	Thu,  3 Jul 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557949; cv=none; b=B8EYlNQE/DHucTOjk1GYtUdn45zp2mt7exSKXsD/ZTmLNgxOcU1O8um5Nx+nExNrKXXri0i4hDYiXfGwjBjC4OSqOLUy1osD9JNHlT7O49Jf11EVxjWWTRDEApsbSyGUgPwtqCWyoNG7IQ4ztJAP45jEMwcVpsqcdUWnw8CdN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557949; c=relaxed/simple;
	bh=jwgKZTPaZQlwll7qCULdeQgNvtUTTT/x/yMZSiwNCwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=on3Gz+GBjRpxeI8fCUX1PX1KpZaPhk0x7fQ9JGLLePUtPkE3CRQQt1JHIC4DSPjogv3KpkEDC2j2xzo54U/MnSAf7cun4VSMc8s9As0SmQzgiz598P2Tv1DtdkFcWibnaAUUb+HO+sgzxyaWCMNT2paLChDx6Ze/kwiQv+c6Zqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6BE4C1D3D6D;
	Thu,  3 Jul 2025 15:52:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 5B44433;
	Thu,  3 Jul 2025 15:52:23 +0000 (UTC)
Date: Thu, 3 Jul 2025 11:52:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Alexandre Ghiti
 <alex@ghiti.fr>, ChenMiao <chenmiao.ku@gmail.com>,
 linux-arch@vger.kernel.org
Subject: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
Message-ID: <20250703115222.2d7c8cd5@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dfnkcxf73rcxdf54d4ej8zbyr86zosuy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5B44433
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1941fakycO7fuixZ+xnYJobriHijGZxFo0=
X-HE-Tag: 1751557943-567718
X-HE-Meta: U2FsdGVkX1+SUmEj7Iin14aLs/X5m3iQXwVMmZcDYZr7pBi5yC56SE0+vRaEXCEvgookkK+fOlzaZS2AS55vrq/oXrmgjhD/y6YMUUGbIluIRTKQFs+0zKEH/1KkAVpWs9QXzLzOf8P47ivGbBq0cxh5h/O5unyC4+BizN24I1qIaT11atH6g149UACqZaTkZVW75PrcHbnm7hWhW7f3/ZmY3cxc/aHjoqYELWJ0AJlecP7azdaNrdHQANkRvrDyuRKBQ6g7ESMnDGXtfkB34DRbaAHZMtYQlqTuI/+hIwbJ2ehP3dWSyrstyaVNojv5teDKzJIz3kKaP9HOXD5czraiKZy8QjIO3xeY0mjY+VtbmUuiJSKxN6oeZGxRx9Cr2CRmHCT1KoinVz7GXLYRFA==

From: Steven Rostedt <rostedt@goodmis.org>

ftrace has two flavors:

 1) static: Where every function always calls the ftrace trampoline

 2) dynamic: Where each function has nops that can be changed on demand to
             jump to the ftrace trampoline when needed.

The static flavor has very high performance overhead and was only created
to make it easier for architectures to implement the dynamic flavor. An
architecture developer can first implement the static ftrace to make sure
the trampolines work before working on the more complicated dynamic aspect
of ftrace. Once the architecture can support dynamic ftrace, there's no
reason to continue to support the static flavor. In fact, the static
flavor tends to bitrot and bugs start to appear in them.

Remove the prompt to pick DYNAMIC_FTRACE and simply enable it if the
architecture supports it.

Link: https://lore.kernel.org/all/f7e12c6d-892e-4ca3-9ef0-fbb524d04a48@ghiti.fr/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..28afc6941e7a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -275,7 +275,7 @@ config FUNCTION_TRACE_ARGS
 	  funcgraph-args (for the function graph tracer)
 
 config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
+	bool
 	depends on FUNCTION_TRACER
 	depends on HAVE_DYNAMIC_FTRACE
 	default y
-- 
2.47.2


