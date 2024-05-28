Return-Path: <linux-arch+bounces-4554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480898D19B6
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17182866E0
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A816C6A5;
	Tue, 28 May 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hZ78wS4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKdIValk"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21016C840;
	Tue, 28 May 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896161; cv=none; b=sBV+DNm89c5CsMu/UZBvOk9kwbueFO3HRm7rV817xu0BkNzCnCBBVu55btY1Rgq9cati+9Ooq3gPkkNxAt0Z3vRYOiKPWZFeqFIb1DGy2QSdN/LpcvlmvBe7JZiYiCHNnReF9s7ksdW1nWpAs9tPDWxsTuX+slO0kMtQytvJuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896161; c=relaxed/simple;
	bh=jFZXicEE6r2ZgbR45j79punfT8HXTNnMc7smmAivjRA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=T96+OB4h9FrfN4m67zFff3hCiqI9+aI2eruBtOGAXnl4330WtAMfUamubHsvfLesI1e2iaBW0wOqwn5UZHzGjUFKBnRTFUouuyWPhPQGj6lIT7cNZWawLTOxbo/QO1zyBt5B5pEPjknjid9ugDxIB4rb82c3oWYzD9huxYdvPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hZ78wS4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKdIValk; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B54BD1C00179;
	Tue, 28 May 2024 07:35:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 28 May 2024 07:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716896157; x=1716982557; bh=Ol7jO+/V1Y
	fPpFVSV5jUah0yPkjfrGrX9WAAgHtbTLo=; b=hZ78wS4owIYvRnqNcJ9zGfh2iV
	29FeERqf3tpc8bFg+119EFqupV4BcHaAixDPQ47HIBf8Va8r8u53824y7iiTbej1
	MQ3Ke5XbklsNLFtST6f7l9RTYPqbHEMJDAnZMzX+kGBk2MB4d0k1z23r2WDbgVrg
	UBwkOCAHYD6SFAULTM/yWP6U78j89HNt7iI/+Y7q2Ql1c161o27u5Yxhmp2v7ARr
	sDFdO+96dQ225yu/Ii5e1lTtKoyOYwfIHiI0XWKmHqgqj+YGIYByqaYCNfpJ93lc
	6ArP5tRztJw096mbCSMpnzOeYGRcjCLM7nqvtXrhnSd9twjdWIjJsh2HIgPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716896157; x=1716982557; bh=Ol7jO+/V1YfPpFVSV5jUah0yPkjf
	rGrX9WAAgHtbTLo=; b=LKdIValkUX29uWFgX5KgpSQVm0yXzqOkReHvvYMzUm+9
	ExhSup/6OzeBkUR5DXy+puro6xhfaLxUZNx5kvtYDBYfZpzZohrP2PCuNxR4ajSj
	Yn8uN3xZrTiaHZTTbtcarB8EATSdnFlQDCsoDm9F4Q6C+GmHBQBddku2wu+j9mMz
	80l4SOr4R47zcy1jIrfdPP5IZ0Nv7r+gELqY+vT8cpZr9xUny9sw+a4Kw2Lna5hZ
	0u2zN6Hi/VqUTAC2yQ/YYLXNxm4kwQfPFOjMAtvV27r6StED/Snt/kUe/ZjuK49B
	B6DnjNG/4ycIwMX+mgoY6uhuCE+OaoncVm8mviv19w==
