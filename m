Return-Path: <linux-arch+bounces-5292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDAA929609
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 02:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D0A1C20DC3
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0242901;
	Sun,  7 Jul 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz8AsGmq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A17FF;
	Sun,  7 Jul 2024 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720310481; cv=none; b=Jq/aQ9sasvAjcTWYXk6dlJ2XZfVl7e5+QGj9FHcvQyFJRnYl+nhksZBoq2RbL8o9ioPIrEXQJ2lMv3NkK2tPuAzbS6kxXp+gDMihBJQDtPakl+HdjFqwqFh7bFV+WKu/lVDsfhCh//zS0Q1u3IdcHgOOMIkqtFfI2fWsqTIYpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720310481; c=relaxed/simple;
	bh=afTn7IR0Zw6dR3NsWMS6k7V8+w95BZZ/12iOIKEqAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cfux7dN92THBN62pVtSsSLTB4HQdZwOdJ96fAsMMAE02ONGZMgwRhtCUbgegjxitWpZePUMRpVKoT+uHSR+sdFsHlWruaQhv7VHqQjscBlMt/jP0CR9+H7Zkda9vL/cWBaUcdRjY2GaWPCUx8SrbXoxWL5vAWRgj3lV5wQqxCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz8AsGmq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so3044445a12.3;
        Sat, 06 Jul 2024 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720310478; x=1720915278; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMokTtKGEeYAS/9d6XHv/W22/lFFy1EwKEMR9en516U=;
        b=Kz8AsGmqGfw1loXY9XrewuXwGCbuHtC1aB8R2cp0G3GKwKQSP4oSQWpx8l+wgBlTZQ
         W2yIlhzDv5N46wRrMSTyZdKNFjL58Hb2IJRSOJgz2PMU9S7QhgqEVV8FL9V/G61Nibym
         OhmY2n0AIfoYJFDwgzA3TjUP9AK/VpoGc3HlSih2rMPEipN9zl0tYytTow3dK8lIvu3j
         mgwmV07Ca4TE3vpTyS2G+mGPjczwHvqwQi8HqLnKVO7D03d2caORr27WrCmmTiRx28zu
         jlYmPrS3C8P38P9oc9ZDFyrhC1SBOi6aBnl2SaPogwqIZFLHK3ptIWel1+OwMLy316Ju
         oxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720310478; x=1720915278;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMokTtKGEeYAS/9d6XHv/W22/lFFy1EwKEMR9en516U=;
        b=F4IsqyxSzncoW3yi4AVIh4l8OFW3CtoTSZN/A6rC4KHO8pVBcpzVrDRL0ECer1RQCP
         7csr1s7MQloxccQ8FJnNOWzvK3DGN/Iic6lCKecAJxRsDIwECr0PpGZ24QNWRT01aDAP
         B4gj10WM6kSZ4oGBD01+cb+dedGC6L+KcpuC/M4TfqwMEFA3gtuI/c9wlc0Hg1n9eZon
         nWxX2zrFt2Zmh7NtKMNuDHUrti9rK829G/L5v0eTLc7OzuoNZsd1EX5szLHi6gKScq+w
         CPgGWKLJ0KHzZ9IwAGH7L0KZA+SzLUAevoB7tIIGhh7JOuD3jyRo/Q0rQIZghoEO4S97
         2EKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNzwpaid4pG3nmPVvZHi8rU0UMa3nYKIiIn4Qbw8t22UsEbUkuagXsaBc1LJYTg+k1lIm5Jeh0T8kUmZuLmmHWBITkLcDei/9DJD9PckIZkMxD66C2vpKQqZg/byfOQp32Hrvs8GxUWQ==
X-Gm-Message-State: AOJu0Yz5Ht3D3a7HHkIhUvCepEIA77wzZE428SO3vdGjJuSZ6tQTbzY3
	4+VmY6BGeGIrd9NejJjISl5IEL+e2ksiaK/AMdOXeOzaER0C4T1ZVJAzo+NQsDY=
