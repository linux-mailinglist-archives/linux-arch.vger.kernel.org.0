Return-Path: <linux-arch+bounces-12331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C6AD7F51
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 02:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA8F3B03D4
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD1EAF1;
	Fri, 13 Jun 2025 00:01:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703032581;
	Fri, 13 Jun 2025 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772919; cv=none; b=J5WPPAi8/qyAJ8gDthD5gf95uPaZswjnJvQpPVtF6Hc+Y1gcTj3AhVrHTVIWqqR4mLBLwXjZwWdh32um+HrVw8ysP6+Mk7k3a3WCtfDN0cRxgGjw0NegjBsKls2DnD05Flcl4gtGmlTAfUM+D7EGtIOGPqOwR4msurFNKMl7dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772919; c=relaxed/simple;
	bh=8DgMDOVyi1UQysuCYqsGqAUmquXWykBR0aOhtrr7Gzk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q2tY7EcX6aMfYfchoze1aG8m7AR/Q0xnLVgkWADN3gEda9+SNAafGK5DWjvY7yZkjme6dPdXegpMXHYMWekez2cdrChkGny+XsFSAlZXYurluW/5xw7HOc72o4u4qYrvh4fe5U6N3YC902umcBVDXw1wXruoyVA++PPcOxNE8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CF0931A041E;
	Fri, 13 Jun 2025 00:01:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 993F420032;
	Fri, 13 Jun 2025 00:01:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPrtJ-00000001wn9-17Qv;
	Thu, 12 Jun 2025 20:03:29 -0400
Message-ID: <20250613000329.115315469@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 19:58:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/5] tracepoint: Do not warn for unused event that is exported
References: <20250612235827.011358765@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 993F420032
X-Stat-Signature: 1zxbipspbpwgk4eze9dcw4fckdd6tc8h
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qD7yXiaPbCBd8OTZRmHSXVEzFmcJHrhc=
X-HE-Tag: 1749772912-324570
X-HE-Meta: U2FsdGVkX1/ZOp03+AQjtW3CXX65J6zD9icmeRKGsXHWTMWM2Q20vEG6fR7TiEqxhT4XhpXFzc/pd7I7ogMJWup0s+XPm907xrkNZ+nEbkscUh3gZpBTQC18TOJjhXGLbj0436VUmtmVnsNhtdOlMxa4KUaRgbH5xbAOJ/dDSK9G2/onQMCAv+UeUfKpwGsLE/94f9STx1LChBLzSYXlJhe7/uhQVqWt7evA5BdBIPlUd9g5BBhHyrgLFvIGuGy3Sml8tV8W2Is5AdS3VFsfeUKTTShF61m9qPj1pwJaGd1IDH5J6GopMojq/3nZQVO8yz0CAkSn6G5cULEwl0J2j6zyIdJOq53CrYkMebqfh5cvJ9tcuhH4vaoIAzhsGjA9xn+ASTFwysH7ibmKRb7FTA==

From: Steven Rostedt <rostedt@goodmis.org>

There are a few generic events that may only be used by modules. They are
defined and then set with EXPORT_TRACEPOINT*(). Mark events that are
exported as being used, even though they still waste memory in the kernel
proper.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 2b96c7e94c52..8026a0659580 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -223,7 +223,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #ifdef CONFIG_TRACEPOINT_VERIFY_USED
 # define TRACEPOINT_CHECK(name)						\
-	static void __used __section("__tracepoint_check") *__trace_check = \
+	static void __used __section("__tracepoint_check") *		\
+	__trace_check_##name =						\
 		&__tracepoint_##name;
 #else
 # define TRACEPOINT_CHECK(name)
@@ -381,10 +382,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
+	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
 	EXPORT_SYMBOL_GPL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
+	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL(__tracepoint_##name);				\
 	EXPORT_SYMBOL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL(tp_func_##name)
-- 
2.47.2