X-ME-Sender: <xms:ncFVZusps8MWQSH-dHY1h1l4dzkxCQLLuGf_MNovm0bEnohNg2dIew>
    <xme:ncFVZjcXjAHp9BIQ7PIuZNTVMSHLHXqyTmQFaQ13zDAW4-2Xw4yw0zoKX84WoEr6p
    YfNFIG9wDZPl0dlRwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ncFVZpyklZXOsQhzaV6ANYCsXeccqVs3Qr8cqaVu5DBISxWaL73cTg>
    <xmx:ncFVZpOqTm-o2yGPweFMDRnQKihWkkr1yN13tbT-4E629rk7U107-g>
    <xmx:ncFVZu92hgdGZ9Sd9pAnhRvscY6gMI_tRQAJXJpzKTU8NEIxHi0cYA>
    <xmx:ncFVZhX6VWqtl6iOxPyjzhjQtS9-6ohJJZC8wITAuShIC0Pfs6PZow>
    <xmx:ncFVZiaxhTGGmMouGpEhLsmQCUxA_yjYOeP91tCDt2Dcj3G1zmLeKALI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 116C4B6008D; Tue, 28 May 2024 07:35:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e8dee26-41cc-41ae-9493-10cd1a8e3268@app.fastmail.com>
In-Reply-To: <20240506133544.2861555-2-masahiroy@kernel.org>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <20240506133544.2861555-2-masahiroy@kernel.org>
Date: Tue, 28 May 2024 13:35:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 1/3] kbuild: provide reasonable defaults for tool coverage
Content-Type: text/plain

On Mon, May 6, 2024, at 15:35, Masahiro Yamada wrote:
> The objtool, sanitizers (KASAN, UBSAN, etc.), and profilers (GCOV, etc.)
> are intended for kernel space objects. To exclude objects from their
> coverage, you need to set variables such as OBJECT_FILES_NON_STNDARD=y,
> KASAN_SANITIZE=n, etc.
>
> For instance, the following are not kernel objects, and therefore should
> opt out of coverage:
>
>   - vDSO
>   - purgatory
>   - bootloader (arch/*/boot/)
>
> Kbuild can detect these cases without relying on such variables because
> objects not directly linked to vmlinux or modules are considered
> "non-standard objects".
>
> Detecting objects linked to vmlinux or modules is straightforward:
>
>   - objects added to obj-y are linked to vmlinux
>   - objects added to lib-y are linked to vmlinux
>   - objects added to obj-m are linked to modules
>

I noticed new randconfig build warnings and bisected them
down to this patch:

warning: unsafe memchr_inv() usage lacked '__read_overflow' symbol in lib/test_fortify/read_overflow-memchr_inv.c
warning: unsafe memchr() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr.c
warning: unsafe memscan() usage lacked '__read_overflow' symbol in lib/test_fortify/read_overflow-memscan.c
warning: unsafe memcmp() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memcmp.c
warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memcpy.c
warning: unsafe memcmp() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcmp.c
warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memmove.c
warning: unsafe memcpy() usage lacked '__read_overflow2_field' symbol in lib/test_fortify/read_overflow2_field-memcpy.c
warning: unsafe memmove() usage lacked '__read_overflow2_field' symbol in lib/test_fortify/read_overflow2_field-memmove.c
warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memcpy.c
warning: unsafe memmove() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memmove.c
warning: unsafe memset() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memset.c
warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strcpy-lit.c
warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strcpy.c
warning: unsafe strncpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strncpy-src.c
warning: unsafe strncpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strncpy.c
warning: unsafe strscpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strscpy.c
warning: unsafe memcpy() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memcpy.c
warning: unsafe memmove() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memmove.c
warning: unsafe memset() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memset.c

I don't understand the nature of this warning, but I see
that your patch ended up dropping -fsanitize=kernel-address
from the compiler flags because the lib/test_fortify/*.c files
don't match the $(is-kernel-object) rule. Adding back
-fsanitize=kernel-address shuts up these warnings.

I've applied a local workaround in my randconfig tree

diff --git a/lib/Makefile b/lib/Makefile
index ddcb76b294b5..d7b8fab64068 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -425,5 +425,7 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 
 # Fake dependency to trigger the fortify tests.
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
+ifndef CONFIG_KASAN
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
+endif
 endif


which I don't think we want upstream. Can you and Kees come
up with a proper fix instead?

     Arnd