X-Google-Smtp-Source: AGHT+IEiwiE87Y1j9LwDTZnHO/ZBG2J/lZglQrX560RXWDEfckKDbksmN13EqtGH5tNxBDcg+s64Tg==
X-Received: by 2002:a05:6402:311c:b0:58c:adad:cbb with SMTP id 4fb4d7f45d1cf-58e5cc0b694mr4150004a12.38.1720310478110;
        Sat, 06 Jul 2024 17:01:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58c9061becfsm5325650a12.83.2024.07.06.17.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Jul 2024 17:01:17 -0700 (PDT)
Date: Sun, 7 Jul 2024 00:01:17 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/2] init/modpost: conditionally check section mismatch
 to __meminit*
Message-ID: <20240707000117.kpotqs3xgfrtllzd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240706160511.2331061-1-masahiroy@kernel.org>
 <20240706160511.2331061-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706160511.2331061-2-masahiroy@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Jul 07, 2024 at 01:05:06AM +0900, Masahiro Yamada wrote:
>This reverts commit eb8f689046b8 ("Use separate sections for __dev/
>_cpu/__mem code/data").
>
>Check section mismatch to __meminit* only when CONFIG_MEMORY_HOTPLUG=y.
>
>With this change, the linker script and modpost become simpler, and we
>can get rid of the __ref annotations from the memory hotplug code.
>

Oh, totally get rid of .meminit.*. Looks nice.
Maybe we can plan a __ref cleanup after this on is merged?

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>---
>
> include/asm-generic/vmlinux.lds.h | 18 ++----------------
> include/linux/init.h              | 14 +++++++++-----
> scripts/mod/modpost.c             | 19 ++++---------------
> 3 files changed, 15 insertions(+), 36 deletions(-)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index 62b4cb0462e6..c23f7d0645ad 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -141,14 +141,6 @@
>  * often happens at runtime)
>  */
> 
>-#if defined(CONFIG_MEMORY_HOTPLUG)
>-#define MEM_KEEP(sec)    *(.mem##sec)
>-#define MEM_DISCARD(sec)
>-#else
>-#define MEM_KEEP(sec)
>-#define MEM_DISCARD(sec) *(.mem##sec)
>-#endif
>-
> #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> #define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
> #define PATCHABLE_DISCARDS
>@@ -357,7 +349,6 @@
> 	*(.data..decrypted)						\
> 	*(.ref.data)							\
> 	*(.data..shared_aligned) /* percpu related */			\
>-	MEM_KEEP(init.data*)						\
> 	*(.data.unlikely)						\
> 	__start_once = .;						\
> 	*(.data.once)							\
>@@ -523,7 +514,6 @@
> 	/* __*init sections */						\
> 	__init_rodata : AT(ADDR(__init_rodata) - LOAD_OFFSET) {		\
> 		*(.ref.rodata)						\
>-		MEM_KEEP(init.rodata)					\
> 	}								\
> 									\
> 	/* Built-in module parameters. */				\
>@@ -574,8 +564,7 @@
> 		*(.text.unknown .text.unknown.*)			\
> 		NOINSTR_TEXT						\
> 		*(.ref.text)						\
>-		*(.text.asan.* .text.tsan.*)				\
>-	MEM_KEEP(init.text*)						\
>+		*(.text.asan.* .text.tsan.*)
> 
> 
> /* sched.text is aling to function alignment to secure we have same
>@@ -682,7 +671,6 @@
> #define INIT_DATA							\
> 	KEEP(*(SORT(___kentry+*)))					\
> 	*(.init.data .init.data.*)					\
>-	MEM_DISCARD(init.data*)						\
> 	KERNEL_CTORS()							\
> 	MCOUNT_REC()							\
> 	*(.init.rodata .init.rodata.*)					\
>@@ -690,7 +678,6 @@
> 	TRACE_SYSCALLS()						\
> 	KPROBE_BLACKLIST()						\
> 	ERROR_INJECT_WHITELIST()					\
>-	MEM_DISCARD(init.rodata)					\
> 	CLK_OF_TABLES()							\
> 	RESERVEDMEM_OF_TABLES()						\
> 	TIMER_OF_TABLES()						\
>@@ -708,8 +695,7 @@
> 
> #define INIT_TEXT							\
> 	*(.init.text .init.text.*)					\
>-	*(.text.startup)						\
>-	MEM_DISCARD(init.text*)
>+	*(.text.startup)
> 
> #define EXIT_DATA							\
> 	*(.exit.data .exit.data.*)					\
>diff --git a/include/linux/init.h b/include/linux/init.h
>index b2e9dfff8691..ee1309473bc6 100644
>--- a/include/linux/init.h
>+++ b/include/linux/init.h
>@@ -84,11 +84,15 @@
> 
> #define __exit          __section(".exit.text") __exitused __cold notrace
> 
>-/* Used for MEMORY_HOTPLUG */
>-#define __meminit        __section(".meminit.text") __cold notrace \
>-						  __latent_entropy
>-#define __meminitdata    __section(".meminit.data")
>-#define __meminitconst   __section(".meminit.rodata")
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+#define __meminit
>+#define __meminitdata
>+#define __meminitconst
>+#else
>+#define __meminit	__init
>+#define __meminitdata	__initdata
>+#define __meminitconst	__initconst
>+#endif
> 
> /* For assembly routines */
> #define __HEAD		.section	".head.text","ax"
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index 3e5313ed6065..8c8ad7485f73 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -776,17 +776,14 @@ static void check_section(const char *modname, struct elf_info *elf,
> 
> 
> #define ALL_INIT_DATA_SECTIONS \
>-	".init.setup", ".init.rodata", ".meminit.rodata", \
>-	".init.data", ".meminit.data"
>+	".init.setup", ".init.rodata", ".init.data"
> 
> #define ALL_PCI_INIT_SECTIONS	\
> 	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
> 	".pci_fixup_enable", ".pci_fixup_resume", \
> 	".pci_fixup_resume_early", ".pci_fixup_suspend"
> 
>-#define ALL_XXXINIT_SECTIONS ".meminit.*"
>-
>-#define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
>+#define ALL_INIT_SECTIONS ".init.*"
> #define ALL_EXIT_SECTIONS ".exit.*"
> 
> #define DATA_SECTIONS ".data", ".data.rel"
>@@ -797,9 +794,7 @@ static void check_section(const char *modname, struct elf_info *elf,
> 		".fixup", ".entry.text", ".exception.text", \
> 		".coldtext", ".softirqentry.text"
> 
>-#define INIT_SECTIONS      ".init.*"
>-
>-#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
>+#define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
> 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
> 
> enum mismatch {
>@@ -839,12 +834,6 @@ static const struct sectioncheck sectioncheck[] = {
> 	.bad_tosec = { ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL },
> 	.mismatch = TEXTDATA_TO_ANY_INIT_EXIT,
> },
>-/* Do not reference init code/data from meminit code/data */
>-{
>-	.fromsec = { ALL_XXXINIT_SECTIONS, NULL },
>-	.bad_tosec = { INIT_SECTIONS, NULL },
>-	.mismatch = XXXINIT_TO_SOME_INIT,
>-},
> /* Do not use exit code/data from init code */
> {
> 	.fromsec = { ALL_INIT_SECTIONS, NULL },
>@@ -859,7 +848,7 @@ static const struct sectioncheck sectioncheck[] = {
> },
> {
> 	.fromsec = { ALL_PCI_INIT_SECTIONS, NULL },
>-	.bad_tosec = { INIT_SECTIONS, NULL },
>+	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
> 	.mismatch = ANY_INIT_TO_ANY_EXIT,
> },
> {
>-- 
>2.43.0

-- 
Wei Yang
Help you, Help me

